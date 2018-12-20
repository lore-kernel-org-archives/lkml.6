Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A03C9C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 14:16:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CEC621720
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 14:16:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WUPcKtiX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387499AbeLTOQc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 09:16:32 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55982 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731305AbeLTOQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 09:16:31 -0500
Received: by mail-wm1-f67.google.com with SMTP id y139so2193191wmc.5
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 06:16:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=JyM8PoVpMMGReUNRG91nRP8Gc1/7Isx2yVO4mPm6EoM=;
        b=WUPcKtiXUBqRPZGNnMpt6uj94YSfAxMlbV23B9AFcwn3f4Vfeq6zQtK0rfRTyAUqd+
         AaFoJ0jJHld2Yw9uxwERfC0ITkd8CJa63ZA60wmMGKEyaEHBmRuFNKjVuAtVjPKeA26u
         tUAplKXsg8czSznAmGn5387S1F3/Hy6HFD4go=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=JyM8PoVpMMGReUNRG91nRP8Gc1/7Isx2yVO4mPm6EoM=;
        b=ER6T5cF/yom7o7FxZQZUOHo/FIW7HEbNPiPcJkwxKy8GwkGB4l3DqcV7UE+8xZiARU
         7GafI3tReEwtg+2QU5kJqxenPPwDjLVdskstZ3/ZROvLfKqaS4G/g96uI87hekQT3N16
         1tQVM7aF5zMyWmJETMI3YKiL2B4DQI1eoH7hS9xhYYQey3RkOp668QItMWJZx7G2fiM9
         oEXeSptDT8YJWduuOZYfDqzdP8f5hWgyKb/Qb1jlwgCvzCWI0V2ZU0McGoZUEX9N+rdV
         XjEMk2qK6KTAKb229dWiyoxcWs1Yqk0n0YSJEQ8YGk4YCFGN+zm5IVgsOlugAehVM2pv
         JbTA==
X-Gm-Message-State: AA+aEWbyY6GP/ZL8kYkYiQoQMWTXsZgffjzUf0NmWbgvVUbPu6MoOB8d
        OWbjchfByXorF4X82XB/e+T+0w==
X-Google-Smtp-Source: AFSGD/Vpk1ALyVefYKtwRXYnZPYD2jYShLTm84caBmf/krEfUQ2IRPsXwDJIcSyluoXXUuaZ/utYdA==
X-Received: by 2002:a1c:b687:: with SMTP id g129mr11493682wmf.59.1545315389791;
        Thu, 20 Dec 2018 06:16:29 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:f9b3:37c1:b11a:64ce])
        by smtp.gmail.com with ESMTPSA id 127sm2313218wmm.45.2018.12.20.06.16.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 20 Dec 2018 06:16:29 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rjw@rjwysocki.net, thara.gopinath@linaro.org,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, airlied@linux.ie,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc:     ulf.hansson@linaro.org,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v4 0/3] Move pm_runtime accounted time to raw nsec
Date:   Thu, 20 Dec 2018 15:16:22 +0100
Message-Id: <1545315385-14384-1-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move pm_runtime accounted time to raw nsec. The subject of the patchset
has changed as the 1st patch of the previous version has been queued by
Rafael.

Patch 1 adds a new pm_runtime interface to get accounted suspended time

Patch 2 moves drm/i915 driver on the new interface and removes access to
internal fields.

Patch 3 moves time accounting on raw ns. This patch initially used
ktime instead of raw ns but it was easier to move i915 driver on raw ns
than on ktime.

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
  PM/runtime:Replace jiffies based accounting with ktime based
    accounting

Vincent Guittot (2):
  PM/runtime: Add a new interface to get accounted time
  drm/i915: Move on the new pm runtime interface

 drivers/base/power/runtime.c    | 27 ++++++++++++++++++++++-----
 drivers/base/power/sysfs.c      | 11 ++++++++---
 drivers/gpu/drm/i915/i915_pmu.c | 16 ++++++----------
 drivers/gpu/drm/i915/i915_pmu.h |  4 ++--
 include/linux/pm.h              |  6 +++---
 include/linux/pm_runtime.h      |  2 ++
 6 files changed, 43 insertions(+), 23 deletions(-)

-- 
2.7.4

