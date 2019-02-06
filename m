Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B914C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 15:09:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01FDC2175B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 15:09:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ZHpcR3cO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731088AbfBFPJJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 10:09:09 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:34422 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728969AbfBFPJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 10:09:09 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x16F8qGb018201;
        Wed, 6 Feb 2019 09:08:52 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1549465732;
        bh=wEUjz3g2SE3jQnDuCpNTAgUiV4t6+666Oz7b1O2f/LI=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=ZHpcR3cOStDjmKEXHYAP7iQUkMsmXBkQlh3k+/4r+nnh3iziUMv9Vb61BQCF6ByIM
         ep+hqUxfGgf+Jskna8cTGgaj9aubYNpUISU7th4NvDhwOLU5WIb9RY9DLIwT3OPCeM
         NgqGu7I6QMHmSMgiHd2oqC1LRtZ0/wPnW7UMbVLY=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x16F8pFg106464
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 6 Feb 2019 09:08:51 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 6
 Feb 2019 09:08:51 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 6 Feb 2019 09:08:51 -0600
Received: from [172.24.190.172] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x16F8mVN010309;
        Wed, 6 Feb 2019 09:08:49 -0600
Subject: Re: [PATCH 07/35] ARM: davinci: aintc: use irq domain
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20190131133928.17985-1-brgl@bgdev.pl>
 <20190131133928.17985-8-brgl@bgdev.pl>
From:   Sekhar Nori <nsekhar@ti.com>
Message-ID: <c69143a5-08ad-5053-ab56-d2fd71c62fb8@ti.com>
Date:   Wed, 6 Feb 2019 20:38:48 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190131133928.17985-8-brgl@bgdev.pl>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/01/19 7:09 PM, Bartosz Golaszewski wrote:
> @@ -82,13 +82,11 @@ static asmlinkage void __exception_irq_entry
>  davinci_handle_irq(struct pt_regs *regs)
>  {
>  	int irqnr = davinci_irq_readl(IRQ_IRQENTRY_OFFSET);
> -	struct pt_regs *old_regs = set_irq_regs(regs);
>  
>  	irqnr >>= 2;
>  	irqnr -= 1;
>  
> -	generic_handle_irq(irqnr);
> -	set_irq_regs(old_regs);
> +	handle_domain_irq(davinci_irq_domain, irqnr, regs);
>  }

Is it possible to bring 2/35 after this patch so you dont end up
removing code added there?

Thanks,
Sekhar
