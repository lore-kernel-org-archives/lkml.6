Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A82FC71122
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 06:53:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D504220652
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 06:53:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HLyrAZ0t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D504220652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbeJNOdU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 10:33:20 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44314 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726356AbeJNOdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 10:33:20 -0400
Received: by mail-lj1-f194.google.com with SMTP id v6-v6so14677572ljc.11
        for <linux-kernel@vger.kernel.org>; Sat, 13 Oct 2018 23:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=M6W+/QMjs1HJ2Qy8aAyCyWYoWpUGfff6SgHNSznsQ/g=;
        b=HLyrAZ0tac77WVZkkUZOgg3O0qOy+bg0ysQo0vosA8wsa9lyb7hbGCa7GSYXLG/6dq
         btNDR7KY24mbIe/ET5LzOEZwoWeKuPNAQL8PvoQIwsJf6aIs0re1HbuQe5RUVXpEnHtW
         HA6EHXDOFmkSMi8Z2GfyQJgbFi5vu9f3Z1wko=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=M6W+/QMjs1HJ2Qy8aAyCyWYoWpUGfff6SgHNSznsQ/g=;
        b=tdfTqzAkpmAZIaipYdzitJ6Pt/A9CiPF2xyeaDOxwF1ERD+vqWL+QSUYniu/NT24Zc
         i2hlbnT/AG9K1me2x//zhnI0u9xQpPLL5VsFW3uP13YQDaKWF9zkGk/t6/5St49iHi9q
         GPNv1a1NUhvAGvOxvsrKhzejacUu5nUnvvQLFVhEoJIp2lAOe1Cs336DyuFNXpXwuEb6
         Fxmyy2W9l70xSO0JF8SIjW6DLs2/0tE06x3ViulZTpaM417TwBGrbqmFyFE9rWI5Povn
         zdE4kyOSjBVce1B1ucQ+MW6eUeHr6qkpcrIfN1s3WIwxD7jLcT5xTlLjy8jpPdfcnsij
         83Gw==
X-Gm-Message-State: ABuFfoiZugsYH9MnpdZVPK0DRx1fFq20TmBeLbxelqkOMEOKcjzjmacr
        VBlzlDzETeqIF1lfSWWgi4EwqjnwigE8i/DrUfaqoaUvA1wCm6zY
X-Google-Smtp-Source: ACcGV63FhxytCoMkIPoxcfezc/ta+fc+gO2Lt7bwiFPXS1SPvmX/Zq5aN+v34PilJabTLbWOaGNBfi6Hy8drXw8rZQI=
X-Received: by 2002:a2e:9b46:: with SMTP id o6-v6mr8551093ljj.78.1539500000136;
 Sat, 13 Oct 2018 23:53:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:95d7:0:0:0:0:0 with HTTP; Sat, 13 Oct 2018 23:53:19
 -0700 (PDT)
In-Reply-To: <20181012143530.GA28145@bogus>
References: <2787f18a0366576959557d05112a069dca982269.1538033078.git.baolin.wang@linaro.org>
 <7dccec1694a05a524710e59a63859974b4cdae89.1538033078.git.baolin.wang@linaro.org>
 <20181012143530.GA28145@bogus>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Sun, 14 Oct 2018 14:53:19 +0800
Message-ID: <CAMz4kuKo0jZ8YS7zx-t8hESedTYb094VLzdzNOpQd04M3kE4Dw@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] power: supply: core: Introduce properties to
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

Hi Rob,

On 12 October 2018 at 22:35, Rob Herring <robh@kernel.org> wrote:
> On Thu, Sep 27, 2018 at 03:26:55PM +0800, Baolin Wang wrote:
>> Some battery driver will use the open circuit voltage (OCV) value to look
>> up the corresponding battery capacity percent in one certain degree Celsius.
>> Thus this patch provides some battery properties to present the OCV table
>> temperatures and OCV capacity table values. Moreover it also provides some
>> helper functions to use the OCV capacity table for users.
>>
>> Suggested-by: Sebastian Reichel <sre@kernel.org>
>> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
>> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>> ---
>> Changes from v2:
>>  - Use type __be32 to calculate the table length.
>>  - Update error messages.
>>  - Add some helper functions.
>>
>> Changes from v1:
>>  - New patch in v2.
>> ---
>>  .../devicetree/bindings/power/supply/battery.txt   |   14 +++
>
> Please split binding patches.

Sure.

>
>>  drivers/power/supply/power_supply_core.c           |  125 +++++++++++++++++++-
>>  include/linux/power_supply.h                       |   19 +++
>>  3 files changed, 157 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/power/supply/battery.txt b/Documentation/devicetree/bindings/power/supply/battery.txt
>> index 938d027..cad38df 100644
>> --- a/Documentation/devicetree/bindings/power/supply/battery.txt
>> +++ b/Documentation/devicetree/bindings/power/supply/battery.txt
>> @@ -23,6 +23,16 @@ Optional Properties:
>>   - constant-charge-current-max-microamp: maximum constant input current
>>   - constant-charge-voltage-max-microvolt: maximum constant input voltage
>>   - factory-internal-resistance-micro-ohms: battery factory internal resistance
>> + - ocv-capacity-table-0: An array providing the battery capacity percent
>> +   with corresponding open circuit voltage (OCV) of the battery, which
>> +   is used to look up battery capacity according to current OCV value.
>> + - ocv-capacity-table-1: Same as ocv-capacity-table-0
>> + ......
>> + - ocv-capacity-table-n: Same as ocv-capacity-table-0
>
> So it is tubles of (percent, voltage)? What's the units for voltage?

Yes. The units for voltage is microvolt, and I will add some words to
make it clear in next version.

>
> What determines the # of entries for each table? Do all tables have the
> same number of entries?

Not same, that depends on the battery drivers' requirement.

>> + - ocv-capacity-table-temperatures: An array containing the temperature
>> +   in degree Celsius, for each of the battery capacity lookup table.
>> +   The first temperature value specifies the OCV table 0, and the second
>> +   temperature value specifies the OCV table 1, and so on.
>
> This should have unit suffix. Perhaps just "ocv-capacity-celsius" to
> avoid being too long.

I am fine with this. Thanks for your comments.

Sebastian and Linusw, what do you think about Rob's suggestion? Thanks.

-- 
Baolin Wang
Best Regards
