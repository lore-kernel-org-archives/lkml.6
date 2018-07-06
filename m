Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74A16C6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 02:57:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38CFE2409C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 02:57:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38CFE2409C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932546AbeGFC5c (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 22:57:32 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46220 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932199AbeGFC5b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 22:57:31 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BC83A40AC6DE;
        Fri,  6 Jul 2018 02:57:30 +0000 (UTC)
Received: from gblock2.localdomain (ovpn-12-18.pek2.redhat.com [10.72.12.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 73D26215688A;
        Fri,  6 Jul 2018 02:57:24 +0000 (UTC)
From:   xiubli@redhat.com
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     hamish.martin@alliedtelesis.co.nz, jannh@google.com,
        pkalever@redhat.com, pkarampu@redhat.com, atumball@redhat.com,
        sabose@redhat.com, mchristi@redhat.com
Subject: [PATCH v3 1/3] uio: use request_threaded_irq instead
Date:   Thu,  5 Jul 2018 22:57:14 -0400
Message-Id: <1530845836-49101-2-git-send-email-xiubli@redhat.com>
In-Reply-To: <1530845836-49101-1-git-send-email-xiubli@redhat.com>
References: <1530845836-49101-1-git-send-email-xiubli@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Fri, 06 Jul 2018 02:57:30 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Fri, 06 Jul 2018 02:57:30 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'xiubli@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiubo Li <xiubli@redhat.com>

Prepraing for changing to use mutex lock.

Signed-off-by: Xiubo Li <xiubli@redhat.com>
---
 drivers/uio/uio.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/uio/uio.c b/drivers/uio/uio.c
index e8f4ac9..b4b2ae1 100644
--- a/drivers/uio/uio.c
+++ b/drivers/uio/uio.c
@@ -902,8 +902,9 @@ int __uio_register_device(struct module *owner,
 		 * FDs at the time of unregister and therefore may not be
 		 * freed until they are released.
 		 */
-		ret = request_irq(info->irq, uio_interrupt,
-				  info->irq_flags, info->name, idev);
+		ret = request_threaded_irq(info->irq, NULL, uio_interrupt,
+					   info->irq_flags, info->name, idev);
+
 		if (ret)
 			goto err_request_irq;
 	}
-- 
1.8.3.1

