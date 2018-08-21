Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C691CC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 10:12:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7334E2172C
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 10:12:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZeXXXPZL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7334E2172C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726850AbeHUNbe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 09:31:34 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36064 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbeHUNbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 09:31:34 -0400
Received: by mail-wm0-f65.google.com with SMTP id w24-v6so2332802wmc.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 03:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LgpZyez+aKYTo4qoN7tRYrRGi3hD+0hjA8QiMiXDphg=;
        b=ZeXXXPZL/k+L4+cgrHkZnqwu+0QWoD/v7XoUdY2Ne/5EBHK7dJVDDcoXA0ryMnOtOR
         3uNfhLpDn53a/caOcR1zbp9lRdUAHnoGAEGmB/ZofKW5K/b4hkxShdC91fA+na3KOVki
         0cej9Ds3GJOLzsdidXLa0XeElriJqVZapWgHA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LgpZyez+aKYTo4qoN7tRYrRGi3hD+0hjA8QiMiXDphg=;
        b=qLxPIQUEpNyVD57fRjw+p8yfN9W2uB5v9eJiQqUdA0X1rIAcCJs1rpltu70KdTKBDo
         /nQiUINBWWcYCByPsXLEwge8a9XJBjPWZnLTCs6FulkZzr+x9teTMMnYwvSBOCCutWjj
         olNHUL5qbSTRmr2RVSVJmy80Wj52DSJVx5w/jBYErOFoNcCKwZqnuN/xHjBIV5xwI2Li
         QbOHXFiZH+n5mfoXXVQ+t0hUFnR9BPnN4qALENcigELktipKwHdTSo0dbWzTnb1qRF2a
         QY2PHd//qon5L62dIY8WkMDQwdZIZE//LFl1UaQDb3x9TZY8Ohp5vBWN9qbsbo13hJ/Q
         cIqw==
X-Gm-Message-State: AOUpUlHes3iklOdnlmDxYPOZafvpgRjVmhrsIVaeI2WpbAlcW+m7Qv2b
        bK0OeSUkwzV7JtriR5pNr1CVoA==
X-Google-Smtp-Source: AA+uWPyE6SuO24FZ/ZxNL3deEDcglhIuccoRWp+Py0wLAbku6AFik9NSnEE+5XsNcb+rqG3vjWf8Ww==
X-Received: by 2002:a1c:9550:: with SMTP id x77-v6mr26558993wmd.135.1534846320234;
        Tue, 21 Aug 2018 03:12:00 -0700 (PDT)
Received: from [192.168.0.18] (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.googlemail.com with ESMTPSA id w10-v6sm15307476wrp.31.2018.08.21.03.11.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Aug 2018 03:11:59 -0700 (PDT)
Subject: Re: [PATCH v2 06/29] mtd: Add support for reading MTD devices via the
 nvmem API
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Alban <albeu@free.fr>, Bartosz Golaszewski <brgl@bgdev.pl>,
        Jonathan Corbet <corbet@lwn.net>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        "David S . Miller" <davem@davemloft.net>,
        Naren <naren.kernel@gmail.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Lukas Wunner <lukas@wunner.de>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        Sven Van Asbroeck <svendev@arcx.com>,
        Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
        David Lechner <david@lechnology.com>,
        Andrew Lunn <andrew@lunn.ch>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-i2c@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20180810080526.27207-1-brgl@bgdev.pl>
 <20180810080526.27207-7-brgl@bgdev.pl> <20180817182720.6a6e5e8e@bbrezillon>
 <20180819133106.0420df5f@tock> <20180819184609.6dcdbb9a@bbrezillon>
 <5b8c30b8-41e1-d59e-542b-fef6c6469ff0@linaro.org>
 <20180820202038.5d3dc195@bbrezillon>
 <e0ec3194-fd3a-9b3d-fba8-f88447eb56e9@linaro.org>
 <20180821115639.4894c1c9@bbrezillon>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <bd4dd892-3b6c-a77e-b2f3-386600c8c9bd@linaro.org>
Date:   Tue, 21 Aug 2018 11:11:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180821115639.4894c1c9@bbrezillon>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21/08/18 10:56, Boris Brezillon wrote:
> On Tue, 21 Aug 2018 10:50:07 +0100
> Srinivas Kandagatla<srinivas.kandagatla@linaro.org>  wrote:
> 
>> On 20/08/18 19:20, Boris Brezillon wrote:
>>> On Mon, 20 Aug 2018 11:43:34 +0100
>>> Srinivas Kandagatla<srinivas.kandagatla@linaro.org>  wrote:
>>>    
>>>> Overall am still not able to clear visualize on how MTD bindings with
>>>> nvmem cells would look in both partition and un-partition usecases?
>>>> An example DT would be nice here!!
>>> Something along those lines:
>>>    
>> This looks good to me.
>>> 	mtdnode {
>>> 		nvmem-cells {
>>> 			#address-cells = <1>;
>>> 			#size-cells = <1>;
>>>
>>> 			cell@0 {
>>> 				reg = <0x0 0x14>;
>>> 			};
>>> 		};
>>>
>>> 		partitions {
>>> 			compatible = "fixed-partitions";
>>> 			#address-cells = <1>;
>>> 			#size-cells = <1>;
>>>
>>> 			partition@0 {
>>> 				reg = <0x0 0x20000>;
>>>
>>> 				nvmem-cells {
>>> 					#address-cells = <1>;
>>> 					#size-cells = <1>;
>>>
>>> 					cell@0 {
>>> 						reg = <0x0 0x10>;
>>> 					};
>>> 				};
>>> 			};
>>> 		};
>>> 	}; >
>> Just curious...Is there a reason why we can't do it like this?:
>> Is this because of issue of #address-cells and #size-cells Or mtd
>> bindings always prefer subnodes?
>>
>> 	mtdnode {
>> 		reg = <0x0123000 0x40000>;
>> 		#address-cells = <1>;
>> 		#size-cells = <1>;
>> 		cell@0 {
>> 			compatible = "nvmem-cell";
>> 			reg = <0x0 0x14>;
>> 		};
>>
>> 		partitions {
>> 			compatible = "fixed-partitions";
>> 			#address-cells = <1>;
>> 			#size-cells = <1>;
>>
>> 			partition@0 {
>> 				reg = <0x0 0x20000>;
>> 				cell@0 {
>> 					compatible = "nvmem-cell";
>> 					reg = <0x0 0x10>;
>> 				};
>> 			};
>> 		};
>> 	};
> It's because partitions were initially directly defined under the mtd
> node, so, if you have an old DT you might have something like:
> 
> 	mtdnode {
> 		reg = <0x0123000 0x40000>;
> 		#address-cells = <1>;
> 		#size-cells = <1>;
> 
> 		partition@0 {
> 			reg = <0x0 0x20000>;
> 			...
> 		};
> 		...
> 	};
> 
> If we use such a DT with this patch applied, the NVMEM framework will
> consider MTD partitions as nvmem cells, which is not what we want.
Yep, I agree.
TBH, I wanted to add compatible string to nvmem-cell at some point in 
time and it seems more natural update too. One of the reason we 
discussed this in the past was parsers. Looks like mtd can make use of this.

We should be able to add this as an optional flag in nvmem_config to 
enforce this check in case providers wanted to.

Do you think that would help mtd nvmem case?
Also I felt like nvmem-cells subnode seems to be a bit heavy!

thanks,
srini
