Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD01AC169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 13:50:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FDB6218D8
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 13:50:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728890AbfBCNup (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 08:50:45 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:54044 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728438AbfBCNuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 08:50:05 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9q-0003tu-CI; Sun, 03 Feb 2019 13:50:02 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9j-0007G8-RQ; Sun, 03 Feb 2019 14:49:55 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Jason Gunthorpe" <jgg@mellanox.com>,
        "Sagi Grimberg" <sagi@grimberg.me>,
        "Dan Carpenter" <dan.carpenter@oracle.com>
Date:   Sun, 03 Feb 2019 14:45:08 +0100
Message-ID: <lsq.1549201508.165642103@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 219/305] iser: set sector for ambiguous mr status errors
In-Reply-To: <lsq.1549201507.384106140@decadent.org.uk>
X-SA-Exim-Connect-IP: 78.29.236.164
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.63-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Sagi Grimberg <sagi@grimberg.me>

commit 24c3456c8d5ee6fc1933ca40f7b4406130682668 upstream.

If for some reason we failed to query the mr status, we need to make sure
to provide sufficient information for an ambiguous error (guard error on
sector 0).

Fixes: 0a7a08ad6f5f ("IB/iser: Implement check_protection")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/infiniband/ulp/iser/iser_verbs.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

--- a/drivers/infiniband/ulp/iser/iser_verbs.c
+++ b/drivers/infiniband/ulp/iser/iser_verbs.c
@@ -1165,7 +1165,9 @@ u8 iser_check_task_pi_status(struct iscs
 					 IB_MR_CHECK_SIG_STATUS, &mr_status);
 		if (ret) {
 			pr_err("ib_check_mr_status failed, ret %d\n", ret);
-			goto err;
+			/* Not a lot we can do, return ambiguous guard error */
+			*sector = 0;
+			return 0x1;
 		}
 
 		if (mr_status.fail_status & IB_MR_CHECK_SIG_STATUS) {
@@ -1193,7 +1195,4 @@ u8 iser_check_task_pi_status(struct iscs
 	}
 
 	return 0;
-err:
-	/* Not alot we can do here, return ambiguous guard error */
-	return 0x1;
 }

