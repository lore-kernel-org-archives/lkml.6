Return-Path: <SRS0=7f4r=L6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6899ECE560
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 16:49:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E5F42083A
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 16:49:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E5F42083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728291AbeIPWNQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Sep 2018 18:13:16 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:56636 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726949AbeIPWNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Sep 2018 18:13:16 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g1aEz-0003c5-7c; Sun, 16 Sep 2018 10:49:45 -0600
Received: from [105.184.227.67] (helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g1aEx-0003HH-VB; Sun, 16 Sep 2018 10:49:45 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Jeff Layton <jlayton@kernel.org>, viro@zeniv.linux.org.uk,
        berrange@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
References: <20180914105310.6454-1-jlayton@kernel.org>
        <20180914105310.6454-4-jlayton@kernel.org>
        <20180915163704.GA31693@redhat.com>
Date:   Sun, 16 Sep 2018 18:49:33 +0200
In-Reply-To: <20180915163704.GA31693@redhat.com> (Oleg Nesterov's message of
        "Sat, 15 Sep 2018 18:37:04 +0200")
Message-ID: <87efdttmjm.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1g1aEx-0003HH-VB;;;mid=<87efdttmjm.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=105.184.227.67;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/O9gbTpRUwlx+fP9tU71/GSPzTxGMycwM=
X-SA-Exim-Connect-IP: 105.184.227.67
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH v3 3/3] exec: do unshare_files after de_thread
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov <oleg@redhat.com> writes:

> On 09/14, Jeff Layton wrote:
>>
>> POSIX mandates that open fds and their associated file locks should be
>> preserved across an execve. This works, unless the process is
>> multithreaded at the time that execve is called.
>>
>> In that case, we'll end up unsharing the files_struct but the locks will
>> still have their fl_owner set to the address of the old one. Eventually,
>> when the other threads die and the last reference to the old
>> files_struct is put, any POSIX locks get torn down since it looks like
>> a close occurred on them.
>>
>> The result is that all of your open files will be intact with none of
>> the locks you held before execve. The simple answer to this is "use OFD
>> locks", but this is a nasty surprise and it violates the spec.
>>
>> Fix this by doing unshare_files later during exec,
>
> See my reply to 1/3... if we can forget about the races with get_files_struct()
> we can probably make a much simpler patch, plus we do not need 2/2, afaics.
>
> What I really can't understand is why we need to _change_ current->files
> early in do_execve().
>
> IOW. Lets ignore do_close_on_exec(), lets ignore the fact that unshare_fd()
> can fail and thus it makes sense to call it before point-of-no-return.
>
> Any other reason why we can't simply call unshare_files() at the end of
> __do_execve_file() on success?

The reason we call we call unshare_files is in case the files are shared
with another process.  AKA old style linux threads, or someone being
clever.  In that case we need a private copy of files for close on exec
because we should not close the files of the other process that has not
called exec.

The only reason for calling unshare_files before the point of no return
is so that we can get a good error message to the calling process if
unshare_files fails.

Given that "files->count > 1" should only exist in rare and crazy cases.
I expect we can legitimately have exec fail hard if we -ENOMEM in that
case and kill the calling process.

AKA it would be reasonable to move unshare_files to just above
do_close_on_exec in flush_old_exec.  We could further make the
unshare_files not return displaced and just drop it.

Thinking about Jeff's version already by necessity places unshare_files
after de_thread.  So it is already after the point of no return.  So
there really is no point in getting trying hard with displaced files.

Eric
