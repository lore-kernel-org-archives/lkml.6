Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21BF5C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 21:10:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC0282083D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 21:10:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="i0bUdnPe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC0282083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727945AbeIGBsF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 21:48:05 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:36384 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727657AbeIGBsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 21:48:04 -0400
Received: by mail-ua1-f67.google.com with SMTP id c12-v6so10284662uan.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 14:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=JabmYADXxpzgOgcr0gPpARuVy87Uqs4wKepeh5bnOtM=;
        b=i0bUdnPeveTph0sMMM0jsSMrvgnBv5MhaWWSgWDVgA2e/YAd7Ygcc/qFoudOwefidn
         Ej27Jyt7GUQ77d6DlPxDbA44Mhk6NKNKqV5oyuTOYct9jgJ9HG+lkCgL0U8hAiD2kbhu
         kV3jMXMc0b/Y8jqeW5kQwx02UqGLC0QsgBgaQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=JabmYADXxpzgOgcr0gPpARuVy87Uqs4wKepeh5bnOtM=;
        b=hyTqhbausDezF51EVImwCh3Fq1qSW8aL+g+lQfXHSOJD3ErQgBd46qs1xfrGbyXRar
         3ohS4mskEG6pzl3OAY/ecJGoaXFs8c/sntLp8DYtoF+6xHXwSISLt3WHI0FaBaZFgvYg
         KdyTllgRPCbtHhaCRyoGGYCjfRm5MOKPviXOS3mFaxnOrbUl3D8K8/ycnZvValsMlkCJ
         vGNjqDknRNBcomLxse2OoAMdWEctJRCN5i6HI3DOV98046kbBi8kBKMkzv47C4GGNSoW
         +1s9u9TF2tfTPOOgVfACzTmOq+ML7b+0pV55gGYr/npRMPZROTbYWCVuiE/3fAgLeI0W
         l32Q==
X-Gm-Message-State: APzg51CSdE35OToStEk1I1l6jZlDn6oKPmqEvTDv2PvvJS2V0iLhzQb/
        UyG849cmBMJP2xoZIJegB/E0icKB4ps=
X-Google-Smtp-Source: ANB0VdbKZ8Fnv5UTv9mTUeyrpv6m/jkiEut1sIaS/vLC0dY+IJsQh7qDPjBGFn3chCN2F2JNzoB18w==
X-Received: by 2002:a9f:2f17:: with SMTP id x23-v6mr1810718uaj.54.1536268246540;
        Thu, 06 Sep 2018 14:10:46 -0700 (PDT)
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com. [209.85.221.179])
        by smtp.gmail.com with ESMTPSA id t7-v6sm824228vsj.1.2018.09.06.14.10.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Sep 2018 14:10:45 -0700 (PDT)
Received: by mail-vk1-f179.google.com with SMTP id q184-v6so77417vke.7
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 14:10:45 -0700 (PDT)
X-Received: by 2002:a1f:8c8c:: with SMTP id o134-v6mr1627401vkd.79.1536268244374;
 Thu, 06 Sep 2018 14:10:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1f:5e8e:0:0:0:0:0 with HTTP; Thu, 6 Sep 2018 14:10:43 -0700 (PDT)
In-Reply-To: <20180906210454.247219-4-mka@chromium.org>
References: <20180906210454.247219-1-mka@chromium.org> <20180906210454.247219-4-mka@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 6 Sep 2018 14:10:43 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WLcgKQWAp8HnBFZhZ4+32keMANcYJ+nGquePqsOnjJ7A@mail.gmail.com>
Message-ID: <CAD=FV=WLcgKQWAp8HnBFZhZ4+32keMANcYJ+nGquePqsOnjJ7A@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: pm8998: Add die temperature
 channel node to the ADC
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Sep 6, 2018 at 2:04 PM, Matthias Kaehlcke <mka@chromium.org> wrote:
> Add a channel node for the die temperature to the ADC.
>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>

Double-SoB?

...presumably Andy can remove that when he lands and doesn't need a re-post...

-Doug
