Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76D65C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 12:16:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4524321902
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 12:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545999383;
	bh=E4KkI7V7ZX3GCmH81d76zp2LPGzqEeZcsoMQRbSau/Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=m8TAokNl5eVpxNKHCLud1SeXWohCnasg/UBgCQed5RgJvAe191FPmozYWrXkgt4jj
	 gaO5W2aKDRbncunZ8z7P6xZU6fJcilgMnwYPlz6eYU2nuygdsvNnWgDh5PwAr4b4la
	 tkLTKiUAL8bIDWJi+d65nvW9JzXE7kU5jMdIoCUA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732677AbeL1MQW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 07:16:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:35380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732662AbeL1MQT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 07:16:19 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F323A218FD;
        Fri, 28 Dec 2018 12:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545999378;
        bh=E4KkI7V7ZX3GCmH81d76zp2LPGzqEeZcsoMQRbSau/Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CK/QtOELZtSnaS7i93nERZhiTCNCBuSCxVlQQe7SNguZEPlsq/FDgAHFcrlesONq7
         IU55vC7w+k9ZcsLj1u38fIsGOP6/e+xL3oY0sB/WHNPJNTbF8mj7E0I4uUDm6RQJcO
         p8oCFejHvo3LsFTFAJyreXHiOBZs97BTCQZ94K8w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 26/36] Drivers: hv: vmbus: Return -EINVAL for the sys files for unopened channels
Date:   Fri, 28 Dec 2018 12:52:42 +0100
Message-Id: <20181228113128.324394005@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181228113126.526729877@linuxfoundation.org>
References: <20181228113126.526729877@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -300,6 +300,8 @@ static ssize_t out_intr_mask_show(struct
 
 	if (!hv_dev->channel)
 		return -ENODEV;
+	if (hv_dev->channel->state != CHANNEL_OPENED_STATE)
+		return -EINVAL;
 	hv_ringbuffer_get_debuginfo(&hv_dev->channel->outbound, &outbound);
 	return sprintf(buf, "%d\n", outbound.current_interrupt_mask);
 }
@@ -313,6 +315,8 @@ static ssize_t out_read_index_show(struc
 
 	if (!hv_dev->channel)
 		return -ENODEV;
+	if (hv_dev->channel->state != CHANNEL_OPENED_STATE)
+		return -EINVAL;
 	hv_ringbuffer_get_debuginfo(&hv_dev->channel->outbound, &outbound);
 	return sprintf(buf, "%d\n", outbound.current_read_index);
 }
@@ -327,6 +331,8 @@ static ssize_t out_write_index_show(stru
 
 	if (!hv_dev->channel)
 		return -ENODEV;
+	if (hv_dev->channel->state != CHANNEL_OPENED_STATE)
+		return -EINVAL;
 	hv_ringbuffer_get_debuginfo(&hv_dev->channel->outbound, &outbound);
 	return sprintf(buf, "%d\n", outbound.current_write_index);
 }
@@ -341,6 +347,8 @@ static ssize_t out_read_bytes_avail_show
 
 	if (!hv_dev->channel)
 		return -ENODEV;
+	if (hv_dev->channel->state != CHANNEL_OPENED_STATE)
+		return -EINVAL;
 	hv_ringbuffer_get_debuginfo(&hv_dev->channel->outbound, &outbound);
 	return sprintf(buf, "%d\n", outbound.bytes_avail_toread);
 }
@@ -355,6 +363,8 @@ static ssize_t out_write_bytes_avail_sho
 
 	if (!hv_dev->channel)
 		return -ENODEV;
+	if (hv_dev->channel->state != CHANNEL_OPENED_STATE)
+		return -EINVAL;
 	hv_ringbuffer_get_debuginfo(&hv_dev->channel->outbound, &outbound);
 	return sprintf(buf, "%d\n", outbound.bytes_avail_towrite);
 }
@@ -368,6 +378,8 @@ static ssize_t in_intr_mask_show(struct
 
 	if (!hv_dev->channel)
 		return -ENODEV;
+	if (hv_dev->channel->state != CHANNEL_OPENED_STATE)
+		return -EINVAL;
 	hv_ringbuffer_get_debuginfo(&hv_dev->channel->inbound, &inbound);
 	return sprintf(buf, "%d\n", inbound.current_interrupt_mask);
 }
@@ -381,6 +393,8 @@ static ssize_t in_read_index_show(struct
 
 	if (!hv_dev->channel)
 		return -ENODEV;
+	if (hv_dev->channel->state != CHANNEL_OPENED_STATE)
+		return -EINVAL;
 	hv_ringbuffer_get_debuginfo(&hv_dev->channel->inbound, &inbound);
 	return sprintf(buf, "%d\n", inbound.current_read_index);
 }
@@ -394,6 +408,8 @@ static ssize_t in_write_index_show(struc
 
 	if (!hv_dev->channel)
 		return -ENODEV;
+	if (hv_dev->channel->state != CHANNEL_OPENED_STATE)
+		return -EINVAL;
 	hv_ringbuffer_get_debuginfo(&hv_dev->channel->inbound, &inbound);
 	return sprintf(buf, "%d\n", inbound.current_write_index);
 }
@@ -408,6 +424,8 @@ static ssize_t in_read_bytes_avail_show(
 
 	if (!hv_dev->channel)
 		return -ENODEV;
+	if (hv_dev->channel->state != CHANNEL_OPENED_STATE)
+		return -EINVAL;
 	hv_ringbuffer_get_debuginfo(&hv_dev->channel->inbound, &inbound);
 	return sprintf(buf, "%d\n", inbound.bytes_avail_toread);
 }
@@ -422,6 +440,8 @@ static ssize_t in_write_bytes_avail_show
 
 	if (!hv_dev->channel)
 		return -ENODEV;
+	if (hv_dev->channel->state != CHANNEL_OPENED_STATE)
+		return -EINVAL;
 	hv_ringbuffer_get_debuginfo(&hv_dev->channel->inbound, &inbound);
 	return sprintf(buf, "%d\n", inbound.bytes_avail_towrite);
 }


