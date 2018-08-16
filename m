Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D7B5C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 10:22:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE5FD2148C
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 10:22:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE5FD2148C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390989AbeHPNTq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 09:19:46 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:35274 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729663AbeHPNTq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 09:19:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4FA167A9;
        Thu, 16 Aug 2018 03:22:13 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2080A3F5BC;
        Thu, 16 Aug 2018 03:22:13 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 4E9531AE2DA4; Thu, 16 Aug 2018 11:22:20 +0100 (BST)
Date:   Thu, 16 Aug 2018 11:22:20 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        john.stultz@linaro.org
Subject: Re: AArch64 boot failure on Hikey960 on latest master after "arm64:
 insn: Don't fallback on nosync path for general insn patching"
Message-ID: <20180816102219.GF31093@arm.com>
References: <462f8ae6-9948-a8e5-7504-623d40344336@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <462f8ae6-9948-a8e5-7504-623d40344336@iki.fi>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tuomas, [+John]

On Thu, Aug 16, 2018 at 02:38:51AM +0300, Tuomas Tynkkynen wrote:
> Booting Linus's master of today with the usual arm64 defconfig fails for
> me on the Hikey960 board. I've bisected it down to:
> 
> commit 693350a7998018391852c48f68956cf0f855b2b9 (HEAD, refs/bisect/bad)
> Author: Will Deacon <will.deacon@arm.com>
> Date:   Tue Jun 19 17:55:28 2018 +0100
> 
>     arm64: insn: Don't fallback on nosync path for general insn patching
> 
> Here's the boot log with earlycon enabled after which the boot hangs:

Thanks for the boot log, that's really helpful. Please can you try the diff
below?

Out of interest -- do you know if Hikey960 is used by any boot-testing
farms? The patch above has been in linux-next for ages, but we didn't see
any complaints until it hit mainline :(

Cheers,

Will

--->8

diff --git a/arch/arm64/kernel/jump_label.c b/arch/arm64/kernel/jump_label.c
index c2dd1ad3e648..e0756416e567 100644
--- a/arch/arm64/kernel/jump_label.c
+++ b/arch/arm64/kernel/jump_label.c
@@ -36,7 +36,7 @@ void arch_jump_label_transform(struct jump_entry *entry,
 		insn = aarch64_insn_gen_nop();
 	}
 
-	aarch64_insn_patch_text(&addr, &insn, 1);
+	aarch64_insn_patch_text_nosync(addr, insn);
 }
 
 void arch_jump_label_transform_static(struct jump_entry *entry,
