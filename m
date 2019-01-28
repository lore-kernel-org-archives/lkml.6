Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 352D6C282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:47:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0320D20881
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548697673;
	bh=esv+EdMCQy0cPNaNgsVFGABGGVt/+wVRs+i6cufiYwk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Yu2B03Yy7bFpdvu1ZNmAidgnmAmNvCOmPvctqQr1sdYCReNCKXi8wouJ1bFHKTOqu
	 lPU6fexW/nrnS+tZobYZlHJ5ipWahyQlBWnoxYGgtCcCvxwQpv4kO1h4gKUJjU3q/s
	 g1Kvuxiee05RLxX2BUmMQaNIqqaC+4GT+TDYSIGw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728220AbfA1Rrv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 12:47:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:59418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727906AbfA1Pp7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:45:59 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B0A9B2147A;
        Mon, 28 Jan 2019 15:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548690359;
        bh=esv+EdMCQy0cPNaNgsVFGABGGVt/+wVRs+i6cufiYwk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Kp2Oa902J1lSxXZ7m9jcXZPX6qZt2bGgVkjvXxDpGdOJdnJunM6DPV1odHlGTlTC8
         EuWqgjmF3f4JFZAH5nyyaTFx+euF0oSQY725RuACb/gOKSyAxHx1AkRONtUA5Q2mU6
         D2Ld+UdZFE7G5Fvrj4Nm+u/4f5urGt4MuRBV1sGY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sean Young <sean@mess.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 063/304] media: rc: ensure close() is called on rc_unregister_device
Date:   Mon, 28 Jan 2019 10:39:40 -0500
Message-Id: <20190128154341.47195-63-sashal@kernel.org>
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

From: Sean Young <sean@mess.org>

[ Upstream commit 8e782fcf78275f505194e767c515202d4fd274bc ]

If userspace has an open file descriptor on the rc input device or lirc
device when rc_unregister_device() is called, then the rc close() is
never called.

This ensures that the receiver is turned off on the nuvoton-cir driver
during shutdown.

Signed-off-by: Sean Young <sean@mess.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/rc/rc-main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/rc/rc-main.c b/drivers/media/rc/rc-main.c
index 877978dbd409..66a174979b3c 100644
--- a/drivers/media/rc/rc-main.c
+++ b/drivers/media/rc/rc-main.c
@@ -1952,6 +1952,8 @@ void rc_unregister_device(struct rc_dev *dev)
 	rc_free_rx_device(dev);
 
 	mutex_lock(&dev->lock);
+	if (dev->users && dev->close)
+		dev->close(dev);
 	dev->registered = false;
 	mutex_unlock(&dev->lock);
 
-- 
2.19.1

