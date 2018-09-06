Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 290FFC433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 11:26:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C13B220857
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 11:26:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C13B220857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727759AbeIFQBM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 12:01:12 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39912 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725919AbeIFQBM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 12:01:12 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BAD53401BF62;
        Thu,  6 Sep 2018 11:26:11 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.43.2.155])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 018EE2027EA0;
        Thu,  6 Sep 2018 11:26:09 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     xen-devel@lists.xenproject.org
Cc:     linux-kernel@vger.kernel.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>, Wei Liu <wei.liu2@citrix.com>
Subject: [PATCH] xen/manage: don't complain about an empty value in control/sysrq node
Date:   Thu,  6 Sep 2018 13:26:08 +0200
Message-Id: <20180906112608.4221-1-vkuznets@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Thu, 06 Sep 2018 11:26:11 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Thu, 06 Sep 2018 11:26:11 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'vkuznets@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When guest receives a sysrq request from the host it acknowledges it by
writing '\0' to control/sysrq xenstore node. This, however, make xenstore
watch fire again but xenbus_scanf() fails to parse empty value with "%c"
format string:

 sysrq: SysRq : Emergency Sync
 Emergency Sync complete
 xen:manage: Error -34 reading sysrq code in control/sysrq

Ignore -ERANGE the same way we already ignore -ENOENT, empty value in
control/sysrq is totally legal.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
This is a follow-up to my Xen toolstack patch:
https://lists.xenproject.org/archives/html/xen-devel/2018-09/msg00266.html
without it we're seeing -EPERM on write and the issue I'm trying to address
here stays hidden.
---
 drivers/xen/manage.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/xen/manage.c b/drivers/xen/manage.c
index c93d8ef8df34..5bb01a62f214 100644
--- a/drivers/xen/manage.c
+++ b/drivers/xen/manage.c
@@ -280,9 +280,11 @@ static void sysrq_handler(struct xenbus_watch *watch, const char *path,
 		/*
 		 * The Xenstore watch fires directly after registering it and
 		 * after a suspend/resume cycle. So ENOENT is no error but
-		 * might happen in those cases.
+		 * might happen in those cases. ERANGE is observed when we get
+		 * an empty value (''), this happens when we acknowledge the
+		 * request by writing '\0' below.
 		 */
-		if (err != -ENOENT)
+		if (err != -ENOENT && err != -ERANGE)
 			pr_err("Error %d reading sysrq code in control/sysrq\n",
 			       err);
 		xenbus_transaction_end(xbt, 1);
-- 
2.14.4

