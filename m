Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D17B8C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 01:16:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97776204FD
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 01:16:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97776204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbeK0MMi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 07:12:38 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43989 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727552AbeK0MMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 07:12:37 -0500
Received: by mail-pf1-f193.google.com with SMTP id w73so7471415pfk.10;
        Mon, 26 Nov 2018 17:16:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8W2Osg6pvIeMVmHW9jM3t0Qqf0upyJLlR7xsbDIQT6c=;
        b=MlllTpfdnMtBJiGdD1UxaDGvpnDiLjsSXGV4Z3DALccR/xhczO3PWPMGLcVmN81jVf
         c7DSkc4nCqAhovzGFgCxUylG+PhNOYtax4I8PGUWmYMmGdB/FAQE1K4OCYlKzDPz3zcM
         sScgBQKW7XSCrVrRtAlYVLO3YmacJLB275WVFE3TOBe0vG3VnVk5nrkjO2q9HAY9WwvO
         E7/sYSTcwOo2z0iso5GS6j0E7u2qLXfJTL/zCx8rEjjoERVkiBklb7U3rQD5gyb9dSY/
         O+joKow7bDUjWKzS3fPwwRtBH4oJ7yrQ0bvfqO+SJcGRdItpm40bgep4ljGOenj1xttd
         KqEQ==
X-Gm-Message-State: AA+aEWZSD1CiA9ewnpdfmRZdJ8LZZQpvslNbiixpvyAX3i3aEZqOP63B
        8gry9HNNhm1wiM6/tjWpsSc=
X-Google-Smtp-Source: AFSGD/WzRtEMbfmOoY4aLba8ko/qy6Ezc6FDjj6NIdskZD5RdG9dQgA8jX3+4CoGVTnX+bnksiuUwQ==
X-Received: by 2002:a63:ea15:: with SMTP id c21mr25904963pgi.361.1543281391876;
        Mon, 26 Nov 2018 17:16:31 -0800 (PST)
Received: from garbanzo.do-not-panic.com (c-73-71-40-85.hsd1.ca.comcast.net. [73.71.40.85])
        by smtp.gmail.com with ESMTPSA id h74sm2045176pfd.35.2018.11.26.17.16.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Nov 2018 17:16:29 -0800 (PST)
Received: by garbanzo.do-not-panic.com (sSMTP sendmail emulation); Mon, 26 Nov 2018 17:16:27 -0800
Date:   Mon, 26 Nov 2018 17:16:27 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Radoslaw Burny <rburny@google.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Seth Forshee <seth.forshee@canonical.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, jsperbeck@google.com
Subject: Re: [PATCH] fs: Make /proc/sys inodes be owned by global root.
Message-ID: <20181127011627.GI4922@garbanzo.do-not-panic.com>
References: <20181126172607.125782-1-rburny@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181126172607.125782-1-rburny@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 06:26:07PM +0100, Radoslaw Burny wrote:
> Due to a recent commit (d151ddc00498 - fs: Update i_[ug]id_(read|write)
> to translate relative to s_user_ns),

Recent? This is commit is from 2014 and present upstream since v4.8.
And the commit ID you mentioned in your commit log seems to be
incorrect. I get:

81754357770ebd900801231e7bc8d151ddc00498a fs: Update i_[ug]id_(read|write) to translate relative to s_user_ns

> inodes under /proc/sys have -1
> written to their i_uid/i_gid members if a containing userns does not
> have entries for root in the uid/gid_map.

Thanks for the description of how to run into the issue described but
is there also a practical use case today where this is happening? I ask
as it would be good to know the severity of the issue in the real world
today.

> This wouldn't normally matter, because these values are not used for
> access checks. However, a later change (0bd23d09b874 - Don't modify
> inodes with a uid or gid unknown to the vfs) changes the kernel to
> prevent opens for write if the i_uid/i_gid field in the inode is -1,
> even if the /proc/sys-specific access checks would otherwise pass.
> 
> This causes a problem: in a userns without root mapping, even the
> namespace creator cannot write to e.g. /proc/sys/kernel/shmmax.
> This change fixes the problem by overriding i_uid/i_gid back to
> GLOBAL_ROOT_UID/GID.

We really need Seth and Eric to provide guidance here as they were
the ones devising this long ago, but to me your solution seems backward.
Why allow any namespace to muck with /proc/sys/ seettings?

Let's recall that this case was a corner case, and writeback was the
biggest concern, and for that it was decided that you'd simply not get
write access, and so its read only. Its not clear to me if things like
proc were considered. For the regular file case the situation can be
addressed with  chown, however we can't chown proc files.

> Tested: Used a repro program that creates a user namespace without any
> mapping and stat'ed /proc/$PID/root/proc/sys/kernel/shmmax from outside.
> Before the change, it shows uid/gid of 65534,

I thought you said it would be uid/gid -1 without your patch?

> with the change it's 0.

Note that a good way to also test issues is with the lib/test_sysctl.c
module and the tools/testing/selftests/sysctl/sysctl.sh script, so if
you can device a test there, once we decide what to do that would be
appreciated.

  Luis

> Signed-off-by: Radoslaw Burny <rburny@google.com>
> ---
>  fs/proc/proc_sysctl.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
> index c5cbbdff3c3d..67379a389658 100644
> --- a/fs/proc/proc_sysctl.c
> +++ b/fs/proc/proc_sysctl.c
> @@ -499,6 +499,10 @@ static struct inode *proc_sys_make_inode(struct super_block *sb,
>  
>  	if (root->set_ownership)
>  		root->set_ownership(head, table, &inode->i_uid, &inode->i_gid);
> +	else {
> +		inode->i_uid = GLOBAL_ROOT_UID;
> +		inode->i_gid = GLOBAL_ROOT_GID;
> +	}
>  
>  out:
>  	return inode;
> -- 
> 2.20.0.rc0.387.gc7a69e6b6c-goog
> 
