Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 725ECC4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 15:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AC6C223EA
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 15:40:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fY2XV99h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AC6C223EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728168AbeHJSKn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 14:10:43 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:45578 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727445AbeHJSKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 14:10:43 -0400
Received: by mail-ua1-f65.google.com with SMTP id k8-v6so2304795uaq.12
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 08:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=lMH8nArlE6tWHdJMP3sJaKhwcKeq1zibWTG50RcP4Dg=;
        b=fY2XV99hSDyFZFM7uwU5S0xOt3R3f+3mWaQePP3mM6aHf2Xqhg6fa2NXtVIBmB42aY
         fhT+rsPd5qAyM1NzRbq+8AvA0tnLlL8Z/QbFUQbh12ysNAxlYe2BNaFvPInpT+2qW0pP
         C9YgjZvJj5WocQ/7TTn14TogDB8iRXHSxFE8A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=lMH8nArlE6tWHdJMP3sJaKhwcKeq1zibWTG50RcP4Dg=;
        b=tx+t1g7gCOU7X+cj5regTk5m7PGeJiatDVLeJ6tPFlqOGux3X9W0eEGGKHhPlAIqqc
         Yo3lobfxS3su38Eb2Xx8cMnRvN4dFTm1NtaX+mtOcI0s4MA6OLwCBNcibHAzlteK0xfe
         xbxWsT1sNpBYP5b72F12DHZVICQ0FJQF3T4dzVGj8GceZU0eNhpbU1r8sQ0Fa+nLs8uY
         DW90YO2G/IUavCswsrK9/a4be66w9hpULx8Lm1GCyzCAHYQIfZnZbld0Q0AJuqiNMl4p
         WAuN0jbaADXOZF8m37pKhy8Tu4Y4Tw0P7fj3ewJ1y2jtoF5T4wq/FGrjNLTTIQKsczRi
         zI/w==
X-Gm-Message-State: AOUpUlFmthP86aZbHu4WMzVa6+NLKVGOcrCNgxX47bATdMRqMXdPjE7f
        stHoXynaMcaDPNswjPFAoZhIrJRZ8kg=
X-Google-Smtp-Source: AA+uWPxbxHOLl682dIwW/GiVCrqCBeUaw5kLOLT0xcSLDtzksHiTjmgLxF6R/SxcoVp5ksqU+VXw6g==
X-Received: by 2002:a1f:b449:: with SMTP id d70-v6mr4414336vkf.160.1533915620212;
        Fri, 10 Aug 2018 08:40:20 -0700 (PDT)
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com. [209.85.222.47])
        by smtp.gmail.com with ESMTPSA id y196-v6sm2757637vkd.50.2018.08.10.08.40.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 08:40:19 -0700 (PDT)
Received: by mail-ua1-f47.google.com with SMTP id k25-v6so2304973uao.11
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 08:40:18 -0700 (PDT)
X-Received: by 2002:ab0:3141:: with SMTP id e1-v6mr4567775uam.121.1533915618454;
 Fri, 10 Aug 2018 08:40:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1f:cd5:0:0:0:0:0 with HTTP; Fri, 10 Aug 2018 08:40:17 -0700 (PDT)
In-Reply-To: <20180810105205.GC20971@sirena.org.uk>
References: <1525383283-18390-1-git-send-email-girishm@codeaurora.org>
 <152607782792.34267.8023817955251139395@swboyd.mtv.corp.google.com>
 <24b3ef71-18c1-1704-e324-5581fd18a998@codeaurora.org> <152700759909.210890.13296077062705155869@swboyd.mtv.corp.google.com>
 <20180522173000.GG24776@sirena.org.uk> <8968e04c-a200-ef06-5c33-94e399f7b9fe@codeaurora.org>
 <20180524162940.GA4828@sirena.org.uk> <28d8ab5fdeb34e52eba7ca771a17bc06@codeaurora.org>
 <61f2e1fb394bfe47ace42352f2e1b3a6@codeaurora.org> <CAD=FV=X-fGukBpSOYCO=rv94_3gorL=9qmttsvZk21=m6mwUgA@mail.gmail.com>
 <20180810105205.GC20971@sirena.org.uk>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 10 Aug 2018 08:40:17 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XXyL5q1quxUtBohn2GrcadbY9hr6sdw+4qShQnYTgVwA@mail.gmail.com>
Message-ID: <CAD=FV=XXyL5q1quxUtBohn2GrcadbY9hr6sdw+4qShQnYTgVwA@mail.gmail.com>
Subject: Re: [PATCH] spi: spi-geni-qcom: Add SPI driver support for GENI based QUP
To:     Mark Brown <broonie@kernel.org>
Cc:     Dilip Kota <dkota@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Sagar Dharia <sdharia@codeaurora.org>,
        Karthikeyan Ramasubramanian <kramasub@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "Mahadevan, Girish" <girishm@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Aug 10, 2018 at 3:52 AM, Mark Brown <broonie@kernel.org> wrote:
> On Thu, Aug 09, 2018 at 11:03:55AM -0700, Doug Anderson wrote:
>> On Fri, Aug 3, 2018 at 5:18 AM,  <dkota@codeaurora.org> wrote:
>
>> > Also, spi core framework will set the transfer speed to controller max
>> > frequency
>> > if transfer frequency is greater than controller max frequency.
>> > Please mention if you have a other opinion.
>
>> 1. It sure seems like the clock framework could be enforcing the max
>> speed here.  SPI can just ask for the speed and the clock framework
>> will pick the highest speed it can if you ask for one too high.  Isn't
>> that the whole point of the "struct freq_tbl" in the clock driver?
>
> This is more about matching the data rate between the two drivers - the
> clock framework could (and possibly should) reasonably return an error
> here, we're trying to ensure that drivers and controllers work well
> together here.

The clock framework should be able to accomplish what you want.  If
you just request the rate it will do its best to make the rate
requested.  If we want to see what clock would be set before setting
it, we could use clk_round_rate().  Then we'd have to decide if the
clock framework is giving us something close enough.  ...but then what
is "close enough" in this case?  I haven't gone and dug, but I've
always seen people only specify a max rate for SPI.  ...so as long as
the clock framework gives us something <= the clock we requested then
we should be OK, right?  If / when this becomes a problem then we
should add a min/max to "struct spi_transfer", no?

Note that there are also clk_set_rate_range(), clk_set_min_rate(), and
clk_set_max_rate() though I'm told those might be a bit quirky.


>> 2. The device tree writer already provides a max clock speed for each
>> SPI slave in the device tree.  ...shouldn't the device tree writer
>> already be taking into account the max of the SPI port when setting
>> this value?
>
> Yes.  We're overriding this because drivers can set a speed from code
> (this is especially common when devices have variable maximum speeds for
> different operations).

OK, makes sense.  You can still cap the max per SPI-slave in the
device tree if you really have to though, right?

...but maybe we don't need to argue about this anyway since IMHO we
should just use the clk framework to figure out our maximum speed.


>> 3. If you really truly need code in the SPI driver then make sure you
>> include a compatible string for the SoC and have a table in the driver
>> that's found with of_device_get_match_data().  AKA:
>
>>   compatible = "qcom,geni-spi-sdm845", "qcom,geni-spi";
>
> A controller driver really shouldn't need to be open coding anything.

It wouldn't be open-coding, it would be a different way of specifying
things.  In my understanding it's always a judgement call about how
much to put in a table that's matched via an SoC-specific compatible
string and how much to describe the SoC-specific behavior device tree
properties.  On the spectrum I've found it's usually best to error on
the side of having a table matched via SoC-specific compatible
strings.

For an example commit of moving _away_ from describing SoC-specific
behavior and just matching on the compatible, see commit 0fbc47d9e426
("phy: rockchip-typec: deprecate some DT properties for various
register fields.") and the associated bindings commit 6912d4f40bc7
("dt-bindings: phy-rockchip-typec: deprecate some register
properties.").


-Doug
