Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70954C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 22:04:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C47A20A8B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 22:04:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BGzDiQCK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C47A20A8B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732307AbeGJWE6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 18:04:58 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:32917 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732258AbeGJWE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 18:04:58 -0400
Received: by mail-pl0-f66.google.com with SMTP id 6-v6so8206013plb.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 15:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=2DYFEOzC+t+Y8HFTiL8CTaXGHGz/bJuzcROI7j8hGiI=;
        b=BGzDiQCKLj7w5vH27s0a6qCrryto4pSvZuYErEDJnu11vu8DSXDsB+jpnP+v7ArcTw
         Gv5lZD0QaCd7OAdjEh+KYnB+zcBdK7Jbl7N+x1dXfPUILvIxg47OFfY9doI5ys1mIecr
         +usXnXqlIXfTPnd2fJXCtQWK7NOV0rSvcLzZg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2DYFEOzC+t+Y8HFTiL8CTaXGHGz/bJuzcROI7j8hGiI=;
        b=K2ClBE5UP/Vv1R8Jw6pezgZhgkEDMQRHrAxml/6nNrFxo01xdtKHM/UWz4iNzGGuH4
         X6saryLlWTUTaqJ/Xy/dqCN+1sOjA9YcnwiRFFxRgrTcrb5b51snDzs9wi7BJ+H1M3Ii
         OdziRFbII0xGLH/wABpx0PZd3nhuZLBdYXuV1ypWXMQLxWTH4t34bYtvDZUhN6iswBor
         fMwrXgEw8KdK+nSwbiMv3B7WTnnNdjY7zK023153tYNNy0fD383htISLfIInHfCJxUxY
         YlVgvHfACBhIeib2YdnAbs3NBw+6pjOXGlF7Q30QhORMmRTNs2cMk8JzEJZR9F6Y0HQd
         S2qQ==
X-Gm-Message-State: APt69E3fKNF04NqxKeHTodjA7hVTO/GNeYY4b3g1Bprd3KPj2XkMOT1r
        bg1j6LZrXQkHHfruhiRGPv0fXQ==
X-Google-Smtp-Source: AAOMgpdI0k4jPStMBEapHUWZzAICZqabvrxk3TsrZoaTyITsMkPMvVYf1SVwztsMPd/cmoF+PeSimw==
X-Received: by 2002:a17:902:599b:: with SMTP id p27-v6mr25972329pli.191.1531260233392;
        Tue, 10 Jul 2018 15:03:53 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:0:1000:1501:38e4:86fe:ec0c:4007])
        by smtp.gmail.com with ESMTPSA id y69-v6sm34939756pfd.36.2018.07.10.15.03.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jul 2018 15:03:52 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Andy Gross <andy.gross@linaro.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>, swboyd@chromium.org,
        tfiga@chromium.org, Manu Gautam <mgautam@codeaurora.org>,
        David Collins <collinsd@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>, linux-soc@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/3] arm64: dts: sdm845: Add RPMh-regulators and usb
Date:   Tue, 10 Jul 2018 15:01:59 -0700
Message-Id: <20180710220202.116404-1-dianders@chromium.org>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This series adds device tree nodes for the RPMh regulators and USB.  These
patches are based on patches in various downstream kernels from Manu Gautam
and David Collins.

This series was tested on SDM845-MTP (with no-AC firmware) atop Andy Gross's
current "for-next" branch with some patches picked from list:

1. clk: qcom: clk-rpmh: Add QCOM RPMh clock driver
   https://patchwork.kernel.org/patch/10388151/
2. regulator: add QCOM RPMh regulator driver
   https://patchwork.kernel.org/patch/10483369/
3. nvmem: Don't let a NULL cell_id for nvmem_cell_get() crash us
   https://patchwork.kernel.org/patch/10401993/

I also needed a few patches that haven't yet posted to-list to keep things
from crashing at boot (these patches weren't needed when using Coreboot as
the BIOS):

1. arm64: dts: sdm845: Enable smmu support
   https://chromium.googlesource.com/chromiumos/third_party/kernel/+/8046f638b4
2. HACK: iommu/arm-smmu: make a mismatch in CBs and CB interrupts non-fatal
   https://chromium.googlesource.com/chromiumos/third_party/kernel/+/8c0b634f48

Given the above caveats these three patches are probably not quite ready for
landing, but I wanted to at least get them out there to start the review
process.


Douglas Anderson (2):
  arm64: dts: qcom: sdm845-mtp: Add RPMh VRM/XOB regulators
  arm64: dts: qcom: sdm845-mtp: Add nodes for USB

Manu Gautam (1):
  arm64: dts: qcom: sdm845: Add USB-related nodes

 arch/arm64/boot/dts/qcom/sdm845-mtp.dts | 507 ++++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/sdm845.dtsi    | 189 +++++++++
 2 files changed, 696 insertions(+)

-- 
2.18.0.203.gfac676dfb9-goog

