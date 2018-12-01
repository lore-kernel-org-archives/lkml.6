Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90982C04EB9
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 14:43:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E9012081D
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 14:43:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E9012081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbeLBB4X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 20:56:23 -0500
Received: from smtprelay0038.hostedemail.com ([216.40.44.38]:59893 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726458AbeLBB4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 20:56:23 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 36D11182CED28;
        Sat,  1 Dec 2018 14:43:43 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: money52_3d699f9ce0940
X-Filterd-Recvd-Size: 1729
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Sat,  1 Dec 2018 14:43:41 +0000 (UTC)
Message-ID: <fc4e1657b33a532b2e970e4b319d0ab5375a1355.camel@perches.com>
Subject: Re: [PATCH] net/core: tidy up an error message
From:   Joe Perches <joe@perches.com>
To:     Qian Cai <cai@gmx.us>, davem@davemloft.net
Cc:     yisen.zhuang@huawei.com, salil.mehta@huawei.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Sat, 01 Dec 2018 06:43:40 -0800
In-Reply-To: <20181201045153.4035-1-cai@gmx.us>
References: <20181201045153.4035-1-cai@gmx.us>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-11-30 at 23:51 -0500, Qian Cai wrote:
> netif_napi_add() could report an error like this below due to it allows
> to pass a format string for wildcarding before calling
> dev_get_valid_name(),
> 
> "netif_napi_add() called with weight 256 on device eth%d"
> 
> For example, hns_enet_drv module does this.
> 
> hns_nic_try_get_ae
>   hns_nic_init_ring_data
>     netif_napi_add
>   register_netdev
>     dev_get_valid_name
> 
> Hence, make it a bit more human-readable.
[]
> diff --git a/net/core/dev.c b/net/core/dev.c
[]
> @@ -6205,7 +6205,8 @@ void netif_napi_add(struct net_device *dev, struct napi_struct *napi,
>  	napi->poll = poll;
>  	if (weight > NAPI_POLL_WEIGHT)
>  		pr_err_once("netif_napi_add() called with weight %d on device %s\n",
> -			    weight, dev->name);
> +			    weight,
> +			    !strchr(dev->name, '%') ? dev->name : "unknown");

perhaps instead use netdev_err_once


