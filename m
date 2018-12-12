Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03964C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 14:43:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C314920839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 14:43:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C314920839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726724AbeLLOnL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 09:43:11 -0500
Received: from mx2.suse.de ([195.135.220.15]:58454 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726228AbeLLOnK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 09:43:10 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 63478AFC3;
        Wed, 12 Dec 2018 14:43:07 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 7522D1E0DB5; Wed, 12 Dec 2018 15:43:06 +0100 (CET)
Date:   Wed, 12 Dec 2018 15:43:06 +0100
From:   Jan Kara <jack@suse.cz>
To:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc:     linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        James Morris <jmorris@namei.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Matthew Garrett <mjg59@google.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mickael.salaun@ssi.gouv.fr>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Philippe =?iso-8859-1?Q?Tr=E9buchet?= 
        <philippe.trebuchet@ssi.gouv.fr>, Shuah Khan <shuah@kernel.org>,
        Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>,
        Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
        Yves-Alexis Perez <yves-alexis.perez@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, sgrubb@redhat.com,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>
Subject: Re: [RFC PATCH v1 1/5] fs: Add support for an O_MAYEXEC flag on
 sys_open()
Message-ID: <20181212144306.GA19945@quack2.suse.cz>
References: <20181212081712.32347-1-mic@digikod.net>
 <20181212081712.32347-2-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181212081712.32347-2-mic@digikod.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 12-12-18 09:17:08, Mickaël Salaün wrote:
> When the O_MAYEXEC flag is passed, sys_open() may be subject to
> additional restrictions depending on a security policy implemented by an
> LSM through the inode_permission hook.
> 
> The underlying idea is to be able to restrict scripts interpretation
> according to a policy defined by the system administrator.  For this to
> be possible, script interpreters must use the O_MAYEXEC flag
> appropriately.  To be fully effective, these interpreters also need to
> handle the other ways to execute code (for which the kernel can't help):
> command line parameters (e.g., option -e for Perl), module loading
> (e.g., option -m for Python), stdin, file sourcing, environment
> variables, configuration files...  According to the threat model, it may
> be acceptable to allow some script interpreters (e.g. Bash) to interpret
> commands from stdin, may it be a TTY or a pipe, because it may not be
> enough to (directly) perform syscalls.
> 
> A simple security policy implementation is available in a following
> patch for Yama.
> 
> This is an updated subset of the patch initially written by Vincent
> Strubel for CLIP OS:
> https://github.com/clipos-archive/src_platform_clip-patches/blob/f5cb330d6b684752e403b4e41b39f7004d88e561/1901_open_mayexec.patch
> This patch has been used for more than 10 years with customized script
> interpreters.  Some examples can be found here:
> https://github.com/clipos-archive/clipos4_portage-overlay/search?q=O_MAYEXEC
> 
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> Signed-off-by: Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>
> Signed-off-by: Vincent Strubel <vincent.strubel@ssi.gouv.fr>
> Reviewed-by: Philippe Trébuchet <philippe.trebuchet@ssi.gouv.fr>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Mickaël Salaün <mickael.salaun@ssi.gouv.fr>

...

> diff --git a/fs/open.c b/fs/open.c
> index 0285ce7dbd51..75479b79a58f 100644
> --- a/fs/open.c
> +++ b/fs/open.c
> @@ -974,6 +974,10 @@ static inline int build_open_flags(int flags, umode_t mode, struct open_flags *o
>  	if (flags & O_APPEND)
>  		acc_mode |= MAY_APPEND;
>  
> +	/* Check execution permissions on open. */
> +	if (flags & O_MAYEXEC)
> +		acc_mode |= MAY_OPENEXEC;
> +
>  	op->acc_mode = acc_mode;
>  
>  	op->intent = flags & O_PATH ? 0 : LOOKUP_OPEN;

I don't feel experienced enough in security to tell whether we want this
functionality or not. But if we do this, shouldn't we also set FMODE_EXEC
on the resulting struct file? That way also security_file_open() can be
used to arbitrate such executable opens and in particular
fanotify permission event FAN_OPEN_EXEC will get properly generated which I
guess is desirable (support for it is sitting in my tree waiting for the
merge window) - adding some audit people involved in FAN_OPEN_EXEC to
CC. Just an idea...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
