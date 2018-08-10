Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5AB0C46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 21:52:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5104C21E26
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 21:52:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ubs31n9i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5104C21E26
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbeHKAXx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 20:23:53 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33800 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726747AbeHKAXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 20:23:53 -0400
Received: by mail-pf1-f194.google.com with SMTP id k19-v6so5118731pfi.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 14:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VWReRIpm5PIS76GdbrvLCyYzLptqe2h88ASeo/3oSk8=;
        b=Ubs31n9iQATVkC+wtG44BKB0kryKMyyTHPmasQS3kzOszD7xGBMaqqKP9KYqTrHzkh
         qB3hpBsFk+ruWfjodLsfPwe0u9q4gavNfQSfkyrsd8kJupYvbHo+oSa6LIASuakkQBIk
         66BZ/LWYZJ9Fh737PtzGgE/Iv47cmVSVEgPp4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VWReRIpm5PIS76GdbrvLCyYzLptqe2h88ASeo/3oSk8=;
        b=J+GNNWMq6k9ilcNolQ2CAGgNFgk5zbeSSlfnWYOcF5Dlt02hNP2gTfV3E9aZ5wgcWG
         Ez7mH+2UF7qwZ9Qq5wpWZcfTUcSE49qFO/5RjI8a1S6KmN6cICAHasNPibmt7FIOyjgZ
         Hjidx++La9SZKf2o0rjyggCPWDhf55WzNsdohkFCVeotk134if+cr6MlpSNQuv/XeLAp
         8yUzx38Rn7icSzk57vlqcxiErKAymjei4+cACes03/lSHCtTH/Df8XJIhMnNL95jh3SF
         qJTYev2ii67RigAi9VJC0BDu63W5+9E/m/riHvhfVGhTgtoJa6sdz3FkuhTCuC5Z7+vu
         7gUA==
X-Gm-Message-State: AOUpUlHFxGPEbik+XQB5h93LKalwZ4Q5TSiuPUdUJxI1KN9+5fI1tLOI
        G6DgHWAHPfxzYrTh5t9Zu2WGhw==
X-Google-Smtp-Source: AA+uWPyg+/sVtbe0RyTBjL3PLw0C9FeZjZFQiFs0boyyaZ6MwMzFj9kL8pA+OpEl9ydJw113rKsD+w==
X-Received: by 2002:a63:3c0c:: with SMTP id j12-v6mr7903938pga.440.1533937932038;
        Fri, 10 Aug 2018 14:52:12 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:c8e0:70d7:4be7:a36])
        by smtp.gmail.com with ESMTPSA id g11-v6sm25730102pgi.90.2018.08.10.14.52.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 14:52:11 -0700 (PDT)
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
Date:   Fri, 10 Aug 2018 14:51:47 -0700
Message-Id: <20180810215150.82490-1-dianders@chromium.org>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This series adds device tree nodes for the RPMh regulators and USB.
These patches are based on patches in various downstream kernels from
Manu Gautam, David Collins, and Vivek Gautam.

This series was tested on SDM845-MTP (with no-AC firmware) atop Andy
Gross's current "for-next" branch at commit 76b9e7f947f1 ("Merge tag
'qcom-defconfig-for-4.19' into all-for-4.19") with some extra patches:

From mainline:
- 87ed1405ef09 ("nvmem: Don't let a NULL cell_id for nvmem_cell_get() crash us")

From clk-next:
- 9c7e47025a6b ("clk: qcom: clk-rpmh: Add QCOM RPMh clock driver")

From regulator/for-next:
- 46fc033eba42 ("regulator: add QCOM RPMh regulator driver")
- 0db021f7a273 ("regulator: dt-bindings: add QCOM RPMh regulator bindings")

From Will Deacon's tree (for-joerg/arm-smmu/updates):
- d1e20222d537 ("iommu/arm-smmu: Error out only if not enough context interrupts")

From the mailing list (needs to be spun but works OK):
- dts: arm64/sdm845: Add node for arm,mmu-500
  https://lore.kernel.org/patchwork/patch/964814/

As you can see from the above all the dependencies except the addition
of the MMU node have landed so this series should be about ready to
land too.

If anyone would like to see the tree I used for test, it can be found
at:
  https://chromium.googlesource.com/chromiumos/third_party/kernel/+log/refs/sandbox/dianders/180810-agross-usbv2


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

 arch/arm64/boot/dts/qcom/sdm845-mtp.dts | 506 ++++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/sdm845.dtsi    | 196 +++++++++
 2 files changed, 702 insertions(+)

-- 
2.18.0.597.ga71716f1ad-goog

