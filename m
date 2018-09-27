Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16E3FC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 10:00:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFD7421571
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 10:00:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="TFjiii68"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFD7421571
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727295AbeI0QSI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 12:18:08 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38206 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726931AbeI0QSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 12:18:08 -0400
Received: by mail-wr1-f65.google.com with SMTP id j8-v6so1893365wrw.5
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 03:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mNcnbW97ikh850xKastQohPQoEuxX7X1bJNWp/R0kfc=;
        b=TFjiii68mFpLa+Tp/k3w5VWIqggigfwtS4sitjxl8aLLf1Lh4cKklEtHd9X6aYHTWd
         5piCJ0iQbIe6YK2rGR5E5Oee1LXCE6pruGzzLBGcoAvacbGJi7fcGcvOn413czCDWM4L
         iMEGnb9icYeGhA7cmTj2fg1ZjgiPQhnUjAG4Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mNcnbW97ikh850xKastQohPQoEuxX7X1bJNWp/R0kfc=;
        b=Vc48IQCCBwqfxG8OcqnHerLkc+D/VSPe0jYzcYTQkpP2MQ4rsG1rau5E2ERN0etj0Q
         pGOwrr8p8PUVsX+T8xmQE0FRF2r8/b6h6th/W/p4+EZCAmHi0el1KRTY6RXY107nwfhR
         vhPpJib6fl/pi6yBCx3yhymI4XZ0PB5UkPCPeAKmmE44KLb0LAsZ0BCOIXKlJoreRHHu
         ridxyh+jD7eIPOPjlCVauKjQC0Xp1k+LR4TLu/g1bY6XHvKvR6U0e6jo0lHxpxmwPJKQ
         aeIgxh5ZwKp6yzotDow9eKuU/ZoF8HlYAljmxZU7qGwL+cxUhoPHhydnPzYstZeT1QAX
         bKhg==
X-Gm-Message-State: ABuFfoh+KY1WxfNQVduYyIlH0WHXuZ8P0r5zw5FtcvDolTeR/WyHokER
        vkrlRlAWknljW8gg6ABN/UjBYw==
X-Google-Smtp-Source: ACcGV63lM9/XBQecOie4waiDYYdbesS987BdMC5PanDWMFFdtt7BuTt9TrBDv0xAc4CZb6S3puiooA==
X-Received: by 2002:adf:bc84:: with SMTP id g4-v6mr888156wrh.250.1538042437777;
        Thu, 27 Sep 2018 03:00:37 -0700 (PDT)
Received: from [192.168.0.41] (30.216.136.77.rev.sfr.net. [77.136.216.30])
        by smtp.googlemail.com with ESMTPSA id o19-v6sm2004752wro.50.2018.09.27.03.00.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 03:00:36 -0700 (PDT)
Subject: Re: [PATCH] clocksource/drivers/timer-atmel-pit: properly handle
 error cases
To:     Nicolas Ferre <nicolas.ferre@microchip.com>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Cristian Birsan <Cristian.Birsan@microchip.com>
References: <20180425101439.28908-1-alexandre.belloni@bootlin.com>
 <20180501083626.GE27619@mai>
 <d2b356f9-6a29-0ce2-c511-ac1aff8e91ca@microchip.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <f5f48a3e-233d-99e8-bd8c-978b4ca2a7cc@linaro.org>
Date:   Thu, 27 Sep 2018 12:00:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <d2b356f9-6a29-0ce2-c511-ac1aff8e91ca@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/09/2018 14:38, Nicolas Ferre wrote:
> Daniel,
> 
> On 01/05/2018 at 10:36, Daniel Lezcano wrote:
>> On Wed, Apr 25, 2018 at 12:14:39PM +0200, Alexandre Belloni wrote:
>>> smatch now reports a possible leak:
>>>
>>> smatch warnings:
>>> drivers/clocksource/timer-atmel-pit.c:183 at91sam926x_pit_dt_init()
>>> warn: possible memory leak of 'data'
>>>
>>> Ensure data is freed before exiting with an error.
>>>
>>> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
>>> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
>>> ---
>>
>> Applied for 4.17-rc
> 
> We don't see it in Mainline as of 4.19-rc neither in linux-next. Has it
> been forgotten?

Yes, my bad. I thought it was merge in tip:timers/urgent

Let me resend another PR for 4.19-rc and Cc stable@




-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

