Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60FE8C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 16:37:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30220218F0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 16:37:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="T5WYtgiL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728623AbfAYQhX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 11:37:23 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:56738 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726256AbfAYQhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 11:37:22 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0PGb7k1025075;
        Fri, 25 Jan 2019 10:37:07 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1548434227;
        bh=e+BbgEkrrkWDs79/EBcXbQLkkPTCLRZTPqOGiMizwyE=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=T5WYtgiLLu6oIFP13YBvIm/5Hbj4AjOOsam8Oj5EuAMgGabDleEvLenpqTlqhgO23
         ws2LaGY70wpBRGoDWsWWi7SVSP1MGmemGBgC6jBHu8KOxQ16mxqyisnERWLbNEvLcx
         zXu5pZlpapGf0zesgC+jn3KYaXCemft6VMP7l8dI=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0PGb7hl119280
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 25 Jan 2019 10:37:07 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Fri, 25
 Jan 2019 10:37:06 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Fri, 25 Jan 2019 10:37:06 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0PGb6pS008030;
        Fri, 25 Jan 2019 10:37:06 -0600
Date:   Fri, 25 Jan 2019 10:37:06 -0600
From:   Bin Liu <b-liu@ti.com>
To:     "Matwey V. Kornilov" <matwey@sai.msu.ru>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <matwey.kornilov@gmail.com>,
        "open list:MUSB MULTIPOINT HIGH SPEED DUAL-ROLE CONTROLLER" 
        <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: musb: Fix potential NULL dereference
Message-ID: <20190125163706.GI18982@uda0271908>
Mail-Followup-To: Bin Liu <b-liu@ti.com>,
        "Matwey V. Kornilov" <matwey@sai.msu.ru>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        matwey.kornilov@gmail.com,
        "open list:MUSB MULTIPOINT HIGH SPEED DUAL-ROLE CONTROLLER" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20190123175142.12604-1-matwey@sai.msu.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190123175142.12604-1-matwey@sai.msu.ru>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2019 at 08:51:42PM +0300, Matwey V. Kornilov wrote:
> We assign "urb->hcpriv = qh;" a few lines down. The valid qh for the urb is
> hep->hcpriv in this code path.
> 
> Fixes: 714bc5ef3eda ("musb: potential use after free")
> Signed-off-by: Matwey V. Kornilov <matwey@sai.msu.ru>
> ---
>  drivers/usb/musb/musb_host.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/musb/musb_host.c b/drivers/usb/musb/musb_host.c
> index c6118a962d37..6f267716768e 100644
> --- a/drivers/usb/musb/musb_host.c
> +++ b/drivers/usb/musb/musb_host.c
> @@ -2336,7 +2336,7 @@ static int musb_urb_enqueue(
>  		 * odd, rare, error prone, but legal.
>  		 */
>  		kfree(qh);
> -		qh = NULL;
> +		qh = hep->hcpriv;
>  		ret = 0;
>  	} else
>  		ret = musb_schedule(musb, qh,

Did you run into any issue? The original code seems to be correct to me.

Regards,
-Bin.
