Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C567FC6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:14:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F5A124380
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:14:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F5A124380
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753099AbeGAQOH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 12:14:07 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60284 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753068AbeGAQOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:14:04 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 5BD15ACD;
        Sun,  1 Jul 2018 16:14:03 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Himanshu Madhani <himanshu.madhani@cavium.com>,
        Eda Zhou <ezhou@redhat.com>,
        "Ewan D. Milne" <emilne@redhat.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 3.18 72/85] scsi: qla2xxx: Fix setting lower transfer speed if GPSC fails
Date:   Sun,  1 Jul 2018 18:02:30 +0200
Message-Id: <20180701153125.239551386@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701153122.365061142@linuxfoundation.org>
References: <20180701153122.365061142@linuxfoundation.org>
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

From: Himanshu Madhani <himanshu.madhani@cavium.com>

commit 413c2f33489b134e3cc65d9c3ff7861e8fdfe899 upstream.

This patch prevents driver from setting lower default speed of 1 GB/sec,
if the switch does not support Get Port Speed Capabilities (GPSC)
command. Setting this default speed results into much lower write
performance for large sequential WRITE.  This patch modifies driver to
check for gpsc_supported flags and prevents driver from issuing
MBC_SET_PORT_PARAM (001Ah) to set default speed of 1 GB/sec. If driver
does not send this mailbox command, firmware assumes maximum supported
link speed and will operate at the max speed.

Cc: stable@vger.kernel.org
Signed-off-by: Himanshu Madhani <himanshu.madhani@cavium.com>
Reported-by: Eda Zhou <ezhou@redhat.com>
Reviewed-by: Ewan D. Milne <emilne@redhat.com>
Tested-by: Ewan D. Milne <emilne@redhat.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/qla2xxx/qla_init.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -3212,7 +3212,8 @@ qla2x00_iidma_fcport(scsi_qla_host_t *vh
 		return;
 
 	if (fcport->fp_speed == PORT_SPEED_UNKNOWN ||
-	    fcport->fp_speed > ha->link_data_rate)
+	    fcport->fp_speed > ha->link_data_rate ||
+	    !ha->flags.gpsc_supported)
 		return;
 
 	rval = qla2x00_set_idma_speed(vha, fcport->loop_id, fcport->fp_speed,


