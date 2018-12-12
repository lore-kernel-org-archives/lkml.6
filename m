Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE071C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 15:53:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EF372084E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 15:53:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="e+hnAaDj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EF372084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbeLLPxD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 10:53:03 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40189 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbeLLPxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 10:53:02 -0500
Received: by mail-wr1-f66.google.com with SMTP id p4so18188074wrt.7
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 07:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eZOkEsSD876kQAIHIKoB50hknJaF111Sooyv/HfcqUI=;
        b=e+hnAaDjI6PEZL5glA1EKOEksfwQ0LX/NBSFnrV5EqEUe5ESsAuq4IjCTDdzQyFe8w
         6i6C3RFBzN6whGlHpfVJ7fcU3JAE0OQ/PYf4utSK7fImezCNg4aqgq+Nwrs07mGjjIQT
         oLjYbhoOOsC6ovRzE/N/s18Lc32YAPFHra3xI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eZOkEsSD876kQAIHIKoB50hknJaF111Sooyv/HfcqUI=;
        b=bGkypHUJYccW0bse2tBl9/xpBNBiFkiu9H57ivNlEcnl5BxMaZ2zeJC9JyXqM91oGg
         YFo4Wus6Vg9H2GOARscF4s/sJPMQdXuV3449VFVBNRKsImKP7Ptl4/kwK2IEQ2qC1OLJ
         aS/OTicWQnSOLhOyxho5DcE8bg8Ht4kW/niKlYfolEOa/3/Zk4aDvyRh3yUBK9Ipfsqz
         lLhv4aKLsVWAq3smXDL/RV8qmSgDwJQWr6gCl6ASNUNYUGSfV1cHW56IULIw5PcYwMpS
         93RAYARcGVGF3W1GZlDUEfkDhIyoX/++HMDe2rD9QwR/g2eEEnYkpD82rH7xeTDK3gcD
         57Qg==
X-Gm-Message-State: AA+aEWaCtCZftOo5lty6dAP0LwPfmllVMUOFNfe75IxzfgQ2GzKMptFb
        iVGE2bRRfJX33Yk7xKGYVzZJKw==
X-Google-Smtp-Source: AFSGD/Wn511cQF7AvdAPj5Q5rNC7KM6tsewGV3tqpWxDYY3tIVQcvWt+ClH7A3kLWKK5tdSfWEtsnw==
X-Received: by 2002:adf:f211:: with SMTP id p17mr17510890wro.293.1544629980745;
        Wed, 12 Dec 2018 07:53:00 -0800 (PST)
Received: from [192.168.0.40] (73.150.94.92.rev.sfr.net. [92.94.150.73])
        by smtp.googlemail.com with ESMTPSA id b12sm6256501wrt.17.2018.12.12.07.52.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Dec 2018 07:53:00 -0800 (PST)
Subject: Re: [PATCH v4 11/15] clocksource: Add clock driver for RDA8810PL SoC
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     olof@lixom.net, arnd@arndb.de, robh+dt@kernel.org,
        tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com,
        gregkh@linuxfoundation.org, jslaby@suse.com,
        linux-unisoc@lists.infradead.org, afaerber@suse.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
        amit.kucheria@linaro.org, linus.walleij@linaro.org,
        zhao_steven@263.net
References: <20181210173550.29643-1-manivannan.sadhasivam@linaro.org>
 <20181210173550.29643-12-manivannan.sadhasivam@linaro.org>
 <0b90a179-aa4b-57f7-0874-996d5c535ea9@linaro.org>
 <20181212154748.GA28130@Mani-XPS-13-9360>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <affe5ffd-66de-526a-f568-52ad5f0c0083@linaro.org>
Date:   Wed, 12 Dec 2018 16:52:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181212154748.GA28130@Mani-XPS-13-9360>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/12/2018 16:47, Manivannan Sadhasivam wrote:
> Hi Daniel,
> 
> On Wed, Dec 12, 2018 at 04:07:53PM +0100, Daniel Lezcano wrote:
>> On 10/12/2018 18:35, Manivannan Sadhasivam wrote:
>>> Add clock driver for RDA Micro RDA8810PL SoC supporting OSTIMER
>>> and HWTIMER.
>>>
>>> RDA8810PL has two independent timers: OSTIMER (56 bit) and HWTIMER
>>> (64 bit). Each timer provides optional interrupt support. In this
>>> driver, OSTIMER is used for clockevents and HWTIMER is used for
>>> clocksource.
>>>
>>> Signed-off-by: Andreas Färber <afaerber@suse.de>
>>> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>>
>> The driver looks good to me. Do you want me to pick it up via my tree?
>>
> 
> Yes, please do. Marc is going to pick up the irqchip driver but I'm not
> sure about the serial driver. The rest of the patches can be picked up
> by the ARM maintainers (I need to send another version for dropping
> Andreas from MAINTAINERS).

Ok, applied.

Thanks

  -- Daniel


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

