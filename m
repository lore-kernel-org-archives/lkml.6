Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF508C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 14:43:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EB5620684
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 14:43:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pnungfiq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EB5620684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405601AbeKWBWx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 20:22:53 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46648 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732343AbeKWBWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 20:22:53 -0500
Received: by mail-wr1-f67.google.com with SMTP id l9so9495841wrt.13
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 06:43:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AvF/C6Afh+OVqJhMBVaEJLEyUXqZYy0rDO6p2WJsYNM=;
        b=Pnungfiq8IqJ7SBfQx8i6ImRN3zaN3qSItLlOejDAa6zdz5vTw98smvZ6bnmR+EhC8
         +YFz39/CmdL7KgFBx5B87gyDZvygroOsPar4Ke1teIhBIpTWJI2vDNYPOXkwvKV3Na8r
         eRiUTkTzK00vsophcno8r11+GOt7/5aVZ/5vk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AvF/C6Afh+OVqJhMBVaEJLEyUXqZYy0rDO6p2WJsYNM=;
        b=hoyUOb8EjKNnSB5b1td5+u5crH39mWsMMPXDFDBWjh/Dye4VnCvjCmxJCD0SGfLt2h
         TfPvqpOeX3EttVUsdfj4EPDL2PeRKCvdiebl9Yazwnrb2j7Kfr2vKawZCZLfGzkBscdK
         dyyb3w93+JujriVtVOMg/TVVg21hr1zIdA5XlNFEgB81hrs13LT7u6f0NCyrAbkCovPw
         3TEfptart4KbA8g237GavJWwnNhMgNVpTDV8HJQLZHY84NCO+chpn/MDEVwZY0aulWmA
         sb31pwy9jJR7QC4fL4PxC/w4UGYzJaDhpt6t25fHTWNWxc2cNdrQa16LEWLWYsiNti5N
         Bxng==
X-Gm-Message-State: AA+aEWYox1alwP/X7T5wavzqgdkdShW2ESca4C0kuvftNtr/k7VS6iOk
        VOgssXTKXrPaYRmGKq+BwCxPYd+KJ+I=
X-Google-Smtp-Source: AFSGD/XlH8KHX0Lp0dpFmxb/9P+fzN6BTrT5anTWdOKvSGnmvwlP5YSY7iz8D+WVrJXAVzP8QIAIzw==
X-Received: by 2002:a5d:5284:: with SMTP id c4-v6mr9484406wrv.210.1542897791845;
        Thu, 22 Nov 2018 06:43:11 -0800 (PST)
Received: from [192.168.0.40] (44.65.136.77.rev.sfr.net. [77.136.65.44])
        by smtp.googlemail.com with ESMTPSA id 184-v6sm4983066wmh.36.2018.11.22.06.43.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Nov 2018 06:43:11 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH] clocksource/drivers/integrator-ap: add of_node_put()
To:     Frank Lee <tiny.windzz@gmail.com>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org
References: <20181120131853.19710-1-tiny.windzz@gmail.com>
 <5ea4da1e-65de-ddc3-5ca6-eb83c2347930@linaro.org>
 <CAEExFWsOh1gixoC4bbSkbawC-ybz1YUA-tmw5FW5W-GFyFGs7Q@mail.gmail.com>
 <54a66dbf-df0a-8cec-cb60-0603a52dad99@linaro.org>
 <CAEExFWvTCJ-k+54PGv7Ov5FRMpD1C2ZzzUxi4=Kbn_hrkmBmqw@mail.gmail.com>
Message-ID: <2cbc73df-e1b4-21bc-c226-38b69ebe9f08@linaro.org>
Date:   Thu, 22 Nov 2018 15:43:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAEExFWvTCJ-k+54PGv7Ov5FRMpD1C2ZzzUxi4=Kbn_hrkmBmqw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/11/2018 15:39, Frank Lee wrote:
> On Thu, Nov 22, 2018 at 10:37 PM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>> On 22/11/2018 15:33, Frank Lee wrote:
>>> On Thu, Nov 22, 2018 at 10:26 PM Daniel Lezcano
>>> <daniel.lezcano@linaro.org> wrote:
>>>>
>>>> On 20/11/2018 14:18, Yangtao Li wrote:
>>>>> use of_node_put() to release the refcount.
>>>>>
>>>>> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
>>>>
>>>> Applied, thanks!
>>> Hi Daniel：
>>>
>>> This patch is a bit small, I will resend。
>>
>> What do you mean by 'small' ?
>         pri_node = of_find_node_by_path(path);
>         if (node == pri_node){
>                 of_node_put(pri_node);
> 
>                 /* The primary timer lacks IRQ, use as clocksource */
>                 return integrator_clocksource_init(rate, base);
>         }
> 
>         sec_node = of_find_node_by_path(path);
> 
> Under my revision, pri_node and sec_nodeare the same thing.

Oh, right. Missed it :/



-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

