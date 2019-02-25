Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 486A6C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:35:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16CCA2184D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551130559;
	bh=lDOUCf60NzSBgpTABfzirbY8okaKZ75to7/FiYFAk7k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lBEppSq5r4i2b1WioXV9NtRgR1B357t1o7tWfooXCVZv5Fk/YXg7LtZO5lVrVsZ8Z
	 vLWygNvtoIZu5L3/Zc83Rre9zyyzr1ZyocL0K0OoYBGY/XbvpFhTK6bR0x9vuyhrR7
	 qhEd3LJAPEoUtcaNm0PUvSa4t/LyH5z9FwvJ3Yho=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733073AbfBYVf5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:35:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:42216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733050AbfBYVfx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:35:53 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2AB4220578;
        Mon, 25 Feb 2019 21:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551130552;
        bh=lDOUCf60NzSBgpTABfzirbY8okaKZ75to7/FiYFAk7k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=supacUZpdp4ckON4oDSzrnuU/l8r/oAB4RLhcAL/v9VZf7ashtW7VYwQCSHkV50VA
         YeQHo+BtC52APoDjUPB8WzFeViOvEx8TMYOFpnlJ08bkSvo1NyXqVdzfBNacJSredk
         pJbcDEtVL6FFOStw/VQuhWy8Jf8ComTTsrIf67E4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Jani Nikula <jani.nikula@intel.com>
Subject: [PATCH 4.20 158/183] drm/i915/fbdev: Actually configure untiled displays
Date:   Mon, 25 Feb 2019 22:12:11 +0100
Message-Id: <20190225195121.601802548@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195054.748060397@linuxfoundation.org>
References: <20190225195054.748060397@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chris Wilson <chris@chris-wilson.co.uk>

commit d179b88deb3bf6fed4991a31fd6f0f2cad21fab5 upstream.

If we skipped all the connectors that were not part of a tile, we would
leave conn_seq=0 and conn_configured=0, convincing ourselves that we
had stagnated in our configuration attempts. Avoid this situation by
starting conn_seq=ALL_CONNECTORS, and repeating until we find no more
connectors to configure.

Fixes: 754a76591b12 ("drm/i915/fbdev: Stop repeating tile configuration on stagnation")
Reported-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Reviewed-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20190215123019.32283-1-chris@chris-wilson.co.uk
Cc: <stable@vger.kernel.org> # v3.19+
(cherry picked from commit d9b308b1f8a1acc0c3279f443d4fe0f9f663252e)
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/i915/intel_fbdev.c |   12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

--- a/drivers/gpu/drm/i915/intel_fbdev.c
+++ b/drivers/gpu/drm/i915/intel_fbdev.c
@@ -336,8 +336,8 @@ static bool intel_fb_initial_config(stru
 				    bool *enabled, int width, int height)
 {
 	struct drm_i915_private *dev_priv = to_i915(fb_helper->dev);
-	unsigned long conn_configured, conn_seq, mask;
 	unsigned int count = min(fb_helper->connector_count, BITS_PER_LONG);
+	unsigned long conn_configured, conn_seq;
 	int i, j;
 	bool *save_enabled;
 	bool fallback = true, ret = true;
@@ -355,10 +355,9 @@ static bool intel_fb_initial_config(stru
 		drm_modeset_backoff(&ctx);
 
 	memcpy(save_enabled, enabled, count);
-	mask = GENMASK(count - 1, 0);
+	conn_seq = GENMASK(count - 1, 0);
 	conn_configured = 0;
 retry:
-	conn_seq = conn_configured;
 	for (i = 0; i < count; i++) {
 		struct drm_fb_helper_connector *fb_conn;
 		struct drm_connector *connector;
@@ -371,7 +370,8 @@ retry:
 		if (conn_configured & BIT(i))
 			continue;
 
-		if (conn_seq == 0 && !connector->has_tile)
+		/* First pass, only consider tiled connectors */
+		if (conn_seq == GENMASK(count - 1, 0) && !connector->has_tile)
 			continue;
 
 		if (connector->status == connector_status_connected)
@@ -475,8 +475,10 @@ retry:
 		conn_configured |= BIT(i);
 	}
 
-	if ((conn_configured & mask) != mask && conn_configured != conn_seq)
+	if (conn_configured != conn_seq) { /* repeat until no more are found */
+		conn_seq = conn_configured;
 		goto retry;
+	}
 
 	/*
 	 * If the BIOS didn't enable everything it could, fall back to have the


