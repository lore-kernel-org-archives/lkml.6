Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B10D1C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 09:27:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75FED217F5
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 09:27:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="GdacPLQk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbfBZJ1d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 04:27:33 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:42894 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbfBZJ1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 04:27:33 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1Q9RSR8081646;
        Tue, 26 Feb 2019 03:27:28 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1551173248;
        bh=PQTDcSRuIjg+WJHbpdYhoICNgyvWsxSrk5/6v9fDIh4=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=GdacPLQkTXiTn+Q5uWFI04NpECxDUlEdHq/nzadEaZhGJ/rHrPGRDTmZJdejCiv15
         TBmzos7V+KOxKA+xKQrZzFD+q0EbhtvA0mh/fpdVaC8RVYRCyIWa77imunlodtE+VX
         aLxSTBXew2TKqGzz1YaYGP9hN/IFvsk7fAvzwrjo=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1Q9RS5g121303
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 26 Feb 2019 03:27:28 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 26
 Feb 2019 03:27:28 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Tue, 26 Feb 2019 03:27:28 -0600
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1Q9RPJ1029103;
        Tue, 26 Feb 2019 03:27:27 -0600
Subject: Re: [PATCH] phy: ti-pipe3: Do not overwrite the whole PROGRAMMABILITY
 register
To:     Rolf Evers-Fischer <embedded24@evers-fischer.de>,
        <linux-kernel@vger.kernel.org>
CC:     Rolf Evers-Fischer <rolf.evers.fischer@aptiv.com>
References: <20190226092421.13440-1-embedded24@evers-fischer.de>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <1dd2c361-2219-05c7-6ca6-27dc049a9c7d@ti.com>
Date:   Tue, 26 Feb 2019 14:56:47 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190226092421.13440-1-embedded24@evers-fischer.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rolf,

On 26/02/19 2:54 PM, Rolf Evers-Fischer wrote:
> From: Rolf Evers-Fischer <rolf.evers.fischer@aptiv.com>
> 
> Previously, ti_pipe3_calibrate() wrote all bits in the
> PCIEPHYRX_ANA_PROGRAMMABILITY register, thus overwriting bits,
> which should not be modified.
> Fix ti_pipe3_calibrate() so that it only modifies LOSD and
> INTERFACE bits.

A patch to fix this was sent a week earlier by Colin
https://lkml.org/lkml/2019/2/19/459

Thanks
Kishon
> 
> Signed-off-by: Rolf Evers-Fischer <rolf.evers.fischer@aptiv.com>
> ---
>  drivers/phy/ti/phy-ti-pipe3.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/phy/ti/phy-ti-pipe3.c b/drivers/phy/ti/phy-ti-pipe3.c
> index 68ce4a082b9b..693acc167351 100644
> --- a/drivers/phy/ti/phy-ti-pipe3.c
> +++ b/drivers/phy/ti/phy-ti-pipe3.c
> @@ -303,7 +303,7 @@ static void ti_pipe3_calibrate(struct ti_pipe3 *phy)
>  
>  	val = ti_pipe3_readl(phy->phy_rx, PCIEPHYRX_ANA_PROGRAMMABILITY);
>  	val &= ~(INTERFACE_MASK | LOSD_MASK | MEM_PLLDIV);
> -	val = (0x1 << INTERFACE_SHIFT | 0xA << LOSD_SHIFT);
> +	val |= (0x1 << INTERFACE_SHIFT | 0xA << LOSD_SHIFT);
>  	ti_pipe3_writel(phy->phy_rx, PCIEPHYRX_ANA_PROGRAMMABILITY, val);
>  
>  	val = ti_pipe3_readl(phy->phy_rx, PCIEPHYRX_DIGITAL_MODES);
> 
