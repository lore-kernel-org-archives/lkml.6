Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E4C6ECE561
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 12:20:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACA4F204EC
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 12:20:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACA4F204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tabi.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732687AbeITSDh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 14:03:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:44398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732247AbeITSDh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 14:03:37 -0400
Received: from [192.168.1.75] (cpe-24-28-70-126.austin.res.rr.com [24.28.70.126])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7679C204EC;
        Thu, 20 Sep 2018 12:20:22 +0000 (UTC)
From:   Timur Tabi <timur@tabi.org>
Subject: Re: [PATCH] gpiolib: Show correct direction from the beginning
To:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>, swboyd@chromium.org,
        linux-gpio@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <20180914070839.4667-1-ricardo.ribalda@gmail.com>
 <20180914070839.4667-2-ricardo.ribalda@gmail.com>
 <CACRpkdbqmK=MzGsOYLdtFO3AAbKHhzy_RD=Gr6wj3WnQunyCGg@mail.gmail.com>
 <CAPybu_0iDqSn02iGLEg8Ge9EdyCCNhRVV3JgHg180qrXK+bcdw@mail.gmail.com>
 <d84ee082-f578-3ed3-32be-dbeb9562980e@kernel.org>
 <CAPybu_39xtDfoHVo2dv2GZcU5hCQYjBpU7tW2hf3vfUwbUK1mQ@mail.gmail.com>
Message-ID: <015715f7-64bc-aca6-77fe-68ddb6c938a8@kernel.org>
Date:   Thu, 20 Sep 2018 07:20:18 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAPybu_39xtDfoHVo2dv2GZcU5hCQYjBpU7tW2hf3vfUwbUK1mQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/19/2018 10:27 AM, Ricardo Ribalda Delgado wrote:
> Let me explain my current setup
> 
> I have a board with input and output gpios, the direction is defined
> via pdata. When I run gpioinfo all the gpios are shown as input,
> regardless if they are input or outputs: Eg:
> 
> root@qt5022:/tmp# ./gpioinfo
> 
> gpiochip0 - 16 lines:
>          line   0:     "PROG_B"       unused   input  active-high
>          line   1:         "M0"       unused   input  active-high
>          line   2:         "M1"       unused   input  active-high
>          line   3:         "M2"       unused   input  active-high
>          line   4:        "DIN"       unused   input  active-high
>          line   5:       "CCLK"       unused   input  active-high
>          line   6:      unnamed       unused   input  active-high
>          line   7:      unnamed       unused   input  active-high
>          line   8:       "DONE"       unused   input  active-high
>          line   9:     "INIT_B"       unused   input  active-high
>          line  10:      unnamed       unused   input  active-high
>          line  11:      unnamed       unused   input  active-high
>          line  12:      unnamed       unused   input  active-high
>          line  13:      unnamed       unused   input  active-high
>          line  14:      unnamed       unused   input  active-high
>          line  15:      unnamed       unused   input  active-high

Yes, this is a known problem that should be fixed.

> That is wrong and very confusing to the user, it can also lead to a
> mayor fuckup if the user decides to connect two output gpio pins
> because he expects that both are input. (This is the programming port,
> but I also have 24 V -high current GPIOs)

Users are expected to program the direction for every GPIO they want to 
use, regardless of whatever it's set to before they open it.

> There is a function in the API to tell libgpio if a gpio is out our
> in. Why not use it?

Because calling that API before properly claiming the GPIO is a 
programming error.

> - If the configuration is hardcoded, the driver will return a fixed value
> - If it is cheap to query the hardware, the driver will query the hardware,
> - If it is expensive to query the hardware the driver can either
> return a cached value or a fake value (current situation)

The reason why the Qualcomm driver is impacted the most is because on 
ACPI platforms, the GPIO map is "sparse".  That is, not every GPIO 
between 0 and n-1 actually exists.  So reading a GPIO that doesn't exist 
is invalid.

The way to protect against that is to claim the GPIO first.  If the 
claim is rejected, then you know that you can't access that GPIO.

The bug is that the original code that I deleted (and that you're trying 
to put back) doesn't claim the GPIO first.

>>From my point of view:  "The get_direction callback normally triggers
> a  read/write to hardware, but we shouldn't be touching the hardware
> for   an individual GPIO until after it's been properly claimed." is
> an statement specific for your platform and should be fixed in your
> driver.
> 
> Either that, or I have completely missunderstund the purpouse of gpiod
> :), and that could easily be the case.

It's not a platform-specific statement.  It applies to all drivers.  In 
some drivers, the get_direction function had side-effects (like 
programming muxes, IIRC) that no one really cared about but was 
technically wrong.

I'm not sure how to properly fix this, but I wonder if we need some kind 
of late-stage initialization where gpiolib scans all the GPIOs by 
claiming them first, reading the directions, and then releasing them.
