Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23D4EECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:25:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCABC21486
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:25:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCABC21486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732990AbeIXS1d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:27:33 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:57002 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730683AbeIXS1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:27:32 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 302F5108B;
        Mon, 24 Sep 2018 12:25:39 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chris Wilson <chris@chris-wilson.co.uk>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 4.14 165/173] drm/i915: Apply the GTT write flush for all !llc machines
Date:   Mon, 24 Sep 2018 13:53:19 +0200
Message-Id: <20180924113127.174758304@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113114.334025954@linuxfoundation.org>
References: <20180924113114.334025954@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chris Wilson <chris@chris-wilson.co.uk>

commit c5ba5b24657e473b1c64b0a614b168a635a2c935 upstream.

We also see the delayed GTT write issue on i915g/i915gm, so let's
presume that it is a universal problem for all !llc machines, and that we
just haven't yet noticed on g33, gen4 and gen5 machines.

v2: Use a register that exists on all platforms

Testcase: igt/gem_mmap_gtt/coherency # i915gm
References: https://bugs.freedesktop.org/show_bug.cgi?id=102577
Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20170907184520.5032-1-chris@chris-wilson.co.uk
Reviewed-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/i915/i915_gem.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/i915/i915_gem.c
+++ b/drivers/gpu/drm/i915/i915_gem.c
@@ -687,10 +687,10 @@ flush_write_domain(struct drm_i915_gem_o
 
 	switch (obj->base.write_domain) {
 	case I915_GEM_DOMAIN_GTT:
-		if (INTEL_GEN(dev_priv) >= 6 && !HAS_LLC(dev_priv)) {
+		if (!HAS_LLC(dev_priv)) {
 			intel_runtime_pm_get(dev_priv);
 			spin_lock_irq(&dev_priv->uncore.lock);
-			POSTING_READ_FW(RING_ACTHD(dev_priv->engine[RCS]->mmio_base));
+			POSTING_READ_FW(RING_HEAD(dev_priv->engine[RCS]->mmio_base));
 			spin_unlock_irq(&dev_priv->uncore.lock);
 			intel_runtime_pm_put(dev_priv);
 		}


