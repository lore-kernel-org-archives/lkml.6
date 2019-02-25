Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98E1AC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 18:26:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76D372084D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 18:26:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728936AbfBYS0S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 13:26:18 -0500
Received: from mga11.intel.com ([192.55.52.93]:37968 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725936AbfBYS0R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 13:26:17 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Feb 2019 10:26:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,412,1544515200"; 
   d="scan'208";a="137084684"
Received: from lrahamim-mobl1.ger.corp.intel.com ([10.255.197.83])
  by orsmga002.jf.intel.com with ESMTP; 25 Feb 2019 10:26:14 -0800
Subject: Re: [Intel-wired-lan] [PATCH net-next 3/4] e1000e: Fix
 -Wformat-truncation warnings
To:     Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org
Cc:     open list <linux-kernel@vger.kernel.org>,
        "moderated list:INTEL ETHERNET DRIVERS" 
        <intel-wired-lan@lists.osuosl.org>, davem@davemloft.net
References: <20190222040929.16657-1-f.fainelli@gmail.com>
 <20190222040929.16657-4-f.fainelli@gmail.com>
From:   "Neftin, Sasha" <sasha.neftin@intel.com>
Message-ID: <69782768-4bba-6442-a1e4-3b019847e53b@intel.com>
Date:   Mon, 25 Feb 2019 20:26:13 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190222040929.16657-4-f.fainelli@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/02/2019 6:09, Florian Fainelli wrote:
> Provide precision hints to snprintf() since we know the destination
> buffer size of the RX/TX ring names are IFNAMSIZ + 5 - 1. This fixes the
> following warnings:
> 
> drivers/net/ethernet/intel/e1000e/netdev.c: In function
> 'e1000_request_msix':
> drivers/net/ethernet/intel/e1000e/netdev.c:2109:13: warning: 'snprintf'
> output may be truncated before the last format character
> [-Wformat-truncation=]
>       "%s-rx-0", netdev->name);
>               ^
> drivers/net/ethernet/intel/e1000e/netdev.c:2107:3: note: 'snprintf'
> output between 6 and 21 bytes into a destination of size 20
>     snprintf(adapter->rx_ring->name,
>     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>       sizeof(adapter->rx_ring->name) - 1,
>       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>       "%s-rx-0", netdev->name);
>       ~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/net/ethernet/intel/e1000e/netdev.c:2125:13: warning: 'snprintf'
> output may be truncated before the last format character
> [-Wformat-truncation=]
>       "%s-tx-0", netdev->name);
>               ^
> drivers/net/ethernet/intel/e1000e/netdev.c:2123:3: note: 'snprintf'
> output between 6 and 21 bytes into a destination of size 20
>     snprintf(adapter->tx_ring->name,
>     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>       sizeof(adapter->tx_ring->name) - 1,
>       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>       "%s-tx-0", netdev->name);
>       ~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>   drivers/net/ethernet/intel/e1000e/netdev.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
> index 736fa51878f8..7acc61e4f645 100644
> --- a/drivers/net/ethernet/intel/e1000e/netdev.c
> +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
> @@ -2106,7 +2106,7 @@ static int e1000_request_msix(struct e1000_adapter *adapter)
>   	if (strlen(netdev->name) < (IFNAMSIZ - 5))
>   		snprintf(adapter->rx_ring->name,
>   			 sizeof(adapter->rx_ring->name) - 1,
> -			 "%s-rx-0", netdev->name);
> +			 "%.14s-rx-0", netdev->name);
>   	else
>   		memcpy(adapter->rx_ring->name, netdev->name, IFNAMSIZ);
>   	err = request_irq(adapter->msix_entries[vector].vector,
> @@ -2122,7 +2122,7 @@ static int e1000_request_msix(struct e1000_adapter *adapter)
>   	if (strlen(netdev->name) < (IFNAMSIZ - 5))
>   		snprintf(adapter->tx_ring->name,
>   			 sizeof(adapter->tx_ring->name) - 1,
> -			 "%s-tx-0", netdev->name);
> +			 "%.14s-tx-0", netdev->name);
>   	else
>   		memcpy(adapter->tx_ring->name, netdev->name, IFNAMSIZ);
>   	err = request_irq(adapter->msix_entries[vector].vector,
> 
Acked-by: Sasha Neftin <sasha.neftin@intel.com>
