Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0BB5C5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 14:03:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3DC8205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 14:03:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3DC8205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=systec-electronic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727262AbeJPVyL convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 17:54:11 -0400
Received: from webbox1416.server-home.net ([77.236.96.61]:40713 "EHLO
        webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726986AbeJPVyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 17:54:10 -0400
Received: from imapserver.systec-electronic.com (unknown [212.185.67.146])
        by webbox1416.server-home.net (Postfix) with ESMTPA id C0D7927A64D;
        Tue, 16 Oct 2018 16:03:31 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by imapserver.systec-electronic.com (Postfix) with ESMTP id 5247F1A1B57;
        Tue, 16 Oct 2018 16:03:31 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at imapserver.systec-electronic.com
Received: from imapserver.systec-electronic.com ([127.0.0.1])
        by localhost (imapserver.systec-electronic.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 0r71DAj7A4j4; Tue, 16 Oct 2018 16:03:28 +0200 (CEST)
Received: from ws-140106.localnet (ws-140106.systec.local [192.168.10.85])
        by imapserver.systec-electronic.com (Postfix) with ESMTPA id EC03B1A1B59;
        Tue, 16 Oct 2018 16:03:25 +0200 (CEST)
From:   Alexander Stein <alexander.stein@systec-electronic.com>
To:     Jonas Danielsson <jonas@orbital-systems.com>
Cc:     linux-kernel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] power: reset: at91-reset: enable I-cache for at91sam9260_reset
Date:   Tue, 16 Oct 2018 16:03:25 +0200
Message-ID: <4836921.pHbLXnhTfm@ws-140106>
In-Reply-To: <20181007125815.8392-1-jonas@threetimestwo.org>
References: <20181007125815.8392-1-jonas@threetimestwo.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do you have CONFIG_CPU_ICACHE_DISABLE enabled?
I wonder why I-cache is disabled. I know about this errata, AT91SAM9G20 is affected as well.

Best regards,
Alexander

On Sunday, October 7, 2018, 2:57:45 PM CEST Jonas Danielsson wrote:
> From: Jonas Danielsson <jonas@orbital-systems.com>
> 
> This fixes a bug where our embedded system (AT91SAM9260 based) would
> hang at reboot. At the most we managed 16 boot loops without a hang.
> 
> With this patch applied the problem has not been observed and the board
> has managed above 250 boot loops.
> 
> The AT91SAM9260 datasheet tells us that with the instruction cache
> disabled all instructions are fetched from SDRAM. And we have an errata
> telling us we must power down the SDRAM before issuing cpu reset.
> 
> This means we need the instruction cache enabled in at91sam9260_reset()
> At the moment it is being disabled in cpu_proc_fin() which is called from
> arch/arm/kernel/reboot.c.
> 
> Signed-off-by: Jonas Danielsson <jonas@orbital-systems.com>
> ---
>  drivers/power/reset/at91-reset.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/power/reset/at91-reset.c b/drivers/power/reset/at91-reset.c
> index f44a9ffcc2ab..78972bba64df 100644
> --- a/drivers/power/reset/at91-reset.c
> +++ b/drivers/power/reset/at91-reset.c
> @@ -50,14 +50,24 @@ static void __iomem *at91_ramc_base[2], *at91_rstc_base;
>  static struct clk *sclk;
>  
>  /*
> -* unless the SDRAM is cleanly shutdown before we hit the
> +* Errata 43.1.7.1 RSTC: Reset during SDRAM Accesses
> +*
> +* Unless the SDRAM is cleanly shutdown before we hit the
>  * reset register it can be left driving the data bus and
>  * killing the chance of a subsequent boot from NAND
> +*
> +* Since we are disabling SDRAM need to make sure that the
> +* instruction cache is enabled.
>  */
>  static int at91sam9260_restart(struct notifier_block *this, unsigned long mode,
>  			       void *cmd)
>  {
>  	asm volatile(
> +		/* Enable I-cache */
> +		"mrc	p15, 0, r0, c1, c0, 0\n\t"
> +		"orr	r0, r0, #4096\n\t" /* CR_I (bit 12) */
> +		"mcr	p15, 0, r0, c1, c0, 0\n\t"
> +
>  		/* Align to cache lines */
>  		".balign 32\n\t"
>  
> 


-- 
SYS TEC electronic GmbH
Am Windrad 2
08468 Heinsdorfergrund
Germany
Telefon : +49 (0) 3765 38600-0
Fax     : +49 (0) 3765 38600-4100
Email   : alexander.stein@systec-electronic.com
Website : http://www.systec-electronic.com

Managing Director   : Dipl.-Phys. Siegmar Schmidt
Commercial registry : Amtsgericht Chemnitz, HRB 28082
USt.-Id Nr.         : DE150534010

Diese E-Mail enthält vertrauliche und/oder rechtlich geschützte Informationen.
Wenn Sie nicht der richtige Adressat sind oder diese E-Mail irrtümlich erhalten haben, informieren Sie bitte sofort den Absender und vernichten Sie diese Mail.
Das unerlaubte Kopieren sowie die unbefugte Weitergabe dieser Mail sind nicht gestattet.
 
This e-mail may contain confidential and/or privileged information.
If you are not the intended recipient (or have received this e-mail in error) please notify the sender immediately and destroy this e-mail.
Any unauthorized copying, disclosure or distribution of the material in this e-mail is strictly forbidden.


