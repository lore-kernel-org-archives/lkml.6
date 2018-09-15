Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67773ECE562
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:43:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0455A20866
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:43:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0455A20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729063AbeIOHAj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 03:00:39 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:38839 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725746AbeIOHAi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 03:00:38 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 06B2C43DFC8C8;
        Sat, 15 Sep 2018 09:43:33 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.399.0; Sat, 15 Sep 2018 09:43:26 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     David Airlie <airlied@linux.ie>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Sean Paul <seanpaul@chromium.org>,
        Mahesh Kumar <mahesh1.kumar@intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>
CC:     Wei Yongjun <weiyongjun1@huawei.com>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] drm/vkms: Fix possible memory leak in _vkms_get_crc()
Date:   Sat, 15 Sep 2018 01:53:19 +0000
Message-ID: <1536976399-1295-1-git-send-email-weiyongjun1@huawei.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'vaddr_out' is malloced in _vkms_get_crc() and should be freed before
leaving from the error handling cases, otherwise it will cause memory
leak.

Fixes: db7f419c06d7 ("drm/vkms: Compute CRC with Cursor Plane")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/gpu/drm/vkms/vkms_crc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/vkms/vkms_crc.c b/drivers/gpu/drm/vkms/vkms_crc.c
index 0a27456..9d9e814 100644
--- a/drivers/gpu/drm/vkms/vkms_crc.c
+++ b/drivers/gpu/drm/vkms/vkms_crc.c
@@ -125,6 +125,7 @@ static uint32_t _vkms_get_crc(struct vkms_crc_data *primary_crc,
 	mutex_lock(&vkms_obj->pages_lock);
 	if (WARN_ON(!vkms_obj->vaddr)) {
 		mutex_unlock(&vkms_obj->pages_lock);
+		kfree(vaddr_out);
 		return crc;
 	}

