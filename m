Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B34BEC43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 07:00:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 689D22073F
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 07:00:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 689D22073F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rustcorp.com.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727589AbeI2N1s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 09:27:48 -0400
Received: from ozlabs.org ([203.11.71.1]:45407 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727418AbeI2N1s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 09:27:48 -0400
Received: by ozlabs.org (Postfix, from userid 1011)
        id 42MfZP5ZPHz9sD0; Sat, 29 Sep 2018 17:00:29 +1000 (AEST)
From:   Rusty Russell <rusty@rustcorp.com.au>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kbuild@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org, Jessica Yu <jeyu@kernel.org>
Subject: Re: [PATCH] modpost: remove leftover symbol prefix handling for module device table
In-Reply-To: <1538115715-10078-1-git-send-email-yamada.masahiro@socionext.com>
References: <1538115715-10078-1-git-send-email-yamada.masahiro@socionext.com>
Date:   Sat, 29 Sep 2018 16:30:22 +0930
Message-ID: <87bm8giy9l.fsf@rustcorp.com.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please send this to the module maintainer (CC'd).

Masahiro Yamada <yamada.masahiro@socionext.com> writes:
> Blackfin and metag were the only architectures that prefix symbols with
> an underscore.  They were removed by commit 4ba66a976072 ("arch: remove
> blackfin port"), commit bb6fb6dfcc17 ("metag: Remove arch/metag/"),
> respectively.
>
> It is no longer necessary to handle <prefix> part of module device
> table symbols.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>
>  scripts/mod/file2alias.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/scripts/mod/file2alias.c b/scripts/mod/file2alias.c
> index 7be4369..ba4ebc4 100644
> --- a/scripts/mod/file2alias.c
> +++ b/scripts/mod/file2alias.c
> @@ -1415,11 +1415,10 @@ void handle_moddevtable(struct module *mod, struct elf_info *info,
>  	if (ELF_ST_TYPE(sym->st_info) != STT_OBJECT)
>  		return;
>  
> -	/* All our symbols are of form <prefix>__mod_<name>__<identifier>_device_table. */
> -	name = strstr(symname, "__mod_");
> -	if (!name)
> +	/* All our symbols are of form __mod_<name>__<identifier>_device_table. */
> +	if (strncmp(symname, "__mod_", strlen("__mod_")))
>  		return;
> -	name += strlen("__mod_");
> +	name = symname + strlen("__mod_");
>  	namelen = strlen(name);
>  	if (namelen < strlen("_device_table"))
>  		return;
> -- 
> 2.7.4
