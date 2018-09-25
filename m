Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94A80ECE561
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 17:59:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45C4620896
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 17:59:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="AIt4OHiB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45C4620896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbeIZAH4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 20:07:56 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:59903 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbeIZAHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 20:07:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1537898356; x=1569434356;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=oMORr6Kizmx+pFnLR4tO58Zyb5lS31vTL3ABJutV9n0=;
  b=AIt4OHiBdBq1xmrTTLKLxTCGeshoDb4RBv3DDVJ86qodtdQ0NkbMbGtb
   H/e0LCLkarx6bRC3qHE7bqAGkb9iK5d/RxvcyQyhxiMD3tkh7T/dwTuBL
   NMc1Py283W6lzkpjXYlK+UmPtHNCYhuh63cf+lDrYMUC07tP5R9yH5oxo
   hb6/w3plFylNAOdq/5e7MgIgLYLgdjctRfJeNWhoEstbr1dscrUJHhgtV
   cyTICQmJDKPOHr8gXJXpA3/qdgcr9oB2jby7viW8KsLPCA1RCHIz4w97A
   mZyF3TeRsVOc4o1S0HL5TfVbT3b4usdyZapsEMYNCh1rw2x3cITPdimem
   w==;
X-IronPort-AV: E=Sophos;i="5.54,303,1534780800"; 
   d="scan'208";a="194779829"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 26 Sep 2018 01:59:15 +0800
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP; 25 Sep 2018 10:45:04 -0700
Received: from c02v91rdhtd5.sdcorp.global.sandisk.com (HELO [10.196.159.148]) ([10.196.159.148])
  by uls-op-cesaip01.wdc.com with ESMTP; 25 Sep 2018 10:59:15 -0700
Subject: Re: [PATCH v2] RISC-V: Show CPU ID and Hart ID separately in
 /proc/cpuinfo
To:     Anup Patel <anup@brainfault.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20180923133737.22693-1-anup@brainfault.org>
From:   Atish Patra <atish.patra@wdc.com>
Message-ID: <a7c64e1a-405e-6a2c-cb42-211c4f89367d@wdc.com>
Date:   Tue, 25 Sep 2018 10:59:15 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180923133737.22693-1-anup@brainfault.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/23/18 6:37 AM, Anup Patel wrote:
> Currently, /proc/cpuinfo show logical CPU ID as Hart ID which
> is in-correct. This patch shows CPU ID and Hart ID separately
> in /proc/cpuinfo using cpuid_to_hardid_map().
> 
I noticed it should be cpuid_to_hartid_map instead of 
cpuid_to_hardid_map. It was a typo in my smp cleanup patch series.
Sorry for the inconvenience here.

I can include this patch in into my series fixing the typo if you want.

Regards,
Atish
> With this patch, contents of /proc/cpuinfo looks as follows:
> processor	: 0
> hart		: 1
> isa		: rv64imafdc
> mmu		: sv48
> 
> processor	: 1
> hart		: 0
> isa		: rv64imafdc
> mmu		: sv48
> 
> processor	: 2
> hart		: 2
> isa		: rv64imafdc
> mmu		: sv48
> 
> processor	: 3
> hart		: 3
> isa		: rv64imafdc
> mmu		: sv48
> 
> Signed-off-by: Anup Patel <anup@brainfault.org>
> ---
> 
> Changes since v1:
>   - Show logical CPU ID as "processor" attribute in /proc/cpuinfo
> 
>   arch/riscv/kernel/cpu.c | 10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
> index 36b6ddb19b4d..392c7c19c4a3 100644
> --- a/arch/riscv/kernel/cpu.c
> +++ b/arch/riscv/kernel/cpu.c
> @@ -81,7 +81,7 @@ static void print_isa(struct seq_file *f, const char *orig_isa)
>   #endif
>   
>   	/* Print the base ISA, as we already know it's legal. */
> -	seq_puts(f, "isa\t: ");
> +	seq_puts(f, "isa\t\t: ");
>   	seq_write(f, isa, 5);
>   	isa += 5;
>   
> @@ -96,6 +96,7 @@ static void print_isa(struct seq_file *f, const char *orig_isa)
>   			isa++;
>   		}
>   	}
> +	seq_puts(f, "\n");
>   
>   	/*
>   	 * If we were given an unsupported ISA in the device tree then print
> @@ -116,7 +117,7 @@ static void print_mmu(struct seq_file *f, const char *mmu_type)
>   		return;
>   #endif
>   
> -	seq_printf(f, "mmu\t: %s\n", mmu_type+6);
> +	seq_printf(f, "mmu\t\t: %s\n", mmu_type+6);
>   }
>   
>   static void *c_start(struct seq_file *m, loff_t *pos)
> @@ -144,14 +145,15 @@ static int c_show(struct seq_file *m, void *v)
>   						   NULL);
>   	const char *compat, *isa, *mmu;
>   
> -	seq_printf(m, "hart\t: %lu\n", cpu_id);
> +	seq_printf(m, "processor\t: %lu\n", cpu_id);
> +	seq_printf(m, "hart\t\t: %lu\n", cpuid_to_hardid_map(cpu_id));
>   	if (!of_property_read_string(node, "riscv,isa", &isa))
>   		print_isa(m, isa);
>   	if (!of_property_read_string(node, "mmu-type", &mmu))
>   		print_mmu(m, mmu);
>   	if (!of_property_read_string(node, "compatible", &compat)
>   	    && strcmp(compat, "riscv"))
> -		seq_printf(m, "uarch\t: %s\n", compat);
> +		seq_printf(m, "uarch\t\t: %s\n", compat);
>   	seq_puts(m, "\n");
>   
>   	return 0;
> 

