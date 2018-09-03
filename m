Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A80D0C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:04:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CBCC20862
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:04:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CBCC20862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729439AbeICVZt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:25:49 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:39370 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728333AbeICVZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:25:48 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 1F1B0D00;
        Mon,  3 Sep 2018 17:04:47 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Rob Clark <robdclark@gmail.com>,
        Archit Taneja <architt@codeaurora.org>,
        Sean Paul <seanpaul@chromium.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 006/107] drm/bridge: adv7511: Reset registers on hotplug
Date:   Mon,  3 Sep 2018 18:55:30 +0200
Message-Id: <20180903165637.603785435@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180903165637.293735109@linuxfoundation.org>
References: <20180903165637.293735109@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sean Paul <seanpaul@chromium.org>

[ Upstream commit 5f3417569165a8ee57654217f73e0160312f409c ]

The bridge loses its hw state when the cable is unplugged. If we detect
this case in the hpd handler, reset its state.

Reported-by: Rob Clark <robdclark@gmail.com>
Tested-by: Rob Clark <robdclark@gmail.com>
Reviewed-by: Archit Taneja <architt@codeaurora.org>
Signed-off-by: Sean Paul <seanpaul@chromium.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20180703165648.120401-1-seanpaul@chromium.org
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/bridge/adv7511/adv7511_drv.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

--- a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
+++ b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
@@ -424,6 +424,18 @@ static void adv7511_hpd_work(struct work
 	else
 		status = connector_status_disconnected;
 
+	/*
+	 * The bridge resets its registers on unplug. So when we get a plug
+	 * event and we're already supposed to be powered, cycle the bridge to
+	 * restore its state.
+	 */
+	if (status == connector_status_connected &&
+	    adv7511->connector.status == connector_status_disconnected &&
+	    adv7511->powered) {
+		regcache_mark_dirty(adv7511->regmap);
+		adv7511_power_on(adv7511);
+	}
+
 	if (adv7511->connector.status != status) {
 		adv7511->connector.status = status;
 		drm_kms_helper_hotplug_event(adv7511->connector.dev);


