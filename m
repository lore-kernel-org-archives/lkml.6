Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_MIXED_ES,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E5D9C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 14:35:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE3E620839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 14:35:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ssi.gouv.fr header.i=@ssi.gouv.fr header.b="TJQyItkJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE3E620839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ssi.gouv.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727260AbeLLOff (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 09:35:35 -0500
Received: from smtp-out.ssi.gouv.fr ([86.65.182.90]:63385 "EHLO
        smtp-out.ssi.gouv.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbeLLOfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 09:35:34 -0500
X-Greylist: delayed 434 seconds by postgrey-1.27 at vger.kernel.org; Wed, 12 Dec 2018 09:35:33 EST
Received: from smtp-out.ssi.gouv.fr (localhost [127.0.0.1])
        by smtp-out.ssi.gouv.fr (Postfix) with ESMTP id A4D92D0006C;
        Wed, 12 Dec 2018 15:28:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ssi.gouv.fr;
        s=20160407; t=1544624905;
        bh=RURSNJxH3uXwyQWATCTsAZKmp59Lkaus4CuUmJ0TlvE=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From:Subject;
        b=TJQyItkJ40LvGdtGynmQhqS0iZOUMxq7wKc2iW3rOl/SnArM1DjIQhViE8hEc05R6
         +NhQg/FC6q3qypYP2rvu/iTNS0YQUEw4cbnObozOuMYCnNLAf8kKnjdZMpVEUSDCP7
         gmOoyxPn5wxmXwCesK+MNY74QJknnGfPMU8tpxBlrHE886J31wsHeMDFjnFGiDdZDc
         wTSZHd4/yhlKzHXnFXGdy/8PPkerTzmDRNpwYFbZd6Gv/7x4ktvkhxJaqgAS5egMWI
         c5gtPTJcS2u5UiaHVptbcoo5z7QXhBfJJkRYXViF1+n+Hta1/bLiHwwbolC8LKLjyY
         wCrqVt2Lh4MlA==
Subject: Re: [RFC PATCH v1 3/5] Yama: Enforces noexec mounts or file
 executability through O_MAYEXEC
To:     <linux-kernel@vger.kernel.org>
CC:     =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        James Morris <jmorris@namei.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Matthew Garrett <mjg59@google.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        =?UTF-8?Q?Philippe_Tr=c3=a9buchet?= 
        <philippe.trebuchet@ssi.gouv.fr>, Shuah Khan <shuah@kernel.org>,
        Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>,
        Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
        Yves-Alexis Perez <yves-alexis.perez@ssi.gouv.fr>,
        <kernel-hardening@lists.openwall.com>, <linux-api@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
References: <20181212081712.32347-1-mic@digikod.net>
 <20181212081712.32347-4-mic@digikod.net>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mickael.salaun@ssi.gouv.fr>
Message-ID: <13fe4508-f0c0-66c7-8aab-8b3ccef5caa2@ssi.gouv.fr>
Date:   Wed, 12 Dec 2018 15:28:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20181212081712.32347-4-mic@digikod.net>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 12/12/2018 à 09:17, Mickaël Salaün a écrit :
> Enable to either propagate the mount options from the underlying VFS
> mount to prevent execution, or to propagate the file execute permission.
> This may allow a script interpreter to check execution permissions
> before reading commands from a file.
> 
> The main goal is to be able to protect the kernel by restricting
> arbitrary syscalls that an attacker could perform with a crafted binary
> or certain script languages.  It also improves multilevel isolation
> by reducing the ability of an attacker to use side channels with
> specific code.  These restrictions can natively be enforced for ELF
> binaries (with the noexec mount option) but require this kernel
> extension to properly handle scripts (e.g., Python, Perl).
> 
> Add a new sysctl kernel.yama.open_mayexec_enforce to control this
> behavior.  A following patch adds documentation.
> 
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> Reviewed-by: Philippe Trébuchet <philippe.trebuchet@ssi.gouv.fr>
> Reviewed-by: Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Mickaël Salaün <mickael.salaun@ssi.gouv.fr>
> ---
>  security/yama/Kconfig    |  3 +-
>  security/yama/yama_lsm.c | 82 +++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 83 insertions(+), 2 deletions(-)
> 
> diff --git a/security/yama/Kconfig b/security/yama/Kconfig
> index 96b27405558a..9457619fabd5 100644
> --- a/security/yama/Kconfig
> +++ b/security/yama/Kconfig
> @@ -5,7 +5,8 @@ config SECURITY_YAMA
>  	help
>  	  This selects Yama, which extends DAC support with additional
>  	  system-wide security settings beyond regular Linux discretionary
> -	  access controls. Currently available is ptrace scope restriction.
> +	  access controls. Currently available are ptrace scope restriction and
> +	  enforcement of the O_MAYEXEC open flag.
>  	  Like capabilities, this security module stacks with other LSMs.
>  	  Further information can be found in
>  	  Documentation/admin-guide/LSM/Yama.rst.
> diff --git a/security/yama/yama_lsm.c b/security/yama/yama_lsm.c
> index ffda91a4a1aa..120664e94ee5 100644
> --- a/security/yama/yama_lsm.c
> +++ b/security/yama/yama_lsm.c
> @@ -1,10 +1,12 @@
>  /*
>   * Yama Linux Security Module
>   *
> - * Author: Kees Cook <keescook@chromium.org>
> + * Authors: Kees Cook <keescook@chromium.org>
> + *          Mickaël Salaün <mickael.salaun@ssi.gouv.fr>
>   *
>   * Copyright (C) 2010 Canonical, Ltd.
>   * Copyright (C) 2011 The Chromium OS Authors.
> + * Copyright (C) 2018 ANSSI
>   *
>   * This program is free software; you can redistribute it and/or modify
>   * it under the terms of the GNU General Public License version 2, as
> @@ -28,7 +30,14 @@
>  #define YAMA_SCOPE_CAPABILITY	2
>  #define YAMA_SCOPE_NO_ATTACH	3
>  
> +#define YAMA_OMAYEXEC_ENFORCE_NONE	0
> +#define YAMA_OMAYEXEC_ENFORCE_MOUNT	(1 << 0)
> +#define YAMA_OMAYEXEC_ENFORCE_FILE	(1 << 1)
> +#define _YAMA_OMAYEXEC_LAST		YAMA_OMAYEXEC_ENFORCE_FILE
> +#define _YAMA_OMAYEXEC_MASK		((_YAMA_OMAYEXEC_LAST << 1) - 1)
> +
>  static int ptrace_scope = YAMA_SCOPE_RELATIONAL;
> +static int open_mayexec_enforce = YAMA_OMAYEXEC_ENFORCE_NONE;
>  
>  /* describe a ptrace relationship for potential exception */
>  struct ptrace_relation {
> @@ -423,7 +432,40 @@ int yama_ptrace_traceme(struct task_struct *parent)
>  	return rc;
>  }
>  
> +/**
> + * yama_inode_permission - check O_MAYEXEC permission before accessing an inode
> + * @inode: inode structure to check
> + * @mask: permission mask
> + *
> + * Return 0 if access is permitted, -EACCES otherwise.
> + */
> +int yama_inode_permission(struct inode *inode, int mask)
> +{
> +	if (!(mask & MAY_OPENEXEC))
> +		return 0;
> +	/*
> +	 * Match regular files and directories to make it easier to
> +	 * modify script interpreters.
> +	 */
> +	if (!S_ISREG(inode->i_mode) && !S_ISDIR(inode->i_mode))
> +		return 0;

I forgot to mention that these checks do not handle fifos. This is
relevant in a threat model targeting persistent attacks (and with
additional protections/restrictions).

> +
> +	if ((open_mayexec_enforce & YAMA_OMAYEXEC_ENFORCE_MOUNT) &&
> +			!(mask & MAY_EXECMOUNT))
> +		return -EACCES;
> +
> +	/*
> +	 * May prefer acl_permission_check() instead of generic_permission(),
> +	 * to not be bypassable with CAP_DAC_READ_SEARCH.
> +	 */
> +	if (open_mayexec_enforce & YAMA_OMAYEXEC_ENFORCE_FILE)
> +		return generic_permission(inode, MAY_EXEC);
> +
> +	return 0;
> +}
> +
>  static struct security_hook_list yama_hooks[] __lsm_ro_after_init = {
> +	LSM_HOOK_INIT(inode_permission, yama_inode_permission),
>  	LSM_HOOK_INIT(ptrace_access_check, yama_ptrace_access_check),
>  	LSM_HOOK_INIT(ptrace_traceme, yama_ptrace_traceme),
>  	LSM_HOOK_INIT(task_prctl, yama_task_prctl),
> @@ -447,6 +489,37 @@ static int yama_dointvec_minmax(struct ctl_table *table, int write,
>  	return proc_dointvec_minmax(&table_copy, write, buffer, lenp, ppos);
>  }
>  
> +static int yama_dointvec_bitmask_macadmin(struct ctl_table *table, int write,
> +					  void __user *buffer, size_t *lenp,
> +					  loff_t *ppos)
> +{
> +	int error;
> +
> +	if (write) {
> +		struct ctl_table table_copy;
> +		int tmp_mayexec_enforce;
> +
> +		if (!capable(CAP_MAC_ADMIN))
> +			return -EPERM;
> +		tmp_mayexec_enforce = *((int *)table->data);
> +		table_copy = *table;
> +		/* do not erase open_mayexec_enforce */
> +		table_copy.data = &tmp_mayexec_enforce;
> +		error = proc_dointvec(&table_copy, write, buffer, lenp, ppos);
> +		if (error)
> +			return error;
> +		if ((tmp_mayexec_enforce | _YAMA_OMAYEXEC_MASK) !=
> +				_YAMA_OMAYEXEC_MASK)
> +			return -EINVAL;
> +		*((int *)table->data) = tmp_mayexec_enforce;
> +	} else {
> +		error = proc_dointvec(table, write, buffer, lenp, ppos);
> +		if (error)
> +			return error;
> +	}
> +	return 0;
> +}
> +
>  static int zero;
>  static int max_scope = YAMA_SCOPE_NO_ATTACH;
>  
> @@ -466,6 +539,13 @@ static struct ctl_table yama_sysctl_table[] = {
>  		.extra1         = &zero,
>  		.extra2         = &max_scope,
>  	},
> +	{
> +		.procname       = "open_mayexec_enforce",
> +		.data           = &open_mayexec_enforce,
> +		.maxlen         = sizeof(int),
> +		.mode           = 0644,
> +		.proc_handler   = yama_dointvec_bitmask_macadmin,
> +	},
>  	{ }
>  };
>  static void __init yama_init_sysctl(void)
> 
