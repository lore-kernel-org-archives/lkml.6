Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E366C67863
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 00:03:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E721820C0E
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 00:03:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="h4nXrawH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E721820C0E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727308AbeJSIGf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 04:06:35 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:39040 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbeJSIGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 04:06:34 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id w9J036CI037228;
        Thu, 18 Oct 2018 19:03:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1539907386;
        bh=Ruqe+B1vAznCC0xwwYKAl+PIR+bzmI5hWbkrVzVav9o=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=h4nXrawHZm7iyR1AswOxC7rDZ82uc4a7KYlVOK84jnIhGAGpLHNphcPOs6MLiEaSl
         gLCnKIZGwfIEIVZQewXaQ491/8o8KNj4T1WRhTyomL8woEaRWiD2x2ZoQDJbxMQqYp
         1W20csxITRDKuqEjeWNzsd862W11KYsnuNbYqT/U=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9J036xT020225;
        Thu, 18 Oct 2018 19:03:06 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Thu, 18
 Oct 2018 19:03:06 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Thu, 18 Oct 2018 19:03:06 -0500
Received: from [128.247.59.147] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9J036Y4021239;
        Thu, 18 Oct 2018 19:03:06 -0500
Subject: Re: [PATCH net-next] net: ethernet: ti: cpsw: don't flush mcast
 entries while switch promisc mode
To:     Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, <davem@davemloft.net>
CC:     <linux-omap@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20181018180006.7065-1-ivan.khoronzhuk@linaro.org>
From:   Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <6c34a3ce-dbee-538e-bda7-8dd485315267@ti.com>
Date:   Thu, 18 Oct 2018 19:03:06 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181018180006.7065-1-ivan.khoronzhuk@linaro.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/18/18 1:00 PM, Ivan Khoronzhuk wrote:
> No need now to flush mcast entries in switch mode while toggling to
> promiscuous mode. It's not needed as vlan reg_mcast = ALL_PORTS
> and mcast/vlan ports = ALL_PORTS, the same happening for vlan
> unreg_mcast, it's set to ALL_PORT_MASK just after calling promisc
> mode routine by calling set allmulti. I suppose main reason to flush
> them is to use unreg_mcast to receive all to host port. Thus, now, all
> mcast packets are received anyway and no reason to flush mcast entries
> unsafely, as they were synced with __dev_mc_sync() previously and are
> not restored. Another way is to _dev_mc_unsync() them, but no need.

User have possibility to add additional mcast entries or edit existing 
in switch-mode, which is now done using custom tool. So, Host in promisc
mode will not receive packets for mcast address X if port mask for this
addr set to (ALL_PORTS - HOST_PORT). Am I missing smth?

> 
> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
> ---
> 
> Based on net-next/master
> Tasted on am572x EVM and BBB
> 
>   drivers/net/ethernet/ti/cpsw.c | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
> index 226be2a56c1f..0e475020a674 100644
> --- a/drivers/net/ethernet/ti/cpsw.c
> +++ b/drivers/net/ethernet/ti/cpsw.c
> @@ -638,9 +638,6 @@ static void cpsw_set_promiscious(struct net_device *ndev, bool enable)
>   			} while (time_after(timeout, jiffies));
>   			cpsw_ale_control_set(ale, 0, ALE_AGEOUT, 1);
>   
> -			/* Clear all mcast from ALE */
> -			cpsw_ale_flush_multicast(ale, ALE_ALL_PORTS, -1);
> -
>   			/* Flood All Unicast Packets to Host port */
>   			cpsw_ale_control_set(ale, 0, ALE_P0_UNI_FLOOD, 1);
>   			dev_dbg(&ndev->dev, "promiscuity enabled\n");
> 

-- 
regards,
-grygorii
