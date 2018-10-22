Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89540C67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 18:35:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E32E20652
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 18:35:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OObyGNem"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E32E20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729006AbeJWCyw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 22:54:52 -0400
Received: from mail-lj1-f180.google.com ([209.85.208.180]:35123 "EHLO
        mail-lj1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728782AbeJWCyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 22:54:51 -0400
Received: by mail-lj1-f180.google.com with SMTP id o14-v6so37966233ljj.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Oct 2018 11:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S48vqaaCSun0FgBFKajQE4jXmLIFB5l3GFVoJ8/2+D4=;
        b=OObyGNemhv19iNyFhO2sfmhfvC1wKnN95M76CghMD4jz3B9dKGnjadEfniebsJ8hO/
         55ffmg67pVACFTswdb3xm/kOn7j2B1Ky7x7ktgBEvL9nrVdqw0AcPOW4necibgMqNkXU
         rA+yRHJHUuPuKtFxF4jbxyzJG/Nbi3QnOLlJ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S48vqaaCSun0FgBFKajQE4jXmLIFB5l3GFVoJ8/2+D4=;
        b=uKXw8/RE8JOmb3OiKTm0x8VCF/AA9Sh6DAWvx3jq9PDn7OtvzbtSIDxVESUg4NWT4k
         VoJiwMhXgyXfmjoq9x1C/mbjXuia+1VEnIQUGga0Z/C3wVRu05pcbFI5PVFBeyqTB/wM
         p75Y1dXqsPZmaZGwdbeeozCi5g00UNtZkjwebf+Y0pORKPKVQ5fD38i0kSPL90TWEq8m
         r3DGC9LeKABYyj+nncFMA0EROPaLNkY2Pd/kFoh6wP8mH4Zb4uu57FEiYGAUAPTusg16
         y23dKvOS9IcHOeFm3EH2Hc8nrCBQJxvarJxZLEG1BjOCXZGsvzDq6/lf6Cqjt+eS5xcn
         Cggg==
X-Gm-Message-State: ABuFfoi/xuBDV4A/KJ01FvSJfYsJKJ7mj1TV0SVaq9Ag3x4LmNrQTChw
        VJXfFc7DYBiYFiNUkWWgeyi9UmwSAwM=
X-Google-Smtp-Source: ACcGV61+WYuobpEGUXbEnwY0j+E4WJEYTc6hMWBGEt+XEyPbVkBFERQOXk2keD5ZrOxJLRhFI+chLw==
X-Received: by 2002:a2e:8514:: with SMTP id j20-v6mr32341292lji.111.1540233311966;
        Mon, 22 Oct 2018 11:35:11 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id n16-v6sm6980682lji.28.2018.10.22.11.35.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Oct 2018 11:35:10 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id x24-v6so15455386lfe.5
        for <linux-kernel@vger.kernel.org>; Mon, 22 Oct 2018 11:35:09 -0700 (PDT)
X-Received: by 2002:a19:1cc3:: with SMTP id c186-v6mr9591468lfc.16.1540233308973;
 Mon, 22 Oct 2018 11:35:08 -0700 (PDT)
MIME-Version: 1.0
References: <1539622953-4188-1-git-send-email-rplsssn@codeaurora.org>
In-Reply-To: <1539622953-4188-1-git-send-email-rplsssn@codeaurora.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Mon, 22 Oct 2018 11:34:32 -0700
X-Gmail-Original-Message-ID: <CAE=gft7piWBN+2Ud-rzCaL_v9dfpqAo7pdazBmrvxBQf-U-M-w@mail.gmail.com>
Message-ID: <CAE=gft7piWBN+2Ud-rzCaL_v9dfpqAo7pdazBmrvxBQf-U-M-w@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: sdm845: Add PSCI cpuidle low power states
To:     rplsssn@codeaurora.org
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, sboyd@kernel.org,
        Doug Anderson <dianders@chromium.org>, mka@chromium.org,
        Lina Iyer <ilina@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 15, 2018 at 10:02 AM Raju P.L.S.S.S.N
<rplsssn@codeaurora.org> wrote:
>
> Add device bindings for cpuidle states for cpu devices.
>
> Cc: <devicetree@vger.kernel.org>
> Signed-off-by: Raju P.L.S.S.S.N <rplsssn@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 62 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 62 insertions(+)
>

Reviewed-by: Evan Green <evgreen@chromium.org>
