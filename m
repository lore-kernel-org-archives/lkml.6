Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B445AECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:45:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79BFD2075B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:45:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79BFD2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389666AbeGPILk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 04:11:40 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49982 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389111AbeGPILj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 04:11:39 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 9F7BFCA4;
        Mon, 16 Jul 2018 07:45:35 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        syzbot 
        <syzbot+9f03168400f56df89dbc6f1751f4458fe739ff29@syzkaller.appspotmail.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.4 43/43] loop: remember whether sysfs_create_group() was done
Date:   Mon, 16 Jul 2018 09:36:48 +0200
Message-Id: <20180716073516.619912920@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180716073511.796555857@linuxfoundation.org>
References: <20180716073511.796555857@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

commit d3349b6b3c373ac1fbfb040b810fcee5e2adc7e0 upstream.

syzbot is hitting WARN() triggered by memory allocation fault
injection [1] because loop module is calling sysfs_remove_group()
when sysfs_create_group() failed.
Fix this by remembering whether sysfs_create_group() succeeded.

[1] https://syzkaller.appspot.com/bug?id=3f86c0edf75c86d2633aeb9dd69eccc70bc7e90b

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Reported-by: syzbot <syzbot+9f03168400f56df89dbc6f1751f4458fe739ff29@syzkaller.appspotmail.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Renamed sysfs_ready -> sysfs_inited.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/block/loop.c |   11 ++++++-----
 drivers/block/loop.h |    1 +
 2 files changed, 7 insertions(+), 5 deletions(-)

--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -835,16 +835,17 @@ static struct attribute_group loop_attri
 	.attrs= loop_attrs,
 };
 
-static int loop_sysfs_init(struct loop_device *lo)
+static void loop_sysfs_init(struct loop_device *lo)
 {
-	return sysfs_create_group(&disk_to_dev(lo->lo_disk)->kobj,
-				  &loop_attribute_group);
+	lo->sysfs_inited = !sysfs_create_group(&disk_to_dev(lo->lo_disk)->kobj,
+						&loop_attribute_group);
 }
 
 static void loop_sysfs_exit(struct loop_device *lo)
 {
-	sysfs_remove_group(&disk_to_dev(lo->lo_disk)->kobj,
-			   &loop_attribute_group);
+	if (lo->sysfs_inited)
+		sysfs_remove_group(&disk_to_dev(lo->lo_disk)->kobj,
+				   &loop_attribute_group);
 }
 
 static void loop_config_discard(struct loop_device *lo)
--- a/drivers/block/loop.h
+++ b/drivers/block/loop.h
@@ -59,6 +59,7 @@ struct loop_device {
 	struct kthread_worker	worker;
 	struct task_struct	*worker_task;
 	bool			use_dio;
+	bool			sysfs_inited;
 
 	struct request_queue	*lo_queue;
 	struct blk_mq_tag_set	tag_set;


