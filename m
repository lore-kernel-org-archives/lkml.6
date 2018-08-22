Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DC40C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 17:36:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC97E20658
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 17:36:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jsLBC5Ol"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC97E20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727535AbeHVVCl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 17:02:41 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37900 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727367AbeHVVCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 17:02:41 -0400
Received: by mail-pg1-f193.google.com with SMTP id k8-v6so1239842pgq.5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 10:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+spugPRqgpfhmjZxEKOGl/jjF0mkLd8S1ZBGUnl6B4A=;
        b=jsLBC5Ol6mrqEIT7XinUIxQ2dtRUrW12By0qeRk2S8nUQVMXWqGIrn8QB+tRpcIJN2
         /rRCUXJUBCGJDjiL/1pG3bDNwg1LW3d0PEU2/8OleIYhN1VJ+N/YXqWyTqzTzK86Z7Lz
         IXaUX1Z3WVSkO+U2RKZeBDx1SIcP3+IL8Z65s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+spugPRqgpfhmjZxEKOGl/jjF0mkLd8S1ZBGUnl6B4A=;
        b=Jtkth/ALyniwjRSdisiudeCYiJZsSJ/HMGJ3IBLvnpzGbCjnhvlFV/k6YP2v3kQbLr
         As8hWVEDdQSA3OdR+7ZG6qdYH3VQz/se1igWVi6HBs+pyNrDovK48KySfjqc4nK0nlaw
         ffxOfKjYHeJcaNb2rN+EWq6yti8yiKQBYM7N62Zs1tj+FFrpWKcM3xBX5NPxRd/SMIXW
         cQAKS1kAJn9FwRwQG8oQKWbRWlEFSOJdvYQgNE631fTvRZTgApjyQSHdEetcZda4VhTa
         Pxr1otNj/LC82E3HFXRiGJplgQTBrD75dRXh2mAven1AcNYKNo1aS3s7kAUsaTzKEQ/v
         yfRg==
X-Gm-Message-State: AOUpUlGxnRabEdCbs828YI2zvJ+UkX86u6QJ8Pze/P/saF+4PwXHAFK7
        cXwe+ZX9onfBM+oM4jMGpoBL/sExsIQ=
X-Google-Smtp-Source: AA+uWPyPPRzBlbQ0AaNF8o5Z7P7cwZm+xbvv8Qu0S/LWAXLQ6J1TfGK4Rx3jX36kLhLsn6mexxk73A==
X-Received: by 2002:a62:68c3:: with SMTP id d186-v6mr58738159pfc.70.1534959413067;
        Wed, 22 Aug 2018 10:36:53 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:c8e0:70d7:4be7:a36])
        by smtp.gmail.com with ESMTPSA id s73-v6sm3378439pfi.154.2018.08.22.10.36.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Aug 2018 10:36:52 -0700 (PDT)
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
        Mark Rutland <mark.rutland@arm.com>, linux-soc@vger.kernel.org
Subject: [PATCH v3 0/3] arm64: dts: sdm845: Add RPMh-regulators and usb
Date:   Wed, 22 Aug 2018 10:36:26 -0700
Message-Id: <20180822173629.202885-1-dianders@chromium.org>
X-Mailer: git-send-email 2.18.0.1017.ga543ac7ca45-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds device tree nodes for the RPMh regulators and USB.
These patches are based on patches in various downstream kernels from
Manu Gautam, David Collins, and Vivek Gautam.

This series was tested on SDM845-MTP (with no-AC firmware) atop
linuxnext (next-20180822) with some extra patches:

From the mailing list:
- dts: arm64/sdm845: Add node for arm,mmu-500
  https://lkml.kernel.org/r/20180814102740.30222-3-vivek.gautam@codeaurora.org

Changes in v3:
- Don't just fix qfprom unit address, fix the reg too (Stephen).
- Rebased to next-20180822
- Set vin-supply for s4a_1p8 properly (Stephen).
- All regulators now HPM / disallow mode change; see commit text.
- Added a few extra labels for some regulators.
- Updated commit text descriptions.

Changes in v2:
- Use "0x784000" for qfprom rather than "0x780000" as per docs.
- Add calibration for 2nd USB port too
- LDO14 initial mode is LPM and shouldn't be always on (Vivek G)
- LDO25 should have min voltage of 3.3V

Douglas Anderson (2):
  arm64: dts: qcom: sdm845-mtp: Add RPMh VRM/XOB regulators
  arm64: dts: qcom: sdm845-mtp: Add nodes for USB

Manu Gautam (1):
  arm64: dts: qcom: sdm845: Add USB-related nodes

 arch/arm64/boot/dts/qcom/sdm845-mtp.dts | 382 ++++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/sdm845.dtsi    | 196 ++++++++++++
 2 files changed, 578 insertions(+)

-- 
2.18.0.1017.ga543ac7ca45-goog

