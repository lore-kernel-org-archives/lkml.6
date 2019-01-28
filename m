Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2893C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:04:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8199521741
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548695068;
	bh=Jd9siYbfidK9R05xIFwqmHsl0B60h3vU3w7S5XqbY5w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DwXio7wm3J1AwDr3pNihCOod6/1LwWk476TRwQ4WPrOJZHXTb9i6qJXhM7c+2jdcs
	 znax9JpE/Zse8JQVqn3dU7XU6lVMLwGjE1cW/jx6C855a/tBKtsvWnIZ4+dbOxH7ct
	 U/qnHmJHcb0RteKrrxcxPIVKt51KXKBb+/uigL/8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387499AbfA1RE0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 12:04:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:42714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732549AbfA1QNv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:13:51 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E1EFD2147A;
        Mon, 28 Jan 2019 16:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548692031;
        bh=Jd9siYbfidK9R05xIFwqmHsl0B60h3vU3w7S5XqbY5w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ahNK3dI8KaG4RgQ4D6MsUNuhevO4PBAfF/+UFcfxbf1IXMUWFw8YbuymRJhUo/te3
         KDs2so+mSuCbHdvcHMlZx11IimY7/F9jaTxFK0bLuXqpJiaMrbf9MuqD37MQw17WTM
         eTjksOJng8pkdGmzbtbQxaq4Xukkds845F1Gs1rk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Michael Straube <straube.linux@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, devel@driverdev.osuosl.org
Subject: [PATCH AUTOSEL 4.14 044/170] staging: pi433: fix potential null dereference
Date:   Mon, 28 Jan 2019 11:09:54 -0500
Message-Id: <20190128161200.55107-44-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128161200.55107-1-sashal@kernel.org>
References: <20190128161200.55107-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Straube <straube.linux@gmail.com>

[ Upstream commit 64c4c4ca6c129a4191e8e1e91b2d5d9b8d08c518 ]

Add a test for successful call to cdev_alloc() to avoid
potential null dereference. Issue reported by smatch.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
Fixes: 874bcba65f9a ("staging: pi433: New driver")
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/pi433/pi433_if.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/staging/pi433/pi433_if.c b/drivers/staging/pi433/pi433_if.c
index 93c01680f016..5be40bdc191b 100644
--- a/drivers/staging/pi433/pi433_if.c
+++ b/drivers/staging/pi433/pi433_if.c
@@ -1210,6 +1210,10 @@ static int pi433_probe(struct spi_device *spi)
 
 	/* create cdev */
 	device->cdev = cdev_alloc();
+	if (!device->cdev) {
+		dev_dbg(device->dev, "allocation of cdev failed");
+		goto cdev_failed;
+	}
 	device->cdev->owner = THIS_MODULE;
 	cdev_init(device->cdev, &pi433_fops);
 	retval = cdev_add(device->cdev, device->devt, 1);
-- 
2.19.1

