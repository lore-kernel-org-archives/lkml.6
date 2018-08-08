Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E517C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 08:14:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C885216FA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 08:14:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C885216FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727195AbeHHKd1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 06:33:27 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:10643 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726979AbeHHKd1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 06:33:27 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id D48472BD272E0;
        Wed,  8 Aug 2018 16:14:49 +0800 (CST)
Received: from [10.177.253.249] (10.177.253.249) by smtp.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.399.0; Wed, 8 Aug 2018
 16:14:47 +0800
To:     Dominique Martinet <asmadeus@codewreck.org>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "Eric Van Hensbergen" <ericvh@gmail.com>,
        Ron Minnich <rminnich@sandia.gov>,
        "Latchesar Ionkov" <lucho@ionkov.net>, Greg Kurz <groug@kaod.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        <v9fs-developer@lists.sourceforge.net>
From:   piaojun <piaojun@huawei.com>
Subject: [PATCH] net/9p/trans_virtio.c: decrease the refcount of 9p virtio
 device when removing it
Message-ID: <5B6AA65E.3030907@huawei.com>
Date:   Wed, 8 Aug 2018 16:14:22 +0800
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

I found that 9pnet_virtio.ko could not be removed by rmmod command, and I
could still found it by lsmod. The reason is that we forgot decrease the
refcount of 9p virtio device by kobject_put. So we should put refcount in
p9_virtio_remove.

Signed-off-by: Jun Piao <piaojun@huawei.com>
---
 net/9p/trans_virtio.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/9p/trans_virtio.c b/net/9p/trans_virtio.c
index 46a5ab2..a00e992 100644
--- a/net/9p/trans_virtio.c
+++ b/net/9p/trans_virtio.c
@@ -710,7 +710,8 @@ static void p9_virtio_remove(struct virtio_device *vdev)
 	vdev->config->del_vqs(vdev);

 	sysfs_remove_file(&(vdev->dev.kobj), &dev_attr_mount_tag.attr);
-	kobject_uevent(&(vdev->dev.kobj), KOBJ_CHANGE);
+	kobject_uevent(&(vdev->dev.kobj), KOBJ_REMOVE);
+	kobject_put(&(vdev->dev.kobj));
 	kfree(chan->tag);
 	kfree(chan->vc_wq);
 	kfree(chan);
-- 
