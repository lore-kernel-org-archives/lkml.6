Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BDF3C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 22:27:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CF2620824
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 22:27:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CF2620824
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727250AbeJZHBn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 03:01:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34714 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726448AbeJZHBn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 03:01:43 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 53DD3307D865;
        Thu, 25 Oct 2018 22:27:15 +0000 (UTC)
Received: from malachite.bss.redhat.com (dhcp-10-20-1-11.bss.redhat.com [10.20.1.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AD9321823B;
        Thu, 25 Oct 2018 22:27:11 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     intel-gfx@lists.freedesktop.org
Cc:     "David Airlie" <airlied@linux.ie>,
        "Rodrigo Vivi" <rodrigo.vivi@intel.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        "Jani Nikula" <jani.nikula@linux.intel.com>,
        "Joonas Lahtinen" <joonas.lahtinen@linux.intel.com>
Subject: [PATCH 0/2] drm/i915: HPD IRQ storm detection fixes
Date:   Thu, 25 Oct 2018 18:26:55 -0400
Message-Id: <20181025222657.9241-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Thu, 25 Oct 2018 22:27:15 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

---- IMPORTANT -----
As a note: I have not had the customer who this second patch is for test
this yet, I'm sending this ahead of time to make sure this is something
that isn't too crazy for upstream to accept. I'm not planning on pushing
this after review until I've verified this actually fixes their
problems.
--------------------

This series contains a fix for a problem which is very difficult to
reproduce under normal circumstances without specialized testing
hardware, along with a fix that seems to be required for some especially
rebellious GM45 laptops.

Lyude Paul (2):
  drm/i915: Fix NULL deref when re-enabling HPD IRQs on systems with MST
  drm/i915: Add short HPD IRQ storm detection for non-MST systems

 drivers/gpu/drm/i915/i915_debugfs.c  | 89 +++++++++++++++++++++++-----
 drivers/gpu/drm/i915/i915_drv.h      | 15 +++--
 drivers/gpu/drm/i915/i915_irq.c      | 14 ++++-
 drivers/gpu/drm/i915/intel_hotplug.c | 87 ++++++++++++++++-----------
 4 files changed, 152 insertions(+), 53 deletions(-)

-- 
2.17.2

