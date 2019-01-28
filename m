Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05F9DC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:47:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA6F12177B
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548690438;
	bh=lEX+ia60M3djuw6C16E24APAvdXawfM5EyjrBZYoZK0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aybtonZ6YrgUKMm/0kgC1f2ljdZu3b3w7oJePklRfBnNKqpxmSSdfvtU9qTQU8C83
	 jKqhNK4i7f/FYGde82+F+EH5tHpflIvz/MW9BOfl34MY5XTr/XMu52VGa5UcDiIRaq
	 kGWCpdnmwTVceElaZzxZ89qtYNbkC2N254ui2JOg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728275AbfA1PrR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 10:47:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:60672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728256AbfA1PrO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:47:14 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3774121741;
        Mon, 28 Jan 2019 15:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548690433;
        bh=lEX+ia60M3djuw6C16E24APAvdXawfM5EyjrBZYoZK0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sRzptUX07mnAkOBnKO7o9la7UCpYZyRgNFdLoWaCd7INN5T9Is3DVTbbn5jevEgkl
         GIx7/sSA4+zOoAh6JkYywt2G98FVe2DYtTobQ9pVyPWJW3oC6mBfnUnC0l/Ulodmzq
         eB1vI8Mxoq2we+SrWphgXUTur2ii4uK5am5+BVv8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Michael Straube <straube.linux@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, devel@driverdev.osuosl.org
Subject: [PATCH AUTOSEL 4.20 084/304] staging: pi433: fix potential null dereference
Date:   Mon, 28 Jan 2019 10:40:01 -0500
Message-Id: <20190128154341.47195-84-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128154341.47195-1-sashal@kernel.org>
References: <20190128154341.47195-1-sashal@kernel.org>
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
index c85a805a1243..a497ec197872 100644
--- a/drivers/staging/pi433/pi433_if.c
+++ b/drivers/staging/pi433/pi433_if.c
@@ -1255,6 +1255,10 @@ static int pi433_probe(struct spi_device *spi)
 
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

