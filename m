Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 619ADC004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 18:26:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50D3E20652
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 18:26:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="aoxQFNQM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50D3E20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728973AbeJWCqR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 22:46:17 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:39670 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727218AbeJWCqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 22:46:16 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id w9MIQZNB021012;
        Mon, 22 Oct 2018 13:26:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1540232795;
        bh=MmbMO5aEKQo/koh3rbQzQeCNblPovxrmwG8cQuB9mnE=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=aoxQFNQM+UYXuUVv1AK63Pnq75jcLcfXfx9rd6a09GVXZpZyL0wNd67eJLmcnFP/8
         pELXQQuBp1r8czkE93mTIrwW49slVCv3jBqccNoAtVi7uhleQx92XT2Lida3oikvTN
         YBF8bjxfpQ17FQ9dJYD+9MAE+ySGyOPgpMi5gEMQ=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id w9MIQZ2P031275
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 22 Oct 2018 13:26:35 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Mon, 22
 Oct 2018 13:26:35 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Mon, 22 Oct 2018 13:26:35 -0500
Received: from [128.247.59.147] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9MIQZvO021295;
        Mon, 22 Oct 2018 13:26:35 -0500
Subject: Re: [PATCH net-next] net: ethernet: ti: cpsw: unsync mcast entries
 while switch promisc mode
To:     Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, <davem@davemloft.net>
CC:     <linux-omap@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20181019202541.10278-1-ivan.khoronzhuk@linaro.org>
From:   Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <6ac434fa-858b-8395-91e7-442cf18b33f0@ti.com>
Date:   Mon, 22 Oct 2018 13:26:35 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181019202541.10278-1-ivan.khoronzhuk@linaro.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/19/18 3:25 PM, Ivan Khoronzhuk wrote:
> After flushing all mcast entries from the table, the ones contained in
> mc list of ndev are not restored when promisc mode is toggled off,
> because they are considered as synched with ALE, thus, in order to
> restore them after promisc mode - reset syncing info. This fix
> touches only switch mode devices, including single port boards
> like Beagle Bone.
> 
> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
> ---


So, this is follow up fix for
176b23 net: ethernet: ti: cpsw: fix lost of mcast packets while rx_mode update
because I can't reproduce it otherwise.

Could you update description and re-send pls.?

> 
> Based on net-nex/master
> and is logical continuation of the
> https://lore.kernel.org/patchwork/patch/1001633/
> 
>   drivers/net/ethernet/ti/cpsw.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
> index 226be2a56c1f..f7753b240ced 100644
> --- a/drivers/net/ethernet/ti/cpsw.c
> +++ b/drivers/net/ethernet/ti/cpsw.c
> @@ -640,6 +640,7 @@ static void cpsw_set_promiscious(struct net_device *ndev, bool enable)
>   
>   			/* Clear all mcast from ALE */
>   			cpsw_ale_flush_multicast(ale, ALE_ALL_PORTS, -1);
> +			__dev_mc_unsync(ndev, NULL);
>   
>   			/* Flood All Unicast Packets to Host port */
>   			cpsw_ale_control_set(ale, 0, ALE_P0_UNI_FLOOD, 1);
> 

-- 
regards,
-grygorii
