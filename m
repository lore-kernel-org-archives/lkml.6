Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EB74C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 22:57:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F50F2075B
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 22:57:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gm0to+oa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F50F2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728123AbeKSJSg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 04:18:36 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45427 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726890AbeKSJSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 04:18:36 -0500
Received: by mail-pf1-f196.google.com with SMTP id g62so10621693pfd.12;
        Sun, 18 Nov 2018 14:56:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3RFURpqRMJP1tniJlzsZP/khS1dRK2eXuF0gEkkIHLI=;
        b=gm0to+oaaAWh6XjcWKYURQphBW7mBJUkdBXz/yshhgZydcnWC9QqBSaGlwbrnMVA9I
         xPYlklIqXxZWzjt6lY1XkU4e9hCZjtjbFYEk2av/oJnw7W/dk8hwV1KArZZNd06NG0DK
         s8559/0bw9ivMYvYnlsDVXCMSe6+q/ba4cC7JUYRZ+DVmx7Q/WDvgg4pkyeysQfaHNWP
         K6/iERyB+UqzJTKk+GMirjARRuZWW0OICs72jY9FpWf4pAItCaOPEZP+dxZePxYao6SX
         oWK9nlL6flrrGGTVG9Jv4OcnMblu50pN9SaR1IkQD6ArDVgrsDNtoiRKFwOmPWQ1LcRK
         GZog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3RFURpqRMJP1tniJlzsZP/khS1dRK2eXuF0gEkkIHLI=;
        b=W+rmJgodw/Tq+wIAbksXtfOE90sBWaYdXszIBNK9CqyhrnF+nARIpONQJAGJctB05J
         yfCa7bHSq8wzF6ptmftaqsAB/tJs0nZpQhf8dJMwWMET3FEZo4bcHAaVep3dTIF3hwup
         0GfoQkt/PBAerx2JFQ5sgolJ6BfrINNsQiQKXhG/b/YHoXra2XTorzo+4TgxmDl/71t+
         wgrg3+ZXTzfSjGmyNg9irnXmuJygh4WEBMimxifOhd+/c6YleHSKzj0X5Hyv8YxETte2
         FiN99IT0HIXSYXky9kQw67a9+HBsM/YVBO8rFGMA/fHkgP8hLGahCo0uzkeCxVHXMXLX
         ELYg==
X-Gm-Message-State: AGRZ1gKlFk2ugdgXJJBNgO891jsSgvLlWaL1tZVYTr4D8zXnoSiXwJ6W
        FdG6GPBhYCTIE6JhlsUp8gM=
X-Google-Smtp-Source: AJdET5czLQ/x/hRwmyKaSnnk5Loe3QoU0WZ3QduFpKJgAJL3+2cCeQGgzQUJmzzootX6fRluogijLQ==
X-Received: by 2002:a62:3a82:: with SMTP id v2mr20327360pfj.174.1542581818696;
        Sun, 18 Nov 2018 14:56:58 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d6sm24809930pgc.89.2018.11.18.14.56.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 18 Nov 2018 14:56:58 -0800 (PST)
Subject: Re: [PATCH v2 1/2] dt-bindings: hwmon: add binding documentation for
 adt7475
To:     Rob Herring <robh@kernel.org>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>
References: <20181108225607.7521-1-chris.packham@alliedtelesis.co.nz>
 <20181108225607.7521-2-chris.packham@alliedtelesis.co.nz>
 <20181117152949.GA31247@bogus>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <f3a29bc9-dbfc-bfb8-8707-2b67d96c2e04@roeck-us.net>
Date:   Sun, 18 Nov 2018 14:56:56 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181117152949.GA31247@bogus>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/17/18 7:29 AM, Rob Herring wrote:
> On Fri, Nov 09, 2018 at 11:56:06AM +1300, Chris Packham wrote:
>> With the addition of the invert-pwm property the adt7475 needs its own
>> binding documentation rather being captured under trivial-devices.txt.
>>
>> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
>> ---
>> Changes in v2:
>> - use pwm-polarity attiribute to indicate normal or inverted polarity.
>>
>>   .../devicetree/bindings/hwmon/adt7475.txt     | 24 +++++++++++++++++++
>>   .../devicetree/bindings/trivial-devices.txt   |  4 ----
>>   2 files changed, 24 insertions(+), 4 deletions(-)
>>   create mode 100644 Documentation/devicetree/bindings/hwmon/adt7475.txt
>>
>> diff --git a/Documentation/devicetree/bindings/hwmon/adt7475.txt b/Documentation/devicetree/bindings/hwmon/adt7475.txt
>> new file mode 100644
>> index 000000000000..d9212b5e9036
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/hwmon/adt7475.txt
>> @@ -0,0 +1,24 @@
>> +*ADT7475 hwmon sensor.
>> +
>> +Required properties:
>> +- compatible: One of
>> +	"adi,adt7473"
>> +	"adi,adt7475"
>> +	"adi,adt7476"
>> +	"adi,adt7490"
>> +
>> +- reg: I2C address
>> +
>> +optional properties:
>> +
>> +- pwm-polarity: This configures the polarity of the PWM. 0
>> +		(PWM_POLARITY_NORMAL) uses logic high for 100% duty cycle. 1
>> +                (PWM_POLARITY_INVERSED) uses logic low for 100% duty cycle.
> 
> So we're using part of the PWM binding, but none of the rest of it? What
> is the PWM connection here?
> The chip has a built-in PWM controller to control fan speeds. PWM frequency
as well as PWM polarity are configurable. I had suggested to use the terminology
from Documentation/devicetree/bindings/pwm/pwm.txt. Other than terminology there
is no connection to a standard pwm controller.

Another option/possibility would be to use a boolean, such as pwm-polarity-inverted.
We are open to suggestions.

> It sounds like this is common for sensors, so this should be documented
> somewhere common.
> 
Sure, no problem. Any suggestion where ?

Thanks,
Guenter
