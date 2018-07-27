Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6ADAC6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 15:30:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 547AF2089F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 15:30:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="AEa66Kru"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 547AF2089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=akkea.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388739AbeG0Qw5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 12:52:57 -0400
Received: from node.akkea.ca ([192.155.83.177]:41604 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732167AbeG0Qw5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 12:52:57 -0400
Received: by node.akkea.ca (Postfix, from userid 33)
        id BE1CE54204A; Fri, 27 Jul 2018 15:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1532705431; bh=HeYptZ05WKaUBv3dfr8vvrC+7xG/Gh+/Ph0TwK/y1l8=;
        h=To:Subject:Date:From:Cc:In-Reply-To:References;
        b=AEa66Kruob/iBn8S+TKsB56H15WoUJHrueTpm8dYcoFHbLyJSQuD/gJEfyG4759vA
         6KuSrTpw6Q/k3PCai8SguCkeZyJOuH6vWTQ4hpvkOT84Az5L2k7S+Mehgv2G8C6YN/
         UDSvdvT2p04xkUAIUU+FPTvxND/x0S7d7G7I3+Ac=
To:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v2 4/4] power: bq25890_charger.c: Read back the current  battery voltage
X-PHP-Originating-Script: 1000:rcube.php
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 27 Jul 2018 09:30:31 -0600
From:   Angus Ainslie <angus@akkea.ca>
Cc:     angus.ainslie@puri.sm, Sebastian Reichel <sre@kernel.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <CAJKOXPc1amTiPKNU02OruOpw+GA6DrZgv1+HhqZ14OZYpA2-YA@mail.gmail.com>
References: <CAJKOXPczJWdNugbHiLRQv1krUFhZH=muix3M9R2LUT5=4zypYA@mail.gmail.com>
 <20180725194630.10414-1-angus@akkea.ca>
 <20180725194630.10414-5-angus@akkea.ca>
 <CAJKOXPc1amTiPKNU02OruOpw+GA6DrZgv1+HhqZ14OZYpA2-YA@mail.gmail.com>
Message-ID: <551b84dd28cba9bf7ca7e2f52c9d1901@www.akkea.ca>
X-Sender: angus@akkea.ca
User-Agent: Roundcube Webmail/1.1.3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-07-26 01:03, Krzysztof Kozlowski wrote:
> On 25 July 2018 at 21:46, Angus Ainslie (Purism) <angus@akkea.ca> 
> wrote:
>> The part has the capability of reading the current battery voltage
>> 
>> Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
>> ---
>>  drivers/power/supply/bq25890_charger.c | 15 +++++++++++++++
>>  1 file changed, 15 insertions(+)
>> 
>> diff --git a/drivers/power/supply/bq25890_charger.c 
>> b/drivers/power/supply/bq25890_charger.c
>> index f4cf2987996b..60ccd6c2b7ad 100644
>> --- a/drivers/power/supply/bq25890_charger.c
>> +++ b/drivers/power/supply/bq25890_charger.c
>> @@ -464,6 +464,20 @@ static int 
>> bq25890_power_supply_get_property(struct power_supply *psy,
>>                 val->intval = bq25890_find_val(bq->init_data.iterm, 
>> TBL_ITERM);
>>                 break;
>> 
>> +       case POWER_SUPPLY_PROP_VOLTAGE_NOW:
>> +               if (!state.online) {
>> +                       val->intval = 0;
>> +                       break;
>> +               }
> 
> You use state from cached value (from last interrupt) but the voltage
> is read directly from registers. The driver follows this convention in
> few other places so maybe it is okay. It depends how accurately the
> interrupts are generated - on every change? IOW, is always guaranteed
> that state will be consistent with values read below?
> 

Well I shouldn't even be checking state here as the VOLTAGE_NOW should 
be valid without it. I'll drop that check.

( Krzysztof sorry for the duplicate email )

> Best regards,
> Krzysztof
> 
>> +
>> +               ret = bq25890_field_read(bq, F_SYSV); /* read measured 
>> value */
>> +               if (ret < 0)
>> +                       return ret;
>> +
>> +               /* converted_val = 2.304V + ADC_val * 20mV (table 
>> 10.3.15) */
>> +               val->intval = 2304000 + ret * 20000;
>> +               break;
>> +
>>         default:
>>                 return -EINVAL;
>>         }
>> @@ -672,6 +686,7 @@ static enum power_supply_property 
>> bq25890_power_supply_props[] = {
>>         POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE,
>>         POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX,
>>         POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT,
>> +       POWER_SUPPLY_PROP_VOLTAGE_NOW,
>>  };
>> 
>>  static char *bq25890_charger_supplied_to[] = {
>> --
>> 2.17.1
>> 

