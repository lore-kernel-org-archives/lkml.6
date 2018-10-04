Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17825C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 17:31:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B69082084D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 17:31:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="XF4u5qck"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B69082084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727599AbeJEAZs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 20:25:48 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53966 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727489AbeJEAZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 20:25:48 -0400
Received: by mail-wm1-f66.google.com with SMTP id b19-v6so9816769wme.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 10:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uSF2uaTg/RHPiswXReEt/qEPMiSuw+iW1rjZsQeQfwo=;
        b=XF4u5qckbY1GzFRuLa/pukwD1Dagy2PkQ4wjT/WZCIp5zNyGFFlaow1p6N3u49bPka
         XdnVC3F1oFOTdC++OBXe90b9q/HCQmDaNlmf+tyHqU/ShxkKOLHkpCOvIun6D4LjodkP
         I3jVf9yZ5g+Jf4VnpCzZnixDmFyycctbPYR9hlLeKBpOxWUEFbYpom7DdvoCOZAyDeNS
         q2+qt81FE5uBUcrWpnRrPawKR3H4OtcAi2Qw00HPnjzQ/IZtGdoGXMDaFt6vbakKldeb
         7WBG2WZNp5bvjXPx+2xIouiLRDkQr0aAI3qr9n3il9W0nHauboTzY8LSO8pzMBCH198O
         UtKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uSF2uaTg/RHPiswXReEt/qEPMiSuw+iW1rjZsQeQfwo=;
        b=XS95mWB7jmOvbY169tSTsrjkGvXbgXmi58psgVMC4vVvXU7VVuFfDcWUx2HluVdAEC
         Rb3En6p1MNW+3Ib4lWVXD9I/bwXmLrcsdtxFuXenXfxEsWpg+hcmg8qgAfrgzuTEsdGU
         4F6YfVPGHo/Ct9vSo8Yz1ei/bNSqwMPMPQ/wF/GoB7tUy1tN61BvotzfFwEhAgSoQbbn
         7Ig3R0k4r3EmOCn04al2jk1vpqYDB19W6ptKbCS+16swA+YN4rRhkOKM3TbCxJtc4miT
         rn31rNGMxsopsms6uS+j+T1c/v9yXv6pHH6oBYwYmT93nJCBm3P3B8+z9fg1JNkp8N3a
         DYsQ==
X-Gm-Message-State: ABuFfojMFbWjSV/HFkONSk4bOf9+qEzdolBTC2QBqve4STH+21YTVsfL
        1JEtbn+R/s7mSJu9IrIZspcBRA==
X-Google-Smtp-Source: ACcGV62G7TUwKmsV7bXfxTfkPtYEASkA2gqfLaLHQG6WJFuKdlx1B+xK3U8B1Oqf+s7RFmpaH+vWlQ==
X-Received: by 2002:a1c:3b87:: with SMTP id i129-v6mr5205175wma.42.1538674290059;
        Thu, 04 Oct 2018 10:31:30 -0700 (PDT)
Received: from brauner.io ([2a02:8070:8895:9700:2824:7b8c:14f1:9980])
        by smtp.gmail.com with ESMTPSA id u191-v6sm6717001wmd.31.2018.10.04.10.31.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Oct 2018 10:31:29 -0700 (PDT)
Date:   Thu, 4 Oct 2018 19:31:22 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     Jann Horn <jannh@google.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>, jlayton@kernel.org,
        Bruce Fields <bfields@fieldses.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>, shuah@kernel.org,
        David Howells <dhowells@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Tycho Andersen <tycho@tycho.ws>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-kselftest@vger.kernel.org, dev@opencontainers.org,
        containers@lists.linux-foundation.org,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH 2/3] namei: implement AT_THIS_ROOT chroot-like path
 resolution
Message-ID: <20181004173121.e6tfwd6nc2geuv5c@brauner.io>
References: <20180929103453.12025-1-cyphar@cyphar.com>
 <20180929131534.24472-1-cyphar@cyphar.com>
 <CAG48ez30WJhbsro2HOc_DR7V91M+hNFzBP5ogRMZaxbAORvqzg@mail.gmail.com>
 <20181004162611.vdlujbdguvagalpt@ryuk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181004162611.vdlujbdguvagalpt@ryuk>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 05, 2018 at 02:26:11AM +1000, Aleksa Sarai wrote:
> On 2018-09-29, Jann Horn <jannh@google.com> wrote:
> > You attempt to open "C/../../etc/passwd" under the root "/A/B".
> > Something else concurrently moves /A/B/C to /A/C. This can result in
> > the following:
> > 
> > 1. You start the path walk and reach /A/B/C.
> > 2. The other process moves /A/B/C to /A/C. Your path walk is now at /A/C.
> > 3. Your path walk follows the first ".." up into /A. This is outside
> > the process root, but you never actually encountered the process root,
> > so you don't notice.
> > 4. Your path walk follows the second ".." up to /. Again, this is
> > outside the process root, but you don't notice.
> > 5. Your path walk walks down to /etc/passwd, and the open completes
> > successfully. You now have an fd pointing outside your chroot.
> 
> I've been playing with this and I have the following patch, which
> according to my testing protects against attacks where ".." skips over
> nd->root. It abuses __d_path to figure out if nd->path can be resolved
> from nd->root (obviously a proper version of this patch would refactor
> __d_path so it could be used like this -- and would not return
> -EMULTIHOP).
> 
> I've also attached my reproducer. With it, I was seeing fairly constant
> breakouts before this patch and after it I didn't see a single breakout
> after running it overnight. Obviously this is not conclusive, but I'm
> hoping that it can show what my idea for protecting against ".." was.
> 
> Does this patch make sense? Or is there something wrong with it that I'm
> not seeing?

Interesting.
Apart from the abuse of __d_path() :) the question I'd have is whether
this just minimizes the race window or if you can provide a sound
argument that this actually can't happen anymore with this patch.

> 
> --8<-------------------------------------------------------------------
> 
> There is a fairly easy-to-exploit race condition with chroot(2) (and
> thus by extension AT_THIS_ROOT and AT_BENEATH) where a rename(2) of a
> path can be used to "skip over" nd->root and thus escape to the
> filesystem above nd->root.
> 
>   thread1 [attacker]:
>     for (;;)
>       renameat2(AT_FDCWD, "/a/b/c", AT_FDCWD, "/a/d", RENAME_EXCHANGE);
>   thread2 [victim]:
>     for (;;)
>       openat(dirb, "b/c/../../etc/shadow", O_THISROOT);
> 
> With fairly significant regularity, thread2 will resolve to
> "/etc/shadow" rather than "/a/b/etc/shadow". With this patch, such cases
> will be detected during ".." resolution (which is the weak point of
> chroot(2) -- since walking *into* a subdirectory tautologically cannot
> result in you walking *outside* nd->root).
> 
> The use of __d_path here might seem suspect, however we don't mind if a
> path is moved from within the chroot to outside the chroot and we
> incorrectly decide it is safe (because at that point we are still within
> the set of files which were accessible at the beginning of resolution).
> However, we can fail resolution on the next path component if it remains
> outside of the root. A path which has always been outside nd->root
> during resolution will never be resolveable from nd->root and thus will
> always be blocked.
> 
> DO NOT MERGE: Currently this code returns -EMULTIHOP in this case,
> 	      purely as a debugging measure (so that you can see that
> 	      the protection actually does something). Obviously in the
> 	      proper patch this will return -EXDEV.
> 
> Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
> ---
>  fs/namei.c | 32 ++++++++++++++++++++++++++++++--
>  1 file changed, 30 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/namei.c b/fs/namei.c
> index 6f995e6de6b1..c8349693d47b 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -53,8 +53,8 @@
>   * The new code replaces the old recursive symlink resolution with
>   * an iterative one (in case of non-nested symlink chains).  It does
>   * this with calls to <fs>_follow_link().
> - * As a side effect, dir_namei(), _namei() and follow_link() are now 
> - * replaced with a single function lookup_dentry() that can handle all 
> + * As a side effect, dir_namei(), _namei() and follow_link() are now
> + * replaced with a single function lookup_dentry() that can handle all
>   * the special cases of the former code.
>   *
>   * With the new dcache, the pathname is stored at each inode, at least as
> @@ -1375,6 +1375,20 @@ static int follow_dotdot_rcu(struct nameidata *nd)
>  				return -EXDEV;
>  			break;
>  		}
> +		if (unlikely(nd->flags & (LOOKUP_BENEATH | LOOKUP_CHROOT))) {
> +			char *pathbuf, *pathptr;
> +
> +			pathbuf = kmalloc(PATH_MAX, GFP_ATOMIC);
> +			if (!pathbuf)
> +				return -ECHILD;
> +			pathptr = __d_path(&nd->path, &nd->root, pathbuf, PATH_MAX);
> +			kfree(pathbuf);
> +			if (IS_ERR_OR_NULL(pathptr)) {
> +				if (!pathptr)
> +					pathptr = ERR_PTR(-EMULTIHOP);
> +				return PTR_ERR(pathptr);
> +			}
> +		}
>  		if (nd->path.dentry != nd->path.mnt->mnt_root) {
>  			struct dentry *old = nd->path.dentry;
>  			struct dentry *parent = old->d_parent;
> @@ -1510,6 +1524,20 @@ static int follow_dotdot(struct nameidata *nd)
>  				return -EXDEV;
>  			break;
>  		}
> +		if (unlikely(nd->flags & (LOOKUP_BENEATH | LOOKUP_CHROOT))) {
> +			char *pathbuf, *pathptr;
> +
> +			pathbuf = kmalloc(PATH_MAX, GFP_KERNEL);
> +			if (!pathbuf)
> +				return -ENOMEM;
> +			pathptr = __d_path(&nd->path, &nd->root, pathbuf, PATH_MAX);
> +			kfree(pathbuf);
> +			if (IS_ERR_OR_NULL(pathptr)) {
> +				if (!pathptr)
> +					pathptr = ERR_PTR(-EMULTIHOP);
> +				return PTR_ERR(pathptr);
> +			}
> +		}
>  		if (nd->path.dentry != nd->path.mnt->mnt_root) {
>  			int ret = path_parent_directory(&nd->path);
>  			if (ret)
> -- 
> 2.19.0
> 
> -- 
> Aleksa Sarai
> Senior Software Engineer (Containers)
> SUSE Linux GmbH
> <https://www.cyphar.com/>




