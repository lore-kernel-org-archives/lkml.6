Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76041C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 23:56:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B98620869
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 23:56:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Bcb+eUHT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727203AbeLRX4A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 18:56:00 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:61078 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726590AbeLRXz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 18:55:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1545177359; x=1576713359;
  h=subject:from:to:cc:references:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=y2b/sktj+XFBb0QeOZRsAE7cZ9vVpwFIlsMXq0GYU9o=;
  b=Bcb+eUHTEL9G1Z2+VnD7oayttvr+H4kZSQw3Ni/v1lZXq0rC1NhG0+vy
   xZUrXaShxrwMcTs7lkHA1GdA0Q3fpoe7cpbcIeTkcZkSlEguj+KAUjCW7
   Vdz7fF5ah/ekigJnVAXnjH+oDlTMRDsTWqV79bnWOwvgHC4Uusb/26Ajb
   vLzttNVATqV5VQt1+E/367ovgoRzMyCcMY6Fblt4YQGocr8UwDnLenpP+
   iItrxWutYjIqBckMPNehAmIrwtxhySmtK6ZaCC8nh12HTcAqUH4MzysHQ
   rViWWb/h+mzXJNnUFrHKQIfISD37J7tweMVV3Z8euQI7sL7fH8MyElG3Q
   g==;
X-IronPort-AV: E=Sophos;i="5.56,370,1539619200"; 
   d="scan'208";a="201619267"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 Dec 2018 07:55:43 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP; 18 Dec 2018 15:36:56 -0800
Received: from c02v91rdhtd5.sdcorp.global.sandisk.com (HELO [10.111.68.123]) ([10.111.68.123])
  by uls-op-cesaip02.wdc.com with ESMTP; 18 Dec 2018 15:55:44 -0800
Subject: Re: [PATCH] RISC-V: Fix of_node_* refcount
From:   Atish Patra <atish.patra@wdc.com>
To:     "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Cc:     "palmer@sifive.com" <palmer@sifive.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "anup@brainfault.org" <anup@brainfault.org>,
        "jeremy.linton@arm.com" <jeremy.linton@arm.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "schwab@suse.de" <schwab@suse.de>
References: <1542755270-10433-1-git-send-email-atish.patra@wdc.com>
Message-ID: <99bcf158-80f2-efa8-cbcb-01493185852d@wdc.com>
Date:   Tue, 18 Dec 2018 15:55:42 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <1542755270-10433-1-git-send-email-atish.patra@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/20/18 3:07 PM, Atish Patra wrote:
> Fix of_node* refcount at various places by using of_node_put.
> 
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> ---
>   arch/riscv/kernel/cacheinfo.c  | 11 +++++++++++
>   arch/riscv/kernel/cpu.c        |  1 +
>   arch/riscv/kernel/cpufeature.c |  2 ++
>   arch/riscv/kernel/perf_event.c |  1 +
>   arch/riscv/kernel/smpboot.c    |  6 +++++-
>   5 files changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/kernel/cacheinfo.c b/arch/riscv/kernel/cacheinfo.c
> index cb35ffd8..638dee3f 100644
> --- a/arch/riscv/kernel/cacheinfo.c
> +++ b/arch/riscv/kernel/cacheinfo.c
> @@ -28,6 +28,7 @@ static int __init_cache_level(unsigned int cpu)
>   {
>   	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
>   	struct device_node *np = of_cpu_device_node_get(cpu);
> +	struct device_node *prev = NULL;
>   	int levels = 0, leaves = 0, level;
>   
>   	if (of_property_read_bool(np, "cache-size"))
> @@ -39,7 +40,10 @@ static int __init_cache_level(unsigned int cpu)
>   	if (leaves > 0)
>   		levels = 1;
>   
> +	prev = np;
>   	while ((np = of_find_next_cache_node(np))) {
> +		of_node_put(prev);
> +		prev = np;
>   		if (!of_device_is_compatible(np, "cache"))
>   			break;
>   		if (of_property_read_u32(np, "cache-level", &level))
> @@ -55,8 +59,10 @@ static int __init_cache_level(unsigned int cpu)
>   		levels = level;
>   	}
>   
> +	of_node_put(np);
>   	this_cpu_ci->num_levels = levels;
>   	this_cpu_ci->num_leaves = leaves;
> +
>   	return 0;
>   }
>   
> @@ -65,6 +71,7 @@ static int __populate_cache_leaves(unsigned int cpu)
>   	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
>   	struct cacheinfo *this_leaf = this_cpu_ci->info_list;
>   	struct device_node *np = of_cpu_device_node_get(cpu);
> +	struct device_node *prev = NULL;
>   	int levels = 1, level = 1;
>   
>   	if (of_property_read_bool(np, "cache-size"))
> @@ -74,7 +81,10 @@ static int __populate_cache_leaves(unsigned int cpu)
>   	if (of_property_read_bool(np, "d-cache-size"))
>   		ci_leaf_init(this_leaf++, np, CACHE_TYPE_DATA, level);
>   
> +	prev = np;
>   	while ((np = of_find_next_cache_node(np))) {
> +		of_node_put(prev);
> +		prev = np;
>   		if (!of_device_is_compatible(np, "cache"))
>   			break;
>   		if (of_property_read_u32(np, "cache-level", &level))
> @@ -89,6 +99,7 @@ static int __populate_cache_leaves(unsigned int cpu)
>   			ci_leaf_init(this_leaf++, np, CACHE_TYPE_DATA, level);
>   		levels = level;
>   	}
> +	of_node_put(np);
>   
>   	return 0;
>   }
> diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
> index 3a5a2ee3..7b3eb970 100644
> --- a/arch/riscv/kernel/cpu.c
> +++ b/arch/riscv/kernel/cpu.c
> @@ -155,6 +155,7 @@ static int c_show(struct seq_file *m, void *v)
>   	    && strcmp(compat, "riscv"))
>   		seq_printf(m, "uarch\t\t: %s\n", compat);
>   	seq_puts(m, "\n");
> +	of_node_put(node);
>   
>   	return 0;
>   }
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> index 0339087a..a6e369ed 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -56,8 +56,10 @@ void riscv_fill_hwcap(void)
>   
>   	if (of_property_read_string(node, "riscv,isa", &isa)) {
>   		pr_warning("Unable to find \"riscv,isa\" devicetree entry");
> +		of_node_put(node);
>   		return;
>   	}
> +	of_node_put(node);
>   
>   	for (i = 0; i < strlen(isa); ++i)
>   		elf_hwcap |= isa2hwcap[(unsigned char)(isa[i])];
> diff --git a/arch/riscv/kernel/perf_event.c b/arch/riscv/kernel/perf_event.c
> index a243fae1..667ee70d 100644
> --- a/arch/riscv/kernel/perf_event.c
> +++ b/arch/riscv/kernel/perf_event.c
> @@ -476,6 +476,7 @@ int __init init_hw_perf_events(void)
>   
>   		if (of_id)
>   			riscv_pmu = of_id->data;
> +		of_node_put(node);
>   	}
>   
>   	perf_pmu_register(riscv_pmu->pmu, "cpu", PERF_TYPE_RAW);
> diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
> index 18cda0e8..fc185eca 100644
> --- a/arch/riscv/kernel/smpboot.c
> +++ b/arch/riscv/kernel/smpboot.c
> @@ -57,12 +57,15 @@ void __init setup_smp(void)
>   
>   	while ((dn = of_find_node_by_type(dn, "cpu"))) {
>   		hart = riscv_of_processor_hartid(dn);
> -		if (hart < 0)
> +		if (hart < 0) {
> +			of_node_put(dn);
>   			continue;
> +		}
>   
>   		if (hart == cpuid_to_hartid_map(0)) {
>   			BUG_ON(found_boot_cpu);
>   			found_boot_cpu = 1;
> +			of_node_put(dn);
>   			continue;
>   		}
>   
> @@ -70,6 +73,7 @@ void __init setup_smp(void)
>   		set_cpu_possible(cpuid, true);
>   		set_cpu_present(cpuid, true);
>   		cpuid++;
> +		of_node_put(dn);
>   	}
>   
>   	BUG_ON(!found_boot_cpu);
> 

ping ?

Regards,
Atish
