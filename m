Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23EB3C5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:34:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D780820936
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:34:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D780820936
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389341AbeGJSem (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 14:34:42 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:48116 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388607AbeGJSel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 14:34:41 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 7AEE3E3D;
        Tue, 10 Jul 2018 18:34:28 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Disseldorp <ddiss@suse.de>,
        Mike Christie <mchristi@redhat.com>,
        Maged Mokhtar <mmokhtar@petasan.org>,
        Christoph Hellwig <hch@lst.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.17 12/56] scsi: target: Fix truncated PR-in ReadKeys response
Date:   Tue, 10 Jul 2018 20:24:54 +0200
Message-Id: <20180710182504.141738182@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180710182503.544433950@linuxfoundation.org>
References: <20180710182503.544433950@linuxfoundation.org>
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

Cc: stable@vger.kernel.org
Signed-off-by: David Disseldorp <ddiss@suse.de>
Reviewed-by: Mike Christie <mchristi@redhat.com>
Tested-by: Maged Mokhtar <mmokhtar@petasan.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/target/target_core_pr.c |   15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

--- a/drivers/target/target_core_pr.c
+++ b/drivers/target/target_core_pr.c
@@ -3727,11 +3727,16 @@ core_scsi3_pri_read_keys(struct se_cmd *
 		 * Check for overflow of 8byte PRI READ_KEYS payload and
 		 * next reservation key list descriptor.
 		 */
-		if ((add_len + 8) > (cmd->data_length - 8))
-			break;
-
-		put_unaligned_be64(pr_reg->pr_res_key, &buf[off]);
-		off += 8;
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


