Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 109C3C5CFE7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 23:53:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B42A120858
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 23:53:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B42A120858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754572AbeGIXxF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 19:53:05 -0400
Received: from gate.crashing.org ([63.228.1.57]:44963 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754502AbeGIXw7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 19:52:59 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w69NqL3T024930;
        Mon, 9 Jul 2018 18:52:22 -0500
Message-ID: <66cab64903570ff2ab93e79b4e71223c64cdf283.camel@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Replaced msleep with usleep_range
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Daniel Klamt <eleon@ele0n.de>
Cc:     paulus@samba.org, mpe@ellerman.id.au,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-kernel@i4.cs.fau.de, Bjoern Noetel <bjoern@br3ak3r.de>
Date:   Tue, 10 Jul 2018 09:52:21 +1000
In-Reply-To: <1531144679-31675-1-git-send-email-eleon@ele0n.de>
References: <1531144679-31675-1-git-send-email-eleon@ele0n.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.3 (3.28.3-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-07-09 at 15:57 +0200, Daniel Klamt wrote:
> Replaced msleep for less than 10ms with usleep_range because will
> often sleep longer than intended.
> For original explanation see:
> Documentation/timers/timers-howto.txt

Why ? This is pointless. The original code is smaller and more
readable. We don't care how long it actually sleeps, this is the FW
telling us it's busy (or the HW is), come back a bit later.

Ben.

> Signed-off-by: Daniel Klamt <eleon@ele0n.de>
> Signed-off-by: Bjoern Noetel <bjoern@br3ak3r.de>
> ---
>  arch/powerpc/sysdev/xive/native.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/powerpc/sysdev/xive/native.c b/arch/powerpc/sysdev/xive/native.c
> index 311185b9960a..b164b1cdf4d6 100644
> --- a/arch/powerpc/sysdev/xive/native.c
> +++ b/arch/powerpc/sysdev/xive/native.c
> @@ -109,7 +109,7 @@ int xive_native_configure_irq(u32 hw_irq, u32 target, u8 prio, u32 sw_irq)
>  		rc = opal_xive_set_irq_config(hw_irq, target, prio, sw_irq);
>  		if (rc != OPAL_BUSY)
>  			break;
> -		msleep(1);
> +		usleep_range(1000, 1100)
>  	}
>  	return rc == 0 ? 0 : -ENXIO;
>  }
> @@ -163,7 +163,7 @@ int xive_native_configure_queue(u32 vp_id, struct xive_q *q, u8 prio,
>  		rc = opal_xive_set_queue_info(vp_id, prio, qpage_phys, order, flags);
>  		if (rc != OPAL_BUSY)
>  			break;
> -		msleep(1);
> +		usleep_range(1000, 1100);
>  	}
>  	if (rc) {
>  		pr_err("Error %lld setting queue for prio %d\n", rc, prio);
> @@ -190,7 +190,7 @@ static void __xive_native_disable_queue(u32 vp_id, struct xive_q *q, u8 prio)
>  		rc = opal_xive_set_queue_info(vp_id, prio, 0, 0, 0);
>  		if (rc != OPAL_BUSY)
>  			break;
> -		msleep(1);
> +		usleep_range(1000, 1100);
>  	}
>  	if (rc)
>  		pr_err("Error %lld disabling queue for prio %d\n", rc, prio);
> @@ -253,7 +253,7 @@ static int xive_native_get_ipi(unsigned int cpu, struct xive_cpu *xc)
>  	for (;;) {
>  		irq = opal_xive_allocate_irq(chip_id);
>  		if (irq == OPAL_BUSY) {
> -			msleep(1);
> +			usleep_range(1000, 1100);
>  			continue;
>  		}
>  		if (irq < 0) {
> @@ -275,7 +275,7 @@ u32 xive_native_alloc_irq(void)
>  		rc = opal_xive_allocate_irq(OPAL_XIVE_ANY_CHIP);
>  		if (rc != OPAL_BUSY)
>  			break;
> -		msleep(1);
> +		usleep_range(1000, 1100);
>  	}
>  	if (rc < 0)
>  		return 0;
> @@ -289,7 +289,7 @@ void xive_native_free_irq(u32 irq)
>  		s64 rc = opal_xive_free_irq(irq);
>  		if (rc != OPAL_BUSY)
>  			break;
> -		msleep(1);
> +		usleep_range(1000, 1100);
>  	}
>  }
>  EXPORT_SYMBOL_GPL(xive_native_free_irq);
> @@ -305,7 +305,7 @@ static void xive_native_put_ipi(unsigned int cpu, struct xive_cpu *xc)
>  	for (;;) {
>  		rc = opal_xive_free_irq(xc->hw_ipi);
>  		if (rc == OPAL_BUSY) {
> -			msleep(1);
> +			usleep_range(1000, 1100);
>  			continue;
>  		}
>  		xc->hw_ipi = 0;
> @@ -400,7 +400,7 @@ static void xive_native_setup_cpu(unsigned int cpu, struct xive_cpu *xc)
>  		rc = opal_xive_set_vp_info(vp, OPAL_XIVE_VP_ENABLED, 0);
>  		if (rc != OPAL_BUSY)
>  			break;
> -		msleep(1);
> +		usleep_range(1000, 1100);
>  	}
>  	if (rc) {
>  		pr_err("Failed to enable pool VP on CPU %d\n", cpu);
> @@ -444,7 +444,7 @@ static void xive_native_teardown_cpu(unsigned int cpu, struct xive_cpu *xc)
>  		rc = opal_xive_set_vp_info(vp, 0, 0);
>  		if (rc != OPAL_BUSY)
>  			break;
> -		msleep(1);
> +		usleep_range(1000, 1100);
>  	}
>  }
>  
> @@ -645,7 +645,7 @@ u32 xive_native_alloc_vp_block(u32 max_vcpus)
>  		rc = opal_xive_alloc_vp_block(order);
>  		switch (rc) {
>  		case OPAL_BUSY:
> -			msleep(1);
> +			usleep_range(1000, 1100);
>  			break;
>  		case OPAL_XIVE_PROVISIONING:
>  			if (!xive_native_provision_pages())
> @@ -687,7 +687,7 @@ int xive_native_enable_vp(u32 vp_id, bool single_escalation)
>  		rc = opal_xive_set_vp_info(vp_id, flags, 0);
>  		if (rc != OPAL_BUSY)
>  			break;
> -		msleep(1);
> +		usleep_range(1000, 1100);
>  	}
>  	return rc ? -EIO : 0;
>  }
> @@ -701,7 +701,7 @@ int xive_native_disable_vp(u32 vp_id)
>  		rc = opal_xive_set_vp_info(vp_id, 0, 0);
>  		if (rc != OPAL_BUSY)
>  			break;
> -		msleep(1);
> +		usleep_range(1000, 1100);
>  	}
>  	return rc ? -EIO : 0;
>  }
