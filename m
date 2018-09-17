Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E366EECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 15:59:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EA472088F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 15:59:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EA472088F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728368AbeIQV1m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 17:27:42 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:42046 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726979AbeIQV1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 17:27:41 -0400
X-IronPort-AV: E=Sophos;i="5.53,386,1531810800"; 
   d="scan'208";a="20111628"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 17 Sep 2018 08:59:43 -0700
Received: from [10.159.245.112] (10.10.76.4) by chn-sv-exch02.mchp-main.com
 (10.10.76.38) with Microsoft SMTP Server id 14.3.352.0; Mon, 17 Sep 2018
 08:59:42 -0700
Subject: Re: [PATCH] net: macb: disable scatter-gather for macb on sama5d3
To:     David Miller <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <claudiu.beznea@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <devicetree@vger.kernel.org>
References: <20180914154811.12090-1-nicolas.ferre@microchip.com>
 <20180917.075813.1145409055019392182.davem@davemloft.net>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
Message-ID: <8da68995-4019-e0c7-0471-4fdbe40ad52a@microchip.com>
Date:   Mon, 17 Sep 2018 17:59:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180917.075813.1145409055019392182.davem@davemloft.net>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/09/2018 at 16:58, David Miller wrote:
> From: Nicolas Ferre <nicolas.ferre@microchip.com>
> Date: Fri, 14 Sep 2018 17:48:10 +0200
> 
>> Create a new configuration for the sama5d3-macb new compatibility string.
>> This configuration disables scatter-gather because we experienced lock down
>> of the macb interface of this particular SoC under very high load.
>>
>> Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> 
> Applied, but are you really sure it isn't just some bug in the driver
> or somesuch?

Actually, the same IP on other SoCs behaves correctly with same driver. 
We tried hard to find the root cause of the problem without success and 
we didn't have confirmation of an issue on Cadence's side either.

The symptom is that we have a receive overrun on this interface under 
heavy load but I think that it is more a result of the issue than the 
real problem: I cannot escape from this overrun condition: the IP itself 
is completely blocked.

Even if the problem is very difficult to reproduce (simple *perf tools 
not sufficient), we play safe by simply disabling this feature on this 
SoC only.

Best regards,
-- 
Nicolas Ferre
