Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4484EC46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 16:48:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECCB720833
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 16:47:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="C8ZMdAFa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECCB720833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728013AbeILVxS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 17:53:18 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:1265 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727122AbeILVxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 17:53:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1536770877; x=1568306877;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=4JGLCW49XAc08LPM/hSiqTGjQc1iDV4zirRZMm2v+fU=;
  b=C8ZMdAFasDvsu8mfPVevqrQktbMA6Ip2iUJafNWcT2Tki1yV8TgVY90U
   N0vda7asDCJg11hIYfWS+fTmbG+geKV4p+C8BUn5zwEBn+Mmg+GMeiTm8
   otTPGMhXWTGvjaqovtAYtSCTeNc+Zs6eQx3vCkzt3Qn1zvmjFMYv2ty1O
   IcwqHUZoEtzWZSR0vl06QC6GTVasMeTcqc6L7lsED2jDF8nhxZ305ifA/
   SYlt64CjQXeODRRTgSI5bvoQAcgMOKZ+I3KP1xotjbmuEDuOuV4U7+OJU
   6XRece2QSVn1ePkUOTJf9elJ/WHkc+o9/FbW/mNZ/JHjyZ447NZj6HSXG
   A==;
X-IronPort-AV: E=Sophos;i="5.53,365,1531756800"; 
   d="scan'208";a="93993338"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 13 Sep 2018 00:47:57 +0800
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP; 12 Sep 2018 09:34:18 -0700
Received: from 45t6pc2.ad.shared (HELO [10.86.63.194]) ([10.86.63.194])
  by uls-op-cesaip01.wdc.com with ESMTP; 12 Sep 2018 09:47:56 -0700
Subject: Re: [PATCH] RISC-V: Show CPU ID and Hart ID separately in
 /proc/cpuinfo
To:     Anup Patel <anup@brainfault.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20180912143822.21948-1-anup@brainfault.org>
From:   Atish Patra <atish.patra@wdc.com>
Message-ID: <72961c71-c4e4-7990-da64-a7f1613f2e1c@wdc.com>
Date:   Wed, 12 Sep 2018 09:47:55 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180912143822.21948-1-anup@brainfault.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/12/18 7:38 AM, Anup Patel wrote:
> Currently, /proc/cpuinfo show logical CPU ID as Hart ID which
> is in-correct. This patch shows CPU ID and Hart ID separately
> in /proc/cpuinfo using cpuid_to_hardid_map().
> 
> With this patch, contents of /proc/cpuinfo looks as follows:
> cpu	: 0
> hart	: 1
> isa	: rv64imafdcsu
> mmu	: sv48
> 
> cpu	: 1
> hart	: 0
> isa	: rv64imafdcsu
> mmu	: sv48
> 
> cpu	: 2
> hart	: 3
> isa	: rv64imafdcsu
> mmu	: sv48
> 
> cpu	: 3
> hart	: 2
> isa	: rv64imafdcsu
> mmu	: sv48
> 
> Signed-off-by: Anup Patel <anup@brainfault.org>
> ---
>   arch/riscv/kernel/cpu.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
> index f0f0ec2737b7..7c1342e242e6 100644
> --- a/arch/riscv/kernel/cpu.c
> +++ b/arch/riscv/kernel/cpu.c
> @@ -87,7 +87,8 @@ static int c_show(struct seq_file *m, void *v)
>   						   NULL);
>   	const char *compat, *isa, *mmu;
>   
> -	seq_printf(m, "hart\t: %lu\n", cpu_id);
> +	seq_printf(m, "cpu\t: %lu\n", cpu_id);
> +	seq_printf(m, "hart\t: %lu\n", cpuid_to_hardid_map(cpu_id));
>   	if (!of_property_read_string(node, "riscv,isa", &isa)
>   	    && isa[0] == 'r'
>   	    && isa[1] == 'v')
> 

The extra hart information will not be parsed by lscpu which will make 
the cpu information inconsistent between lscpu & /proc/cpuinfo.

Should we patch lscpu as well to show correct hart id as well ?

Regards,
Atish
