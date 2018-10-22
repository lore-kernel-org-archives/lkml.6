Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68A1DC67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 22:09:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7672920651
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 22:09:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eZtL7Ajy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7672920651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729428AbeJWG3h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 02:29:37 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:43203 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbeJWG3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 02:29:37 -0400
Received: by mail-vs1-f66.google.com with SMTP id w85so30666841vsa.10
        for <linux-kernel@vger.kernel.org>; Mon, 22 Oct 2018 15:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H0B1suPAYipa56gyXudKt1BPw3ylxRynKX8wFG2urfw=;
        b=eZtL7AjyV+BOOH1LVEYBRwZueOlYSruEmr7pfrgnpn8Q/Qwsd4zt0uFkDtqdbRqv7s
         c7X+c4aCF0y2001Y3PnUSF21pdjMxeIne7TggsgY6C5UgZj+iv5LuYCcDd8OIO7z7HMo
         zkvqsMUIxQ0yL9xhZs3hgUJu8aJWDe0ontPZo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H0B1suPAYipa56gyXudKt1BPw3ylxRynKX8wFG2urfw=;
        b=Pq0dduI+9QY+XHmXvoykPurECEC1nw2TAbrKdW99By0YJ+/kjWPYeA/ODDqePIuWgM
         T9cKdGCq6TK/wx1E5Q6GqSWjIrtdMAHX49yAyB/whtqsOcUDBqbYNIvhJc1jBqHPASGF
         l6LDxK6NSkawp9DSK47/PyamlJKJWcp9yWqehiSc7EPMMwQh0tE8tsVXk/yecbLMHasv
         l62DTbjhHd/AaTtqqYqfc8jASHtbJaWAdQpdfLxdxRK+XCX+JjrmQD5qcKE8yAxKkka6
         QVItZ6K8KxrtvfKGTC6NJjv/j29S4cwfzy2Rkctq+ouocfTR2W1F+zEoo4PFQZEQUnUm
         3jXg==
X-Gm-Message-State: ABuFfojThOs/vpitIxWWlNfrUci5jOgcg21BFrl0dXYtFAxWHSo0Kanx
        TIZsTIHdJcjNXNprilLJBU2yOjZxV3U=
X-Google-Smtp-Source: AJdET5cl45xz1PHxUCYFw0qZ4UtOu7yCQ0755RSdwEWiDSPAGY+AIz9BbE++l5PAJWA36tHe9VHLVw==
X-Received: by 2002:a67:1c8:: with SMTP id r69mr1803461vsf.48.1540246153626;
        Mon, 22 Oct 2018 15:09:13 -0700 (PDT)
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com. [209.85.221.181])
        by smtp.gmail.com with ESMTPSA id l200sm7708038vkl.40.2018.10.22.15.09.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Oct 2018 15:09:12 -0700 (PDT)
Received: by mail-vk1-f181.google.com with SMTP id b65-v6so10191499vkf.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Oct 2018 15:09:12 -0700 (PDT)
X-Received: by 2002:a1f:850a:: with SMTP id h10-v6mr7955358vkd.4.1540246151968;
 Mon, 22 Oct 2018 15:09:11 -0700 (PDT)
MIME-Version: 1.0
References: <20181022205102.74825-1-evgreen@chromium.org> <20181022205102.74825-6-evgreen@chromium.org>
In-Reply-To: <20181022205102.74825-6-evgreen@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 22 Oct 2018 15:09:00 -0700
X-Gmail-Original-Message-ID: <CAD=FV=W4mfsB35XSnhL=p-K4vNVQBwpuq_3mULc3MKta-wwv4Q@mail.gmail.com>
Message-ID: <CAD=FV=W4mfsB35XSnhL=p-K4vNVQBwpuq_3mULc3MKta-wwv4Q@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] arm64: dts: qcom: sdm845: Add USB PHY lane two
To:     Evan Green <evgreen@chromium.org>
Cc:     Rob Herring <robh@kernel.org>, Andy Gross <andy.gross@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Stephen Boyd <swboyd@chromium.org>, devicetree@vger.kernel.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On Mon, Oct 22, 2018 at 1:52 PM Evan Green <evgreen@chromium.org> wrote:
>
> Add the second lane registers for the USB PHY, now that the
> QMP phy bindings have been updated. This way the driver can stop
> reaching beyond its register region to get at the second lane.
>
> Signed-off-by: Evan Green <evgreen@chromium.org>
> ---
>
> Changes in v3:
>  - Removed erroneous fixup for USB UniPro PHY, which is not dual lane (Doug)
>
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Super.  Thanks for doing this.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
