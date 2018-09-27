Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B079C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 15:37:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07D09216FA
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 15:37:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="EbUTSBxp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07D09216FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728080AbeI0Vzw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 17:55:52 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42781 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727426AbeI0Vzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 17:55:52 -0400
Received: by mail-wr1-f68.google.com with SMTP id b11-v6so3108101wru.9
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 08:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=XpfyjubRxpOYF9FoHU3Q/FOSQSTcdzPQQk+DYSE2m9A=;
        b=EbUTSBxplPAQOoBLzAeb3XjdHKzRiGUCaGnJTsn4GLxmoWB9SNRk0CgJ3NkVyJkY+i
         hYuYkAx+2gOteJVWfX/0rWWo/iqGIyeukE02Yr4YwlrAI2KCRk+k1C1vdtI28CeL7POs
         bdGZ/UtCEZ42Aza8m2CwyjGKK+Ajv/nAfo+Aw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=XpfyjubRxpOYF9FoHU3Q/FOSQSTcdzPQQk+DYSE2m9A=;
        b=DLQxDTk+ehLh36mfv80spqkPb0+Wno/10c6llWl3A+xw7qpuqbUtFJnyngKcVshzYa
         aUH9L/LYdzdgWTYy7JZJ/ty6sBu5Jl32ye+8G6swrPNZ8D4yPPefbz5+GYRxv3mj3mbk
         RhI7M95wUXR8y7BGfEP3PAnRhCO20nuVQ8MaZGeluGwDR1HS4AJNQjkiK6XhGuwqrCbV
         wFLQ2198yvQSJ0gMowyU/7d8Hv8C7S78nDk+DiEW+pZvCkx0sTOm3UJqdJ91zxHKkawk
         hARc8EYBCK3Tsgfa5Fqq0PtDKCTjmTIQDWZ7H7MoX0ogiUTnJY1XoP/jBB+pLew+pdG3
         3JKg==
X-Gm-Message-State: ABuFfoh1g+6ATrZugcPSo8N+IfRwnq5iObxJab44zfkEJWZGOhy6lwZ3
        1FvIxDNItxdRVQqNpUM92egtgIxaIcM=
X-Google-Smtp-Source: ACcGV619qe2zeF3UT0MRIYSI54vHbysplzTD8m2RwMU8C+KEueUrib/G09FtQ2vr+k6Qm130IcR32w==
X-Received: by 2002:adf:f802:: with SMTP id s2-v6mr5530747wrp.172.1538062621959;
        Thu, 27 Sep 2018 08:37:01 -0700 (PDT)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id p11-v6sm2520033wrd.74.2018.09.27.08.36.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 27 Sep 2018 08:37:00 -0700 (PDT)
From:   Srinath Mannam <srinath.mannam@broadcom.com>
To:     daniel.lezcano@linaro.org, Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [PATCH v4 0/3] Stingray thermal driver support
Date:   Thu, 27 Sep 2018 21:06:40 +0530
Message-Id: <1538062603-7490-1-git-send-email-srinath.mannam@broadcom.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches adds the stingray thermal driver and its
corresponding DT nodes with documentation.

Changes from v3
  - Addressed Daniel lezcano comments.
  - Elaborated commit description of thermal driver patch.
  - Added brcm,max-crit-temp DT parameter.

Changes from v2:
  - All stingray TMON DT nodes are combine together into single.
    Temperature registers are combined into one mem resource.
    brcm,tmon-mask parameter has available TMONs mask value.
  - All available TMONs are initialized together in single
    instance of driver probe call.

Changes from v1:
  - Fixed auto build sparce warning.

Pramod Kumar (3):
  dt-bindings: thermal: Add binding document for SR thermal
  arm64: dts: stingray: Add Stingray Thermal DT support.
  thermal: broadcom: Add Stingray thermal driver

 .../bindings/thermal/brcm,sr-thermal.txt           |  25 +++
 .../arm64/boot/dts/broadcom/stingray/stingray.dtsi |  14 ++
 drivers/thermal/Kconfig                            |   3 +-
 drivers/thermal/broadcom/Kconfig                   |   9 +
 drivers/thermal/broadcom/Makefile                  |   1 +
 drivers/thermal/broadcom/sr-thermal.c              | 203 +++++++++++++++++++++
 6 files changed, 254 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/thermal/brcm,sr-thermal.txt
 create mode 100644 drivers/thermal/broadcom/sr-thermal.c

-- 
2.7.4

