Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9271BC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 17:38:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44FC020658
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 17:38:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aHc7G1x+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44FC020658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbeHVVDq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 17:03:46 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:40656 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727544AbeHVVDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 17:03:46 -0400
Received: by mail-ua1-f65.google.com with SMTP id 101-v6so744905uav.7
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 10:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=7a7adOt7OKdV6OIE0hiKqsuO+up88Xzip+Pa7TGZQpY=;
        b=aHc7G1x+JRGvWIBw6G6GfuBkNBEloMz5VrJe1yRxMeVkV88ahRhRYkVywUjUlZofZo
         +ZJyVATREURfp3DmB6hPVzQsMLBJ+I20bAgbC3CTMZsnICXUvBV6v8/fKA9TuKLJkTcY
         CF38SgqbpeEgGnEcUjum70Hrck9VXNZzg8hOA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=7a7adOt7OKdV6OIE0hiKqsuO+up88Xzip+Pa7TGZQpY=;
        b=Z3FSQLgrXggoHj8Gjm6AgZVR3IQ9EMQbSBYRVkaIGi3YI0t+hniTAA9wfmv9lxMugQ
         YN5QXYEs0BLstlKxBeyt5D12xBmT2fEeUFw2DoNDTsidxbQ/IuvE58LGoVYEUsDF9kMJ
         saxOWBT2RUT0xoNdd9keaL/KtKSOUcxeJ7RKbBMGkapdhucmAfCDtLLtZL5PqTclEAcx
         LvJKKk70hDhfcc9GEIg5ZDpk5UxHEbkpxoYQ02CBdJgR+33gw4Il702Ak5ur8ypQGw57
         qXdoeS4dC55DWHgkYOv5ki1GhRev2pQvBixpna5jwoAMDVIU2HJ6vhvkZwj6KaXz9biy
         wOJQ==
X-Gm-Message-State: AOUpUlHVQac5T2MKzTP8cdYGcacWFqZskuM02UvlAhmxT4UMQOUoVB/+
        tAxk7xOx20rukjMclp0nAdQxabkIMvk=
X-Google-Smtp-Source: AA+uWPwRxXzFTpOi4KydfdqLvu48ApLu3AP18G9TExQ5dL9H+DpBpyQWmXw0tLjYSZM9Pd8rzOH5jw==
X-Received: by 2002:ab0:52a4:: with SMTP id v33-v6mr36955327uav.32.1534959477083;
        Wed, 22 Aug 2018 10:37:57 -0700 (PDT)
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com. [209.85.222.43])
        by smtp.gmail.com with ESMTPSA id z18-v6sm299340uao.16.2018.08.22.10.37.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Aug 2018 10:37:56 -0700 (PDT)
Received: by mail-ua1-f43.google.com with SMTP id g18-v6so1558114uam.6
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 10:37:55 -0700 (PDT)
X-Received: by 2002:a9f:2f17:: with SMTP id x23-v6mr20270442uaj.54.1534959475157;
 Wed, 22 Aug 2018 10:37:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1f:1f05:0:0:0:0:0 with HTTP; Wed, 22 Aug 2018 10:37:54
 -0700 (PDT)
In-Reply-To: <153478902525.28926.6688429060107225232@swboyd.mtv.corp.google.com>
References: <20180810215150.82490-1-dianders@chromium.org> <20180810215150.82490-2-dianders@chromium.org>
 <153478902525.28926.6688429060107225232@swboyd.mtv.corp.google.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 22 Aug 2018 10:37:54 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V=Me8g1MN1ZnV2JzHuLLppGr1JwnXZBBPDY1iHVivFFw@mail.gmail.com>
Message-ID: <CAD=FV=V=Me8g1MN1ZnV2JzHuLLppGr1JwnXZBBPDY1iHVivFFw@mail.gmail.com>
Subject: Re: [PATCH 1/3] arm64: dts: qcom: sdm845: Add USB-related nodes
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Manu Gautam <mgautam@codeaurora.org>,
        David Collins <collinsd@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        devicetree@vger.kernel.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Aug 20, 2018 at 11:17 AM, Stephen Boyd <swboyd@chromium.org> wrote:
>> +               qfprom@784000 {
>
> This doesn't match reg property.
>
>> +                       compatible = "qcom,qfprom";
>> +                       reg = <0x780000 0x8ff>;
>
> Because this should be 0x784000?

Thank you for catching.  This ought to be fixed in v3.

-Doug
