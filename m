Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36EA4C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 05:57:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E940E2081C
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 05:57:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AI6zVRNc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E940E2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727311AbeK1Q51 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 11:57:27 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:44727 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727082AbeK1Q51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 11:57:27 -0500
Received: by mail-ua1-f65.google.com with SMTP id d19so8490854uaq.11
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 21:56:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NSuVpeW/+Encil7p4teReutjaTilfSv2YtW7lzME3V0=;
        b=AI6zVRNc2xOlBW6si3eFlF5NC9HlY/Bngr5b9gA3/rrsS1iW5UEq4PSxTEQRp8DW8X
         w6l06x0hDl6L8KaHTIIfuWb5F6YHujjH/v6pgRm0G+bxEpqddUR1HjtbaG8d4ctelNfi
         BEg404HtTkkQItkru4lB4byJaD18vsuTIPlkc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NSuVpeW/+Encil7p4teReutjaTilfSv2YtW7lzME3V0=;
        b=eyC0KTltkkrk1n6LBA5B5quBl0XxGxoJG42aIOffTF0hEpUil7hxrGyz3KKZI8u5UW
         E28NMdqlCP6CtU0bafUOarET06WXmLjgbn+K41LKcMFyprjGK//0/XPodOTZ4Ux92SeF
         WMJxzKV58+GX62XKediEKkja17urVhHR2dpBP+WbgjoVQ40XruCdaC3iP/Jw0ycKrmej
         /LfGMLBkiZJ2PT6yOs+lBq4rgssL1nPvZIAiGIzCoRUYnX+1ulLxCFn7qBEQSZz50FsI
         7oXUhwqvIHzvhxth2avMdKFmhi5nke5dUGlj/z6d9OW/O+Zomu7cEy5nDeX4fl8r9/mQ
         7Vig==
X-Gm-Message-State: AA+aEWYA0hGZa5NrLt1JGeHgwcWYc1Q9BESh/7VNRrabosP73oao4v8L
        OPM1e+EU26HZ856Q4smeYJl2nNrF3Ys=
X-Google-Smtp-Source: AFSGD/XZ5BreVWpHNRcYNX0GTYpxRxpTZcVByFOJeHjVwiGr7r9VtDSFoG3hqC8fqLNQkhaQuRt8uw==
X-Received: by 2002:ab0:48ad:: with SMTP id x42mr14398794uac.59.1543384619486;
        Tue, 27 Nov 2018 21:56:59 -0800 (PST)
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com. [209.85.221.174])
        by smtp.gmail.com with ESMTPSA id f71sm1915330vke.41.2018.11.27.21.56.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Nov 2018 21:56:59 -0800 (PST)
Received: by mail-vk1-f174.google.com with SMTP id v70so5655659vkv.7
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 21:56:58 -0800 (PST)
X-Received: by 2002:a1f:ab17:: with SMTP id u23mr14223663vke.73.1543384618504;
 Tue, 27 Nov 2018 21:56:58 -0800 (PST)
MIME-Version: 1.0
References: <20181126231159.122298-1-mka@chromium.org> <20181126231159.122298-3-mka@chromium.org>
In-Reply-To: <20181126231159.122298-3-mka@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 27 Nov 2018 21:56:46 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WNHUL+W1ozoRaCCd=-OcAD3QmqZaNLK0PNJQVbDqdaLQ@mail.gmail.com>
Message-ID: <CAD=FV=WNHUL+W1ozoRaCCd=-OcAD3QmqZaNLK0PNJQVbDqdaLQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] drm/msm/dsi: 14nm PHY: Get ref clock from the DT
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

On Mon, Nov 26, 2018 at 3:12 PM Matthias Kaehlcke <mka@chromium.org> wrote:
>
> Get the ref clock of the PHY from the device tree instead of
> hardcoding its name and rate.

In the case of the 14nm PHY I think it's OK that you break
compatibility with old device tree files (as this patch does) since
the 14nm support was added sorta recently and "git grep" shows no
users in linuxnext.  You should note that you're breaking
compatibility with old DTS files in the commit message here so that if
someone crawls out of the woodwork it will be easy for them to
understand what happened.


> +       pll_14nm->vco_ref_clk = devm_clk_get(&pdev->dev, "ref");
> +       if (IS_ERR(pll_14nm->vco_ref_clk)) {
> +               ret = PTR_ERR(pll_14nm->vco_ref_clk);
> +               if (ret != EPROBE_DEFER)

Shouldn't this check against -EPROBE_DEFER, not against EPROBE_DEFER?
It's negative.  Presumably this same feedback needs to be applied to
the whole patch series.

Other than that this looks good to me and you can feel free to add my
Reviewed-by tag FWIW.

-Doug
