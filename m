Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 000A3ECE562
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 07:37:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE79820880
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 07:37:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE79820880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731132AbeISNOO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 09:14:14 -0400
Received: from mga18.intel.com ([134.134.136.126]:9065 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726972AbeISNON (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 09:14:13 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Sep 2018 00:37:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,393,1531810800"; 
   d="scan'208";a="74202161"
Received: from ning-debian.sh.intel.com ([10.239.16.9])
  by orsmga007.jf.intel.com with ESMTP; 19 Sep 2018 00:37:32 -0700
From:   ning.a.zhang@intel.com
To:     jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, airlied@linux.ie
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Zhang Ning <ning.a.zhang@intel.com>
Subject: [PATCH] drm/i915: set i915 driver probe to asynchronous
Date:   Wed, 19 Sep 2018 15:37:12 +0800
Message-Id: <20180919073712.25463-1-ning.a.zhang@intel.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhang Ning <ning.a.zhang@intel.com>

when i915 is built in module, and system has built-in display, eg. eDP,
i915 will detect and active it during driver probe. it will take long
time.

set i915 driver probe to asynchrous can save kernel initial time.

Signed-off-by: Zhang Ning <ning.a.zhang@intel.com>
---
 drivers/gpu/drm/i915/i915_pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/i915/i915_pci.c b/drivers/gpu/drm/i915/i915_pci.c
index 6a4d1388ad2d..0f57d71d0abb 100644
--- a/drivers/gpu/drm/i915/i915_pci.c
+++ b/drivers/gpu/drm/i915/i915_pci.c
@@ -738,6 +738,7 @@ static struct pci_driver i915_pci_driver = {
 	.probe = i915_pci_probe,
 	.remove = i915_pci_remove,
 	.driver.pm = &i915_pm_ops,
+	.driver.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 };
 
 static int __init i915_init(void)
-- 
2.18.0

