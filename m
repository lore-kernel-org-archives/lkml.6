Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 285D8C67863
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 01:50:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D829720866
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 01:50:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NY5u0BGG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D829720866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbeJSJyp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 05:54:45 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:36963 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726608AbeJSJyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 05:54:44 -0400
Received: by mail-lf1-f65.google.com with SMTP id a82-v6so24061822lfa.4
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 18:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=TPMkdWvBGvg4FvnssSVbk6AEM880kMjROnlvB26fBzY=;
        b=NY5u0BGGW/AWgtwB7T95Txn3sebGYEuSqoaiEIRifkkOcmlQlJ+JHygHgqAGBAsvUo
         Z3q5vOG6Lz69DFbytRD4tLocthMMtGFAZPBj+3V27aoLOvUd/UaNCojxy8ahG6TrFp5p
         iAla2TRDMfWO2WCcz+31oUp5n7jdEsSRHxsHw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=TPMkdWvBGvg4FvnssSVbk6AEM880kMjROnlvB26fBzY=;
        b=kygYNDHUw2OQjgwWQiRucPxWhQ5g6PaDQ6Gb2gFQbU3jm/AP8j0t+f5AEGUnq+xYx0
         FmmhQEshsfo44IvDUyzZ7eZd6Hte+6QG7FUyOapPtsFIZpk+DomKNB89GKujN/slFDzM
         pQlfaivhJgKqo+fl7Kd8oIDIAOF/B/e7Mod68opPXSDL3ZUukTa+cRUpxRmrM8C2vH16
         4yZ9ZMN1k/9tP0bkQ9vIaa3GK4vI9Rqai8ZjGSGzOtCOVAOyWJ0bp2a2+BtdkTFj04wY
         na37b4svSGK1apeNQPjDKM5m/IsA5Ql96oAHaFUYr5vq/7l+A46QDvEGADTgxqIYJnkF
         CRkA==
X-Gm-Message-State: ABuFfojIc7DuPmws/sFNWWaehJfr6jBSv6G64uVR7PUY4MsmU1xeZYMJ
        kIY7b10T8W+ZRXJ6LGEL3vhrU+rZ6+fkupE+FEXrig==
X-Google-Smtp-Source: ACcGV618DA9P/BrObQVqF3T1q8/+5F6C+2u7Tm42Vm54Gk5aoOJSf79Jtn/a+g5KDoLdoWyqOmn/Z3k+TDFdLiYutVg=
X-Received: by 2002:a19:771b:: with SMTP id s27-v6mr1623242lfc.84.1539913851673;
 Thu, 18 Oct 2018 18:50:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:95d7:0:0:0:0:0 with HTTP; Thu, 18 Oct 2018 18:50:51
 -0700 (PDT)
In-Reply-To: <20181018165101.GA11562@bogus>
References: <e7c061535f2dcca54d6498405fdd5ed7098b19f9.1539587217.git.baolin.wang@linaro.org>
 <eb56baf2e2d127067e459b6014516071ba9005c0.1539587217.git.baolin.wang@linaro.org>
 <20181018165101.GA11562@bogus>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Fri, 19 Oct 2018 09:50:51 +0800
Message-ID: <CAMz4kuK7FjFSs0gUENsGekg+0eWyd40yaG6d27A-gMJCG-9_Sw@mail.gmail.com>
Subject: Re: [PATCH v4 3/6] dt-bindings: power: Introduce properties to
 present the battery OCV capacity table
To:     Rob Herring <robh@kernel.org>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, yuanjiang.yu@unisoc.com,
        Mark Brown <broonie@kernel.org>,
        Craig Tatlor <ctatlor97@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19 October 2018 at 00:51, Rob Herring <robh@kernel.org> wrote:
> On Mon, Oct 15, 2018 at 04:09:22PM +0800, Baolin Wang wrote:
>> Some battery driver will use the open circuit voltage (OCV) value to look
>> up the corresponding battery capacity percent in one certain degree Celsius.
>> Thus this patch provides some battery properties to present the OCV table
>> temperatures and OCV capacity table values.
>>
>> Suggested-by: Sebastian Reichel <sre@kernel.org>
>> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
>> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>> ---
>> Changes from v3:
>>  - Split binding into one separate patch.
>>  - Rename ocv-capacity-table-temperatures to ocv-capacity-celsius.
>>  - Add some words to specify the OCV's unit.
>>
>> Changes from v2:
>>  - Use type __be32 to calculate the table length.
>>  - Update error messages.
>>  - Add some helper functions.
>>
>> Changes from v1:
>>  - New patch in v2.
>> ---
>>  .../devicetree/bindings/power/supply/battery.txt   |   15 +++++++++++++++
>>  1 file changed, 15 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/power/supply/battery.txt b/Documentation/devicetree/bindings/power/supply/battery.txt
>> index 938d027..1f70e5d 100644
>> --- a/Documentation/devicetree/bindings/power/supply/battery.txt
>> +++ b/Documentation/devicetree/bindings/power/supply/battery.txt
>> @@ -23,6 +23,17 @@ Optional Properties:
>>   - constant-charge-current-max-microamp: maximum constant input current
>>   - constant-charge-voltage-max-microvolt: maximum constant input voltage
>>   - factory-internal-resistance-micro-ohms: battery factory internal resistance
>> + - ocv-capacity-table-0: An array providing the battery capacity percent
>> +   with corresponding open circuit voltage (OCV) of the battery, which
>> +   is used to look up battery capacity according to current OCV value.
>> +   And the open circuit voltage unit is microvolt.
>
> The order percent and voltage is still not clear. I'd guess one way
> based on the text here, but the example is the opposite. The description
> here must stand on its own.

Yes, you are right. I will correct the order of ocv-capacity-table-n. Thanks.

>> + - ocv-capacity-table-1: Same as ocv-capacity-table-0
>> + ......
>> + - ocv-capacity-table-n: Same as ocv-capacity-table-0
>> + - ocv-capacity-celsius: An array containing the temperature in degree Celsius,
>> +   for each of the battery capacity lookup table. The first temperature value
>> +   specifies the OCV table 0, and the second temperature value specifies the
>> +   OCV table 1, and so on.
>>
>>  Battery properties are named, where possible, for the corresponding
>>  elements in enum power_supply_property, defined in
>> @@ -44,6 +55,10 @@ Example:
>>               constant-charge-current-max-microamp = <900000>;
>>               constant-charge-voltage-max-microvolt = <4200000>;
>>               factory-internal-resistance-micro-ohms = <250000>;
>> +             ocv-capacity-celsius = <(-10) 0 10>;
>> +             ocv-capacity-table-0 = <4185000 100>, <4113000 95>, <4066000 90>, ...;
>> +             ocv-capacity-table-1 = <4200000 100>, <4185000 95>, <4113000 90>, ...;
>> +             ocv-capacity-table-2 = <4250000 100>, <4200000 95>, <4185000 90>, ...;
>>       };
>>
>>       charger: charger@11 {
>> --
>> 1.7.9.5
>>



-- 
Baolin Wang
Best Regards
