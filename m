Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F10B0C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 12:02:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD07F20663
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 12:02:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD07F20663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395001AbeKVWlE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 17:41:04 -0500
Received: from foss.arm.com ([217.140.101.70]:46722 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730337AbeKVWlD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 17:41:03 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 06E69361A;
        Thu, 22 Nov 2018 04:01:58 -0800 (PST)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C6F743F5A0;
        Thu, 22 Nov 2018 04:01:56 -0800 (PST)
Date:   Thu, 22 Nov 2018 12:01:54 +0000
From:   Dave Martin <Dave.Martin@arm.com>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     linux@armlinux.org.uk, jeyu@kernel.org,
        Vincent Whitchurch <rabinv@axis.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] module: Overwrite st_size instead of st_info
Message-ID: <20181122120154.GH3505@e103592.cambridge.arm.com>
References: <20181119162513.16562-1-vincent.whitchurch@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181119162513.16562-1-vincent.whitchurch@axis.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 05:25:12PM +0100, Vincent Whitchurch wrote:
> st_info is currently overwritten after relocation and used to store the
> elf_type().  However, we're going to need it fix kallsyms on ARM's
> Thumb-2 kernels, so preserve st_info and overwrite the st_size field
> instead.  st_size is neither used by the module core nor by any
> architecture.
> 
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
> ---
> v4: Split out to separate patch.  Use st_size instead of st_other.
> v1-v3: See PATCH 2/2
> 
>  kernel/module.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/module.c b/kernel/module.c
> index 49a405891587..3d86a38b580c 100644
> --- a/kernel/module.c
> +++ b/kernel/module.c
> @@ -2682,7 +2682,7 @@ static void add_kallsyms(struct module *mod, const struct load_info *info)
>  
>  	/* Set types up while we still have access to sections. */
>  	for (i = 0; i < mod->kallsyms->num_symtab; i++)
> -		mod->kallsyms->symtab[i].st_info
> +		mod->kallsyms->symtab[i].st_size
>  			= elf_type(&mod->kallsyms->symtab[i], info);
>  
>  	/* Now populate the cut down core kallsyms for after init. */
> @@ -4061,7 +4061,7 @@ int module_get_kallsym(unsigned int symnum, unsigned long *value, char *type,
>  		kallsyms = rcu_dereference_sched(mod->kallsyms);
>  		if (symnum < kallsyms->num_symtab) {
>  			*value = kallsyms->symtab[symnum].st_value;
> -			*type = kallsyms->symtab[symnum].st_info;
> +			*type = kallsyms->symtab[symnum].st_size;
>  			strlcpy(name, symname(kallsyms, symnum), KSYM_NAME_LEN);
>  			strlcpy(module_name, mod->name, MODULE_NAME_LEN);
>  			*exported = is_exported(name, *value, mod);

This is fine if st_size is really unused, but how sure are you of that?

grepping for st_size throws up some hits that appear ELF-related, but
I've not investigated them in detail.

(The fact that struct stat has an identically named field throws up
a load of false positives too.)

Cheers
---Dave
