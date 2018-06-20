Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA569C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 14:04:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89EB320836
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 14:04:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89EB320836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754216AbeFTOEo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 10:04:44 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:24354 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754136AbeFTOEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 10:04:38 -0400
X-IronPort-AV: E=Sophos;i="5.51,247,1526367600"; 
   d="scan'208";a="13247852"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 20 Jun 2018 07:04:22 -0700
Received: from [10.159.245.112] (10.10.76.4) by chn-sv-exch07.mchp-main.com
 (10.10.76.108) with Microsoft SMTP Server id 14.3.352.0; Wed, 20 Jun 2018
 07:04:20 -0700
Subject: Re: [PATCH] net: macb: Fix ptp time adjustment for large negative
 delta
To:     Harini Katakam <harini.katakam@xilinx.com>, <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <michal.simek@xilinx.com>, <harinikatakamlinux@gmail.com>,
        Claudiu Beznea - M18063 <Claudiu.Beznea@microchip.com>
References: <1529494460-4689-1-git-send-email-harini.katakam@xilinx.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
Message-ID: <ff8fac12-b5a1-5e2d-e4f6-4ee68bf685a7@microchip.com>
Date:   Wed, 20 Jun 2018 16:04:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1529494460-4689-1-git-send-email-harini.katakam@xilinx.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/06/2018 at 13:34, Harini Katakam wrote:
> When delta passed to gem_ptp_adjtime is negative, the sign is
> maintained in the ns_to_timespec64 conversion. Hence timespec_add
> should be used directly. timespec_sub will just subtract the negative
> value thus increasing the time difference.
> 
> Signed-off-by: Harini Katakam <harini.katakam@xilinx.com>

Makes sense:
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

> ---
>   drivers/net/ethernet/cadence/macb_ptp.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/cadence/macb_ptp.c b/drivers/net/ethernet/cadence/macb_ptp.c
> index 2220c77..6788351 100644
> --- a/drivers/net/ethernet/cadence/macb_ptp.c
> +++ b/drivers/net/ethernet/cadence/macb_ptp.c
> @@ -170,10 +170,7 @@ static int gem_ptp_adjtime(struct ptp_clock_info *ptp, s64 delta)
>   
>   	if (delta > TSU_NSEC_MAX_VAL) {
>   		gem_tsu_get_time(&bp->ptp_clock_info, &now);
> -		if (sign)
> -			now = timespec64_sub(now, then);
> -		else
> -			now = timespec64_add(now, then);
> +		now = timespec64_add(now, then);
>   
>   		gem_tsu_set_time(&bp->ptp_clock_info,
>   				 (const struct timespec64 *)&now);
> 


-- 
Nicolas Ferre
