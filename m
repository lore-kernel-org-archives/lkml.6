Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50E99C282CB
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 09:04:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23EBC2147C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 09:04:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qncDYqT3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727539AbfBHJEM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 04:04:12 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:43242 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbfBHJEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 04:04:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ER8lPzip1hTSPeJiD4Wo8QbeZrrPyfhHxVe9hx9JkmU=; b=qncDYqT3LdliBD+G0UgYHf0yh
        VQdmHHKuDYbg27mTQ7H6f3s1ndOqfBC3ivzKhXSa84fsK5919zoEN8zrIJbLZzP3GK4eRkqRv7l0Q
        yRZYBonbnn3S3J1KEbnAMlaEa5Wm09uBZZRtAeuT38e5FKLKS74900FbjeDZJSJ+B/h56VXU6DWkk
        LW++4bH4GnptX2wfv+JIgbdTb6a0Yfii+DqZg41qJ1R2Pag7JB2z1WK13JJlnWI7mcFsLys3K99aE
        kIiGs+p4gcteNT3Aqowl5Fam050GWTuHO5k/oMNWvrVAhIRVuwWAEFIccMmsQNe9CU9i2GzVU67jw
        0Oj+XI8Sg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gs24r-0004ig-Kh; Fri, 08 Feb 2019 09:04:05 +0000
Date:   Fri, 8 Feb 2019 01:04:05 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Atish Patra <atish.patra@wdc.com>
Cc:     linux-riscv@lists.infradead.org,
        Patrick =?iso-8859-1?Q?St=E4hlin?= <me@packi.ch>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Alan Kao <alankao@andestech.com>,
        Dmitriy Cherkasov <dmitriy@oss-tech.org>,
        Anup Patel <anup@brainfault.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-kernel@vger.kernel.org, Zong Li <zongbox@gmail.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Andreas Schwab <schwab@suse.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [v3 PATCH 6/8] clocksource/drivers/riscv: Add required checks
 during clock source init
Message-ID: <20190208090405.GC16932@infradead.org>
References: <1549590681-24125-1-git-send-email-atish.patra@wdc.com>
 <1549590681-24125-7-git-send-email-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1549590681-24125-7-git-send-email-atish.patra@wdc.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 07, 2019 at 05:51:19PM -0800, Atish Patra wrote:
> Currently, clocksource registration happens for an invalid cpu
> for non-smp kernels. This lead to kernel panic as cpu hotplug
> registration will fail for those cpus. Moreover,
> riscv_hartid_to_cpuid can return errors now.
> 
> Do not proceed if hartid or cpuid is invalid. Take this opprtunity
> to print appropriate error strings for different failure cases.
> 
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> ---
>  drivers/clocksource/timer-riscv.c | 23 ++++++++++++++++++++---
>  1 file changed, 20 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/timer-riscv.c
> index 43189220..3c7ea75b 100644
> --- a/drivers/clocksource/timer-riscv.c
> +++ b/drivers/clocksource/timer-riscv.c
> @@ -95,13 +95,30 @@ static int __init riscv_timer_init_dt(struct device_node *n)
>  	struct clocksource *cs;
>  
>  	hartid = riscv_of_processor_hartid(n);
> +	if (hartid < 0) {
> +		pr_warn("Not valid hartid for node [%pOF] error = [%d]\n",
> +			n, hartid);
> +		return hartid;
> +	}
> +
>  	cpuid = riscv_hartid_to_cpuid(hartid);
> +	if (cpuid < 0) {
> +		pr_warn("Invalid cpuid for hartid [%d]\n", hartid);
> +		return cpuid;
> +	}
>  
>  	if (cpuid != smp_processor_id())
>  		return 0;
>  
> +	pr_err("%s: Registering clocksource cpuid [%d] hartid [%d]\n",
> +	       __func__, cpuid, hartid);

This does not look like an error case to me.  At best it is info,
if not debug.
