Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF6D6C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 22:20:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 961A520827
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 22:20:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 961A520827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388135AbeKFHmP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 02:42:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57678 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387441AbeKFHmP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 02:42:15 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B85DE308624F;
        Mon,  5 Nov 2018 22:20:22 +0000 (UTC)
Received: from malachite.bss.redhat.com (dhcp-10-20-1-11.bss.redhat.com [10.20.1.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DA2CD19748;
        Mon,  5 Nov 2018 22:20:18 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     intel-gfx@lists.freedesktop.org
Cc:     "David Airlie" <airlied@linux.ie>,
        "Rodrigo Vivi" <rodrigo.vivi@intel.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        "Jani Nikula" <jani.nikula@linux.intel.com>,
        "Joonas Lahtinen" <joonas.lahtinen@linux.intel.com>
Subject: [PATCH v4 0/5] drm/i915: HPD IRQ storm detection fixes
Date:   Mon,  5 Nov 2018 17:20:06 -0500
Message-Id: <20181105222011.2913-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Mon, 05 Nov 2018 22:20:22 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series contains a fix for a problem which is very difficult to
reproduce under normal circumstances without specialized testing
hardware, along with a fix that seems to be required for some especially
rebellious GM45 laptops.

Lyude Paul (5):
  drm/i915: Fix possible race in intel_dp_add_mst_connector()
  drm/i915: Fix NULL deref when re-enabling HPD IRQs on systems with MST
  drm/i915: Fix threshold check in intel_hpd_irq_storm_detect()
  drm/i915: Clarify flow for disabling IRQs on storms
  drm/i915: Add short HPD IRQ storm detection for non-MST systems

 drivers/gpu/drm/i915/i915_debugfs.c  | 74 +++++++++++++++++++++++++
 drivers/gpu/drm/i915/i915_drv.h      |  5 +-
 drivers/gpu/drm/i915/i915_irq.c      |  7 +++
 drivers/gpu/drm/i915/intel_dp_mst.c  |  8 +--
 drivers/gpu/drm/i915/intel_hotplug.c | 83 +++++++++++++++++-----------
 5 files changed, 140 insertions(+), 37 deletions(-)

-- 
2.19.1

