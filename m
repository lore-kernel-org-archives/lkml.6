Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 578ADC46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 17:24:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06EEC216F6
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 17:24:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="d22d+KNT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06EEC216F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729602AbeHHToz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 15:44:55 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45848 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727295AbeHHToz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 15:44:55 -0400
Received: by mail-pf1-f196.google.com with SMTP id i26-v6so1452311pfo.12
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 10:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aCGDazpF1dME0Q+tH97mPdVBzHyvCqizaFVXzkgaGDc=;
        b=d22d+KNTuZptkpnYXtX7Kv3ocRdIeKT6somtcCtk24Qjg9GIZqemUUmCcXm4Z5zit4
         JhN60B5tiYNtZLHFDUZa5JuoZmLznlU/6773Dnm74c0ZQWHoQ8H93D5Ryjm9Ehl8dIIf
         USCIcwrxgpZaNrfoPt92pVNb7YHvpwS7U4vvk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aCGDazpF1dME0Q+tH97mPdVBzHyvCqizaFVXzkgaGDc=;
        b=XI/GR6vdzjfB1PhLxVRV4NcOIpflfos/XUS/Jtfs/9RSuA7+laztjkP3QRmYlfmtfu
         alBzVbP+Rx+RJybDPhkgsaaGTVdmfFvof+XfDU7PmKCMjutfxKpwma2BCScsXnFcwRAC
         e3xK1qKoIfGsogoz6Gx2ZK1Fjnun36PV5yx4q8p803P1m81s9oHveuRLJIekK8qIbusr
         uLmaWirnNiUU2CGybwf9uiFFW+7DbYrHEFwz3BRLNavCIpdEC2Vzm6YwId1ErSWtIlHB
         py1ETRW3XdmuwuugPka62I0Od2M2YA7LdT3UTRW1GnSv2VnYxAzNo2ACe9FRur8RRUgJ
         0L2A==
X-Gm-Message-State: AOUpUlEDlxHp/qiqi5TeDvktZA83COeNGnjIR1TQrsVGz5Cvpm44hcP2
        Hnd2dpGzEOO18CIS+6y+EzrW45O3tuUmuQ==
X-Google-Smtp-Source: AA+uWPy1XRM/PzF94vBU88CullbiwTJjr2jrIspKRiribWpyhMvAXB0vQpr3ODzkRqH5wGq4Z3rxOA==
X-Received: by 2002:a63:144b:: with SMTP id 11-v6mr3472936pgu.219.1533749056234;
        Wed, 08 Aug 2018 10:24:16 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:7e28:b9f3:6afc:5326])
        by smtp.gmail.com with ESMTPSA id 1-v6sm9679503pfm.145.2018.08.08.10.24.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 10:24:15 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] firmware: coreboot: Fix probe and simplify code
Date:   Wed,  8 Aug 2018 10:24:12 -0700
Message-Id: <20180808172414.29983-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first patch is a trimmed down version of patch#1 that leaves
the of_iomap() in place and just fixes the real problem of probe
not working on DT based platforms. The second patch collapses everything
into the core file to hopefully simplify code at the expense of mildly
changing the behavior on DT based platforms.

Stephen Boyd (2):
  firmware: coreboot: Let OF core populate platform device
  firmware: coreboot: Collapse platform drivers into bus core

 drivers/firmware/google/Kconfig               | 28 +++---
 drivers/firmware/google/Makefile              |  2 -
 drivers/firmware/google/coreboot_table-acpi.c | 88 -----------------
 drivers/firmware/google/coreboot_table-of.c   | 82 ----------------
 drivers/firmware/google/coreboot_table.c      | 96 ++++++++++++++++---
 drivers/firmware/google/coreboot_table.h      |  6 --
 6 files changed, 96 insertions(+), 206 deletions(-)
 delete mode 100644 drivers/firmware/google/coreboot_table-acpi.c
 delete mode 100644 drivers/firmware/google/coreboot_table-of.c

-- 
Sent by a computer through tubes

