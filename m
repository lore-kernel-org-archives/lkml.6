Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54A0FC43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 20:18:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 067FF25A34
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 20:18:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dpBrWXQs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 067FF25A34
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966612AbeF0US0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 16:18:26 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:41359 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966599AbeF0USW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 16:18:22 -0400
Received: by mail-oi0-f66.google.com with SMTP id 21-v6so3048151oip.8
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 13:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UTa6HX9kIK75kCfyP2Gxa5+rFcPVC1Ujypn9LTdscNI=;
        b=dpBrWXQsy6WEcjKNGGY7Yx00iH3aO4dDptAv1zjikEqHNY/iNj4Tpf54sCluXMuFsW
         rV1+JZXrqyojgbZNWqdbS2d9o7dWqTFWGOdKEBJlbbnNXD2LR7hUM9GtMOR25yiY5Kup
         7dSnwK08nNsfGdxpfCHOjsDQCFY2yi8mJiT0o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UTa6HX9kIK75kCfyP2Gxa5+rFcPVC1Ujypn9LTdscNI=;
        b=ocy7BaRwnMGU7yaJLCpjgTGiM1hcKp2Ms/IDgBY/qriNeDUJ3qsanBT8cLlMsy9xda
         Yu8Vpj267dgXQJvhT4LUhha3h6COgSTSvUK6HgkATiPUeDcWuIi4u+Gcx+GeL5t3yO8W
         HqfFjIpoSfFZFFllsXl+nXzhmVxJMr2JZSScjhj/xNIWRwACb1+If+vw9bjeKOp9tyrw
         RF/bSgfvO3JVDy9NmKyK+IXgqKiTOZ9llPRzVtfMfvUpPdesAP2oYY4ZKlUnQl4gSGGM
         HGwIWF3lVbO4XCxRNnop81zr2unpw0qoSvipEwrT/bcA0U0b6joY0NgG72+9wUeGL416
         cQXA==
X-Gm-Message-State: APt69E1g2qG3eRck9TqFurXj0CH15PWVAUGoU/NzRVRzmiOfobIIPDBY
        0hNzJxrcQdeUwJLrxb0Sp+C80Lp0Pcw=
X-Google-Smtp-Source: AAOMgpeDSTplqDzrnJZpuVcpifp5DK1zqQVnUfYUlR7faCW6RatqZWozjQqZtiEP18cEKnDgn4IXuQ==
X-Received: by 2002:aca:2808:: with SMTP id 8-v6mr4354995oix.235.1530130701642;
        Wed, 27 Jun 2018 13:18:21 -0700 (PDT)
Received: from mail-oi0-f51.google.com (mail-oi0-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id a52-v6sm4232056ote.30.2018.06.27.13.18.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 13:18:20 -0700 (PDT)
Received: by mail-oi0-f51.google.com with SMTP id e8-v6so3055110oii.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 13:18:19 -0700 (PDT)
X-Received: by 2002:aca:4343:: with SMTP id q64-v6mr4295083oia.140.1530130698730;
 Wed, 27 Jun 2018 13:18:18 -0700 (PDT)
MIME-Version: 1.0
References: <20180619083647.10116-1-cang@codeaurora.org> <20180619083647.10116-3-cang@codeaurora.org>
In-Reply-To: <20180619083647.10116-3-cang@codeaurora.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Wed, 27 Jun 2018 13:17:42 -0700
X-Gmail-Original-Message-ID: <CAE=gft64dGEMi5QTCzKp7Eg9T=QDL3SbohiAuZBFJkeiOZK3og@mail.gmail.com>
Message-ID: <CAE=gft64dGEMi5QTCzKp7Eg9T=QDL3SbohiAuZBFJkeiOZK3og@mail.gmail.com>
Subject: Re: [PATCH v7 2/4] phy: General struct and field cleanup
To:     cang@codeaurora.org
Cc:     subhashj@codeaurora.org, asutoshd@codeaurora.org,
        vivek.gautam@codeaurora.org, Manu Gautam <mgautam@codeaurora.org>,
        kishon@ti.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 1:38 AM Can Guo <cang@codeaurora.org> wrote:
>
> Move MSM8996 specific PHY vreg list struct name to a genernal one as it is
> used by all PHYs. Add a specific field to handle dual lane situation.
>
> Signed-off-by: Can Guo <cang@codeaurora.org>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp.c | 25 ++++++++++++++-----------
>  1 file changed, 14 insertions(+), 11 deletions(-)
>

I'm not a PHY expert, so I can't say much about the mechanics or
ramifications of the is_dual_lane_phy change is, but for at least the
sanity of the patch, here's my tag:
Reviewed-by: Evan Green <evgreen@chromium.org>
