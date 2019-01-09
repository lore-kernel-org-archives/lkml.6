Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1CF1C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 10:56:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F33020883
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 10:56:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730446AbfAIK4p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 05:56:45 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:18692 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729752AbfAIK4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 05:56:45 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x09AuXCu015374;
        Wed, 9 Jan 2019 11:56:40 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2ptwtdkd8a-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 09 Jan 2019 11:56:40 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B27C134;
        Wed,  9 Jan 2019 10:56:39 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas23.st.com [10.75.90.46])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 890A027EF;
        Wed,  9 Jan 2019 10:56:39 +0000 (GMT)
Received: from SAFEX1HUBCAS21.st.com (10.75.90.45) by SAFEX1HUBCAS23.st.com
 (10.75.90.46) with Microsoft SMTP Server (TLS) id 14.3.361.1; Wed, 9 Jan 2019
 11:56:38 +0100
Received: from localhost (10.201.20.178) by Webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.361.1; Wed, 9 Jan 2019 11:56:38
 +0100
From:   Loic Pallardy <loic.pallardy@st.com>
To:     <bjorn.andersson@linaro.org>, <ohad@wizery.com>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <arnaud.pouliquen@st.com>, <benjamin.gaignard@linaro.org>,
        <s-anna@ti.com>, <xiaoxiang781216@gmail.com>,
        Loic Pallardy <loic.pallardy@st.com>
Subject: [PATCH 1/1] remoteproc: fix recovery procedure
Date:   Wed, 9 Jan 2019 11:56:43 +0100
Message-ID: <1547031403-34535-1-git-send-email-loic.pallardy@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.20.178]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-09_06:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 7e83cab824a87e83cab824a8 ("remoteproc: Modify recovery path
to use rproc_{start,stop}()") replaces rproc_{shutdown,boot}() with
rproc_{stop,start}(), which skips destroy the virtio device at stop
but re-initializes it again at start.

Issue is that struct virtio_dev is not correctly reinitialized like done
at initial allocation thanks to kzalloc() and kobject is considered as
already initialized by kernel. That is due to the fact struct virtio_dev
is allocated and released at vdev resource handling level managed and
virtio device is registered and unregistered at rproc subdevices level.

This patch initializes struct virtio_dev to 0 before using it and
registering it.

Fixes: 7e83cab824a8 ("remoteproc: Modify recovery path to use rproc_{start,stop}()")

Reported-by: Xiang Xiao <xiaoxiang781216@gmail.com>
Signed-off-by: Loic Pallardy <loic.pallardy@st.com>
---
 drivers/remoteproc/remoteproc_virtio.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/remoteproc/remoteproc_virtio.c b/drivers/remoteproc/remoteproc_virtio.c
index 183fc42a510a..88eade99395c 100644
--- a/drivers/remoteproc/remoteproc_virtio.c
+++ b/drivers/remoteproc/remoteproc_virtio.c
@@ -332,6 +332,8 @@ int rproc_add_virtio_dev(struct rproc_vdev *rvdev, int id)
 	struct virtio_device *vdev = &rvdev->vdev;
 	int ret;
 
+	/* Reset vdev struct as you don't know how it has been previously used */
+	memset(vdev, 0, sizeof(struct virtio_device));
 	vdev->id.device	= id,
 	vdev->config = &rproc_virtio_config_ops,
 	vdev->dev.parent = dev;
-- 
2.7.4

