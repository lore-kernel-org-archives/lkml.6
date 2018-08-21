Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F1B7C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 06:22:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8AB421774
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 06:22:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8AB421774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727260AbeHUJlm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 05:41:42 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:54768 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726628AbeHUJll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 05:41:41 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A50789D7;
        Tue, 21 Aug 2018 06:22:55 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, james.r.harris@intel.com,
        Ahsan Atta <ahsan.atta@intel.com>
Subject: [PATCH 4.18 26/35] Revert "uio: use request_threaded_irq instead"
Date:   Tue, 21 Aug 2018 08:20:52 +0200
Message-Id: <20180821055021.123920436@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180821055019.954904905@linuxfoundation.org>
References: <20180821055019.954904905@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xiubo Li <xiubli@redhat.com>

commit 3d27c4de8d4fb2d4099ff324671792aa2578c6f9 upstream.

Since mutex lock in irq hanler is useless currently, here will
remove it together with it.

This reverts commit 9421e45f5ff3d558cf8b75a8cc0824530caf3453.

Reported-by: james.r.harris@intel.com
CC: Ahsan Atta <ahsan.atta@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/uio/uio.c |    8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

--- a/drivers/uio/uio.c
+++ b/drivers/uio/uio.c
@@ -443,13 +443,10 @@ static irqreturn_t uio_interrupt(int irq
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
 
@@ -969,9 +966,8 @@ int __uio_register_device(struct module
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


