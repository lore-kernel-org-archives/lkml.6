Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 374C4C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 14:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 046F9218A2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 14:55:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="V66R/L4V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbeLROze (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 09:55:34 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54196 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726723AbeLROzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 09:55:33 -0500
Received: by mail-wm1-f66.google.com with SMTP id d15so2964921wmb.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 06:55:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=nJOMK4qGOuH+htAiRTQMW4VoOALmj1vJ8fGpeQ2ufJk=;
        b=V66R/L4V505EyKmW4YIZMvmzL9z6OEG3SlpMmYrMCVMz16J+whpMScf7s+9+rl3Mlp
         w9VrL5vfWoTYNBBLoUOhOGlTK4yS8oneYsL3go0XYnKZPNKA35JFubpNzGToBkqZwpl/
         Chok/IhxwHHTx6qbc3WTVgjzkqcchz+HOB1hY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=nJOMK4qGOuH+htAiRTQMW4VoOALmj1vJ8fGpeQ2ufJk=;
        b=XJRNQhIvCQOrU+Cp49GKMU97BfDQyPMPmkkKCzVDzEt/jmvyMlv6ON8MsuxULUyORp
         K4N48m91ORsVd6Tr0/WsZSwj0WPHtMEeYl276uQwsogxJvKBN79wnRKOQpT03puRyYSO
         wCNoM+NpWwWuNarQ7MW4rsXG/2buA102Zco8FTsBP4YqjqV+k7nXPR0flTD2w61lKBpR
         RPsCkd/QlY1uCXq5GVA5kJR2kqHGaGd7/lra/klpLjhITMdyU15DnY6ws+fXaUVU51CO
         szQHRO3BTM3bE+a3RS6/L30V+ZseERTmap30Y9E3ks/7fUgjaWi0eAX7Kz5c+XlShRrR
         xcIQ==
X-Gm-Message-State: AA+aEWYO+Ak1XCN7s2ukIBExgU6hJizpmUiUCe56mR8eXi4cGj3el8vy
        BRawUcdp0oeiCV3SrH9IvIp4tQ==
X-Google-Smtp-Source: AFSGD/WyfkPru7UiGqwy5vr3/LmUzD6wXgTCCVL0bROvdKkNSj0zW7q/FYzJvae9D9eCrbZy+diW5g==
X-Received: by 2002:a1c:e3d7:: with SMTP id a206mr3393236wmh.12.1545144931236;
        Tue, 18 Dec 2018 06:55:31 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:85e9:25c5:6cbd:73e9])
        by smtp.gmail.com with ESMTPSA id n20sm1579956wmi.11.2018.12.18.06.55.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 18 Dec 2018 06:55:30 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rjw@rjwysocki.net, thara.gopinath@linaro.org,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, airlied@linux.ie,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc:     ulf.hansson@linaro.org,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v3 0/3] Move pm_runtime accounted time to raw nsec
Date:   Tue, 18 Dec 2018 15:55:20 +0100
Message-Id: <1545144923-31546-1-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move pm_runtime accounted time to raw nsec. The subject of the patchset
has changed as the 1st patch has been queued by Rafael

Patch 1 adds a new pm_runtime interface to get accounted suspended time

Patch 2 moves drm/i915 driver on the new interface and removes access to internal
fields

Patch 3 moves time accounting on raw ns. This patch initially used
ktime instead of raw ns but it was easier to move i915 driver on raw ns
than on ktim

Changes since v2:
- remove patch1 that has been queued by rafael
- add new interface in pm_runtime to get accounted time
- reorder patchset to prevent compilation error

Changes since v1:
- updated commit message of patch 1
- Added patches 2 & 3 to move runtime_pm accounting on raw ns
  
Thara Gopinath (1):
  PM/runtime:Replace jiffies based accounting with ktime based
    accounting

Vincent Guittot (2):
  PM/runtime: Add a new interface to get accounted time
  drm/i915: Move on the new pm runtime interface

 drivers/base/power/runtime.c    | 36 +++++++++++++++++++++++++++++++-----
 drivers/base/power/sysfs.c      | 11 ++++++++---
 drivers/gpu/drm/i915/i915_pmu.c | 18 ++++++++----------
 drivers/gpu/drm/i915/i915_pmu.h |  4 ++--
 include/linux/pm.h              |  6 +++---
 include/linux/pm_runtime.h      |  2 ++
 6 files changed, 54 insertions(+), 23 deletions(-)

-- 
2.7.4

