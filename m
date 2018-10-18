Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E3C5C67863
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 23:52:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1523A208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 23:52:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ps50zUIE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1523A208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727445AbeJSHzv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 03:55:51 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:36661 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726454AbeJSHzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 03:55:50 -0400
Received: by mail-vs1-f65.google.com with SMTP id c205so24235083vsd.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 16:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F0/Gpd7Z8wxWOaQYaJLB4H7s3hOZQlg8jciCad48Fx0=;
        b=Ps50zUIERVcSMJj2QCobH4c9z14sjUX1QJYAmmGMxkTqiATV0Ftu6GbcXON35luk7A
         x1N5AzgDKsyd/u8gZ0/ULArqP361QWcfX6VjaBTqAyIMK30wCafDBBB4JeQOaxdJ43vv
         NC62K4cDu7BPNIocNrL4OsdcGqV14WPaN97yo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F0/Gpd7Z8wxWOaQYaJLB4H7s3hOZQlg8jciCad48Fx0=;
        b=Sgm3iaTgGTLu+cwrqJx8a/gfOINsOv0JL31Grif5fSsxMWVFaTNYAMeChc3glrdOkz
         HENoHyMIX/8k5UOXwT7N17XVp6hkihhg+kpKzVjVnssyth9mVm/TF0Yy8lw2ExdXwiU+
         Jgqpkmz/WtfeipnGMibmjhxUGlZElw4x0ZseTMYOdZYQxs1hiGWB/2DqAkBLDJ3Ti5G2
         Im5xIg/Kq6xEGPKZWMNHlXS88O3GGH1L30Zv9KaHD3s1JBv6FM9S4gMBkOyJDA+83iWX
         GK4E3ByZaHA4hco7fPJPpOqe2Ele0cvid0oE3+QpuSh8c5qF7rZ5g5jBG2x+DlxBM1FS
         gVpw==
X-Gm-Message-State: ABuFfoi6mrFQz5sGzOlOYSVDyfTCtithAQ0rPKTSOHCyWmlyaix3TN0T
        VvBX+jA5o7FtyQ+CzaJgrQqz+s3NV0s=
X-Google-Smtp-Source: ACcGV60auriBm54Kb+xGj67MmvzPqv6ivLyMAcJG1PyJOCpoF8rxW/yau31jDfvIhZNfnZKarQQTNQ==
X-Received: by 2002:a67:de0d:: with SMTP id q13mr13143611vsk.127.1539906747852;
        Thu, 18 Oct 2018 16:52:27 -0700 (PDT)
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com. [209.85.222.49])
        by smtp.gmail.com with ESMTPSA id w189-v6sm4446211vka.24.2018.10.18.16.52.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Oct 2018 16:52:26 -0700 (PDT)
Received: by mail-ua1-f49.google.com with SMTP id o17so4092801uad.8
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 16:52:26 -0700 (PDT)
X-Received: by 2002:a9f:344d:: with SMTP id s13mr13951192uab.27.1539906746319;
 Thu, 18 Oct 2018 16:52:26 -0700 (PDT)
MIME-Version: 1.0
References: <20181018210933.113592-1-evgreen@chromium.org> <20181018210933.113592-4-evgreen@chromium.org>
In-Reply-To: <20181018210933.113592-4-evgreen@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 18 Oct 2018 16:52:12 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VFRxsa5CeUcKSx-Ar4sGDWCUkO1cQgHtfHjHCnfwpHTA@mail.gmail.com>
Message-ID: <CAD=FV=VFRxsa5CeUcKSx-Ar4sGDWCUkO1cQgHtfHjHCnfwpHTA@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] arm64: dts: qcom: sdm845: add UFS controller
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
On Thu, Oct 18, 2018 at 2:10 PM Evan Green <evgreen@chromium.org> wrote:
>
> This change adds the UFS controller and PHY to SDM845.
>
> Signed-off-by: Evan Green <evgreen@chromium.org>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 67 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 67 insertions(+)

I'm already in the Signed-off-by since I did some touching of this
patch, so not sure it makes sense to provide my Reviewed-by on this
patch.  ...but I'll at least make the note that it seems good and
matches my understanding


As mentioned in patch #2 ideally this patch should land after the
driver fix so the old driver doesn't try to use the "tx2" range as
"pcs_misc".

-Doug
