Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E065C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:39:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 020042147A
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:39:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 020042147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731799AbeHWMHl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:07:41 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49272 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730680AbeHWMHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:07:41 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E5EC8941;
        Thu, 23 Aug 2018 08:39:05 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 002/324] vfio: ccw: fix error return in vfio_ccw_sch_event
Date:   Thu, 23 Aug 2018 09:51:08 +0200
Message-Id: <20180823074956.023039639@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823074955.885811006@linuxfoundation.org>
References: <20180823074955.885811006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>

[ Upstream commit 2c861d89ccda2fbcea9358eff9cc5f8fae548be5 ]

If the device has not been registered, or there is work pending,
we should reschedule a sch_event call again.

Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Message-Id: <20180502072559.50691-1-bjsdjshi@linux.vnet.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/s390/cio/vfio_ccw_drv.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/s390/cio/vfio_ccw_drv.c
+++ b/drivers/s390/cio/vfio_ccw_drv.c
@@ -177,6 +177,7 @@ static int vfio_ccw_sch_event(struct sub
 {
 	struct vfio_ccw_private *private = dev_get_drvdata(&sch->dev);
 	unsigned long flags;
+	int rc = -EAGAIN;
 
 	spin_lock_irqsave(sch->lock, flags);
 	if (!device_is_registered(&sch->dev))
@@ -187,6 +188,7 @@ static int vfio_ccw_sch_event(struct sub
 
 	if (cio_update_schib(sch)) {
 		vfio_ccw_fsm_event(private, VFIO_CCW_EVENT_NOT_OPER);
+		rc = 0;
 		goto out_unlock;
 	}
 
@@ -195,11 +197,12 @@ static int vfio_ccw_sch_event(struct sub
 		private->state = private->mdev ? VFIO_CCW_STATE_IDLE :
 				 VFIO_CCW_STATE_STANDBY;
 	}
+	rc = 0;
 
 out_unlock:
 	spin_unlock_irqrestore(sch->lock, flags);
 
-	return 0;
+	return rc;
 }
 
 static struct css_device_id vfio_ccw_sch_ids[] = {


