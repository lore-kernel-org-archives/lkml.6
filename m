Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0E64C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 11:11:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B04AD222B2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 11:11:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390497AbfBMLLM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 06:11:12 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:51746 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727894AbfBMLLL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 06:11:11 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0F58BA78;
        Wed, 13 Feb 2019 03:11:11 -0800 (PST)
Received: from [10.1.197.45] (e112298-lin.cambridge.arm.com [10.1.197.45])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 176FB3F557;
        Wed, 13 Feb 2019 03:11:06 -0800 (PST)
Subject: Re: [PATCH v8 0/5] arm64: ftrace with regs
To:     Torsten Duwe <duwe@lst.de>, Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        live-patching@vger.kernel.org
References: <20190208150826.44EBC68DD2@newverein.lst.de>
From:   Julien Thierry <julien.thierry@arm.com>
Message-ID: <0f8d2e77-7e51-fba8-b179-102318d9ff84@arm.com>
Date:   Wed, 13 Feb 2019 11:11:04 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190208150826.44EBC68DD2@newverein.lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Torsten,

On 08/02/2019 15:08, Torsten Duwe wrote:
> Patch series v8, as discussed.
> The whole series applies cleanly on 5.0-rc5
> 

For this series:

Tested-by: Julien Thierry <julien.thierry@arm.com>

> ---
>  arch/arm64/Kconfig                    |    4 +
>  arch/arm64/Makefile                   |   10 ++
>  arch/arm64/include/asm/ftrace.h       |   16 ++++
>  arch/arm64/include/asm/module.h       |    3 
>  arch/arm64/kernel/Makefile            |   12 +--
>  arch/arm64/kernel/entry-ftrace.S      |  125 ++++++++++++++++++++++++++++++++--
>  arch/arm64/kernel/ftrace.c            |  117 ++++++++++++++++++++++++-------
>  arch/arm64/kernel/module-plts.c       |    3 
>  arch/arm64/kernel/module.c            |    2 
>  arch/arm64/lib/Makefile               |    4 -
>  drivers/firmware/efi/libstub/Makefile |   12 +--
>  include/asm-generic/vmlinux.lds.h     |    2 
>  include/linux/compiler_types.h        |    4 +
>  kernel/module.c                       |   14 +++
>  mm/kasan/Makefile                     |    8 +-
>  15 files changed, 281 insertions(+), 55 deletions(-)
> ---
> changes since v7:
> 
> * -pg -> $(CC_FLAGS_FTRACE) cleanup now split according to subtree
>   maintainership.
> 
> * REC_IP_BRANCH_OFFSET is gone, the functionality went into
>   ftrace_call_adjust(), where it belongs.
> 
> * MOV_X9_X30 macro is gone (why did we argue about its name anyway?);
>   it is only used once now in the initial ftrace_make_nop new helper
>   function ftrace_setup_lr_saver(), suggested by Julien.
> 
> * call site processing was missing for modules. Fixed.
> 
> changes since v6:
> 
> * change the stack layout once more; I hope I have it the "standard" way now.
>   And yes, it looks simpler and cleaner; thanks, Mark, for nagging.
> 
> * split out the independent Kconfig and Makefile changes
> 
> * fixed style issues
> 
> * s/fp/x29/g
> 
> * MCOUNT_ADDR is now merely a 64-bit magic, as this is totally sufficient.
> 
> * QUICK_LR_SAVE renamed back to MOV_X9_X30.
> 
> * place MOV_X9_X30 insns on bootup, and only flip b <-> nop at runtime
> 
> * graph tracer "ifdeffery" reshuffle
> 
> 	Torsten
>   
> 

-- 
Julien Thierry
