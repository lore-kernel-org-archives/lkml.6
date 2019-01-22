Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25B7AC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 14:24:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6F2E20870
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 14:24:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ifog/VvV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728715AbfAVOYf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 09:24:35 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33493 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728511AbfAVOYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 09:24:35 -0500
Received: by mail-wr1-f66.google.com with SMTP id c14so27622818wrr.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 06:24:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=itJxEXH4FREUUJIjo2Nj5mSOkQ/lHsZ5PO5eWoAOnes=;
        b=ifog/VvVKSzamOglbvzQKyLRYfoPQZjgsjivGhOU3qepRjuAvfEVi5kWGCOA++8dZF
         mSN93tXGL75N4KdizMdlD1GWTsnxbyoXLin2UsEnI/yb0Sht3wUVfZdggnrYPIJEVzlD
         fDkTaaqynPP33O2QMEoJY910GgJ4Sxojx7XaM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=itJxEXH4FREUUJIjo2Nj5mSOkQ/lHsZ5PO5eWoAOnes=;
        b=RJqHTPf247p14eUWN1n5UWteRiCX/AdqUvLmgGlgp4qam6vmTEXL/w5sXJDdJendHC
         wKfETQLknRA0F/XmvIv7IQFHZPuRW7+NKE2kqdVLteCpFdY/bp02PNXsu9N1aXFYJndh
         9M+e6mSwIPH61pX+CTpKvyBW66iSvbNvMSZvvWvH+1EUhn0g/B/BDfVs9MVdg4FBmWK8
         Vjy16b7pzoLJ0abAkykje3RTGlI7EFgGd0n1BJLGNLD+Glmszy+jHPFEfQj7bnrPGwZ7
         0ooEGAt2q7R8aylKvkXtv9WuIEo6BcH2axxPejYVi5z6rzoUMIcyoYCRgrxiGsgvytps
         llGA==
X-Gm-Message-State: AJcUukeUPCQxJewAUAzzlgi2qjCR0/1sh1YTq06Kil85D5dGMP8DX2yS
        B8K3EqgVtmUsiOY7aKNncoT7Fg==
X-Google-Smtp-Source: ALg8bN6VI5EkHXMl5P/Q5TRhkEZ67/06Az+XqTc9B7rtuBCESH4C/S4hDQAymKOiPQzrD5S/z1+alQ==
X-Received: by 2002:adf:a393:: with SMTP id l19mr34079911wrb.110.1548167073481;
        Tue, 22 Jan 2019 06:24:33 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:609f:7896:d361:50c6])
        by smtp.gmail.com with ESMTPSA id l19sm52620119wme.21.2019.01.22.06.24.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 22 Jan 2019 06:24:32 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rjw@rjwysocki.net, thara.gopinath@linaro.org, linux@roeck-us.net
Cc:     ulf.hansson@linaro.org,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v6 0/3] Move pm_runtime accounted time to raw nsec
Date:   Tue, 22 Jan 2019 15:24:28 +0100
Message-Id: <1548167070-421-1-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move pm_runtime accounted time to raw nsec. The subject of the patchset
has changed as the 1st patch of the previous versions has been queued by
Rafael.

Patch 1 set accounting_timestamp to 0 in pm_runtime_init and update it when enable. So
we remove ordering constraint between timekeeping_init and pm_runtime_init

Patch 2 moves time accounting on raw ns. This patch initially used
ktime instead of raw ns but it was easier to move i915 driver on raw ns
than on ktime.

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

 drivers/base/power/runtime.c | 21 +++++++++++++--------
 drivers/base/power/sysfs.c   | 11 ++++++++---
 include/linux/pm.h           |  6 +++---
 3 files changed, 24 insertions(+), 14 deletions(-)

-- 
2.7.4

