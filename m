Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EB40C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 20:27:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3943720852
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 20:27:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iwMxYEc0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3943720852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731122AbeGYVkQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 17:40:16 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:45248 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730520AbeGYVkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 17:40:16 -0400
Received: by mail-lf1-f65.google.com with SMTP id j143-v6so6305887lfj.12
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 13:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=75YQRk6vcCLpvtCq/6FeIHRLGNVumWQexVkdw3cOu/k=;
        b=iwMxYEc0C9lSBRr0Qcjh5QW5gusYu0lQh3kA88sA+SVW35FWgotjjBQRj+cKzRhYyC
         SGfuD7Psl4sVH+EFMH3foCtk/RB3IkfQuxlBNO9uWirBtzwfXjf0iDIbl/leqzCodPVT
         9xA1dXfzSFvPh0LAVyv7eE2V4+6sktsjedipc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=75YQRk6vcCLpvtCq/6FeIHRLGNVumWQexVkdw3cOu/k=;
        b=DJacOmX6gdJMuwOFtpFKjGVbGpBYY0vSXytpgGitu8rDkwKYoOT6x7gSj1vS3/cMnX
         FQ2p2FsVZNcLCrTW14fRnbetE25iTVtsQW32doHMDa33OdkKz+JvydhJJtg000cAy+3G
         zQlqkRWrMukaibmOWijJ5b+PeWdZ27TvAnWoYL1VozArK6V4gk0JXj9Jrxr1n5+VV18I
         dBtsd5ltjhxGDLpBxS/3cQsoTklicxZEYvl8oJXU7w70rjYciWLP1ZSuq81Hq20aemQI
         bGn07hNW0rKJk/7RUpN5+XL7xLNw1tX/zd/10Xmj8osVgs/W3p6hHtbF8LVribzE1jqc
         yvrg==
X-Gm-Message-State: AOUpUlFO0/E7lolu4rNb6Q077nzEHqJt0x2AMERZNwryCs7fIcR1g0XV
        IFFhXDe/zjyXvRAVSDYny8gXAaD0F4U=
X-Google-Smtp-Source: AAOMgpc30pVQX+myBRPvFpB+MvIdfJyy368EUHdZId3qZ71h9Hr/5NKMFMnerR4lcw+fmJPwFgchNg==
X-Received: by 2002:a19:a685:: with SMTP id p127-v6mr14424642lfe.4.1532550417305;
        Wed, 25 Jul 2018 13:26:57 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id f3-v6sm2345861lfc.30.2018.07.25.13.26.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Jul 2018 13:26:55 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id f135-v6so4608891lfg.10
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 13:26:55 -0700 (PDT)
X-Received: by 2002:a19:f70d:: with SMTP id z13-v6mr13410732lfe.33.1532550415054;
 Wed, 25 Jul 2018 13:26:55 -0700 (PDT)
MIME-Version: 1.0
References: <20180619083647.10116-1-cang@codeaurora.org> <20180619083647.10116-2-cang@codeaurora.org>
 <CAFp+6iHxu2GYAn8ftDuHfE1Hj=aQvd6Rum9zjEe-G1WHsAkZuw@mail.gmail.com>
In-Reply-To: <CAFp+6iHxu2GYAn8ftDuHfE1Hj=aQvd6Rum9zjEe-G1WHsAkZuw@mail.gmail.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Wed, 25 Jul 2018 13:26:18 -0700
X-Gmail-Original-Message-ID: <CAE=gft5m_upt4hhPf3ZbCm99usoaW_OXibxM2XzFEgvwLmjnKQ@mail.gmail.com>
Message-ID: <CAE=gft5m_upt4hhPf3ZbCm99usoaW_OXibxM2XzFEgvwLmjnKQ@mail.gmail.com>
Subject: Re: [PATCH v7 1/4] phy: Update PHY power control sequence
To:     vivek.gautam@codeaurora.org
Cc:     cang@codeaurora.org, subhashj@codeaurora.org,
        asutoshd@codeaurora.org, Manu Gautam <mgautam@codeaurora.org>,
        kishon@ti.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 2, 2018 at 10:00 AM Vivek Gautam
<vivek.gautam@codeaurora.org> wrote:
>
> On Tue, Jun 19, 2018 at 2:06 PM, Can Guo <cang@codeaurora.org> wrote:
> > All PHYs should be powered on before register configuration starts. And
> > only PCIe PHYs need an extra power control before deasserts reset state.
> >
> > Signed-off-by: Can Guo <cang@codeaurora.org>
> > ---
> >  drivers/phy/qualcomm/phy-qcom-qmp.c | 19 ++++++++++++-------
> >  1 file changed, 12 insertions(+), 7 deletions(-)
> >

Reviewed-by: Evan Green <evgreen@chromium.org>
