Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C15FC433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:36:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 421DF20658
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:36:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 421DF20658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731419AbeICV5i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:57:38 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:48126 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbeICV5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:57:38 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 38926D16;
        Mon,  3 Sep 2018 17:36:28 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Himanshu Madhani <himanshu.madhani@cavium.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.18 078/123] scsi: qla2xxx: Fix stalled relogin
Date:   Mon,  3 Sep 2018 18:57:02 +0200
Message-Id: <20180903165722.852999575@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180903165719.499675257@linuxfoundation.org>
References: <20180903165719.499675257@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Himanshu Madhani <himanshu.madhani@cavium.com>

commit 15b6c3c9568765f0717b2dd3aa67a5f7eadd9734 upstream.

This patch sets and clears FCF_ASYNC_{SENT|ACTIVE} flags to prevent
stalling of relogin attempt. Once flag are correctly set/cleared, relogin
timer can retry relogin attempt for driver to continue login.

Fixes: fa83e65885b9 ("scsi: qla2xxx: ensure async flags are reset correctly")
Cc: stable@vger.kernel.org #4.17
Signed-off-by: Himanshu Madhani <himanshu.madhani@cavium.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/qla2xxx/qla_init.c |    2 +-
 drivers/scsi/qla2xxx/qla_iocb.c |    1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -382,7 +382,7 @@ qla2x00_async_adisc_sp_done(void *ptr, i
 	    "Async done-%s res %x %8phC\n",
 	    sp->name, res, sp->fcport->port_name);
 
-	sp->fcport->flags &= ~FCF_ASYNC_SENT;
+	sp->fcport->flags &= ~(FCF_ASYNC_SENT | FCF_ASYNC_ACTIVE);
 
 	memset(&ea, 0, sizeof(ea));
 	ea.event = FCME_ADISC_DONE;
--- a/drivers/scsi/qla2xxx/qla_iocb.c
+++ b/drivers/scsi/qla2xxx/qla_iocb.c
@@ -2656,6 +2656,7 @@ qla24xx_els_dcmd2_iocb(scsi_qla_host_t *
 	ql_dbg(ql_dbg_io, vha, 0x3073,
 	    "Enter: PLOGI portid=%06x\n", fcport->d_id.b24);
 
+	fcport->flags |= FCF_ASYNC_SENT;
 	sp->type = SRB_ELS_DCMD;
 	sp->name = "ELS_DCMD";
 	sp->fcport = fcport;


