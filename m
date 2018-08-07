Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F287C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 18:52:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 408352172F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 18:52:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 408352172F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403821AbeHGVI3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 17:08:29 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33076 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbeHGVI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 17:08:28 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 5CC0C3EE;
        Tue,  7 Aug 2018 18:52:46 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Quinn Tran <quinn.tran@cavium.com>,
        Himanshu Madhani <himanshu.madhani@cavium.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.17 04/18] scsi: qla2xxx: Fix ISP recovery on unload
Date:   Tue,  7 Aug 2018 20:51:07 +0200
Message-Id: <20180807172313.124356830@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180807172312.964272530@linuxfoundation.org>
References: <20180807172312.964272530@linuxfoundation.org>
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

From: Quinn Tran <quinn.tran@cavium.com>

commit b08abbd9f5996309f021684f9ca74da30dcca36a upstream.

During unload process, the chip can encounter problem where a FW dump would
be captured. For this case, the full reset sequence will be skip to bring
the chip back to full operational state.

Fixes: e315cd28b9ef ("[SCSI] qla2xxx: Code changes for qla data structure refactoring")
Cc: <stable@vger.kernel.org>
Signed-off-by: Quinn Tran <quinn.tran@cavium.com>
Signed-off-by: Himanshu Madhani <himanshu.madhani@cavium.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/qla2xxx/qla_os.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -6014,8 +6014,9 @@ qla2x00_do_dpc(void *data)
 				set_bit(ISP_ABORT_NEEDED, &base_vha->dpc_flags);
 		}
 
-		if (test_and_clear_bit(ISP_ABORT_NEEDED,
-						&base_vha->dpc_flags)) {
+		if (test_and_clear_bit
+		    (ISP_ABORT_NEEDED, &base_vha->dpc_flags) &&
+		    !test_bit(UNLOADING, &base_vha->dpc_flags)) {
 
 			ql_dbg(ql_dbg_dpc, base_vha, 0x4007,
 			    "ISP abort scheduled.\n");


