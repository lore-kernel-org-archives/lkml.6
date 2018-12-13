Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DE28C67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 18:12:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4879E20870
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 18:12:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4879E20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729899AbeLMSMz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 13:12:55 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:39962 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727929AbeLMSMy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 13:12:54 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 63347A78;
        Thu, 13 Dec 2018 10:12:54 -0800 (PST)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 32EA13F575;
        Thu, 13 Dec 2018 10:12:54 -0800 (PST)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 16B9A1AE0838; Thu, 13 Dec 2018 18:13:18 +0000 (GMT)
Date:   Thu, 13 Dec 2018 18:13:18 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     Miles Chen <miles.chen@mediatek.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, wsd_upstream@mediatek.com,
        ard.biesheuvel@linaro.org
Subject: Re: [PATCH] arm64: kaslr: print PHYS_OFFSET in dump_kernel_offset()
Message-ID: <20181213181317.GD18185@edgewater-inn.cambridge.arm.com>
References: <1544612209-13660-1-git-send-email-miles.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544612209-13660-1-git-send-email-miles.chen@mediatek.com>
User-Agent: Mutt/1.11.1+30 (d10eec459b35) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[+Ard because I'll basically go with his preference on this one]

On Wed, Dec 12, 2018 at 06:56:49PM +0800, Miles Chen wrote:
> When debug with kaslr, it is sometimes necessary to have PHYS_OFFSET to
> perform linear virtual address to physical address translation.
> Sometimes we're debugging with only few information such as a kernel log
> and a symbol file, print PHYS_OFFSET in dump_kernel_offset() for that case.
> 
> Tested by:
> echo c > /proc/sysrq-trigger
> [   11.996161] SMP: stopping secondary CPUs
> [   11.996732] Kernel Offset: 0x2522200000 from 0xffffff8008000000
> [   11.996881] PHYS_OFFSET: 0xffffffeb40000000
> 
> Signed-off-by: Miles Chen <miles.chen@mediatek.com>
> Tested-by: Miles Chen <miles.chen@mediatek.com>
> ---
>  arch/arm64/kernel/setup.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> index f4fc1e0544b7..4b0e1231625c 100644
> --- a/arch/arm64/kernel/setup.c
> +++ b/arch/arm64/kernel/setup.c
> @@ -388,6 +388,7 @@ static int dump_kernel_offset(struct notifier_block *self, unsigned long v,
>  	if (IS_ENABLED(CONFIG_RANDOMIZE_BASE) && offset > 0) {
>  		pr_emerg("Kernel Offset: 0x%lx from 0x%lx\n",
>  			 offset, KIMAGE_VADDR);
> +		pr_emerg("PHYS_OFFSET: 0x%llx\n", PHYS_OFFSET);
>  	} else {
>  		pr_emerg("Kernel Offset: disabled\n");
>  	}
> -- 
> 2.18.0
> 
