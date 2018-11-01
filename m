Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C376C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 16:07:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D49A12081B
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 16:07:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D49A12081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728952AbeKBBL3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 21:11:29 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:58578 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728078AbeKBBL3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 21:11:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D7DF2341;
        Thu,  1 Nov 2018 09:07:51 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 955B53F716;
        Thu,  1 Nov 2018 09:07:51 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id C0A0F1AE0D51; Thu,  1 Nov 2018 16:07:59 +0000 (GMT)
Date:   Thu, 1 Nov 2018 16:07:59 +0000
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
Message-ID: <20181101160759.GB17659@arm.com>
References: <20181001140910.086E768BC7@newverein.lst.de>
 <20181001141652.5478C68BE1@newverein.lst.de>
 <20181023175553.gaobskk26koft6s2@linux-8ccs>
 <20181026172500.g65bl2p7cvey3qsx@linux-8ccs>
 <20181029152834.GA16289@arm.com>
 <20181030131910.zuqw523rq4pi7apb@linux-8ccs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181030131910.zuqw523rq4pi7apb@linux-8ccs>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Jessica,

On Tue, Oct 30, 2018 at 02:19:10PM +0100, Jessica Yu wrote:
> +++ Will Deacon [29/10/18 15:28 +0000]:
> >On Fri, Oct 26, 2018 at 07:25:01PM +0200, Jessica Yu wrote:
> >>diff --git a/arch/arm64/include/asm/module.h b/arch/arm64/include/asm/module.h
> >>index fef773c94e9d..ac9b97f9ae5e 100644
> >>--- a/arch/arm64/include/asm/module.h
> >>+++ b/arch/arm64/include/asm/module.h
> >>@@ -25,6 +25,7 @@ struct mod_plt_sec {
> >>	struct elf64_shdr	*plt;
> >>	int			plt_num_entries;
> >>	int			plt_max_entries;
> >>+	int			plt_shndx;
> >>};
> >
> >Does this mean we can drop the plt pointer from this struct altogether, and
> >simply offset into the section headers when applying the relocations?
> 
> Hmm, if everyone is OK with dropping the plt pointer from struct
> mod_plt_sec, then I think we can simplify this patch even further.
> 
> With the plt shndx saved, we can additionally pass a pointer to
> sechdrs to module_emit_plt_entry(), and with that just offset into the
> section headers as you suggest. Since livepatch *already* passes in
> the correct copy of the section headers (mod->klp_info->sechdrs) to
> apply_relocate_add(), we wouldn't even need to modify the arm64
> module_finalize() to change mod->arch.core.plt to point into
> mod->klp_info->sechdrs anymore and we can drop all the changes to the
> module loader too.
> 
> Something like the following maybe?

This looks pretty good, thanks! My only (minor) objection is that the
renaming of plt_sec -> plt_info throughout makes the patch a lot more
churny than it needs to be, for questionable gain.

Anyway, it looks functionally correct and I've tested loading/unloading
the "hello world" test module with both PLTs enabled and disabled.

Acked-by: Will Deacon <will.deacon@arm.com>

Will
