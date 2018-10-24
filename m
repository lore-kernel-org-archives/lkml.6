Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09843C67863
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 11:57:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBAFD20824
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 11:57:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBAFD20824
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727606AbeJXUZR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 16:25:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:36698 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726428AbeJXUZR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 16:25:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 25099AE98;
        Wed, 24 Oct 2018 11:57:26 +0000 (UTC)
Date:   Wed, 24 Oct 2018 13:57:24 +0200 (CEST)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Jessica Yu <jeyu@kernel.org>
cc:     Torsten Duwe <duwe@lst.de>, Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        live-patching@vger.kernel.org
Subject: Re: [PATCH] arm64/module: use mod->klp_info section header
 information
In-Reply-To: <20181023175553.gaobskk26koft6s2@linux-8ccs>
Message-ID: <alpine.LSU.2.21.1810241341580.20865@pobox.suse.cz>
References: <20181001140910.086E768BC7@newverein.lst.de> <20181001141652.5478C68BE1@newverein.lst.de> <20181023175553.gaobskk26koft6s2@linux-8ccs>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Oct 2018, Jessica Yu wrote:

> diff --git a/arch/arm64/kernel/module-plts.c b/arch/arm64/kernel/module-plts.c
> index f0690c2ca3e0..05067717dfc5 100644
> --- a/arch/arm64/kernel/module-plts.c
> +++ b/arch/arm64/kernel/module-plts.c
> @@ -210,9 +210,15 @@ int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr
> *sechdrs,
> 	 * entries. Record the symtab address as well.
> 	 */
> 	for (i = 0; i < ehdr->e_shnum; i++) {
> -		if (!strcmp(secstrings + sechdrs[i].sh_name, ".plt"))
> +		if (!strcmp(secstrings + sechdrs[i].sh_name, ".plt")) {
> 			mod->arch.core.plt = sechdrs + i;
> -		else if (!strcmp(secstrings + sechdrs[i].sh_name,
> ".init.plt"))
> +			/*
> +			 * Keep the section index for the .plt section for
> +			 * livepatching. Note that .init.plt is irrelevant to
> +			 * livepatch, so only the shndx for .plt is saved.
> +			 */
> +			mod->arch.core.plt_shndx = i;
> +		} else if (!strcmp(secstrings + sechdrs[i].sh_name,
> ".init.plt"))

Else branches should have braces now too according to the coding style.

Otherwise it looks good to me.

Thanks,
Miroslav
