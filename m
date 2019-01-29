Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CD4AC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:04:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F20EA2084A
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:04:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YaHZ8DKf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727902AbfA2JE3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 04:04:29 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40788 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725298AbfA2JE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 04:04:28 -0500
Received: by mail-lj1-f196.google.com with SMTP id n18-v6so16771966lji.7
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 01:04:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UMbazCSb1nLk9SjRCQYLf+OiTTp5QrpSco9qD6Gx0AU=;
        b=YaHZ8DKfdir0ctMFXX8giR96KjXIRT3UpWFTmAntv+m6n0mHDDq7ATVd02sAkkkZO+
         CN1K4EBb0ob92zrSbfNDNiZWCMh93Uc2y1HMNgyhYHrfThp7mVjK/tV3ztc+kFUGyMHA
         tMAMjiRKYwJ1XrvpFxMKPaTp4twb/s4AJoItQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UMbazCSb1nLk9SjRCQYLf+OiTTp5QrpSco9qD6Gx0AU=;
        b=ltrySCg43iM5CqobNFPq1bVWlDpIrOSdKFkrvkEhBlrEpRsw3UHcAqYfk/we/VebX2
         k41Hen/sdastEBju9ZRvDeUxzme6lcIOwprUXoxXdPLQOjSC0PQnL0NA71xXLfyQm6eU
         iGnpFwiseXr3lZXq13aX31180iF84x8wtuWdfkdRU9UMSjotYQRYPxO3A2EC1i6fvEbo
         NVC4nso9pYV7K72r+LmdjEAlU7FLzFYbpSeovcHvNEumqPa403lghMCXVw7YNg9Y/8QB
         2zKEgrGvlNGCTVuSNYuhuvCrm/7sClO2thT/iRNwa7ezNYXNwkyh5lfVIWZFG/yqbUPh
         j32w==
X-Gm-Message-State: AJcUukfLayO1ywBDYjbxYCKrEdIs+7uvtgn36+HEHPAtGjUiLnYWGyMA
        X/UKjUpNP1WsEl989UJqXeZJm8uDkqUQpkN/oNdf3Q==
X-Google-Smtp-Source: ALg8bN4O5hlgBUN/8mMyxVTEnyUxp/GmuW1Xyy5/cxKTkHrcqc/mxqV2c8LUUfDT/6uZ99jMJLJ+WROUBNCiq7v+j7I=
X-Received: by 2002:a2e:7e04:: with SMTP id z4-v6mr21023898ljc.97.1548752666742;
 Tue, 29 Jan 2019 01:04:26 -0800 (PST)
MIME-Version: 1.0
References: <20190126163220.26421-1-jonas@norrbonn.se> <20190126163220.26421-2-jonas@norrbonn.se>
 <20190128181038.GF11699@sirena.org.uk> <1b9807aa-3e6e-16f2-a2c2-ebe5e186d904@norrbonn.se>
In-Reply-To: <1b9807aa-3e6e-16f2-a2c2-ebe5e186d904@norrbonn.se>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Tue, 29 Jan 2019 17:04:15 +0800
Message-ID: <CAMz4kuK9HAmntmqG-_s6re854tK7UL6wwCh0Lm8=bzpFZsseaw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] spi: support inter-word delay requirement for devices
To:     Jonas Bonn <jonas@norrbonn.se>
Cc:     Mark Brown <broonie@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lanqing Liu <lanqing.liu@spreadtrum.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonas,
On Tue, 29 Jan 2019 at 05:28, Jonas Bonn <jonas@norrbonn.se> wrote:
>
> Hi,
>
> On 28/01/2019 19:10, Mark Brown wrote:
> > On Sat, Jan 26, 2019 at 05:32:19PM +0100, Jonas Bonn wrote:
> >
> >> @@ -164,6 +166,7 @@ struct spi_device {
> >>      char                    modalias[SPI_NAME_SIZE];
> >>      const char              *driver_override;
> >>      int                     cs_gpio;        /* chip select gpio */
> >> +    uint16_t                word_delay;     /* inter-word delay (us) */
> >
> > This needs some code in the core joining it up with the per-transfer
> > word delay similar to what we have for speed_hz and bits_per_word in
> > __spi_validate().  Then the controller drivers can just look at the
> > per-transfer value and support both without having to duplicate logic.
> >
>
> So spi_transfer already has a field word_delay and it's defined as
> _clock cycles_ to delay between words.  I defined word_delay in
> spi_device as _microseconds_ to delay along the lines of delay_usecs.
>
> Given that the inter-word delay is a function of the slave device speed
> and not of the SPI bus speed, I'm inclined to say that a time-based
> delay is what we want (to be independent of bus speed).  As such, I want
> to know if I should add word_delay_usecs to _both_ spi_transfer and
> spi_device?
>
> There's only one user of word_delay from spi_transfer.  Just looking at
> it quickly, it looks like it wants the word_delay in
> SPI-controller-clock cycles and not SCK cycles which seems pretty broken
> to me.  Adding Baolin and Lanqing to CC: for comment.  Could we rework
> that to be microseconds and do the calculation in the driver?

The Spreadtrum SPI controller's word delay unit is clock cycle of the
SPI clock, since the SPI source clock can be changed, we can not force
user to know the real microseconds. But can we change it to a union
structure? not sure if this is a good way.

union {
     int word_delay_us;
     int word_delay_cycle;
} w;

-- 
Baolin Wang
Best Regards
