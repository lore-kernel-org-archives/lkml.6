Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD007C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 15:28:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F64320657
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 15:28:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F64320657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727644AbeJ3ARe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 20:17:34 -0400
Received: from foss.arm.com ([217.140.101.70]:42280 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726741AbeJ3ARd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 20:17:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9C5BD341;
        Mon, 29 Oct 2018 08:28:27 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6BA5B3F71D;
        Mon, 29 Oct 2018 08:28:27 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 71FF21AE091C; Mon, 29 Oct 2018 15:28:34 +0000 (GMT)
Date:   Mon, 29 Oct 2018 15:28:34 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Torsten Duwe <duwe@lst.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Petr Mladek <pmladek@suse.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        live-patching@vger.kernel.org
Subject: Re: [PATCH v2] arm64/module: use mod->klp_info section header
 information for livepatch modules
Message-ID: <20181029152834.GA16289@arm.com>
References: <20181001140910.086E768BC7@newverein.lst.de>
 <20181001141652.5478C68BE1@newverein.lst.de>
 <20181023175553.gaobskk26koft6s2@linux-8ccs>
 <20181026172500.g65bl2p7cvey3qsx@linux-8ccs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181026172500.g65bl2p7cvey3qsx@linux-8ccs>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jessica,

On Fri, Oct 26, 2018 at 07:25:01PM +0200, Jessica Yu wrote:
> The arm64 module loader keeps a pointer into info->sechdrs to keep track
> of section header information for .plt section(s). A pointer to the
> relevent section header (struct elf64_shdr) in info->sechdrs is stored
> in mod->arch.{init,core}.plt. This pointer may be accessed while
> applying relocations in apply_relocate_add() for example. And unlike
> normal modules, livepatch modules can call apply_relocate_add() after
> module load. But the info struct (and therefore info->sechdrs) gets
> freed at the end of load_module() and so mod->arch.{init,core}.plt
> becomes an invalid pointer after the module is done loading.
> 
> Luckily, livepatch modules already keep a copy of Elf section header
> information in mod->klp_info. So make sure livepatch modules on arm64
> have access to the section headers in klp_info and set
> mod->arch.{init,core}.plt to the appropriate section header in
> mod->klp_info so that they can call apply_relocate_add() even after
> module load.
> 
> Signed-off-by: Jessica Yu <jeyu@kernel.org>
> ---
> 
> v2:
>  - fix missing free_module_elf() in error path
>  - move copy_module_elf() and module_finalize() out of post_relocation()
>    to make error handling more clear
>  - add braces to if-else block in arm64 module_frob_arch_sections()
> 
> arch/arm64/include/asm/module.h |  1 +
> arch/arm64/kernel/module-plts.c | 17 ++++++++++++-----
> arch/arm64/kernel/module.c      | 10 ++++++++++
> kernel/module.c                 | 29 +++++++++++++++--------------
> 4 files changed, 38 insertions(+), 19 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/module.h b/arch/arm64/include/asm/module.h
> index fef773c94e9d..ac9b97f9ae5e 100644
> --- a/arch/arm64/include/asm/module.h
> +++ b/arch/arm64/include/asm/module.h
> @@ -25,6 +25,7 @@ struct mod_plt_sec {
> 	struct elf64_shdr	*plt;
> 	int			plt_num_entries;
> 	int			plt_max_entries;
> +	int			plt_shndx;
> };

Does this mean we can drop the plt pointer from this struct altogether, and
simply offset into the section headers when applying the relocations?

Cheers,

Will
