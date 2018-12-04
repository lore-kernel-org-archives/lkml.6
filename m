Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7C81C04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 17:21:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AB7F206B7
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 17:21:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="W81J9Q8e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AB7F206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727219AbeLDRVS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 12:21:18 -0500
Received: from mail-vk1-f193.google.com ([209.85.221.193]:45474 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727158AbeLDRVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 12:21:16 -0500
Received: by mail-vk1-f193.google.com with SMTP id n126so3957148vke.12
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 09:21:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SQYkJflw6ZG3qbcZAPQ+3KILhFUJGYVNsDVNeEvwkfM=;
        b=W81J9Q8eLfRiVjfZq3obFwjB0W6RsOZLBr8+gBslpOO+O7ihowslvpAw/7NV/nrhuZ
         RpBVS3/BcMdw0XUXBWLtJZx0BjWyKB0X8F4UpQ5v59/IePVRhWM8AU0hr/P8hLLTEKV5
         gsT5ZVcF0Udn6/XCxr3GjfwqXXM/Rq7dvFvzA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SQYkJflw6ZG3qbcZAPQ+3KILhFUJGYVNsDVNeEvwkfM=;
        b=beapShzMEeAvpMOioDcHfNbVV8UsvTD971IhUFL6ncwC7op4rfDFSg2JeKy+Llagqu
         7Xl0UxlA3a8SI1M37y7EsC9IEHAMnSreFWdeYcH05QB1yY6KejJGZqiCvIKlWf+5Os+J
         DG5EQ8w7/IPaXr9MIrsTlnbG/t1gWU7L/B4S3/siuPL+sI/kHrfoavka0VOxB2yj39re
         7NdJ4081kPlduzh/anBDUoCxT23IeNowlv7ql+5nBCq6DAaV9Aq1cad0d/zLso6hUKQu
         pODRk2KPIhf1CyotyM543+7DEoVNIDA651XJU23l3PfwZBpEB60gRm/M2DUjk5pfFNQm
         FG6Q==
X-Gm-Message-State: AA+aEWYMWLOzFKEWRKbOH6kq0b0HE718GVKM4bC4GxO9s9+IRXI2wPm4
        SD3z5V0jqvnLPRbbIf03RY/+R/sn9Vk=
X-Google-Smtp-Source: AFSGD/XVPxs+jgtiOzfUXKfSI1vvO2wyaVgsHQf77+Wiyf1Sb/bBuzarA0LGSZyiIg70vb5vhD9NzA==
X-Received: by 2002:a1f:6b14:: with SMTP id g20mr9096438vkc.47.1543944075211;
        Tue, 04 Dec 2018 09:21:15 -0800 (PST)
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com. [209.85.217.45])
        by smtp.gmail.com with ESMTPSA id l123sm4994536vsd.26.2018.12.04.09.21.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 09:21:15 -0800 (PST)
Received: by mail-vs1-f45.google.com with SMTP id n10so1462332vso.13
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 09:21:14 -0800 (PST)
X-Received: by 2002:a67:1505:: with SMTP id 5mr8214331vsv.20.1543943738499;
 Tue, 04 Dec 2018 09:15:38 -0800 (PST)
MIME-Version: 1.0
References: <20181201005254.139908-1-mka@chromium.org> <20181201005254.139908-2-mka@chromium.org>
In-Reply-To: <20181201005254.139908-2-mka@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 4 Dec 2018 09:15:25 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WPXGAb0jYWvFhuTLOWKjsnDDC972pHN_05sTFgkLW9KA@mail.gmail.com>
Message-ID: <CAD=FV=WPXGAb0jYWvFhuTLOWKjsnDDC972pHN_05sTFgkLW9KA@mail.gmail.com>
Subject: Re: [PATCH v3 1/8] dt-bindings: msm/dsi: Add ref clock for PHYs
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Rob Clark <robdclark@gmail.com>, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Archit Taneja <architt@codeaurora.org>,
        Sean Paul <seanpaul@chromium.org>,
        Rajesh Yadav <ryadav@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Jeykumar Sankaran <jsanka@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Nov 30, 2018 at 4:53 PM Matthias Kaehlcke <mka@chromium.org> wrote:
>
> Allow the PHY drivers to get the ref clock from the DT.
>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
> Changes in V3:
> - added note that the ref clock is only required for new DTS
>   files/entries
>
> Changes in v2:
> - add the ref clock for all PHYs, not only the 10nm one
> - updated commit message
> ---
>  Documentation/devicetree/bindings/display/msm/dsi.txt | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
