Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E54D9C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 06:21:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A819820811
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 06:21:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="KRuGfZZv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A819820811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727190AbeLNGVV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 01:21:21 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34090 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726615AbeLNGVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 01:21:21 -0500
Received: by mail-pf1-f196.google.com with SMTP id h3so2337277pfg.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 22:21:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=jhPuMjuWmZy0Cnza8feEXcHf7PUqiv75e7osHKP1vKE=;
        b=KRuGfZZvjaSJH5dZFYx4KrMDTfkCldom2MtPqxZ+Is5hVpGMFlfEGf/QTQwDiE0Ml0
         wwDlyhhqHkb3PGzU37D0CzzpNri6sz+Mk4fwdQOFoS3s48TSNqfsXJhkTNjPs/xAKd+D
         g8qZWUublVp7sgIp3tt29+iyhWn5Y8q90Vr3l06D9INCfP6hLIn5u+KakBIdZZ+rESnG
         7qFgw0h0oFZu13MZB9YNxBTz/0+G3+y3yihwoFsZ7MBOo0MueCEsib42HEEFFcTCyVOQ
         SaaDiJ4W3kINoqazroiXCXypcae6Sa/eayxxnAkCmVY6jBZqCnQBhibRwGO8BkXZKXqu
         FK7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=jhPuMjuWmZy0Cnza8feEXcHf7PUqiv75e7osHKP1vKE=;
        b=WJxlBxSxV0DYHNF1jqLkRugU0uAGFV1jkq940eB3hRqY4oyaw3lMBpSU1QITdQGr7I
         2fS/v0mMirBN+LEehomgu1DsiYhThzr4qyW7pfSscxXHGJs89Os7PYvLx11AN12+46mK
         k4Fg1NT3J01QOsDVMLiX+bWFUwXbArEy0gTWCJ0F61xSXC820E/857NHanUjgdMV2/1j
         iCd3DwFKJMRteYxGB/25llst634zfpKMYJ7p8PEXPHny/nWl6rvqreZRn1JHuQRjTY8U
         xO//ErsKjKogoDK40g9R7xbw2fP+ZCHj+cre7SXbFP4Zv9AI29sBOGVdoFrn4DglS9m0
         ov3Q==
X-Gm-Message-State: AA+aEWYft/QrdP0ijWb85W9MfBeOa9VBI2tIyj42KdN662FnFVbviuVi
        hIgnHhsKe72iwA9HBBAXo0eybQ==
X-Google-Smtp-Source: AFSGD/XaIFQXj6O2MKM0S1rfoTxMlT1toxiF3wLN8tnaxL8ykzXbiFBmPCb1qdrRBg8qd00tdYosfA==
X-Received: by 2002:a62:ab0d:: with SMTP id p13mr1668073pff.211.1544768480344;
        Thu, 13 Dec 2018 22:21:20 -0800 (PST)
Received: from buildserver-90.open-silicon.com ([114.143.65.226])
        by smtp.googlemail.com with ESMTPSA id i1sm4841703pgb.46.2018.12.13.22.21.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 13 Dec 2018 22:21:19 -0800 (PST)
From:   Yash Shah <yash.shah@sifive.com>
To:     palmer@sifive.com, linux-pwm@vger.kernel.org,
        linux-riscv@lists.infradead.org
Cc:     thierry.reding@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        sachin.ghadi@sifive.com, paul.walmsley@sifive.com,
        Yash Shah <yash.shah@sifive.com>
Subject: [RFC v2 0/2] PWM support for HiFive Unleashed
Date:   Fri, 14 Dec 2018 11:50:40 +0530
Message-Id: <1544768442-12530-1-git-send-email-yash.shah@sifive.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds PWM drivers and DT documentation for 
HiFive Unleashed board. The patches are mostly based on Wesley's patch.
V2 of this patchset incorporates below items pointed out in v1.

V2 changed from V1:
  1. Remove inclusion of dt-bindings/pwm/pwm.h
  2. Remove artificial alignments
  3. Replace ioread32/iowrite32 with readl/writel
  4. Remove camelcase
  5. Change dev_info to dev_dbg for unnecessary log
  6. Correct typo in driver name
  7. Remove use of of_match_ptr macro
  8. Update the DT compatible strings and Add reference to a common
     versioning document

Yash Shah (2):
  pwm: sifive: Add DT documentation for SiFive PWM Controller
  pwm: sifive: Add a driver for SiFive SoC PWM

 .../devicetree/bindings/pwm/pwm-sifive.txt         |  44 ++++
 drivers/pwm/Kconfig                                |  10 +
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/pwm-sifive.c                           | 229 +++++++++++++++++++++
 4 files changed, 284 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-sifive.txt
 create mode 100644 drivers/pwm/pwm-sifive.c

-- 
1.9.1

