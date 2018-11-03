Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 347D1C32789
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 00:19:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7C5B20833
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 00:19:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7C5B20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728438AbeKCJ2h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 05:28:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53716 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726083AbeKCJ2g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 05:28:36 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7499530842CE;
        Sat,  3 Nov 2018 00:19:17 +0000 (UTC)
Received: from malachite.bss.redhat.com (dhcp-10-20-1-11.bss.redhat.com [10.20.1.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 459E55D967;
        Sat,  3 Nov 2018 00:19:13 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     intel-gfx@lists.freedesktop.org
Cc:     "David Airlie" <airlied@linux.ie>,
        "Rodrigo Vivi" <rodrigo.vivi@intel.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        "Jani Nikula" <jani.nikula@linux.intel.com>,
        "Joonas Lahtinen" <joonas.lahtinen@linux.intel.com>
Subject: [PATCH v3 0/5] drm/i915: HPD IRQ storm detection fixes 
Date:   Fri,  2 Nov 2018 20:19:03 -0400
Message-Id: <20181103001909.23645-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Sat, 03 Nov 2018 00:19:17 +0000 (UTC)
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

 drivers/gpu/drm/i915/i915_debugfs.c  | 74 ++++++++++++++++++++++++++
 drivers/gpu/drm/i915/i915_drv.h      |  5 +-
 drivers/gpu/drm/i915/i915_irq.c      |  7 +++
 drivers/gpu/drm/i915/intel_dp_mst.c  |  8 +--
 drivers/gpu/drm/i915/intel_hotplug.c | 78 +++++++++++++++++-----------
 5 files changed, 137 insertions(+), 35 deletions(-)

-- 
2.19.1

