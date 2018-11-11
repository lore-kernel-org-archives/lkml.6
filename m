Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78F57C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:38:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4579020869
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:38:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4579020869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730028AbeKLFsI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 00:48:08 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:49560 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729994AbeKLFsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:48:07 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsT-0000oJ-AC; Sun, 11 Nov 2018 19:58:37 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsS-0001ZN-Qf; Sun, 11 Nov 2018 19:58:36 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Maged Mokhtar" <mmokhtar@petasan.org>,
        "Mike Christie" <mchristi@redhat.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "Christoph Hellwig" <hch@lst.de>,
        "David Disseldorp" <ddiss@suse.de>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.280788820@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 155/366] scsi: target: Fix truncated PR-in ReadKeys
 response
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

From: David Disseldorp <ddiss@suse.de>

commit 63ce3c384db26494615e3c8972bcd419ed71f4c4 upstream.

SPC5r17 states that the contents of the ADDITIONAL LENGTH field are not
altered based on the allocation length, so always calculate and pack the
full key list length even if the list itself is truncated.

According to Maged:

  Yes it fixes the "Storage Spaces Persistent Reservation" test in the
  Windows 2016 Server Failover Cluster validation suites when having
  many connections that result in more than 8 registrations. I tested
  your patch on 4.17 with iblock.

This behaviour can be tested using the libiscsi PrinReadKeys.Truncate test.

Signed-off-by: David Disseldorp <ddiss@suse.de>
Reviewed-by: Mike Christie <mchristi@redhat.com>
Tested-by: Maged Mokhtar <mmokhtar@petasan.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
[bwh: Backported to 3.16: Convert from open-coded put_unaligned_be64()]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/target/target_core_pr.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

--- a/drivers/target/target_core_pr.c
+++ b/drivers/target/target_core_pr.c
@@ -3726,18 +3726,16 @@ core_scsi3_pri_read_keys(struct se_cmd *
 		 * Check for overflow of 8byte PRI READ_KEYS payload and
 		 * next reservation key list descriptor.
 		 */
-		if ((add_len + 8) > (cmd->data_length - 8))
-			break;
-
-		buf[off++] = ((pr_reg->pr_res_key >> 56) & 0xff);
-		buf[off++] = ((pr_reg->pr_res_key >> 48) & 0xff);
-		buf[off++] = ((pr_reg->pr_res_key >> 40) & 0xff);
-		buf[off++] = ((pr_reg->pr_res_key >> 32) & 0xff);
-		buf[off++] = ((pr_reg->pr_res_key >> 24) & 0xff);
-		buf[off++] = ((pr_reg->pr_res_key >> 16) & 0xff);
-		buf[off++] = ((pr_reg->pr_res_key >> 8) & 0xff);
-		buf[off++] = (pr_reg->pr_res_key & 0xff);
-
+		if (off + 8 <= cmd->data_length) {
+			put_unaligned_be64(pr_reg->pr_res_key, &buf[off]);
+			off += 8;
+		}
+		/*
+		 * SPC5r17: 6.16.2 READ KEYS service action
+		 * The ADDITIONAL LENGTH field indicates the number of bytes in
+		 * the Reservation key list. The contents of the ADDITIONAL
+		 * LENGTH field are not altered based on the allocation length
+		 */
 		add_len += 8;
 	}
 	spin_unlock(&dev->t10_pr.registration_lock);

