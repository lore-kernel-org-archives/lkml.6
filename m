Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59AA0C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 07:50:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2264020870
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 07:50:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HeoATH3X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726972AbfAWHuV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 02:50:21 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41084 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbfAWHuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 02:50:20 -0500
Received: by mail-wr1-f65.google.com with SMTP id x10so1186477wrs.8
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 23:50:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=ErITnZX7V2KHQl6xx/ncGHB7pc8CDMknHP/nniLmEZs=;
        b=HeoATH3X2Ycp16lTuJr3RNP5usYadU7AnoFwDbNRyOKZn/IcA2ni1PV2CGGgosiB8N
         HVRGbIPQlZMh86aFd6EqXDD/0Na+czVJa4J6obEEqxxZKj/kbSNMCWA9YAxm0B9rpOXW
         RD1Ej+Rvrj+NAAI0u8mAO7uebn1xvqjw5BWMg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ErITnZX7V2KHQl6xx/ncGHB7pc8CDMknHP/nniLmEZs=;
        b=paU0X4YUSz1GS933LO6P2ImFsASgiDo9Vc0yBoRiRUXyu8ijd75WqspLD8WA6eZp5J
         jP+ogiS3fSlRGI3GboNgP2kTyV+MaH1z8+9UNPBfWIMbbqCDzfZfM3yLSZI0uJktC+wb
         DMGoyldlceBkYRDHV2P3mxrngcCL+inJB2KBPSw3GRWmxK0dYUuIH+khSkmdG8Avik8r
         yuVlNBWSf+6748yC71fM2/EECozQwcMX/YlJpeVPK94ZPGC/8nevzBKEv2TVZbaECwPQ
         j3+IWQzRRu0I+x5pW7n2fySuuFT8MXq9ZKc8cNQQtAuWKPt0UWRCIT20DYWUxWpinvwT
         Jr5Q==
X-Gm-Message-State: AJcUukcUGHunYNfuwRLxRx172YvMNZsHE2mzshYf9cG094p8g2xKQ6Zv
        nyOzqJJI6Uo93GRjFVHRZOGyxw==
X-Google-Smtp-Source: ALg8bN64TLsEtqUWmhPghRGCGHthC/cPxwQV/+PotTYAbILJ3Xs7xSV7CB8uD9ht0J0uipkuxPFCNQ==
X-Received: by 2002:adf:ea11:: with SMTP id q17mr1325784wrm.328.1548229818594;
        Tue, 22 Jan 2019 23:50:18 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:5ca6:2921:648b:56b6])
        by smtp.gmail.com with ESMTPSA id i186sm70138787wmd.19.2019.01.22.23.50.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 22 Jan 2019 23:50:17 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rjw@rjwysocki.net, thara.gopinath@linaro.org, linux@roeck-us.net
Cc:     ulf.hansson@linaro.org,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v7 0/3] Move pm_runtime accounted time to raw nsec
Date:   Wed, 23 Jan 2019 08:50:12 +0100
Message-Id: <1548229814-24913-1-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move pm_runtime accounted time to raw nsec. The subject of the patchset
has changed as 1st patch o the previous versions has been queued by
Rafael.

Patch 1 set accounting_timestamp to 0 in pm_runtime_init and update it when enable.
So we remove ordering constraint between timekeeping_init and pm_runtime_init

Patch 2 moves time accounting on raw ns. This patch initially used
ktime instead of raw ns but it was easier to move i915 driver on raw ns
than on ktime.

Change since v6:
- move code that set accounting_timestamp in pm_runtime_enable

Changes since v5:
- removed patches already queued.
- set accounting_timestamp to 0 in pm_runtime_init and update it when enable

Changes since v4:
-Update commit message

Changes since v3:
- Rebase on v4.20-rc7 without patch that has been queued by Rafael
- Simplify the new interface pm_runtime_suspended_time()

Changes since v2:
- remove patch1 that has been queued by rafael
- add new interface in pm_runtime to get accounted time
- reorder patchset to prevent compilation error

Changes since v1:
- updated commit message of patch 1
- Added patches 2 & 3 to move runtime_pm accounting on raw ns
  
Thara Gopinath (1):
  PM-runtime: Replace jiffies based accounting with ktime-based
    accounting

Vincent Guittot (1):
  PM-runtime: update accounting_timestamp only when enable

 drivers/base/power/runtime.c | 26 ++++++++++++++++----------
 drivers/base/power/sysfs.c   | 11 ++++++++---
 include/linux/pm.h           |  6 +++---
 3 files changed, 27 insertions(+), 16 deletions(-)

-- 
2.7.4

