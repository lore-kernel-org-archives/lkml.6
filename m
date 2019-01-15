Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B23EEC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:40:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 810BD20859
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547570434;
	bh=WC+sGfMcIuUsts2eGa++BW2yjuahfSlVXhhuzpihm7c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xBf0ZcDLvIF7i4IdVl5lPLGwuXQ8ZkAaAZJQMEmd7N3dHOjWKGm2IAcacv4pNEKKU
	 Bh4CgvzyblGl0Lurpyfx73MLDsdB051+Y3nlit0k1vmvIh9XdFtjFEqAaKhf4BC1G1
	 QMOQaPBFgo5HwLP2Lgg8RDQ3j8h9I8NIb7BxLsrs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732625AbfAOQkd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 11:40:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:56902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730179AbfAOQka (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 11:40:30 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9967C20675;
        Tue, 15 Jan 2019 16:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547570430;
        bh=WC+sGfMcIuUsts2eGa++BW2yjuahfSlVXhhuzpihm7c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZM8gcpTj35b9+sJTENAQ+P4AZ6EgYpTCSdljXO5MwhN34BPZRAsUIWk3xfs93NUEU
         JBFVbNeznIJdrUAO5kygwulLfkha4HAVhfsc8rSiqudn92zE2c3zcIa5DBxF9umqOL
         4/GfrOlnvAW4kjla8sq+o4pFb7sn2lTptMyYzoBM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ilya Dryomov <idryomov@gmail.com>,
        Dongsheng Yang <dongsheng.yang@easystack.cn>
Subject: [PATCH 4.14 20/27] rbd: dont return 0 on unmap if RBD_DEV_FLAG_REMOVING is set
Date:   Tue, 15 Jan 2019 17:36:09 +0100
Message-Id: <20190115154902.545773817@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190115154901.189747728@linuxfoundation.org>
References: <20190115154901.189747728@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ilya Dryomov <idryomov@gmail.com>

commit 85f5a4d666fd9be73856ed16bb36c5af5b406b29 upstream.

There is a window between when RBD_DEV_FLAG_REMOVING is set and when
the device is removed from rbd_dev_list.  During this window, we set
"already" and return 0.

Returning 0 from write(2) can confuse userspace tools because
0 indicates that nothing was written.  In particular, "rbd unmap"
will retry the write multiple times a second:

  10:28:05.463299 write(4, "0", 1)        = 0
  10:28:05.463509 write(4, "0", 1)        = 0
  10:28:05.463720 write(4, "0", 1)        = 0
  10:28:05.463942 write(4, "0", 1)        = 0
  10:28:05.464155 write(4, "0", 1)        = 0

Cc: stable@vger.kernel.org
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Tested-by: Dongsheng Yang <dongsheng.yang@easystack.cn>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/block/rbd.c |    9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -6308,7 +6308,6 @@ static ssize_t do_rbd_remove(struct bus_
 	struct list_head *tmp;
 	int dev_id;
 	char opt_buf[6];
-	bool already = false;
 	bool force = false;
 	int ret;
 
@@ -6341,13 +6340,13 @@ static ssize_t do_rbd_remove(struct bus_
 		spin_lock_irq(&rbd_dev->lock);
 		if (rbd_dev->open_count && !force)
 			ret = -EBUSY;
-		else
-			already = test_and_set_bit(RBD_DEV_FLAG_REMOVING,
-							&rbd_dev->flags);
+		else if (test_and_set_bit(RBD_DEV_FLAG_REMOVING,
+					  &rbd_dev->flags))
+			ret = -EINPROGRESS;
 		spin_unlock_irq(&rbd_dev->lock);
 	}
 	spin_unlock(&rbd_dev_list_lock);
-	if (ret < 0 || already)
+	if (ret)
 		return ret;
 
 	if (force) {


