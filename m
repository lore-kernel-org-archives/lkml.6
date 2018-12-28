Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75CE7C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 12:17:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 485F42148E
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 12:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545999455;
	bh=wUwE9SvCBqBcyktQSNZb3gccuREclHr+BCDeLBIVrOE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wYgdoPGYxyJZC5JlHYS1u2QPTVWADckON1XvuuXrOL43OA7+cUb3avCfdI3Haw+OJ
	 rpF0laTi7Fvanm/II4f3HRFxrlcDPi24bEfkMbeIG6Ef12ycHz686Cv8tAZlbAzOmP
	 OxdwXRcieBuKNRbYH5f73czoqdDqPZalvzlyMNF8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732969AbeL1MRe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 07:17:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:36562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728177AbeL1MRc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 07:17:32 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD57920675;
        Fri, 28 Dec 2018 12:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545999451;
        bh=wUwE9SvCBqBcyktQSNZb3gccuREclHr+BCDeLBIVrOE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DcGBUnbtcifGJsOPu8QDZUtaHuarmUAcKrbO368fchPBMJMHKZELCF+fkw6ebSErL
         M2BGm9uT62PgXYVR3932mF603o8QJ6DZwLHlpSqVSB90APiH3jjxn8dMr1xYCyV4OO
         xm4kULOx8VO9dvd6m8/8KgOlESq/Ac1/b/xPDS3Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 16/22] Drivers: hv: vmbus: Return -EINVAL for the sys files for unopened channels
Date:   Fri, 28 Dec 2018 12:52:53 +0100
Message-Id: <20181228113127.284712177@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181228113126.144310132@linuxfoundation.org>
References: <20181228113126.144310132@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -317,6 +317,8 @@ static ssize_t out_intr_mask_show(struct
 
 	if (!hv_dev->channel)
 		return -ENODEV;
+	if (hv_dev->channel->state != CHANNEL_OPENED_STATE)
+		return -EINVAL;
 	hv_ringbuffer_get_debuginfo(&hv_dev->channel->outbound, &outbound);
 	return sprintf(buf, "%d\n", outbound.current_interrupt_mask);
 }
@@ -330,6 +332,8 @@ static ssize_t out_read_index_show(struc
 
 	if (!hv_dev->channel)
 		return -ENODEV;
+	if (hv_dev->channel->state != CHANNEL_OPENED_STATE)
+		return -EINVAL;
 	hv_ringbuffer_get_debuginfo(&hv_dev->channel->outbound, &outbound);
 	return sprintf(buf, "%d\n", outbound.current_read_index);
 }
@@ -344,6 +348,8 @@ static ssize_t out_write_index_show(stru
 
 	if (!hv_dev->channel)
 		return -ENODEV;
+	if (hv_dev->channel->state != CHANNEL_OPENED_STATE)
+		return -EINVAL;
 	hv_ringbuffer_get_debuginfo(&hv_dev->channel->outbound, &outbound);
 	return sprintf(buf, "%d\n", outbound.current_write_index);
 }
@@ -358,6 +364,8 @@ static ssize_t out_read_bytes_avail_show
 
 	if (!hv_dev->channel)
 		return -ENODEV;
+	if (hv_dev->channel->state != CHANNEL_OPENED_STATE)
+		return -EINVAL;
 	hv_ringbuffer_get_debuginfo(&hv_dev->channel->outbound, &outbound);
 	return sprintf(buf, "%d\n", outbound.bytes_avail_toread);
 }
@@ -372,6 +380,8 @@ static ssize_t out_write_bytes_avail_sho
 
 	if (!hv_dev->channel)
 		return -ENODEV;
+	if (hv_dev->channel->state != CHANNEL_OPENED_STATE)
+		return -EINVAL;
 	hv_ringbuffer_get_debuginfo(&hv_dev->channel->outbound, &outbound);
 	return sprintf(buf, "%d\n", outbound.bytes_avail_towrite);
 }
@@ -385,6 +395,8 @@ static ssize_t in_intr_mask_show(struct
 
 	if (!hv_dev->channel)
 		return -ENODEV;
+	if (hv_dev->channel->state != CHANNEL_OPENED_STATE)
+		return -EINVAL;
 	hv_ringbuffer_get_debuginfo(&hv_dev->channel->inbound, &inbound);
 	return sprintf(buf, "%d\n", inbound.current_interrupt_mask);
 }
@@ -398,6 +410,8 @@ static ssize_t in_read_index_show(struct
 
 	if (!hv_dev->channel)
 		return -ENODEV;
+	if (hv_dev->channel->state != CHANNEL_OPENED_STATE)
+		return -EINVAL;
 	hv_ringbuffer_get_debuginfo(&hv_dev->channel->inbound, &inbound);
 	return sprintf(buf, "%d\n", inbound.current_read_index);
 }
@@ -411,6 +425,8 @@ static ssize_t in_write_index_show(struc
 
 	if (!hv_dev->channel)
 		return -ENODEV;
+	if (hv_dev->channel->state != CHANNEL_OPENED_STATE)
+		return -EINVAL;
 	hv_ringbuffer_get_debuginfo(&hv_dev->channel->inbound, &inbound);
 	return sprintf(buf, "%d\n", inbound.current_write_index);
 }
@@ -425,6 +441,8 @@ static ssize_t in_read_bytes_avail_show(
 
 	if (!hv_dev->channel)
 		return -ENODEV;
+	if (hv_dev->channel->state != CHANNEL_OPENED_STATE)
+		return -EINVAL;
 	hv_ringbuffer_get_debuginfo(&hv_dev->channel->inbound, &inbound);
 	return sprintf(buf, "%d\n", inbound.bytes_avail_toread);
 }
@@ -439,6 +457,8 @@ static ssize_t in_write_bytes_avail_show
 
 	if (!hv_dev->channel)
 		return -ENODEV;
+	if (hv_dev->channel->state != CHANNEL_OPENED_STATE)
+		return -EINVAL;
 	hv_ringbuffer_get_debuginfo(&hv_dev->channel->inbound, &inbound);
 	return sprintf(buf, "%d\n", inbound.bytes_avail_towrite);
 }


