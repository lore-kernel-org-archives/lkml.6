Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1211C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:26:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EC0A213A2
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551129984;
	bh=ZPMySkQm+YTkbMq5eRc2ooernnYvTxX42ZdmgTZ2l5k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MISDlslCgNdi/GQVjzKdWqIKzWrOYTdneomRcZKEw3RACTpio7gc1ZV7tqOKTQB+C
	 BvElbCToHPp6b5Kc+xMS2kujADMW5Cx+hUCfJ9PY7CwH9C9ZHb3qPO/X3BA7MgY/ly
	 uGUfTcq8W4tcHZPnMW6OIx9rpYH5Uy5CF1yDZnw0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731554AbfBYV0X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:26:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:60750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730170AbfBYV0U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:26:20 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B2CCB2084D;
        Mon, 25 Feb 2019 21:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551129979;
        bh=ZPMySkQm+YTkbMq5eRc2ooernnYvTxX42ZdmgTZ2l5k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U8BmQpXfUp30TM/sWoJ7jfJ1J3QAnBJ1cLTPvi7mq9K9Pdl6Eq2ivFJLK1wtQV38W
         dORnxC0PElHbz93+eB8CDSF0wSZPB8OWNbqAJIY6gzr9j1ouPmP/uLUmPchpe9+cbd
         DL02u8by+TQ+d12Dg93ryDNS+HIKldPaMQRFluAM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Jani Nikula <jani.nikula@intel.com>
Subject: [PATCH 4.19 128/152] drm/i915/fbdev: Actually configure untiled displays
Date:   Mon, 25 Feb 2019 22:12:00 +0100
Message-Id: <20190225195052.113434134@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195043.645958524@linuxfoundation.org>
References: <20190225195043.645958524@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
@@ -334,8 +334,8 @@ static bool intel_fb_initial_config(stru
 				    bool *enabled, int width, int height)
 {
 	struct drm_i915_private *dev_priv = to_i915(fb_helper->dev);
-	unsigned long conn_configured, conn_seq, mask;
 	unsigned int count = min(fb_helper->connector_count, BITS_PER_LONG);
+	unsigned long conn_configured, conn_seq;
 	int i, j;
 	bool *save_enabled;
 	bool fallback = true, ret = true;
@@ -353,10 +353,9 @@ static bool intel_fb_initial_config(stru
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
@@ -369,7 +368,8 @@ retry:
 		if (conn_configured & BIT(i))
 			continue;
 
-		if (conn_seq == 0 && !connector->has_tile)
+		/* First pass, only consider tiled connectors */
+		if (conn_seq == GENMASK(count - 1, 0) && !connector->has_tile)
 			continue;
 
 		if (connector->status == connector_status_connected)
@@ -473,8 +473,10 @@ retry:
 		conn_configured |= BIT(i);
 	}
 
-	if ((conn_configured & mask) != mask && conn_configured != conn_seq)
+	if (conn_configured != conn_seq) { /* repeat until no more are found */
+		conn_seq = conn_configured;
 		goto retry;
+	}
 
 	/*
 	 * If the BIOS didn't enable everything it could, fall back to have the


