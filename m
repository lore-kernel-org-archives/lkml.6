Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 511E2C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 09:12:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E52E20827
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 09:12:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E52E20827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730342AbeKFSg7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 13:36:59 -0500
Received: from mga05.intel.com ([192.55.52.43]:26399 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729160AbeKFSg7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 13:36:59 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Nov 2018 01:12:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,471,1534834800"; 
   d="scan'208";a="83674060"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.48])
  by fmsmga007.fm.intel.com with ESMTP; 06 Nov 2018 01:12:42 -0800
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc-next 2/3] mei: flush queues by the host client only
Date:   Tue,  6 Nov 2018 12:04:39 +0200
Message-Id: <20181106100440.2140-2-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20181106100440.2140-1-tomas.winkler@intel.com>
References: <20181106100440.2140-1-tomas.winkler@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Usyskin <alexander.usyskin@intel.com>

During queues flush, the me client in most cases is already
unlinked hence the me client id is unavailable. The host client
structure pointer is enough for identification.
The function mei_cl_cmp_id() is dropped as it has no more usage.

Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/misc/mei/client.c | 21 ++-------------------
 1 file changed, 2 insertions(+), 19 deletions(-)

diff --git a/drivers/misc/mei/client.c b/drivers/misc/mei/client.c
index ebdcf0b450e2..ee58561ceb08 100644
--- a/drivers/misc/mei/client.c
+++ b/drivers/misc/mei/client.c
@@ -317,23 +317,6 @@ void mei_me_cl_rm_all(struct mei_device *dev)
 	up_write(&dev->me_clients_rwsem);
 }
 
-/**
- * mei_cl_cmp_id - tells if the clients are the same
- *
- * @cl1: host client 1
- * @cl2: host client 2
- *
- * Return: true  - if the clients has same host and me ids
- *         false - otherwise
- */
-static inline bool mei_cl_cmp_id(const struct mei_cl *cl1,
-				const struct mei_cl *cl2)
-{
-	return cl1 && cl2 &&
-		(cl1->host_client_id == cl2->host_client_id) &&
-		(mei_cl_me_id(cl1) == mei_cl_me_id(cl2));
-}
-
 /**
  * mei_io_cb_free - free mei_cb_private related memory
  *
@@ -418,7 +401,7 @@ static void mei_io_list_flush_cl(struct list_head *head,
 	struct mei_cl_cb *cb, *next;
 
 	list_for_each_entry_safe(cb, next, head, list) {
-		if (mei_cl_cmp_id(cl, cb->cl))
+		if (cl == cb->cl)
 			list_del_init(&cb->list);
 	}
 }
@@ -435,7 +418,7 @@ static void mei_io_tx_list_free_cl(struct list_head *head,
 	struct mei_cl_cb *cb, *next;
 
 	list_for_each_entry_safe(cb, next, head, list) {
-		if (mei_cl_cmp_id(cl, cb->cl))
+		if (cl == cb->cl)
 			mei_tx_cb_dequeue(cb);
 	}
 }
-- 
2.14.5

