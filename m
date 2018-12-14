Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 204E3C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 14:22:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1708820643
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 14:22:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YrFhZXFx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729714AbeLNOWd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 09:22:33 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33056 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726554AbeLNOWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 09:22:33 -0500
Received: by mail-wr1-f67.google.com with SMTP id c14so5636653wrr.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 06:22:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=LfTTvp443Dgh5VY+fhlpQqhAl+xvk/ZihGH9oJSH5yk=;
        b=YrFhZXFxGPPCjxnRFsFiwu+dMSt/OBMPxtJKK6uG/oEhJrT5eW07WjO8dEKHUuw1Ys
         dcJT6tuXvOq/uP4mG+Ds0lv2P1TnJ4ACktYl43bqxr070EokgL9ABdcBoBUZsZC5tC6n
         c84xDFtc7DgnzFotuxIfyOoakytDwyQQD6uKM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=LfTTvp443Dgh5VY+fhlpQqhAl+xvk/ZihGH9oJSH5yk=;
        b=jbpxtRXjc8zU/LshMBFSSX9cwv5E1v7oBZEzCV1Cm2BSASHBEjhC0VNDZaaDt4jWgK
         mCxxv6BzmdGT4++tGWSgrFJiQmaF+yaDqO+27Ibg6797fnNS4e1UhO4vh8zeXtKAO53c
         iOl7EMOKuVGaM7UvPRgOTl1UuegjexinY4f4ZDxThppZ2pZqz98W0P2DWo6ArwV0dK0A
         V5Ipr+N4mSf0BRs5hL9Dkl7Q8Gey1ZqvMy+BTuYdCCs4EZdoWRyvLZEStwYN4RMuAg9m
         yW2UY8aQ+XHBlKSkIGF1HpznawEjSQsQ5N8nR6mQYvKohctsgpZyC6AJmkSr/n+eNOHC
         x3Fw==
X-Gm-Message-State: AA+aEWZ4pLWJGWAMpqZyO42zo+OL2b2zu+iHJ6Ol6JUcdli3Z9dsPHF1
        IzJKfqsbzQ3TTAEBacXJkVK+tw==
X-Google-Smtp-Source: AFSGD/XzDh+V9qnLFcjemCb+Bz/pOK7ogonfDvzpO1J8Hf9MpcK8apbfQLJDAgjthhnDNsaRy7m2Nw==
X-Received: by 2002:adf:be8b:: with SMTP id i11mr2918872wrh.235.1544797351143;
        Fri, 14 Dec 2018 06:22:31 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:ed2e:a6ad:f6ef:ff8e])
        by smtp.gmail.com with ESMTPSA id m4sm25793829wmi.3.2018.12.14.06.22.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 14 Dec 2018 06:22:30 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rjw@rjwysocki.net, thara.gopinath@linaro.org,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, airlied@linux.ie,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc:     ulf.hansson@linaro.org,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v2 0/3] PM/pm_runtime: move on hrtimer and nsec
Date:   Fri, 14 Dec 2018 15:22:24 +0100
Message-Id: <1544797347-20601-1-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move pm_runtime on hrtimer and raw ns time to get finer granularity

Patch 1 moves runtime_pm autosuspend on hrtimer framework

Patch 2 moves time accounting on raw ns. This patch initially used
ktime instead of raw ns but it was easier to move i915 driver on raw ns
than on ktime

Patch 3 fixes drm/i915 driver that uses PM core fields

Changes since v1:
- updated commit message of patch 1
- Added patches 2 & 3 to move runtime_pm accounting on raw ns
  
Thara Gopinath (1):
  PM/runtime:Replace jiffies based accouting with ktime based accounting

Vincent Guittot (2):
  PM/pm_runtime: move autosuspend on hrtimer
  drm/i915: Move to new PM core fields

 drivers/base/power/runtime.c    | 73 ++++++++++++++++++++++-------------------
 drivers/base/power/sysfs.c      | 11 +++++--
 drivers/gpu/drm/i915/i915_pmu.c | 12 +++----
 drivers/gpu/drm/i915/i915_pmu.h |  4 +--
 include/linux/pm.h              | 11 ++++---
 include/linux/pm_runtime.h      |  6 ++--
 6 files changed, 64 insertions(+), 53 deletions(-)

-- 
2.7.4

