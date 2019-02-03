Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31A18C169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 13:54:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A8B7218F0
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 13:54:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729060AbfBCNyb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 08:54:31 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:54434 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728995AbfBCNyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 08:54:24 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqIE3-0003td-F7; Sun, 03 Feb 2019 13:54:23 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9r-0007P6-Tc; Sun, 03 Feb 2019 14:50:03 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Christoph Hellwig" <hch@lst.de>,
        "Chad Dupuis" <chad.dupuis@qlogic.com>,
        "Dan Carpenter" <dan.carpenter@oracle.com>
Date:   Sun, 03 Feb 2019 14:45:08 +0100
Message-ID: <lsq.1549201508.321714770@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 273/305] bnx2fc: fix an error code in _bnx2fc_create()
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

From: Dan Carpenter <dan.carpenter@oracle.com>

commit 2043e1fd09c1896bb03a6e25b64baa84a30879c9 upstream.

We should be returning an error code here instead of success.  Either
-ENODEV or -ENOMEM would work.  There is also a failure message in
printk().

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Acked-by: Chad Dupuis <chad.dupuis@qlogic.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/scsi/bnx2fc/bnx2fc_fcoe.c | 1 +
 1 file changed, 1 insertion(+)

--- a/drivers/scsi/bnx2fc/bnx2fc_fcoe.c
+++ b/drivers/scsi/bnx2fc/bnx2fc_fcoe.c
@@ -2201,6 +2201,7 @@ static int _bnx2fc_create(struct net_dev
 	interface = bnx2fc_interface_create(hba, netdev, fip_mode);
 	if (!interface) {
 		printk(KERN_ERR PFX "bnx2fc_interface_create failed\n");
+		rc = -ENOMEM;
 		goto ifput_err;
 	}
 

