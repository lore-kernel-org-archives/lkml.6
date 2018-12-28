Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C2C7C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 11:53:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3871320879
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 11:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545998038;
	bh=plkO8wSSGLEOB4xCOSgrayPclYFMJRLggZ8fSA+4AUA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PlZ7yP+Y4/DnAGH9uGe3zywz3K8rDpyOTnQHJiaGdYOb9G2wWce5vuh/8hRv5vphW
	 AZ/mTxOKcL9CP89oD6p81uz4/6fYsoZIuuni7wjauZRTOzcp5/ZmpYiCuE8Lbri+uO
	 k5P1EUtdINtt+LJsq37562aHyFDRfRsWyxWTef+E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732396AbeL1Lx4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 06:53:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:53726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732370AbeL1Lxv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 06:53:51 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 892D9218F0;
        Fri, 28 Dec 2018 11:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545998030;
        bh=plkO8wSSGLEOB4xCOSgrayPclYFMJRLggZ8fSA+4AUA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Nle9OVIyNBjtunvixfQtjzwm42HYgFlKnJLPBDL993vBghIoeiOVVuKfpmpuoh50W
         dnqdu16lKMTWIElSoOdhQtUXyuMycPhqZWb8Tjqo00gJ7G3HqcQOhMJWsUZKI1Bwu0
         JOAmhpet5OtCYqJ/eFFALsI7vm7XV3SPNNL5Ro+c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 24/46] Drivers: hv: vmbus: Return -EINVAL for the sys files for unopened channels
Date:   Fri, 28 Dec 2018 12:52:18 +0100
Message-Id: <20181228113126.175718919@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181228113124.971620049@linuxfoundation.org>
References: <20181228113124.971620049@linuxfoundation.org>
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

From: Dexuan Cui <decui@microsoft.com>

commit fc96df16a1ce80cbb3c316ab7d4dc8cd5c2852ce upstream.

Before 98f4c651762c, we returned zeros for unopened channels.
With 98f4c651762c, we started to return random on-stack values.

We'd better return -EINVAL instead.

Fixes: 98f4c651762c ("hv: move ringbuffer bus attributes to dev_groups")
Cc: stable@vger.kernel.org
Cc: K. Y. Srinivasan <kys@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Signed-off-by: Dexuan Cui <decui@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/hv/vmbus_drv.c |   20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -316,6 +316,8 @@ static ssize_t out_intr_mask_show(struct
 
 	if (!hv_dev->channel)
 		return -ENODEV;
+	if (hv_dev->channel->state != CHANNEL_OPENED_STATE)
+		return -EINVAL;
 	hv_ringbuffer_get_debuginfo(&hv_dev->channel->outbound, &outbound);
 	return sprintf(buf, "%d\n", outbound.current_interrupt_mask);
 }
@@ -329,6 +331,8 @@ static ssize_t out_read_index_show(struc
 
 	if (!hv_dev->channel)
 		return -ENODEV;
+	if (hv_dev->channel->state != CHANNEL_OPENED_STATE)
+		return -EINVAL;
 	hv_ringbuffer_get_debuginfo(&hv_dev->channel->outbound, &outbound);
 	return sprintf(buf, "%d\n", outbound.current_read_index);
 }
@@ -343,6 +347,8 @@ static ssize_t out_write_index_show(stru
 
 	if (!hv_dev->channel)
 		return -ENODEV;
+	if (hv_dev->channel->state != CHANNEL_OPENED_STATE)
+		return -EINVAL;
 	hv_ringbuffer_get_debuginfo(&hv_dev->channel->outbound, &outbound);
 	return sprintf(buf, "%d\n", outbound.current_write_index);
 }
@@ -357,6 +363,8 @@ static ssize_t out_read_bytes_avail_show
 
 	if (!hv_dev->channel)
 		return -ENODEV;
+	if (hv_dev->channel->state != CHANNEL_OPENED_STATE)
+		return -EINVAL;
 	hv_ringbuffer_get_debuginfo(&hv_dev->channel->outbound, &outbound);
 	return sprintf(buf, "%d\n", outbound.bytes_avail_toread);
 }
@@ -371,6 +379,8 @@ static ssize_t out_write_bytes_avail_sho
 
 	if (!hv_dev->channel)
 		return -ENODEV;
+	if (hv_dev->channel->state != CHANNEL_OPENED_STATE)
+		return -EINVAL;
 	hv_ringbuffer_get_debuginfo(&hv_dev->channel->outbound, &outbound);
 	return sprintf(buf, "%d\n", outbound.bytes_avail_towrite);
 }
@@ -384,6 +394,8 @@ static ssize_t in_intr_mask_show(struct
 
 	if (!hv_dev->channel)
 		return -ENODEV;
+	if (hv_dev->channel->state != CHANNEL_OPENED_STATE)
+		return -EINVAL;
 	hv_ringbuffer_get_debuginfo(&hv_dev->channel->inbound, &inbound);
 	return sprintf(buf, "%d\n", inbound.current_interrupt_mask);
 }
@@ -397,6 +409,8 @@ static ssize_t in_read_index_show(struct
 
 	if (!hv_dev->channel)
 		return -ENODEV;
+	if (hv_dev->channel->state != CHANNEL_OPENED_STATE)
+		return -EINVAL;
 	hv_ringbuffer_get_debuginfo(&hv_dev->channel->inbound, &inbound);
 	return sprintf(buf, "%d\n", inbound.current_read_index);
 }
@@ -410,6 +424,8 @@ static ssize_t in_write_index_show(struc
 
 	if (!hv_dev->channel)
 		return -ENODEV;
+	if (hv_dev->channel->state != CHANNEL_OPENED_STATE)
+		return -EINVAL;
 	hv_ringbuffer_get_debuginfo(&hv_dev->channel->inbound, &inbound);
 	return sprintf(buf, "%d\n", inbound.current_write_index);
 }
@@ -424,6 +440,8 @@ static ssize_t in_read_bytes_avail_show(
 
 	if (!hv_dev->channel)
 		return -ENODEV;
+	if (hv_dev->channel->state != CHANNEL_OPENED_STATE)
+		return -EINVAL;
 	hv_ringbuffer_get_debuginfo(&hv_dev->channel->inbound, &inbound);
 	return sprintf(buf, "%d\n", inbound.bytes_avail_toread);
 }
@@ -438,6 +456,8 @@ static ssize_t in_write_bytes_avail_show
 
 	if (!hv_dev->channel)
 		return -ENODEV;
+	if (hv_dev->channel->state != CHANNEL_OPENED_STATE)
+		return -EINVAL;
 	hv_ringbuffer_get_debuginfo(&hv_dev->channel->inbound, &inbound);
 	return sprintf(buf, "%d\n", inbound.bytes_avail_towrite);
 }


