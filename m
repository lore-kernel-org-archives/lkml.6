Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08196ECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:09:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE05D2146F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:09:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE05D2146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731996AbeIREjS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 00:39:18 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50186 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730295AbeIREjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 00:39:17 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 382C5C49;
        Mon, 17 Sep 2018 23:09:47 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Quinn Tran <quinn.tran@cavium.com>,
        Himanshu Madhani <himanshu.madhani@cavium.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 059/158] scsi: qla2xxx: Fix session state stuck in Get Port DB
Date:   Tue, 18 Sep 2018 00:41:29 +0200
Message-Id: <20180917211713.977837730@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180917211710.383360696@linuxfoundation.org>
References: <20180917211710.383360696@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Quinn Tran <quinn.tran@cavium.com>

[ Upstream commit 8fde6977ac478c00eeb2beccfdd4a6ad44219f6c ]

This patch sets discovery state back to GNL (Get Name List) when session is
stuck at GPDB (Get Port DataBase). This will allow state machine to retry
login and move session state ahead in discovery.

Signed-off-by: Quinn Tran <quinn.tran@cavium.com>
Signed-off-by: Himanshu Madhani <himanshu.madhani@cavium.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/qla2xxx/qla_init.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -1074,9 +1074,12 @@ void qla24xx_handle_gpdb_event(scsi_qla_
 	case PDS_PLOGI_COMPLETE:
 	case PDS_PRLI_PENDING:
 	case PDS_PRLI2_PENDING:
-		ql_dbg(ql_dbg_disc, vha, 0x20d5, "%s %d %8phC relogin needed\n",
-		    __func__, __LINE__, fcport->port_name);
-		set_bit(RELOGIN_NEEDED, &vha->dpc_flags);
+		/* Set discovery state back to GNL to Relogin attempt */
+		if (qla_dual_mode_enabled(vha) ||
+		    qla_ini_mode_enabled(vha)) {
+			fcport->disc_state = DSC_GNL;
+			set_bit(RELOGIN_NEEDED, &vha->dpc_flags);
+		}
 		return;
 	case PDS_LOGO_PENDING:
 	case PDS_PORT_UNAVAILABLE:


