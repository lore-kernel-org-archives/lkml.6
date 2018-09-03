Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB9BAC433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 16:51:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DB8E20779
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 16:51:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DB8E20779
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728240AbeICVM0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:12:26 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36330 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727577AbeICVMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:12:25 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 878C3CF3;
        Mon,  3 Sep 2018 16:51:28 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jim Gill <jgill@vmware.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 34/56] scsi: vmw_pvscsi: Return DID_RESET for status SAM_STAT_COMMAND_TERMINATED
Date:   Mon,  3 Sep 2018 18:49:24 +0200
Message-Id: <20180903164925.768525654@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180903164924.078355019@linuxfoundation.org>
References: <20180903164924.078355019@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jim Gill <jgill@vmware.com>

[ Upstream commit e95153b64d03c2b6e8d62e51bdcc33fcad6e0856 ]

Commands that are reset are returned with status
SAM_STAT_COMMAND_TERMINATED. PVSCSI currently returns DID_OK |
SAM_STAT_COMMAND_TERMINATED which fails the command. Instead, set hostbyte
to DID_RESET to allow upper layers to retry.

Tested by copying a large file between two pvscsi disks on same adapter
while performing a bus reset at 1-second intervals. Before fix, commands
sometimes fail with DID_OK. After fix, commands observed to fail with
DID_RESET.

Signed-off-by: Jim Gill <jgill@vmware.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/vmw_pvscsi.c |   11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

--- a/drivers/scsi/vmw_pvscsi.c
+++ b/drivers/scsi/vmw_pvscsi.c
@@ -567,9 +567,14 @@ static void pvscsi_complete_request(stru
 	    (btstat == BTSTAT_SUCCESS ||
 	     btstat == BTSTAT_LINKED_COMMAND_COMPLETED ||
 	     btstat == BTSTAT_LINKED_COMMAND_COMPLETED_WITH_FLAG)) {
-		cmd->result = (DID_OK << 16) | sdstat;
-		if (sdstat == SAM_STAT_CHECK_CONDITION && cmd->sense_buffer)
-			cmd->result |= (DRIVER_SENSE << 24);
+		if (sdstat == SAM_STAT_COMMAND_TERMINATED) {
+			cmd->result = (DID_RESET << 16);
+		} else {
+			cmd->result = (DID_OK << 16) | sdstat;
+			if (sdstat == SAM_STAT_CHECK_CONDITION &&
+			    cmd->sense_buffer)
+				cmd->result |= (DRIVER_SENSE << 24);
+		}
 	} else
 		switch (btstat) {
 		case BTSTAT_SUCCESS:


