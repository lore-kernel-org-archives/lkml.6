Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6538C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:15:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B02832080D
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:15:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B02832080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731843AbeKLGF1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:05:27 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:53090 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731042AbeKLGF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 01:05:26 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvt4-0000oF-2a; Sun, 11 Nov 2018 19:59:14 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsR-0001WV-El; Sun, 11 Nov 2018 19:58:35 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "Eda Zhou" <ezhou@redhat.com>, "Ewan D. Milne" <emilne@redhat.com>,
        "Himanshu Madhani" <himanshu.madhani@cavium.com>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.526556446@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 120/366] scsi: qla2xxx: Fix setting lower transfer
 speed if GPSC fails
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

Signed-off-by: Himanshu Madhani <himanshu.madhani@cavium.com>
Reported-by: Eda Zhou <ezhou@redhat.com>
Reviewed-by: Ewan D. Milne <emilne@redhat.com>
Tested-by: Ewan D. Milne <emilne@redhat.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/scsi/qla2xxx/qla_init.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -3205,7 +3205,8 @@ qla2x00_iidma_fcport(scsi_qla_host_t *vh
 		return;
 
 	if (fcport->fp_speed == PORT_SPEED_UNKNOWN ||
-	    fcport->fp_speed > ha->link_data_rate)
+	    fcport->fp_speed > ha->link_data_rate ||
+	    !ha->flags.gpsc_supported)
 		return;
 
 	rval = qla2x00_set_idma_speed(vha, fcport->loop_id, fcport->fp_speed,

