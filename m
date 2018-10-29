Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E5B6C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 14:49:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4BAE2082D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 14:49:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4BAE2082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727369AbeJ2XiJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 19:38:09 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:43431 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726155AbeJ2XiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 19:38:09 -0400
X-IronPort-AV: E=Sophos;i="5.54,440,1534834800"; 
   d="scan'208";a="23246772"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 29 Oct 2018 07:49:11 -0700
Received: from localhost (10.10.76.4) by chn-sv-exch05.mchp-main.com
 (10.10.76.106) with Microsoft SMTP Server id 14.3.352.0; Mon, 29 Oct 2018
 07:49:11 -0700
Date:   Mon, 29 Oct 2018 15:49:18 +0100
From:   Ludovic Desroches <ludovic.desroches@microchip.com>
To:     Tudor Ambarus - M18064 <Tudor.Ambarus@microchip.com>
CC:     "wsa@the-dreams.de" <wsa@the-dreams.de>,
        Nicolas Ferre - M43238 <Nicolas.Ferre@microchip.com>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RESEND PATCH 1/2] i2c: enable buses to save their clock
 frequency in adapter
Message-ID: <20181029144918.3iukhksa522xna2e@M43218.corp.atmel.com>
Mail-Followup-To: Tudor Ambarus - M18064 <Tudor.Ambarus@microchip.com>,
        "wsa@the-dreams.de" <wsa@the-dreams.de>,
        Nicolas Ferre - M43238 <Nicolas.Ferre@microchip.com>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20181023092025.32463-1-tudor.ambarus@microchip.com>
 <20181023092025.32463-2-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20181023092025.32463-2-tudor.ambarus@microchip.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 23, 2018 at 11:20:39AM +0200, Tudor Ambarus - M18064 wrote:
> The clock-frequency property is not mandatory for the i2c buses. If it's
> not present in the device tree, the buses __usually__ assume it's 100kHZ
> (see altera, at91, axxia, etc.). Broadcom uses a 375kHZ default
> clock-frequency, so the default clock frequency varies from bus to bus.
> 
> There are i2c clients that need to know the bus clock frequency in order to
> compute their wake token (see atecc508a i2c client).
> 
> The clock-frequency value has to be propagated to the i2c clients, otherwise,
> if they will not find the i2c bus clock frequency in the device tree, they
> will have to make their own assumption of the clock frequency.
> 
> Spare the i2c clients of making wrong assumptions of the i2c bus clock
> frequency and enable the buses to save their clock frequency in adapter.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
Reviwed-by: Ludovic Desroches <ludovic.desroches@microchip.com>

> ---
>  include/linux/i2c.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/i2c.h b/include/linux/i2c.h
> index 65b4eaed1d96..f238da204c49 100644
> --- a/include/linux/i2c.h
> +++ b/include/linux/i2c.h
> @@ -677,6 +677,7 @@ struct i2c_adapter {
>  	struct rt_mutex bus_lock;
>  	struct rt_mutex mux_lock;
>  
> +	u32 bus_freq_hz;
>  	int timeout;			/* in jiffies */
>  	int retries;
>  	struct device dev;		/* the adapter device */
> -- 
> 2.9.4
> 
