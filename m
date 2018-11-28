Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2D5EC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 06:11:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2CBF2086B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 06:11:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mEVEmUrP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2CBF2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727329AbeK1RLm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 12:11:42 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:46400 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727082AbeK1RLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 12:11:42 -0500
Received: by mail-ua1-f67.google.com with SMTP id v24so8496109uap.13
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 22:11:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=95/j4OaP+7oLfip7mT7xIJREPajjcQ3AuDdxuZHfAGQ=;
        b=mEVEmUrPhbcRQ0uChz3gwEXAcgrVoIU9LBpeFJB5D1ZFqD0YB/vmbGnfMywOC6rJUW
         WLE7hOex1yfgJuwn8OooIin3X5UPt8BDudEYrxGKSeVZZobOpsOxTIgc9PeupdcjMdKv
         o9pCHldRppUpfogMehwXzWzUeet0eBbQ3uAW0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=95/j4OaP+7oLfip7mT7xIJREPajjcQ3AuDdxuZHfAGQ=;
        b=FWfDpbsxD3hfEtsYKW9X8hkEAlyl4tscGJQnFMYSnc8bUmC0TyCo9LY/mXHhfCkBcL
         h7cUMrjCNLL8hcIRlBd7M6ilbraOZBEMRkpBFaIYsozINzT9l+qLV+44gTjnYpfn5EUa
         VCB+p8UfeUorKKcA0svguAxNLPxduPGtEpCST3GmklE3jxsSsr26+JHkYRfSjd8gb1+5
         2j5aBePfHifYaNpIbaQ95SNhfqLG4vR3MJ8/dc/foSDTLbH3VeHu2Cc79dsKLpNc0qDE
         xmiWB6TO3tGiHPdW+zNT9CKBvLC2xSlteRA9qP6HIG/JIqErKDJTTk2Squr5KSI42wh9
         ABKQ==
X-Gm-Message-State: AA+aEWb0Kwsv2p4OX8FGgIReVtI1QznDZvUhXkknNyk4vhSVZG7xeEEB
        SPTZPbwgDIRiVT0VlBduXTT0HzHaobg=
X-Google-Smtp-Source: AFSGD/Vkbd5q+J+8ByCGlk7cXdp4gMcWefGB8zuclcEF50/AcAEPsxbzMJK8rYT5Px69RkeHy9OaZg==
X-Received: by 2002:a9f:2709:: with SMTP id a9mr14820339uaa.10.1543385472819;
        Tue, 27 Nov 2018 22:11:12 -0800 (PST)
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com. [209.85.221.172])
        by smtp.gmail.com with ESMTPSA id k20sm1567948uaq.2.2018.11.27.22.11.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Nov 2018 22:11:11 -0800 (PST)
Received: by mail-vk1-f172.google.com with SMTP id t127so5653683vke.8
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 22:11:11 -0800 (PST)
X-Received: by 2002:a1f:1881:: with SMTP id 123mr4137813vky.40.1543385470608;
 Tue, 27 Nov 2018 22:11:10 -0800 (PST)
MIME-Version: 1.0
References: <20181126231159.122298-1-mka@chromium.org> <20181126231159.122298-5-mka@chromium.org>
In-Reply-To: <20181126231159.122298-5-mka@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 27 Nov 2018 22:10:58 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XWaQqhzwBp0YAavnD-2kL+QFO7_wZBxp+2KjN7HNEfMQ@mail.gmail.com>
Message-ID: <CAD=FV=XWaQqhzwBp0YAavnD-2kL+QFO7_wZBxp+2KjN7HNEfMQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] arm64: dts: qcom: msm8916: Set 'xo_board' as ref
 clock of the DSI PHY
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
> Add 'xo_board' as ref clock for the DSI PHYs, it was previously
> hardcoded in the PLL 'driver' for the 28nm PHY.

Note: presumably your series should have one more patch to fix
"arch/arm/boot/dts/qcom-apq8064.dtsi" too?


> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
> Changes in v2:
> - patch added to the series
> ---
>  arch/arm64/boot/dts/qcom/msm8916.dtsi | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

This looks right to me.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
