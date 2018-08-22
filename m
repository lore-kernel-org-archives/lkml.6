Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE40FC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 17:51:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EF3920BF2
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 17:51:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=compulab.co.il header.i=@compulab.co.il header.b="m/Me6wJV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EF3920BF2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=compulab.co.il
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727770AbeHVVRg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 17:17:36 -0400
Received: from softlayer.compulab.co.il ([50.23.254.55]:41877 "EHLO
        compulab.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727468AbeHVVRg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 17:17:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=compulab.co.il; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=1mFCdIkZygQloDCIJwcLgP9XXVHsmC34+eGkOMt/s1U=; b=m/Me6wJV0cBGPcEfqvLeualXvA
        ZbD4T8p8VAIp3VOoCWi32nvs7pVZvlMFEg4lgjWOLAnGQ2uX5TcbonqJ7xihnjlPmQ/iiJ+izCPEg
        GhTMvmvVMtYPMhp2P2Z/Jv4X8EtRp/6T076jCMTHD4dMcO0+gk3V7X8SvAGzcQN/cP2UORKY8rrog
        VDQnsc0L8Yj02nznYmWlfTPwVlrw0sNjkQ0iJXR9AOlUNJkgXnwfOYyJabfqhG79jluB5DSmo3GFc
        buHoNhQ3mSXzFwRdpiwhGWVUzOaUXtVCqQThw/gKypk/YGez0CBCimF1w4sjBvag0VSLCnp0qP411
        RlfS+P5g==;
Received: from [37.142.126.90] (port=43737 helo=zimbra-mta.compulab.co.il)
        by softlayer.compulab.co.il with esmtp (Exim 4.87)
        (envelope-from <kirill.kapranov@compulab.co.il>)
        id 1fsXIF-000084-5P; Wed, 22 Aug 2018 20:51:43 +0300
Received: from localhost (localhost [127.0.0.1])
        by zimbra-mta.compulab.co.il (Postfix) with ESMTP id E594D4826BF;
        Wed, 22 Aug 2018 20:51:41 +0300 (IDT)
Received: from zimbra-mta.compulab.co.il ([127.0.0.1])
        by localhost (zimbra-mta.compulab.co.il [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id pJHqDBE3xlLy; Wed, 22 Aug 2018 20:51:41 +0300 (IDT)
Received: from localhost (localhost [127.0.0.1])
        by zimbra-mta.compulab.co.il (Postfix) with ESMTP id 7BF114826C2;
        Wed, 22 Aug 2018 20:51:41 +0300 (IDT)
X-Virus-Scanned: amavisd-new at zimbra-mta.compulab.co.il
Received: from zimbra-mta.compulab.co.il ([127.0.0.1])
        by localhost (zimbra-mta.compulab.co.il [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id JI12KLHdogm9; Wed, 22 Aug 2018 20:51:41 +0300 (IDT)
Received: from [192.168.11.10] (lifshitz-linux.compulab.local [192.168.11.10])
        by zimbra-mta.compulab.co.il (Postfix) with ESMTPSA id 227B64826BF;
        Wed, 22 Aug 2018 20:51:41 +0300 (IDT)
Subject: Re: [PATCH -next] spi: Fix double IDR allocation with DT aliases
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20180821095303.27664-1-geert+renesas@glider.be>
From:   Kirill Kapranov <kirill.kapranov@compulab.co.il>
Organization: CompuLab Ltd.
Message-ID: <35fbd3ae-3ac3-f6ef-874b-3d99c4d4d29a@compulab.co.il>
Date:   Wed, 22 Aug 2018 20:51:40 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180821095303.27664-1-geert+renesas@glider.be>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - softlayer.compulab.co.il
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - compulab.co.il
X-Get-Message-Sender-Via: softlayer.compulab.co.il: acl_c_recent_authed_mail_ips_text_entry: kirill.kapranov@compulab.co.il|compulab.co.il
X-Authenticated-Sender: softlayer.compulab.co.il: kirill.kapranov@compulab.co.il
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert

Thank you for keeping me informed.

I have to point at the following threat: a dynamically allocated ID may 
'squat' a bus ID that intended for a device with statically allocated 
ID. This scenario is possible since module loading order is uncertain.
This threat seems to be inevitable...

--
Best regards,
Kirill.


On 08/21/2018 12:53 PM, Geert Uytterhoeven wrote:
> If the SPI bus number is provided by a DT alias, idr_alloc() is called
> twice, leading to:
> 
>      WARNING: CPU: 1 PID: 1 at drivers/spi/spi.c:2179 spi_register_controller+0x11c/0x5d8
>      couldn't get idr
> 
> Fix this by moving the handling of fixed SPI bus numbers up, before the
> DT handling code fills in ctlr->bus_num.
> 
> Fixes: 1a4327fbf4554d5b ("spi: fix IDR collision on systems with both fixed and dynamic SPI bus numbers")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Seen on e.g. r8a7791/koelsch, breaking both RSPI and MSIOF.
> ---
>   drivers/spi/spi.c | 22 +++++++++++-----------
>   1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index a00d006d4c3a1c5a..9da0bc5a036cfff6 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -2143,8 +2143,17 @@ int spi_register_controller(struct spi_controller *ctlr)
>   	 */
>   	if (ctlr->num_chipselect == 0)
>   		return -EINVAL;
> -	/* allocate dynamic bus number using Linux idr */
> -	if ((ctlr->bus_num < 0) && ctlr->dev.of_node) {
> +	if (ctlr->bus_num >= 0) {
> +		/* devices with a fixed bus num must check-in with the num */
> +		mutex_lock(&board_lock);
> +		id = idr_alloc(&spi_master_idr, ctlr, ctlr->bus_num,
> +			ctlr->bus_num + 1, GFP_KERNEL);
> +		mutex_unlock(&board_lock);
> +		if (WARN(id < 0, "couldn't get idr"))
> +			return id == -ENOSPC ? -EBUSY : id;
> +		ctlr->bus_num = id;
> +	} else if (ctlr->dev.of_node) {
> +		/* allocate dynamic bus number using Linux idr */
>   		id = of_alias_get_id(ctlr->dev.of_node, "spi");
>   		if (id >= 0) {
>   			ctlr->bus_num = id;
> @@ -2170,15 +2179,6 @@ int spi_register_controller(struct spi_controller *ctlr)
>   		if (WARN(id < 0, "couldn't get idr"))
>   			return id;
>   		ctlr->bus_num = id;
> -	} else {
> -		/* devices with a fixed bus num must check-in with the num */
> -		mutex_lock(&board_lock);
> -		id = idr_alloc(&spi_master_idr, ctlr, ctlr->bus_num,
> -			ctlr->bus_num + 1, GFP_KERNEL);
> -		mutex_unlock(&board_lock);
> -		if (WARN(id < 0, "couldn't get idr"))
> -			return id == -ENOSPC ? -EBUSY : id;
> -		ctlr->bus_num = id;
>   	}
>   	INIT_LIST_HEAD(&ctlr->queue);
>   	spin_lock_init(&ctlr->queue_lock);
> 


