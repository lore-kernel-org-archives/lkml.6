Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 857E7C4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 09:53:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36585204EC
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 09:53:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="SycIiAHv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36585204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbeILO5I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 10:57:08 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:44674 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726985AbeILO5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 10:57:08 -0400
Received: by mail-ed1-f65.google.com with SMTP id s10-v6so1233204edb.11
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 02:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=qpuhBgJaCiXWaajWhjpFTri3LV8sQfdxUNkXmVCKgpI=;
        b=SycIiAHv1BmYgatd/r4voSBECjv1IBxAcmMFNWaNuhCC+5YIdgP/I+2Zpsm4nTgs2h
         k+Mnw967dkineftr9due377JFCignP9N7HkKwaZsL98BO9IBbdQ4tN+nozmaTXxviewO
         1iWmtI90D7lXOY3gI1e4RJu9y7hkXnU3hiLOg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=qpuhBgJaCiXWaajWhjpFTri3LV8sQfdxUNkXmVCKgpI=;
        b=nYezJRs9n2ip977lsNYKEQHSIqR3B0XhxoVLvJv9bc7v5Wp5uKHjveJjUdFSLCLMXd
         lcnesh91y9ajGiCXCXxLxdF0ezVVGPPACIuyOiOi/ZTdEgjfbFRJF3H1pYyQ+u18QW+v
         StQmqCS69JYMcpnq6JyEigbFgh0lyAkYc+jvXxgtXt0x+3l2Wp5Tx6fPGSSC/1PpaLV2
         9E2RPGitzlk6HQ++Jro9Lr9h6oPiINEF+kCqoTOdffieecaw+9m7dN+tM4L09cguC9AE
         vyUmYcqjSoUODAWTa4iCWeQvjy6eH+alPmLrQpAR8c4QoUhFvoKW7+9nOnb+3T5aza+1
         YANg==
X-Gm-Message-State: APzg51A4Jchz8FC/8E4uZUzW1gHTZg+INA/s6m8hwTjv7rvfA343DUe7
        61FyZ0OenXYIRu65JkoEt/9c49nx1LY=
X-Google-Smtp-Source: ANB0VdaQ9N+fdS0G/woILBORb5M5pVrFkBSos/Dt8sBuK8VpAORALjw9vxX7VVwp/L+ej2Ks53BQiA==
X-Received: by 2002:a50:8dcb:: with SMTP id s11-v6mr26632edh.86.1536746000279;
        Wed, 12 Sep 2018 02:53:20 -0700 (PDT)
Received: from localhost ([49.248.190.214])
        by smtp.gmail.com with ESMTPSA id e15-v6sm474292edb.60.2018.09.12.02.53.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Sep 2018 02:53:18 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     rnayak@codeaurora.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        smohanad@codeaurora.org, andy.gross@linaro.org,
        dianders@chromium.org, mka@chromium.org,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-soc@vger.kernel.org
Subject: [PATCH v3 00/16] Another round of tsens cleanups
Date:   Wed, 12 Sep 2018 15:22:45 +0530
Message-Id: <cover.1536744310.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is another series of tsens cleanups before we add interrupt support. This applies on top of 4.19-rc2.

Patches [1-6] can directly be applied by Eduardo.
Patches [9-16] can directly be applied by Andy.
Patches [7-8] introduce a new check and needs review and can then be
applied completely separately by Eduardo. 

There is a *dependency* however. Patch 1 should be applied to the tree
before the DT changes in patches 9 and 10.

In this series, I've collected all outstanding tsens patches by combining
the patches from the v2 posting with 3 DT patches for sdm845 thermal zones
and msm8916 camera and gpu thermal zones. Details are as follows:

- splitup 8916 and 8974 register address spaces for SROT and TM
- cleanups: move to spdx, dead code removal, removal of id field
- Add support to map the SROT address space for DTs that list it separately
- Check if TSENS IP is enabled in firmware by querying the SROT space
- Add myself as maintainer of tsens
- Add one-off patches adding sdm845 thermal zones and msm8916 gpu and
  camera thermal zones to this series.

Changes since v2:
- Split up changes to code and dt and within dt, split into arm and arm64
  patches
- Rearrange the sequence of patches so that the thermal maintainer can pick
  up the first part and the platform maintainer can pick up the latter part
  of the series
- Drop patch 09/11 because it causes some issues on systems with
  non-contiguous enabled sensors e.g. db410c
- Drop patch 10/11 because reg-name property isn't encouraged
- Fix a bug on msm8916 to check if IP is enabled in firmware. This was due
  to the register being at a different offset on msm8916. Fixed by coding
  this information as private data.

Changes since v1:
- Split up changes that split the address space and added qcom,sensors
  property into two separate patches
- Remove brackets in typo correction patch

Amit Kucheria (16):
  thermal: tsens: Prepare 8916 and 8974 tsens to use SROT and TM address
    space
  thermal: tsens: Add SPDX license identifiers
  thermal: tsens: Get rid of dead code
  thermal: tsens: Rename map field in order to add a second address map
  thermal: tsens: Add the SROT address map
  MAINTAINERS: Add entry for Qualcomm TSENS thermal drivers
  thermal: tsens: Pass register offsets as private data
  thermal: tsens: Check if the IP is correctly enabled by firmware
  arm: dts: msm8974: thermal: split address space into two
  arm64: dts: msm8916: thermal: split address space into two
  arm: dts: msm8974: thermal: Add "qcom,sensors" property
  arm64: dts: msm8916: thermal: Add "qcom,sensors" property
  dt-bindings: thermal: Fix a typo in documentation
  arm64: dts: msm8916: Add gpu thermal zone
  arm64: dts: msm8916: Add camera thermal zone
  arm64: dts: sdm845: enable tsens thermal zones

 .../devicetree/bindings/thermal/thermal.txt   |   2 +-
 MAINTAINERS                                   |   7 +
 arch/arm/boot/dts/qcom-msm8974.dtsi           |   6 +-
 arch/arm64/boot/dts/qcom/msm8916.dtsi         |  47 ++++-
 arch/arm64/boot/dts/qcom/sdm845.dtsi          | 170 ++++++++++++++++++
 drivers/thermal/qcom/tsens-8916.c             |  12 +-
 drivers/thermal/qcom/tsens-8960.c             |  41 ++---
 drivers/thermal/qcom/tsens-8974.c             |  12 +-
 drivers/thermal/qcom/tsens-common.c           |  62 ++++---
 drivers/thermal/qcom/tsens-v2.c               |   8 +-
 drivers/thermal/qcom/tsens.c                  |  19 +-
 drivers/thermal/qcom/tsens.h                  |  23 +--
 12 files changed, 309 insertions(+), 100 deletions(-)

-- 
2.17.1

