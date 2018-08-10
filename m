Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA0AEC46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 16:27:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 894252189B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 16:27:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="c7xOsotr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 894252189B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729134AbeHJS5l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 14:57:41 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:38437 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728138AbeHJS5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 14:57:41 -0400
Received: by mail-ua1-f68.google.com with SMTP id o11-v6so2465355uak.5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 09:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=5dtrncEM795Zdb/BVWDARRY7YKCknclklpxCnWjjIO0=;
        b=c7xOsotrfJza0WHid4TfY6kKTWsxaO2AmLDqhOK+J+dmjOgUOS6VY1QBC17fVrQgMg
         1S23MlZ/dssMaOvFiIBH8+ce7Mfd3rdb5FCFr0TdRr3ZUhdxuP6r2sWP4IKlqaPhT7dh
         iZUwHU23jn4KLqf4RMbT8pjDiaqcLAjUSx5fw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=5dtrncEM795Zdb/BVWDARRY7YKCknclklpxCnWjjIO0=;
        b=KUwir01MO9UICQU86ZK+ks1ulNJD8w3HXgbaktWC6DYCzVs1wfo71ps73BTxhWQYW4
         aYJ7yGaSYz9RlbNfZ6H6+poKY+8gwSgJlD0n5Us2iSZWP7PFFfRzTYEnaFh1NWfZuOAW
         +s8ZMK4Q9xEeRI6uJ8vg5qol4I8xHAVoIwT4j0zns9He6Epaow/DBeUcIkLA6zBZwG5b
         eKnyPmtqEOOkuAYNwVnY+nPGzxrvu2QJf29kgo7vRqemjlCe/PJK30VZh0HXmzFcYg/c
         D3oRwOV/0bKZoSNjDG9VfqWtQUjXHIY46xqds6JAPSoafAjQZBCDMon1poEJfuBG8kTz
         CaSQ==
X-Gm-Message-State: AOUpUlF6tD/b9TBNWD70TM1LZMi5U4sKZLF/tg63iF5MLAT28rVKutWi
        2M9UlJFQGyoLiAw0hkCMpCrKjoaPlxE=
X-Google-Smtp-Source: AA+uWPxSXe1vWTMpGjZuDdsjxSSgEBzVZabus0yBzQrjvc2lg+TXFmPlJwgFUdq7nW23Z72+XutidQ==
X-Received: by 2002:a1f:3a95:: with SMTP id h143-v6mr4663451vka.42.1533918427917;
        Fri, 10 Aug 2018 09:27:07 -0700 (PDT)
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com. [209.85.222.42])
        by smtp.gmail.com with ESMTPSA id f90-v6sm3332960vki.29.2018.08.10.09.27.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 09:27:06 -0700 (PDT)
Received: by mail-ua1-f42.google.com with SMTP id u11-v6so2463468uan.13
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 09:27:06 -0700 (PDT)
X-Received: by 2002:a9f:3b69:: with SMTP id j41-v6mr4752037uah.37.1533918426089;
 Fri, 10 Aug 2018 09:27:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1f:cd5:0:0:0:0:0 with HTTP; Fri, 10 Aug 2018 09:27:05 -0700 (PDT)
In-Reply-To: <20180810161329.GF20971@sirena.org.uk>
References: <24b3ef71-18c1-1704-e324-5581fd18a998@codeaurora.org>
 <152700759909.210890.13296077062705155869@swboyd.mtv.corp.google.com>
 <20180522173000.GG24776@sirena.org.uk> <8968e04c-a200-ef06-5c33-94e399f7b9fe@codeaurora.org>
 <20180524162940.GA4828@sirena.org.uk> <28d8ab5fdeb34e52eba7ca771a17bc06@codeaurora.org>
 <61f2e1fb394bfe47ace42352f2e1b3a6@codeaurora.org> <CAD=FV=X-fGukBpSOYCO=rv94_3gorL=9qmttsvZk21=m6mwUgA@mail.gmail.com>
 <20180810105205.GC20971@sirena.org.uk> <CAD=FV=XXyL5q1quxUtBohn2GrcadbY9hr6sdw+4qShQnYTgVwA@mail.gmail.com>
 <20180810161329.GF20971@sirena.org.uk>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 10 Aug 2018 09:27:05 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Xu986JWnwC_D6OdUbers4fGf=ExS_z-J_t=QqHOhs1PA@mail.gmail.com>
Message-ID: <CAD=FV=Xu986JWnwC_D6OdUbers4fGf=ExS_z-J_t=QqHOhs1PA@mail.gmail.com>
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

On Fri, Aug 10, 2018 at 9:13 AM, Mark Brown <broonie@kernel.org> wrote:
> On Fri, Aug 10, 2018 at 08:40:17AM -0700, Doug Anderson wrote:
>> On Fri, Aug 10, 2018 at 3:52 AM, Mark Brown <broonie@kernel.org> wrote:
>
>> > This is more about matching the data rate between the two drivers - the
>> > clock framework could (and possibly should) reasonably return an error
>> > here, we're trying to ensure that drivers and controllers work well
>> > together here.
>
>> The clock framework should be able to accomplish what you want.  If
>> you just request the rate it will do its best to make the rate
>> requested.  If we want to see what clock would be set before setting
>
> The request could be massively off the deliverable rate - 50% or more.

Agreed.  If the clock is massively off and that causes problems then
someone will need to debug it and find a solution.  I'm not aware of
us being in that case in the driver in question.


>> >> 3. If you really truly need code in the SPI driver then make sure you
>> >> include a compatible string for the SoC and have a table in the driver
>> >> that's found with of_device_get_match_data().  AKA:
>
>> >>   compatible = "qcom,geni-spi-sdm845", "qcom,geni-spi";
>
>> > A controller driver really shouldn't need to be open coding anything.
>
>> It wouldn't be open-coding, it would be a different way of specifying
>> things.  In my understanding it's always a judgement call about how
>
> If you're saying we need clock rate selection logic (which is what it
> sounds like) rather than data then that seems like a problem.

We're talking past each other I think.  Maybe a concrete example helps?

---

IMO the line marked "/* UNNEEDED */" below should be removed:


spi0: spi@880000 {
    compatible = "qcom,geni-spi";
    ...
    spi-max-frequency = <50000000>;  /* UNNEEDED */

    device@0 {
        spi-max-frequency = <25000000>;
        ...
    }
};

---

Said another way: I don't think we should specify the
spi-max-frequency of the _master_ in the device tree.  If there is
_really_ no way to get the max speed from the clock framework and we
_really_ need a per-controller max speed on all geni controllers on
SDM845 then IMO the above should be:

spi0: spi@880000 {
    compatible = "qcom,geni-spi-sdm845", "qcom,geni-spi";
    ...

    device@0 {
        spi-max-frequency = <25000000>;
        ...
    }
};

...and then the driver should say "oh, I have a compatible string of
"qcom,geni-spi-sdm845" so I know my controller's max frequency must be
50 MHz.  It can get that information using of_device_get_match_data().

---

Hopefully that's clearer?


-Doug
