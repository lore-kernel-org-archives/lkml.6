Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6215CC67863
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 23:50:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 256222087A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 23:50:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bG5ftTXG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 256222087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727241AbeJSHyM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 03:54:12 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:37260 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726977AbeJSHyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 03:54:12 -0400
Received: by mail-ua1-f68.google.com with SMTP id y5so6837085uap.4
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 16:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ej9GWqztV4YayoN6VfUnAmxlWRuyAiHJeA0+pwOYNYU=;
        b=bG5ftTXG4ijWNxqwbSXHnlnpj+3ZO7020fB/ntdHvEBhluG4i7XjzCRZXI33E7hEqm
         rFwU6IfEUtFDtqwBPtyig3cSzPr5fMzESUwATvJzEedoJ2o523IqE+dQzRa7dutAoGqg
         zfpUGnvqVYH6xIaDoRXaFQx5ikPvuQA0I4SpE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ej9GWqztV4YayoN6VfUnAmxlWRuyAiHJeA0+pwOYNYU=;
        b=gl+6m4O0Y2FublnpS1T2Y4f/mbw+fdK+6NxVcqyhkq/FjfecR6A2byLz2Oga8EBA5p
         hbd8S0mus0GkTYfQTEGl1iGMe3uGkPQy+0IGmGc7rAuJJ1Y0i4Wkkm/KQE5iyi+PIYIp
         zPdl0JfjAsNNbcyiH6PYTiFl1Zd9EwvBsHl+0ScAqLRuoa0VptFPjQ2/ZTzckUhQoqs/
         P/dOUqnZ7iI1EbOYHyGUapFuQzkqCWlE8YS6X4FSrZWusDHsS/ak+D2+GDmj8iAfP65z
         C8/Ps8pqoGLQMuxY41ragcNfHljPr9xOv3Pmhce71kedcQaYB86RNrB/Peqpk7tYpeSF
         c7bQ==
X-Gm-Message-State: ABuFfohQuIpkvGG1aX4H2QGa1uhtZPq3uBxvxqFBSIdEOStHXDAvcURn
        rJFUKxrcbriSNrfz3Bt2uhqyJjafrKc=
X-Google-Smtp-Source: ACcGV63APn/WuuDTHyj7jnFiEjNXDZ6jnVrqJ9bLqvuOzkAyuuhNhiYJHOovajFr0RJNwMAUp+azkw==
X-Received: by 2002:ab0:4e8b:: with SMTP id l11mr14882097uah.93.1539906649656;
        Thu, 18 Oct 2018 16:50:49 -0700 (PDT)
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com. [209.85.222.54])
        by smtp.gmail.com with ESMTPSA id c25sm3844287uan.13.2018.10.18.16.50.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Oct 2018 16:50:48 -0700 (PDT)
Received: by mail-ua1-f54.google.com with SMTP id c21so6835132uap.7
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 16:50:47 -0700 (PDT)
X-Received: by 2002:ab0:7291:: with SMTP id w17mr14823974uao.115.1539906647519;
 Thu, 18 Oct 2018 16:50:47 -0700 (PDT)
MIME-Version: 1.0
References: <20181018210933.113592-1-evgreen@chromium.org> <20181018210933.113592-2-evgreen@chromium.org>
In-Reply-To: <20181018210933.113592-2-evgreen@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 18 Oct 2018 16:50:34 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XM9uG8EfamXmEp2-g5tgagir0KHpdMZMtL6ckqt+Jjsg@mail.gmail.com>
Message-ID: <CAD=FV=XM9uG8EfamXmEp2-g5tgagir0KHpdMZMtL6ckqt+Jjsg@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] dt-bindings: phy-qcom-qmp: Fix register underspecification
To:     Evan Green <evgreen@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Manu Gautam <mgautam@codeaurora.org>, cang@codeaurora.org,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Oct 18, 2018 at 2:09 PM Evan Green <evgreen@chromium.org> wrote:
>
> This change adds register regions for the second lane of dual-lane nodes.
> This additional specification is needed so that the driver can stop
> reaching beyond the tx and rx register allocations to get at the
> second lane registers in a dual-lane PHY.
>
> While in there, document #clock-cells as optional for PHYs that don't
> provide a pipe clock. Also, document the pcs_misc register region, which
> was being quietly supplied and used.
>
> Signed-off-by: Evan Green <evgreen@chromium.org>
>
> ---
> This applies atop linux-next 20181018 with the addition of Doug's
> changes [1] and [2].
>
> [1] https://lore.kernel.org/lkml/20181012213632.252346-1-dianders@chromium.org/
> [2] https://lore.kernel.org/lkml/20181012213926.253765-1-dianders@chromium.org/
>
>  .../devicetree/bindings/phy/qcom-qmp-phy.txt       | 73 +++++++++++++++++++---
>  1 file changed, 65 insertions(+), 8 deletions(-)

This all makes sense to me and seems like the right compromise to make

The only current SoC that uses tx2/rx2 is SDM845 and the support of
that SoC is in its infancy in mainline.  Thus I don't mind that we say
that all 5 registers are "required" even though there is an existing
device tree out there that don't include tx2/rx2 for USB.  Currently
patch #2 in this series still makes old device trees "work" (as well
as they used to) but I'm all for that being very temporary code and
that officially tx2/rx2 are not optional.


Reviewed-by: Douglas Anderson <dianders@chromium.org>
