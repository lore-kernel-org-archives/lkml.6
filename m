Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4479EC46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 12:55:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F355421C39
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 12:55:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="VyASsVwR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F355421C39
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731991AbeHIPUB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 11:20:01 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:35954 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730634AbeHIPUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 11:20:01 -0400
Received: by mail-qk0-f194.google.com with SMTP id x192-v6so3918727qkb.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 05:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=tkVrjUmMoiGeKVTEPUTHKCb21cGNq6uRRAMlOCuo20I=;
        b=VyASsVwRR1/e4QpKinUrGOKRtwCmGMGgBXn2Ea/dRgi0QuHn5H1eitqxZTYSyso6he
         XP3pAOtlhOTg/WFcSa46KV+71C/KpTcHrhf/S5jYXUOrcEqRKcyHd5H8rypMNK/w2fPV
         dqEbBjNLlt0/g0cbXL/MxKvmfPJUt9bXlWNAI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tkVrjUmMoiGeKVTEPUTHKCb21cGNq6uRRAMlOCuo20I=;
        b=FbgZZfykv8rWF3aXXv/BDFEcst8mynby9bQX/JqFNtqqETvH3okR9SBjuQZqSlhVb3
         JK3ixLB/L2ERpqpVQa4LYTYBTNZIuHmV06o3El3zNoekKLiCbVUa8WFy2KkyS3C1FCxy
         RDHfvDlljqCqdP6qwXh8oFCiU4Sjbf2E4X5kfgOZmRA4oVO2L8guq9fSLd7gem82xVwq
         QwuDxfwgudn08SJj0WcbcBKROpHmvMo6zxuyX0yfe0NZJjT0lsgtjlbriWv69adNsdNh
         ZPoJ/Wl/m/gomoMWmrO9VUg23QSST8uKM5m1lBigKa56WBblEzX971Tg+VNusnKnJpuy
         9mxA==
X-Gm-Message-State: AOUpUlHeVZUfuoPc05+y58RNjxg2jkAp17St3UTvYYOwbrfkeseWtYQF
        xRZvQuDN3P9PTI6DBwV2WQLKGQ==
X-Google-Smtp-Source: AA+uWPwYHkWXLt1n4f7Vk4lUsMkOTg2C/ZQ0gs1aWOs0+aouSRsWOdtDwzQAlqraOCWmsnTLElcq4A==
X-Received: by 2002:a37:8044:: with SMTP id b65-v6mr1626098qkd.347.1533819313591;
        Thu, 09 Aug 2018 05:55:13 -0700 (PDT)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id q51-v6sm4933654qta.92.2018.08.09.05.55.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 09 Aug 2018 05:55:12 -0700 (PDT)
From:   Srinath Mannam <srinath.mannam@broadcom.com>
To:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [PATCH v3 0/3] Stingray thermal driver support
Date:   Thu,  9 Aug 2018 18:24:56 +0530
Message-Id: <1533819299-3401-1-git-send-email-srinath.mannam@broadcom.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches adds the stingray thermal driver and its
corresponding DT nodes with documentation.

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

 .../bindings/thermal/brcm,sr-thermal.txt           |  23 +++
 .../arm64/boot/dts/broadcom/stingray/stingray.dtsi |  13 ++
 drivers/thermal/Kconfig                            |   3 +-
 drivers/thermal/broadcom/Kconfig                   |   9 +
 drivers/thermal/broadcom/Makefile                  |   1 +
 drivers/thermal/broadcom/sr-thermal.c              | 216 +++++++++++++++++++++
 6 files changed, 264 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/thermal/brcm,sr-thermal.txt
 create mode 100644 drivers/thermal/broadcom/sr-thermal.c

-- 
2.7.4

