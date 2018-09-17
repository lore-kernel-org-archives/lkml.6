Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52AEEECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:00:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1458A2146F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:00:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1458A2146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729900AbeIRE32 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 00:29:28 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47992 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727559AbeIRE31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 00:29:27 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 1D6FDC03;
        Mon, 17 Sep 2018 22:59:58 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dick Kennedy <dick.kennedy@broadcom.com>,
        James Smart <james.smart@broadcom.com>,
        "Ewan D. Milne" <emilne@redhat.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.14 003/126] scsi: lpfc: Correct MDS diag and nvmet configuration
Date:   Tue, 18 Sep 2018 00:40:51 +0200
Message-Id: <20180917211703.701016044@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180917211703.481236999@linuxfoundation.org>
References: <20180917211703.481236999@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: James Smart <jsmart2021@gmail.com>

commit 53e13ee087a80e8d4fc95436318436e5c2c1f8c2 upstream.

A recent change added some MDS processing in the lpfc_drain_txq routine
that relies on the fcp_wq being allocated. For nvmet operation the fcp_wq
is not allocated because it can only be an nvme-target.  When the original
MDS support was added LS_MDS_LOOPBACK was defined wrong, (0x16) it should
have been 0x10 (decimal value used for hex setting). This incorrect value
allowed MDS_LOOPBACK to be set simultaneously with LS_NPIV_FAB_SUPPORTED,
causing the driver to crash when it accesses the non-existent fcp_wq.

Correct the bad value setting for LS_MDS_LOOPBACK.

Fixes: 	ae9e28f36a6c  ("lpfc: Add MDS Diagnostic support.")
Cc: <stable@vger.kernel.org> # v4.12+
Signed-off-by: Dick Kennedy <dick.kennedy@broadcom.com>
Signed-off-by: James Smart <james.smart@broadcom.com>
Tested-by: Ewan D. Milne <emilne@redhat.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/lpfc/lpfc.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/scsi/lpfc/lpfc.h
+++ b/drivers/scsi/lpfc/lpfc.h
@@ -676,7 +676,7 @@ struct lpfc_hba {
 #define LS_NPIV_FAB_SUPPORTED 0x2	/* Fabric supports NPIV */
 #define LS_IGNORE_ERATT       0x4	/* intr handler should ignore ERATT */
 #define LS_MDS_LINK_DOWN      0x8	/* MDS Diagnostics Link Down */
-#define LS_MDS_LOOPBACK      0x16	/* MDS Diagnostics Link Up (Loopback) */
+#define LS_MDS_LOOPBACK      0x10	/* MDS Diagnostics Link Up (Loopback) */
 
 	uint32_t hba_flag;	/* hba generic flags */
 #define HBA_ERATT_HANDLED	0x1 /* This flag is set when eratt handled */


