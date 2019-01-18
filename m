Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14E03C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 14:11:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D794B20855
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 14:11:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="V6t1DfeN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727469AbfAROLD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 09:11:03 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:53414 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726881AbfAROLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 09:11:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1547820661; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fOutaf2HnM/FzPKMvZXVw3HMACcHrmpPfxEr3NfVp3A=;
        b=V6t1DfeNI0nztrHNpovG7NPF23N+GHuu7UIP3jN3cTjNJuXcfxhRnleh5Wujd0WO6v/Rhr
        SoyrtSrQ7r14855hSCkPvH9cCtEzAx8v5s+X5/LNBcM+dYxcxhG8k5c1E7/5aLdF6cRcvE
        awTYwwK+ePNrXyL02h+rYh/kvHi8IX0=
Date:   Fri, 18 Jan 2019 11:10:50 -0300
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 3/4] memory: jz4780-nemc: Reduce size of const array
To:     Boris Brezillon <bbrezillon@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <1547820650.1909.0@crapouillou.net>
In-Reply-To: <20190118091518.467087b8@bbrezillon>
References: <20190117224550.18043-1-paul@crapouillou.net>
        <20190117224550.18043-3-paul@crapouillou.net>
        <20190118091518.467087b8@bbrezillon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

On Fri, Jan 18, 2019 at 5:15 AM, Boris Brezillon 
<bbrezillon@kernel.org> wrote:
> On Thu, 17 Jan 2019 19:45:49 -0300
> Paul Cercueil <paul@crapouillou.net <mailto:paul@crapouillou.net>> 
> wrote:
> 
>>  The maximum value found in that array is 15, there's no need to 
>> store
>>  these values as uint32_t, a uint8_t is enough.
> 
> Is it really worth the additional cast you add in the code?

They're not needed. I had to verify, because it was not obvious to me.
I'll remove them then.

>> 
>>  Signed-off-by: Paul Cercueil <paul@crapouillou.net 
>> <mailto:paul@crapouillou.net>>
>>  ---
>>   drivers/memory/jz4780-nemc.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>> 
>>  diff --git a/drivers/memory/jz4780-nemc.c 
>> b/drivers/memory/jz4780-nemc.c
>>  index bcf06adefc96..ef3f20e46590 100644
>>  --- a/drivers/memory/jz4780-nemc.c
>>  +++ b/drivers/memory/jz4780-nemc.c
>>  @@ -161,7 +161,7 @@ static bool jz4780_nemc_configure_bank(struct 
>> jz4780_nemc *nemc,
>>   	 * Conversion of tBP and tAW cycle counts to values supported by 
>> the
>>   	 * hardware (round up to the next supported value).
>>   	 */
>>  -	static const uint32_t convert_tBP_tAW[] = {
>>  +	static const u8 convert_tBP_tAW[] = {
>>   		0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10,
>> 
>>   		/* 11 - 12 -> 12 cycles */
>>  @@ -232,7 +232,7 @@ static bool jz4780_nemc_configure_bank(struct 
>> jz4780_nemc *nemc,
>>   			return false;
>>   		}
>> 
>>  -		smcr |= convert_tBP_tAW[cycles] << NEMC_SMCR_TBP_SHIFT;
>>  +		smcr |= (u32)convert_tBP_tAW[cycles] << NEMC_SMCR_TBP_SHIFT;
>>   	}
>> 
>>   	if (of_property_read_u32(node, "ingenic,nemc-tAW", &val) == 0) {
>>  @@ -244,7 +244,7 @@ static bool jz4780_nemc_configure_bank(struct 
>> jz4780_nemc *nemc,
>>   			return false;
>>   		}
>> 
>>  -		smcr |= convert_tBP_tAW[cycles] << NEMC_SMCR_TAW_SHIFT;
>>  +		smcr |= (u32)convert_tBP_tAW[cycles] << NEMC_SMCR_TAW_SHIFT;
>>   	}
>> 
>>   	if (of_property_read_u32(node, "ingenic,nemc-tSTRV", &val) == 0) {
> 


