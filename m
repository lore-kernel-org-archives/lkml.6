Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A288FC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 06:03:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 413EE20837
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 06:03:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XbwCT1fy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 413EE20837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727340AbeHaKJp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 06:09:45 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37062 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727211AbeHaKJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 06:09:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ff0bXRnW8kfax3YG7Kxwnxtb+n4ZS78GOzy1P0nb5a8=; b=XbwCT1fyTvF1qc7aY72C4Hhig
        X753kdmclZ2B7huDlJQ9Zp8b9nCjZP8OfujeWEJesYUgKNovy2G3NdS/c6GztbD0jwyHMx+0e1zjz
        RsmwlMldOPiY9dzWKmpfrqviJ5Ztjk4gMfPsoxPmTRVr+9zYg49hEV2O+qfcqGMnz6FCm0vqctUS4
        zcI/YRF927vTf4tD0DYB1G3zRigm5RnxyYiWP2U7t9y04O5hYisGLtbY/m7OKZBlI/IQ8NJ0jzmwp
        SQxda6rO5xz9Q75WsFR2ztzWXanwEHJ/5zLK2ZtkLaCju9uWlFFfL6TDQDJewzK0xYb6E6vZBMxqu
        ++Xw/Srdg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fvcXA-0008DM-R7; Fri, 31 Aug 2018 06:03:52 +0000
Date:   Thu, 30 Aug 2018 23:03:52 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Atish Patra <atish.patra@wdc.com>
Cc:     palmer@sifive.com, linux-riscv@lists.infradead.org,
        mark.rutland@arm.com, anup@brainfault.org, hch@infradead.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        damein@vger.kernel.org
Subject: Re: [PATCH v2 1/3] RISC-V: Add logical CPU indexing for RISC-V
Message-ID: <20180831060352.GA19292@infradead.org>
References: <1535445370-19004-1-git-send-email-atish.patra@wdc.com>
 <1535445370-19004-2-git-send-email-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1535445370-19004-2-git-send-email-atish.patra@wdc.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2018 at 01:36:08AM -0700, Atish Patra wrote:
> Currently, both linux cpu id and hardware cpu id are same.
> This is not recommended as it will lead to discontinuous cpu
> indexing in Linux. Moreover, kdump kernel will run from CPU0
> which would be absent if we follow existing scheme.
> 
> Implement a logical mapping between Linux cpu id and hardware
> cpuid to decouple these two. Always mark the boot processor as
> cpu0 and all other cpus get the logical cpu id based on their
> booting order.
> 
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> ---
>  arch/riscv/include/asm/smp.h | 18 +++++++++++++++++-
>  arch/riscv/kernel/setup.c    |  2 ++
>  arch/riscv/kernel/smp.c      | 19 +++++++++++++++++++
>  3 files changed, 38 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/include/asm/smp.h b/arch/riscv/include/asm/smp.h
> index 36016845..a5c257b3 100644
> --- a/arch/riscv/include/asm/smp.h
> +++ b/arch/riscv/include/asm/smp.h
> @@ -22,6 +22,13 @@
>  #include <linux/cpumask.h>
>  #include <linux/irqreturn.h>
>  
> +#define INVALID_HARTID -1
> +/*
> + * Mapping between linux logical cpu index and hartid.
> + */
> +extern unsigned long __cpu_logical_map[NR_CPUS];
> +#define cpu_logical_map(cpu)    __cpu_logical_map[cpu]

How about naming this cpuid_to_hardid_map to make things a little
more obvious?  Also shouldn't this be signed given your INVALID_HARTID
definition above.

> +static inline int riscv_hartid_to_cpuid(int hartid) { return 0 ; }
> +static inline void riscv_cpuid_to_hartid_mask(const struct cpumask *in,
> +				       struct cpumask *out) {
> +	cpumask_set_cpu(cpu_logical_map(0), out);
> +}

Please use normal coding style even for stubs:

static inline int riscv_hartid_to_cpuid(int hartid)
{
	return 0;
}

static inline void riscv_cpuid_to_hartid_mask(const struct cpumask *in,
			struct cpumask *out)
{
	cpumask_set_cpu(cpu_logical_map(0), out);
}

> +unsigned long __cpu_logical_map[NR_CPUS] = { [0 ... NR_CPUS-1] = INVALID_HARTID };

Please break the line into the usual format:

unsigned long __cpu_logical_map[NR_CPUS] = {
	[0 ... NR_CPUS-1]	= INVALID_HARTID,
};
