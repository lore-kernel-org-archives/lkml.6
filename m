Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9BA9ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 20:26:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E98A2086E
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 20:26:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E98A2086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728458AbeIRBzV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 21:55:21 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:42993 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728009AbeIRBzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 21:55:20 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g206B-00036E-Ia; Mon, 17 Sep 2018 14:26:23 -0600
Received: from [105.184.227.67] (helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g206A-0000eR-IQ; Mon, 17 Sep 2018 14:26:23 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Jeff Layton <jlayton@kernel.org>, viro@zeniv.linux.org.uk,
        berrange@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180914105310.6454-1-jlayton@kernel.org>
        <87a7ohs5ow.fsf@xmission.com> <87y3c1qr1g.fsf_-_@xmission.com>
        <20180917162342.GB25565@redhat.com>
Date:   Mon, 17 Sep 2018 22:26:15 +0200
In-Reply-To: <20180917162342.GB25565@redhat.com> (Oleg Nesterov's message of
        "Mon, 17 Sep 2018 18:23:42 +0200")
Message-ID: <874lenoopk.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1g206A-0000eR-IQ;;;mid=<874lenoopk.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=105.184.227.67;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/bPuxNDdPBMfRly0b6z7zZGQrrC+RfsgM=
X-SA-Exim-Connect-IP: 105.184.227.67
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [RFC][PATCH 2/3] exec: Simplify unshare_files
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov <oleg@redhat.com> writes:

> absolutely off-topic question,
>
> On 09/16, Eric W. Biederman wrote:
>>
>> @@ -747,11 +746,9 @@ void do_coredump(const siginfo_t *siginfo)
>>  	}
>>
>>  	/* get us an unshared descriptor table; almost always a no-op */
>> -	retval = unshare_files(&displaced);
>> +	retval = unshare_files();
>
> I fail to understand why do_coredump() needs unshare_files(). Could someone
> explain?
>
> And "almost always a no-op" above is not true, this is never a no-op in mt case;
> other (killed) threads sleep in exit_mm() which is called before
> exit_files().

So I looked at the history and I have half an explanation.
179e037fc1370288188cb1f90b81156d75a3cb2d do_coredump(): make sure that descriptor table isn't shared

As far as I can tell this was Al Viro making certain that there were not
any races that had to be dealt with when accessing the file table during
execve.

Which gets to the heart of what we have to do before this set of changes
that we have been looking at can be merged.  We need to go through exec
and do_coredump if we wish to remove this call of unshare_files
and verify that everything is thread-safe, and using thread-safe idioms.

There is at least one place in exec where it is documented that the
access to files is not thread-safe in the comment.  I don't think any of
that is fundamentally hard but that work needs to be done for the rest
of this cleanup to be usable.

Eric
