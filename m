Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25195C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 22:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CA8E21531
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 22:20:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=permerror (0-bit key) header.d=wdc.com header.i=@wdc.com header.b="PUgDV1EV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CA8E21531
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731014AbeHCANL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 20:13:11 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:43833 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbeHCANL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 20:13:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1533249419; x=1564785419;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=cBqTTTw6dfJeAS/bV04IXvg0qkwKnKHgMk5K88N1tyc=;
  b=PUgDV1EVQybKrnTiij+Pmp+LW7xBRQO+3sGWfeprGFoHSNYpd8PTS26R
   GxNh/KUFsf4vEulEiLJuacfx01K91S1Qyu/MaqbpC5d+shHuQooALVt4v
   Bjg97cf0BSF6xkgnyoweoCASMKvtdnaNUyxwMHu9eTvNBmEHCuHC5Q6Df
   cb7Rjf7Kran7k1MfYsx5+1VnDdC7ekvsRSAYiYkYHinXdiA/ze5qN2ljf
   TKFJATDsX/7ZgY8FBf84wrv4OKvbXJE2UOhoX1c+j9xbbhPkJXlm6gyvV
   VQ7EWBLVvjxOjfU43tAr2MKvXOLi6pLxP0H0WNP71R5b/TcxnEKhHAYbL
   Q==;
X-IronPort-AV: E=Sophos;i="5.51,437,1526313600"; 
   d="scan'208";a="183419622"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 03 Aug 2018 06:36:40 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 02 Aug 2018 15:07:37 -0700
Received: from c02v91rdhtd5.sdcorp.global.sandisk.com (HELO [10.196.159.148]) ([10.196.159.148])
  by uls-op-cesaip02.wdc.com with ESMTP; 02 Aug 2018 15:19:50 -0700
Subject: Re: [PATCH 09/11] RISC-V: Support per-hart timebase-frequency
To:     Christoph Hellwig <hch@lst.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "palmer@sifive.com" <palmer@sifive.com>,
        "jason@lakedaemon.net" <jason@lakedaemon.net>,
        "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>
Cc:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "anup@brainfault.org" <anup@brainfault.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "shorne@gmail.com" <shorne@gmail.com>
References: <20180802115008.4031-1-hch@lst.de>
 <20180802115008.4031-10-hch@lst.de>
From:   Atish Patra <atish.patra@wdc.com>
Message-ID: <fef973e1-6efc-0eff-2789-4a4b5b01900b@wdc.com>
Date:   Thu, 2 Aug 2018 15:19:49 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180802115008.4031-10-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/2/18 4:50 AM, Christoph Hellwig wrote:
> From: Palmer Dabbelt <palmer@sifive.com>
> 
> Follow the updated DT specs and read the timebase-frequency from the
> CPU 0 node.
> 

However, the DT in the HighFive Unleashed has the entry at the wrong place.

Even the example in github also at wrong place.
https://github.com/riscv/riscv-device-tree-doc/pull/8/commits/2461d481329c55005fcbe684f0d6bdb3b7f0a432

DT should be consistent between Documentation and the one in the 
hardware. I can fix them in bbl & submit a bbl patch. But I am not sure 
if that's an acceptable way to do it.

Regards,
Atish
> Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>
> [hch: updated changelog]
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   arch/riscv/kernel/time.c | 17 ++++++++++++-----
>   1 file changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/riscv/kernel/time.c b/arch/riscv/kernel/time.c
> index 0df9b2cbd645..1bb01dc2d0f1 100644
> --- a/arch/riscv/kernel/time.c
> +++ b/arch/riscv/kernel/time.c
> @@ -24,17 +24,24 @@ void __init init_clockevent(void)
>   	csr_set(sie, SIE_STIE);
>   }
>   
> -void __init time_init(void)
> +static long __init timebase_frequency(void)
>   {
>   	struct device_node *cpu;
>   	u32 prop;
>   
>   	cpu = of_find_node_by_path("/cpus");
> -	if (!cpu || of_property_read_u32(cpu, "timebase-frequency", &prop))
> -		panic(KERN_WARNING "RISC-V system with no 'timebase-frequency' in DTS\n");
> -	riscv_timebase = prop;
> +	if (cpu && !of_property_read_u32(cpu, "timebase-frequency", &prop))
> +		return prop;
> +	cpu = of_find_node_by_path("/cpus/cpu@0");
> +	if (cpu && !of_property_read_u32(cpu, "timebase-frequency", &prop))
> +		return prop;
>   
> -	lpj_fine = riscv_timebase / HZ;
> +	panic(KERN_WARNING "RISC-V system with no 'timebase-frequency' in DTS\n");
> +}
>   
> +void __init time_init(void)
> +{
> +	riscv_timebase = timebase_frequency();
> +	lpj_fine = riscv_timebase / HZ;
>   	init_clockevent();
>   }
> 

