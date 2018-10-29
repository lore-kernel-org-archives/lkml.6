Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6581DC2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 13:24:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A74B2082D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 13:24:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A74B2082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727317AbeJ2WNA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 18:13:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:35982 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725862AbeJ2WM7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 18:12:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 950EBAE03;
        Mon, 29 Oct 2018 13:24:17 +0000 (UTC)
Date:   Mon, 29 Oct 2018 14:24:16 +0100 (CET)
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
        Petr Mladek <pmladek@suse.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        live-patching@vger.kernel.org
Subject: Re: [PATCH v2] arm64/module: use mod->klp_info section header
 information for livepatch modules
In-Reply-To: <20181026172500.g65bl2p7cvey3qsx@linux-8ccs>
Message-ID: <alpine.LSU.2.21.1810291415340.22023@pobox.suse.cz>
References: <20181001140910.086E768BC7@newverein.lst.de> <20181001141652.5478C68BE1@newverein.lst.de> <20181023175553.gaobskk26koft6s2@linux-8ccs> <20181026172500.g65bl2p7cvey3qsx@linux-8ccs>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> diff --git a/arch/arm64/kernel/module.c b/arch/arm64/kernel/module.c
> index dd23655fda3a..490e56070a7e 100644
> --- a/arch/arm64/kernel/module.c
> +++ b/arch/arm64/kernel/module.c
> @@ -461,5 +461,15 @@ int module_finalize(const Elf_Ehdr *hdr,
> #endif
> 	}
> 
> +#ifdef CONFIG_LIVEPATCH
> +	/*
> +	 * For livepatching, switch to the saved section header info for .plt
> +	 * stored in mod->klp_info. This is needed so that livepatch is able to
> +	 * call apply_relocate_add() after patch module load.
> +	 */
> +	if (is_livepatch_module(me))
> +		me->arch.core.plt = me->klp_info->sechdrs + me->arch.core.plt_shndx;
> +#endif

I missed it before, but the hunk should be under "#ifdef 
CONFIG_ARM64_MODULE_PLTS" protection similarly to ftrace_trampoline just 
above. me->arch.core.plt may not exist otherwise.

Miroslav
