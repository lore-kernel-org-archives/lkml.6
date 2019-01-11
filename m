Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F26E2C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:18:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCCD82177B
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547216296;
	bh=R54gWuY83Skfplo0UwTgLVDNUsRLSivCQc7qGA0dIs8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=C1QuPLjMmofE1gAB2Ya8lYKfTkxHValJxVv/q1wqyGgDmyonXmzSYRzx7r5aCSB1J
	 HuPKtu4NQCeGc7UNI+oA/6KldoAkdqEd/FeM/PGW4ev2CPYWO+w0DdK4zgj1kpAHQa
	 2ozYx1d5KJx8iNJY7y9wFHiao9SsKQRI4gCcxKnk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730154AbfAKOSQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:18:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:34630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387954AbfAKOSL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:18:11 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E75012177B;
        Fri, 11 Jan 2019 14:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547216290;
        bh=R54gWuY83Skfplo0UwTgLVDNUsRLSivCQc7qGA0dIs8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wdTi5YGLLX+okPWwXQB5QQvk6E4MDBzXnEdSAC1grIcutqiDlmufJjQ35ddknnuqh
         VXx4JDOWKvOq1mnzp7yDuH8jrn73Nd2XWwweuvdfLw1My3cqrG3mUROW+FgiM9Jf0C
         ucspbLHjzmolBmvZoJs4p+qmwssVMqXuxXw9Dpm8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 11/88] Drivers: hv: vmbus: Return -EINVAL for the sys files for unopened channels
Date:   Fri, 11 Jan 2019 15:07:40 +0100
Message-Id: <20190111131047.857135317@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131045.137499039@linuxfoundation.org>
References: <20190111131045.137499039@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

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


