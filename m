Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C50D4C71122
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 16:00:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 969FE20645
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 16:00:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 969FE20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729825AbeJNXlx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:41:53 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35828 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727352AbeJNXLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:11:48 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLb-0004cp-Qe; Sun, 14 Oct 2018 16:30:28 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLY-0000fC-UN; Sun, 14 Oct 2018 16:30:24 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Joonas Lahtinen" <joonas.lahtinen@linux.intel.com>,
        "Matthew Auld" <matthew.auld@intel.com>,
        "Chris Wilson" <chris@chris-wilson.co.uk>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.924063394@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 301/366] drm/i915/userptr: reject zero user_size
In-Reply-To: <lsq.1539530740.755408431@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.60-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Matthew Auld <matthew.auld@intel.com>

commit 20943f984967477c906522112d2b6b5a29f94684 upstream.

Operating on a zero sized GEM userptr object will lead to explosions.

Fixes: 5cc9ed4b9a7a ("drm/i915: Introduce mapping of user pages into video memory (userptr) ioctl")
Testcase: igt/gem_userptr_blits/input-checking
Signed-off-by: Matthew Auld <matthew.auld@intel.com>
Cc: Chris Wilson <chris@chris-wilson.co.uk>
Reviewed-by: Chris Wilson <chris@chris-wilson.co.uk>
Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
Link: https://patchwork.freedesktop.org/patch/msgid/20180502195021.30900-1-matthew.auld@intel.com
(cherry picked from commit c11c7bfd213495784b22ef82a69b6489f8d0092f)
Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/gpu/drm/i915/i915_gem_userptr.c | 3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/gpu/drm/i915/i915_gem_userptr.c
+++ b/drivers/gpu/drm/i915/i915_gem_userptr.c
@@ -657,6 +657,9 @@ i915_gem_userptr_ioctl(struct drm_device
 			    I915_USERPTR_UNSYNCHRONIZED))
 		return -EINVAL;
 
+	if (!args->user_size)
+		return -EINVAL;
+
 	if (offset_in_page(args->user_ptr | args->user_size))
 		return -EINVAL;
 

