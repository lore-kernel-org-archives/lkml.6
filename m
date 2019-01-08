Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43823C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 10:33:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DFBF20850
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 10:33:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="qihHki2h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728676AbfAHKdG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 05:33:06 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:44551 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728118AbfAHKdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 05:33:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1546943586; x=1578479586;
  h=subject:from:to:cc:references:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=hq5oGPu07KlC+0CLOCmKx2M1enW77+L+m4qZ8+kveQA=;
  b=qihHki2h5enXPTB0JlGpfOaFvW4BlZVYy/VBaI8Em1/VQyQlCuU01ki9
   C3KA2zMXV/Qnp23DmY0Q04dADBAu+E8zImN1d7SxMmOvYdx7Q85kEr+7O
   Cvw+NIY8tMIUQpWmAjXYP0GQQ0LzkfGYyTwSmzr1FZwlFinaGbKz+hDzV
   LI8Fs8NfkVo/f6ouhI9OSWOJdPuGWOBCrAdMn29gQBU9YkdsEdBZuoIzP
   4QtIF/fZbZjLx7fip3GSaOGN9VCdbwKTGV3VkugLt5OrTCiShrWLxo/iG
   4pLtxyYU2jWJttL7ZxZk72ZQkzqm3ppY7BHXEHGDGmtPc/3URmid0asdL
   A==;
X-IronPort-AV: E=Sophos;i="5.56,453,1539619200"; 
   d="scan'208";a="100003278"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 08 Jan 2019 18:33:06 +0800
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP; 08 Jan 2019 02:14:39 -0800
Received: from usa003532.ad.shared (HELO [10.86.59.202]) ([10.86.59.202])
  by uls-op-cesaip01.wdc.com with ESMTP; 08 Jan 2019 02:33:04 -0800
Subject: Re: [PATCH v2 8/8] RISC-V: Assign hwcap only according to current
 cpu.
From:   Atish Patra <atish.patra@wdc.com>
To:     "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Cc:     Alan Kao <alankao@andestech.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andreas Schwab <schwab@suse.de>,
        Anup Patel <anup@brainfault.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Dmitriy Cherkasov <dmitriy@oss-tech.org>,
        Jason Cooper <jason@lakedaemon.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Michael Clark <michaeljclark@mac.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        =?UTF-8?Q?Patrick_St=c3=a4hlin?= <me@packi.ch>,
        Thomas Gleixner <tglx@linutronix.de>,
        Zong Li <zongbox@gmail.com>
References: <1546940318-9752-1-git-send-email-atish.patra@wdc.com>
 <1546940318-9752-9-git-send-email-atish.patra@wdc.com>
Message-ID: <5445186f-db34-d319-5081-37ee1fc58273@wdc.com>
Date:   Tue, 8 Jan 2019 02:33:03 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <1546940318-9752-9-git-send-email-atish.patra@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/8/19 1:38 AM, Atish Patra wrote:
> Currently, we set hwcap based on first valid cpu from
> DT. This may not be correct always as that CPU might not
> be current booting cpu.
> 
> Set hwcap based on the current cpu instead of first
> valid CPU from DT.
> 
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> ---
>   arch/riscv/kernel/cpufeature.c | 11 +++++++----
>   1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> index a6e369ed..ed6122ff 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -43,12 +43,15 @@ void riscv_fill_hwcap(void)
>   	elf_hwcap = 0;
>   
>   	/*
> -	 * We don't support running Linux on hertergenous ISA systems.  For
> -	 * now, we just check the ISA of the first "okay" processor.
> +	 * We don't support running Linux on hertergenous ISA systems.
> +	 * But first "okay" processor might not be the boot cpu.
> +	 * Check the ISA of boot cpu.
>   	 */
> -	while ((node = of_find_node_by_type(node, "cpu")))
> -		if (riscv_of_processor_hartid(node) >= 0)
> +	while ((node = of_find_node_by_type(node, "cpu"))) {
> +		if (riscv_of_processor_hartid(node) == boot_cpu_hartid)
>   			break;
> +	}
> +
>   	if (!node) {
>   		pr_warning("Unable to find \"cpu\" devicetree entry");
>   		return;
> 

Argh..Missed an include while rebasing. Following edit is required for 
non SMP config. I will fix it in v2.

diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index ed6122ff..78379ea3 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -20,6 +20,7 @@
  #include <linux/of.h>
  #include <asm/processor.h>
  #include <asm/hwcap.h>
+#include <asm/smp.h>

Regards,
Atish
