Return-Path: <SRS0=4YaO=K3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49685C46460
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 11:58:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECE52208EA
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 11:58:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECE52208EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728230AbeHLOg3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Aug 2018 10:36:29 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56902 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727801AbeHLOg3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Aug 2018 10:36:29 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0538C40122C4;
        Sun, 12 Aug 2018 11:58:40 +0000 (UTC)
Received: from rhel3.localdomain (ovpn-12-110.pek2.redhat.com [10.72.12.110])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 506E710EE77D;
        Sun, 12 Aug 2018 11:58:36 +0000 (UTC)
From:   xiubli@redhat.com
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, james.r.harris@intel.com,
        Xiubo Li <xiubli@redhat.com>, Ahsan Atta <ahsan.atta@intel.com>
Subject: [PATCH] Revert "uio: use request_threaded_irq instead"
Date:   Sun, 12 Aug 2018 07:58:23 -0400
Message-Id: <20180812115823.10377-1-xiubli@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Sun, 12 Aug 2018 11:58:40 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Sun, 12 Aug 2018 11:58:40 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'xiubli@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiubo Li <xiubli@redhat.com>

Since mutex lock in irq hanler is useless currently, here will
remove it together with it.

This reverts commit 9421e45f5ff3d558cf8b75a8cc0824530caf3453.

Reported-by: james.r.harris@intel.com
CC: Ahsan Atta <ahsan.atta@intel.com>
Signed-off-by: Xiubo Li <xiubli@redhat.com>
---
 drivers/uio/uio.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/uio/uio.c b/drivers/uio/uio.c
index 5d421d7..d7fb493 100644
--- a/drivers/uio/uio.c
+++ b/drivers/uio/uio.c
@@ -443,13 +443,10 @@ static irqreturn_t uio_interrupt(int irq, void *dev_id)
 	struct uio_device *idev = (struct uio_device *)dev_id;
 	irqreturn_t ret;
 
-	mutex_lock(&idev->info_lock);
-
 	ret = idev->info->handler(irq, idev->info);
 	if (ret == IRQ_HANDLED)
 		uio_event_notify(idev->info);
 
-	mutex_unlock(&idev->info_lock);
 	return ret;
 }
 
@@ -969,9 +966,8 @@ int __uio_register_device(struct module *owner,
 		 * FDs at the time of unregister and therefore may not be
 		 * freed until they are released.
 		 */
-		ret = request_threaded_irq(info->irq, NULL, uio_interrupt,
-					   info->irq_flags, info->name, idev);
-
+		ret = request_irq(info->irq, uio_interrupt,
+				  info->irq_flags, info->name, idev);
 		if (ret)
 			goto err_request_irq;
 	}
-- 
1.8.3.1

