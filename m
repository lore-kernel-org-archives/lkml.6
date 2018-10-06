Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A859EC677E8
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 17:02:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5397521486
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 17:02:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YTRTROlO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5397521486
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727951AbeJGAGz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 20:06:55 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51461 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726256AbeJGAGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 20:06:55 -0400
Received: by mail-wm1-f67.google.com with SMTP id 143-v6so4435436wmf.1
        for <linux-kernel@vger.kernel.org>; Sat, 06 Oct 2018 10:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZAbHohvfMG0TDgFeW4zJNLWY2xuStAPo5HN+M6fgGUY=;
        b=YTRTROlOX5JZoSQKONwP7d/zsWei466HXsOowoEfNDdfhfZlYsQ8CdhAXSpzfkBEyR
         XmRmHgJtKyrjWawghH6VUA2zQzpiZNqtiF/pvDUwp+ChYm9W2omQ0+Imk//Y6aH1D6Js
         O8jt9MWePIEAoQVnIwCPkjC30LPNyNX7WyBuU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZAbHohvfMG0TDgFeW4zJNLWY2xuStAPo5HN+M6fgGUY=;
        b=K976sfUvfW5DsDNHOlkNdAHX1Hva1CFqeOVQKphRsVMyzghOCwxu5U6dfI94e7E3Ng
         ndgyG/oMr5O0jLrt27PtHi5WQqpihh5+TfAVDpjhFNnKyzcXlRYC1zZkN/z9uAQOrHps
         ycCbb0xOGGfEfr5Tn1Qo626G0KaPwAX0yyNKdbVh/hIt+71OD32Zrl4wsLRZyo2prIgH
         PcSn29kYsCcW4U68CtpjDAT71corSCNo94W86ydDArrSDylnS01j1PNLrPG86/Te5xTH
         TNC2zMPhLhSADyjwOXRYW+oxfDy7ljmduxvc7hZMsT/LzrYuYRCexPhIcUAeN6tYJDVM
         UWpw==
X-Gm-Message-State: ABuFfogvLERU65QfZE0aRFb8+iJjTNAhslEZbOPP0nTKos8zhoVALGov
        t8uAjtHvW0672EqdfdDHRBTTGQ==
X-Google-Smtp-Source: ACcGV60d2Ot8hF2KMCRth+BKiT82HldT09r1WhDNhqLw9Z9IosMLrH2xG2BWkeokkHT9QCPu3cSVUQ==
X-Received: by 2002:a1c:c708:: with SMTP id x8-v6mr10844881wmf.116.1538845366764;
        Sat, 06 Oct 2018 10:02:46 -0700 (PDT)
Received: from [192.168.0.40] (41.220.136.77.rev.sfr.net. [77.136.220.41])
        by smtp.googlemail.com with ESMTPSA id l67-v6sm13967170wma.20.2018.10.06.10.02.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Oct 2018 10:02:45 -0700 (PDT)
Subject: Re: [PATCH 13/13] clocksource/drivers/dw_apb: Add reset control
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        Marek Vasut <marex@denx.de>
References: <20181005143253.GE1881@mai>
 <1538750143-4282-1-git-send-email-daniel.lezcano@linaro.org>
 <1538750143-4282-13-git-send-email-daniel.lezcano@linaro.org>
 <alpine.DEB.2.21.1810061433170.5454@nanos.tec.linutronix.de>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <5ebc1d90-2067-8cb5-0c93-1c9f0677abc5@linaro.org>
Date:   Sat, 6 Oct 2018 19:02:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1810061433170.5454@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/10/2018 14:34, Thomas Gleixner wrote:
> On Fri, 5 Oct 2018, Daniel Lezcano wrote:
> 
>> From: Dinh Nguyen <dinguyen@kernel.org>
>>
>> Add code to retrieve the reset property from the dw-apb timers and if
>> the property is available, the safe operation is to assert the timer
>> into reset, and followed by a deassert of the timer reset (brings the
>> timer out of reset).
>>
>> This patch is needed for systems where the bootloader has left the timer
>> not used in reset.
>>
>>  - Trivial conflict with commit a74bd1ad7a:
>>     "Convert to using %pOFn instead of device_node.name"
>>
>> Signed-off-by: Marek Vasut <marex@denx.de>
>> Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
> 
> Ingo just noticed, that this SOB chain is wrong. How is Marek involved
> here? Can you please fix that up and send me another pull request?

Thomas,

I will fix it as soon as possible but I would like to give the
opportunity to Dinh to explain why he sent the patch with Marek's SOB.

Dinh ?


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

