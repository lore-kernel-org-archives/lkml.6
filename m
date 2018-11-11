Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4C6CC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:08:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 939092080D
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:08:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 939092080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731609AbeKLF51 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 00:57:27 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:52228 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730938AbeKLF51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:57:27 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvt4-0000lF-WB; Sun, 11 Nov 2018 19:59:15 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsR-0001Vc-2X; Sun, 11 Nov 2018 19:58:35 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Jason Gunthorpe" <jgg@mellanox.com>,
        "Christoph Hellwig" <hch@lst.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "Sagi Grimberg" <sagi@grimberg.me>,
        "Max Gurtovoy" <maxg@mellanox.com>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.70355388@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 110/366] IB/isert: fix T10-pi check mask setting
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Max Gurtovoy <maxg@mellanox.com>

commit 0e12af84cdd3056460f928adc164f9e87f4b303b upstream.

A copy/paste bug (probably) caused setting of an app_tag check mask
in case where a ref_tag check was needed.

Fixes: 38a2d0d429f1 ("IB/isert: convert to the generic RDMA READ/WRITE API")
Fixes: 9e961ae73c2c ("IB/isert: Support T10-PI protected transactions")
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/infiniband/ulp/isert/ib_isert.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/infiniband/ulp/isert/ib_isert.c
+++ b/drivers/infiniband/ulp/isert/ib_isert.c
@@ -2822,7 +2822,7 @@ static inline u8
 isert_set_prot_checks(u8 prot_checks)
 {
 	return (prot_checks & TARGET_DIF_CHECK_GUARD  ? 0xc0 : 0) |
-	       (prot_checks & TARGET_DIF_CHECK_REFTAG ? 0x30 : 0) |
+	       (prot_checks & TARGET_DIF_CHECK_APPTAG ? 0x30 : 0) |
 	       (prot_checks & TARGET_DIF_CHECK_REFTAG ? 0x0f : 0);
 }
 

