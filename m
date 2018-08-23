Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2543BC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 02:25:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA205206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 02:25:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA205206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbeHWFwj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 01:52:39 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:11161 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726121AbeHWFwi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 01:52:38 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 350882E8E8691;
        Thu, 23 Aug 2018 10:25:14 +0800 (CST)
Received: from [10.177.253.249] (10.177.253.249) by smtp.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.399.0; Thu, 23 Aug 2018
 10:25:13 +0800
To:     <stefanha@linux.vnet.ibm.com>, <pbonzini@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, <rusty@rustcorp.com.au>,
        <kvm@vger.kernel.org>, <penberg@kernel.org>, <mst@redhat.com>,
        <stefanha@linux.vnet.ibm.com>, <michaelc@cs.wisc.edu>
From:   piaojun <piaojun@huawei.com>
Subject: [PATCH] scsi/virio_scsi.c: do not call virtscsi_remove_vqs() in
 virtscsi_init() to avoid crash bug
Message-ID: <5B7E1AFA.8030506@huawei.com>
Date:   Thu, 23 Aug 2018 10:24:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.253.249]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If some error happened before find_vqs, error branch will goto
virtscsi_remove_vqs to free vqs. Actually the vqs have not been allocated
successfully, so this will cause wild-pointer-free problem. So
virtscsi_remove_vqs could be deleted as no error will happen after
find_vqs.

Signed-off-by: Jun Piao <piaojun@huawei.com>
---
 drivers/scsi/virtio_scsi.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/scsi/virtio_scsi.c b/drivers/scsi/virtio_scsi.c
index 1c72db9..da0fd74 100644
--- a/drivers/scsi/virtio_scsi.c
+++ b/drivers/scsi/virtio_scsi.c
@@ -833,8 +833,6 @@ static int virtscsi_init(struct virtio_device *vdev,
 	kfree(names);
 	kfree(callbacks);
 	kfree(vqs);
-	if (err)
-		virtscsi_remove_vqs(vdev);
 	return err;
 }

-- 
