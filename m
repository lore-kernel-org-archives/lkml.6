Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D27AC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 21:49:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EA3722506
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 21:49:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="F4eTp0xI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EA3722506
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730602AbeKMHo2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 02:44:28 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:45262 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725817AbeKMHo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 02:44:27 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id wACLnMeS075443;
        Mon, 12 Nov 2018 15:49:22 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1542059362;
        bh=PnlIankKqrU0g054yPdPnoSnf4HT5sfkHF+CBRoiSA0=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=F4eTp0xI8Ol87bg4kL/oh7FMthaiVIGED2BeqY0tEPmpCCauYw6YMvR5vGfcgihaW
         5oCDJyPCO7tnnyeXy2VhKIQmLEJ8R1Hze+HXR55nah1VH4bwWiu7UU0dMLUEktf/63
         ygnIL5RLfUqveyZ7CSaN0+/MYI8wZmvSCX3JNJPo=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wACLnMW6124962
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 12 Nov 2018 15:49:22 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Mon, 12
 Nov 2018 15:49:22 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Mon, 12 Nov 2018 15:49:22 -0600
Received: from [128.247.59.203] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wACLnMhj022312;
        Mon, 12 Nov 2018 15:49:22 -0600
Subject: Re: [PATCH 2/2] opp: ti-opp-supply: Correct the supply in
 _get_optimal_vdd_voltage call
To:     Keerthy <j-keerthy@ti.com>, <vireshk@kernel.org>, <nm@ti.com>,
        <sboyd@kernel.org>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <t-kristo@ti.com>
References: <1541565263-8296-1-git-send-email-j-keerthy@ti.com>
 <1541565263-8296-3-git-send-email-j-keerthy@ti.com>
From:   Dave Gerlach <d-gerlach@ti.com>
Message-ID: <312975f3-3cbd-3ece-20b6-ceb93421a3c9@ti.com>
Date:   Mon, 12 Nov 2018 15:49:22 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1541565263-8296-3-git-send-email-j-keerthy@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/06/2018 10:34 PM, Keerthy wrote:
> _get_optimal_vdd_voltage call provides new_supply_vbb->u_volt
> as the reference voltage while it should be really new_supply_vdd->u_volt.
> 
> Fixes: 9a835fa6e47 ("PM / OPP: Add ti-opp-supply driver")
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---

Acked-by: Dave Gerlach <d-gerlach@ti.com>

Currently all corresponding vbb and vdd values provided by the device tree match
which is why this does not fail, but this was a typo by me and vdd is the
correct value to actually use.

Regards,
Dave

>  drivers/opp/ti-opp-supply.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/opp/ti-opp-supply.c b/drivers/opp/ti-opp-supply.c
> index 29e08a4..3f4fb4d 100644
> --- a/drivers/opp/ti-opp-supply.c
> +++ b/drivers/opp/ti-opp-supply.c
> @@ -288,7 +288,7 @@ static int ti_opp_supply_set_opp(struct dev_pm_set_opp_data *data)
>  	int ret;
>  
>  	vdd_uv = _get_optimal_vdd_voltage(dev, &opp_data,
> -					  new_supply_vbb->u_volt);
> +					  new_supply_vdd->u_volt);
>  
>  	if (new_supply_vdd->u_volt_min < vdd_uv)
>  		new_supply_vdd->u_volt_min = vdd_uv;
> 

