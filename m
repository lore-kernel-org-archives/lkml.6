Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D49AC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 10:34:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E4E321908
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 10:34:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="kL7fU9vL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389751AbeLUKeF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 05:34:05 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33806 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389727AbeLUKeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 05:34:05 -0500
Received: by mail-wr1-f68.google.com with SMTP id j2so4715757wrw.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 02:34:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=AXRcF9hCBywIe7OQ4cW1uBDgnWFwaWi9AOMWDYeO9tI=;
        b=kL7fU9vL5DZ3AsZn11Hxv0HnCpqv74k7RaY07oKap1o6D8tHdDKqWT9aMCXRVgd0N6
         WsDEQ4vC1+iWbWpkEorIyIWqvdfeUGtXjDYZJ+EolFbvKIlACkeyUi3S8zCjI8qpdATk
         +3SjJzDPnhLzc/NgYImfDTNoGEMTTzcg9TQTw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=AXRcF9hCBywIe7OQ4cW1uBDgnWFwaWi9AOMWDYeO9tI=;
        b=raowBzT/swQW7hp7hnXptde3SVmk1otTRb5ylDbNlXgTbT1mLN+m7beGUx7WVhkNYC
         r7EXcc5lkF0mD2UVmeWQPsJ5dxvM//0yH4scAkrTbavEOJgbrWD3ZspKEMyRZkjxjLQv
         nVZy5gN1/pJtwcVYwIG43QpQj/lC+j80XYrdoy4ozTY83CTQGIWGIdN3kxEmgCykUo/h
         uk+xPFe65UlfB83cB+KCwC/xG2NStrUhmuDfPSnw+yKVQh/Mhzq5f06/VDRNZcqcUHcl
         hEI7fwXI3Wfefr4knm952dNyJ+TyWrVMmEmZV+So4ICXNpiNe7+w/FS5jUkiI8S6d8xc
         /Fhw==
X-Gm-Message-State: AJcUukcw2vcRiZ3TZ3dsaMQSAPII2jVoZRyqB3cu8bhEQ535s1aP88Mv
        I5jFXfN+iiC0EcRuHU1Ed9uvXg==
X-Google-Smtp-Source: ALg8bN7/2JTkZAXxgUFS2tLPQu/+sEL8VKaVFekordDbMZeqKZiBmxduapOdfN3EVkSBni7WiTQvEw==
X-Received: by 2002:adf:8001:: with SMTP id 1mr1908786wrk.23.1545388443270;
        Fri, 21 Dec 2018 02:34:03 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:ac05:2372:f02d:b03f])
        by smtp.gmail.com with ESMTPSA id h10sm10573685wmf.44.2018.12.21.02.34.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 21 Dec 2018 02:34:02 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rjw@rjwysocki.net, thara.gopinath@linaro.org,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, airlied@linux.ie,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc:     ulf.hansson@linaro.org,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v5 0/3] Move pm_runtime accounted time to raw nsec
Date:   Fri, 21 Dec 2018 11:33:53 +0100
Message-Id: <1545388436-7489-1-git-send-email-vincent.guittot@linaro.org>
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

