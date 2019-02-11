Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D110C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:25:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEA0E20821
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549895123;
	bh=XMVLi8YD2vSIedJuozVCeKF463CULcOVzWiHS/CEM6w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yMewt2Q7EhUmUuljBslihzNwigKunyxeN06CsQ+d0nXC4TlQXH49dd6xBdNpxxOUv
	 44K6nEB3L/0Z8x6TmeX3s1Mv/n0LWxwC5qB8F9zeSrFereal2YBOCx7r/0dwVtu4Ky
	 WiM+/kpSp/+qYkasdHDIg1BPdFr1U1IjHiWj8d20=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728226AbfBKOZV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:25:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:58582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727216AbfBKOZL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:25:11 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9799B214DA;
        Mon, 11 Feb 2019 14:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549895111;
        bh=XMVLi8YD2vSIedJuozVCeKF463CULcOVzWiHS/CEM6w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PGT3AMfEPSsk0DDJoXnwyoJAJWDWERfL5ZBSqkiOvOAXI9oBbyD9FQ5VUBSm2OzMV
         De+RrnriWHJBXhj+NeBvXJHtwFXtSkZhF3LTD3d0he5j5LpxCK5HLdNU3FoV/hUzb4
         +MjUg6EcuunnDjE0+v7CVxjhzt7HPT+HQg3KWSn4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Straube <straube.linux@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 078/352] staging: pi433: fix potential null dereference
Date:   Mon, 11 Feb 2019 15:15:05 +0100
Message-Id: <20190211141851.007917054@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141846.543045703@linuxfoundation.org>
References: <20190211141846.543045703@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

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



