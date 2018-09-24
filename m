Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A116ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:43:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DE232083A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:43:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DE232083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389011AbeIXSpU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:45:20 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59434 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730805AbeIXSpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:45:19 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E9E491099;
        Mon, 24 Sep 2018 12:43:20 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tuomas Tynkkynen <tuomas@tuxera.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 199/235] staging: bcm2835-audio: Dont leak workqueue if open fails
Date:   Mon, 24 Sep 2018 13:53:05 +0200
Message-Id: <20180924113124.089014823@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113103.999624566@linuxfoundation.org>
References: <20180924113103.999624566@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tuomas Tynkkynen <tuomas@tuxera.com>

[ Upstream commit 678c5b119307c40f9a17152512f9c949d0ec7292 ]

Currently, if bcm2835_audio_open() fails partway, the allocated
workqueue is leaked. Avoid that.

While at it, propagate the return value of
bcm2835_audio_open_connection() on failure instead of returning -1.

Signed-off-by: Tuomas Tynkkynen <tuomas@tuxera.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c |   16 +++++++-----
 1 file changed, 10 insertions(+), 6 deletions(-)

--- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c
+++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c
@@ -439,16 +439,16 @@ int bcm2835_audio_open(struct bcm2835_al
 	my_workqueue_init(alsa_stream);
 
 	ret = bcm2835_audio_open_connection(alsa_stream);
-	if (ret) {
-		ret = -1;
-		goto exit;
-	}
+	if (ret)
+		goto free_wq;
+
 	instance = alsa_stream->instance;
 	LOG_DBG(" instance (%p)\n", instance);
 
 	if (mutex_lock_interruptible(&instance->vchi_mutex)) {
 		LOG_DBG("Interrupted whilst waiting for lock on (%d)\n", instance->num_connections);
-		return -EINTR;
+		ret = -EINTR;
+		goto free_wq;
 	}
 	vchi_service_use(instance->vchi_handle[0]);
 
@@ -471,7 +471,11 @@ int bcm2835_audio_open(struct bcm2835_al
 unlock:
 	vchi_service_release(instance->vchi_handle[0]);
 	mutex_unlock(&instance->vchi_mutex);
-exit:
+
+free_wq:
+	if (ret)
+		destroy_workqueue(alsa_stream->my_wq);
+
 	return ret;
 }
 


