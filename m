Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB904C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 21:54:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B104720989
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 21:54:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="YvwW0EAz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B104720989
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389932AbeKVIaT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 03:30:19 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:34943 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389918AbeKVIaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 03:30:18 -0500
Received: by mail-ot1-f68.google.com with SMTP id 81so6355281otj.2;
        Wed, 21 Nov 2018 13:54:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1eeKDWvqEXgxNxauuoVjDt70U4UcxevhZeNHNGyqj/E=;
        b=YvwW0EAzXa/Bqab2rnUPt7AQ8ny8Bznz/dN1ljz3+fBD4SYIehZjL1f5lIDPcEu9V2
         llNeQOFpl1t8v9oj8ELyWjoI35dgKoahRmedB7XUbpH5DJXY/rXGbkcsKvEfDqPW+E6k
         BEaumCHFUgDY05SihQh8J1Ve4F8JbZi8mwJz9GTeJ1e53H6G/Yz1vGJYi8A01wGL1QIT
         U/A8l6o4uq4KAcNUXiuMY7Mvw6/+9FJvY66WfCvSoRYap27Rojr6bex0s5aXGa4xILSG
         +fq9ERncQJ4uD+d3fbFr8JlsoYm/qkznrNlgcIC0OA+rDCOuhPXFfKXn53iFWwIiwNNK
         I/PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1eeKDWvqEXgxNxauuoVjDt70U4UcxevhZeNHNGyqj/E=;
        b=CVIrromvaHpn3XouBmtVWp5EOy1HjF042s3EqnpNHwbUdBbxSU4vZj0SjESf0CfaYP
         xIqlayB3Vc7fdU15D2jSEzLHA953oguR+srVN6b1RjIB02sb6yRTlO9ROZBHqyM8d6Eo
         SiQ7Z8NdjbsJAlLwnjWRQhSGW+oJpyZ5X7Hfp6JFkO0jEAxYzkR2wyHLSTbIv85umbnq
         01uQdHx+bhr36RvDpV/ODeKdn+1cE81jF37Se5atOeyajywnRLN5UV9wB9ur3mrO+jkf
         yIxst2N6Nfg2gU+JuhAX26f+2+P8N0hPbSelD+P9dndQ75YGy3SU3AtjvD3WIS3NG6oB
         sUTw==
X-Gm-Message-State: AA+aEWZl4FPjPx17LttJvZvpwdHhKdj/hLiWwjNfCJPlYtwAA0C2uekY
        O3+JccYLC4RdqfgpKcxPKgaat+AMkB499RhU/Dg=
X-Google-Smtp-Source: AFSGD/UBuoeOkTRwG4BEAPzt/Nm4AUVCTQXGYQhW92pdx+wynk1WbmupT3Mks3+jVOsk42r0VwjKsndFvYe1x/7F8IQ=
X-Received: by 2002:a9d:3408:: with SMTP id v8mr5116851otb.237.1542837248414;
 Wed, 21 Nov 2018 13:54:08 -0800 (PST)
MIME-Version: 1.0
References: <20181121111922.1277-1-narmstrong@baylibre.com>
In-Reply-To: <20181121111922.1277-1-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Wed, 21 Nov 2018 22:53:57 +0100
Message-ID: <CAFBinCDkXYH9bCf_aaVptqcgZabreuZxLoAW3-o2qBHgcbm8Xw@mail.gmail.com>
Subject: Re: [PATCH] clk: meson: Fix GXL HDMI PLL fractional bits width
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     jbrunet@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

On Wed, Nov 21, 2018 at 12:19 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> The GXL Documentation specifies 12 bits for the Fractional bit field,
> bit the last bits have a different purpose that we cannot handle right
> now, so update the bitwidth to have correct fractional calculations.
I assume you have more accurate documentation than what's available publicly:
- the S805 datasheet doesn't have any documentation for this register at all
- the S905 datasheet states that HHI_HDMI_PLL_CNTL2[11:0] are DIV_FRAC
- the S905X and S912 datasheets state that SDMNC_POWER is at
HHI_HDMI_PLL_CNTL2[6:0], SDMNC_ULMS is at HHI_HDMI_PLL_CNTL2[9:7] and
SSC_DEP_SEL is at HHI_HDMI_PLL_CNTL2[13:10]
- the S905X and S912 datasheets state that HHI_HDMI_PLL_CNTL1[11:0] are DIV_FRAC

can you confirm that the public S905X and S912 documentation is wrong
and that the .frac field is really part of HHI_HDMI_PLL_CNTL2 instead
of HHI_HDMI_PLL_CNTL1?


Regards
Martin
