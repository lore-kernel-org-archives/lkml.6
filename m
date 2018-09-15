Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E3D9ECE565
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 16:37:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 077892147A
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 16:37:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 077892147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728172AbeIOV4j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 17:56:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38562 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727727AbeIOV4j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 17:56:39 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6787C30820D2;
        Sat, 15 Sep 2018 16:37:06 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.34.27.30])
        by smtp.corp.redhat.com (Postfix) with SMTP id DC948429C4;
        Sat, 15 Sep 2018 16:37:04 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Sat, 15 Sep 2018 18:37:06 +0200 (CEST)
Date:   Sat, 15 Sep 2018 18:37:04 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     viro@zeniv.linux.org.uk, ebiederm@xmission.com,
        berrange@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3 3/3] exec: do unshare_files after de_thread
Message-ID: <20180915163704.GA31693@redhat.com>
References: <20180914105310.6454-1-jlayton@kernel.org>
 <20180914105310.6454-4-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180914105310.6454-4-jlayton@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Sat, 15 Sep 2018 16:37:06 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/14, Jeff Layton wrote:
>
> POSIX mandates that open fds and their associated file locks should be
> preserved across an execve. This works, unless the process is
> multithreaded at the time that execve is called.
>
> In that case, we'll end up unsharing the files_struct but the locks will
> still have their fl_owner set to the address of the old one. Eventually,
> when the other threads die and the last reference to the old
> files_struct is put, any POSIX locks get torn down since it looks like
> a close occurred on them.
>
> The result is that all of your open files will be intact with none of
> the locks you held before execve. The simple answer to this is "use OFD
> locks", but this is a nasty surprise and it violates the spec.
>
> Fix this by doing unshare_files later during exec,

See my reply to 1/3... if we can forget about the races with get_files_struct()
we can probably make a much simpler patch, plus we do not need 2/2, afaics.

What I really can't understand is why we need to _change_ current->files
early in do_execve().

IOW. Lets ignore do_close_on_exec(), lets ignore the fact that unshare_fd()
can fail and thus it makes sense to call it before point-of-no-return.

Any other reason why we can't simply call unshare_files() at the end of
__do_execve_file() on success?

Oleg.

