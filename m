Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AB94C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:47:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1191520831
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:47:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="bdr5kq9L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1191520831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389247AbeKTDMI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:12:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:48254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388196AbeKTDMH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:12:07 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 93CE520831;
        Mon, 19 Nov 2018 16:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542646075;
        bh=YcjtDjEvwEs7d8+fUESFlYdKj9YXzCsHpDsreQI+RJU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bdr5kq9Lm7HMn4Rx/2PIyRCahFeP/Hbz6Jo/XLzQ4qlzkCw0cour/2VjT30/gDKg6
         x8htuFUrY4wcu7Asjwxavw+5tdHxfdCAifwnK/ijXc2NCxzUJ8nvyMU30LNUlj/Q8F
         2gmkgFbibxIwKNyNvCjN3rv5qvxj6DJbotWcsw00=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Quinn Tran <quinn.tran@cavium.com>,
        Himanshu Madhani <himanshu.madhani@cavium.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.14 026/124] scsi: qla2xxx: Fix process response queue for ISP26XX and above
Date:   Mon, 19 Nov 2018 17:28:00 +0100
Message-Id: <20181119162618.644827192@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162612.951907286@linuxfoundation.org>
References: <20181119162612.951907286@linuxfoundation.org>
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

From: Quinn Tran <quinn.tran@cavium.com>

commit b86ac8fd4b2f6ec2f9ca9194c56eac12d620096f upstream.

This patch improves performance for 16G and above adapter by removing
additional call to process_response_queue().

[mkp: typo]

Cc: <stable@vger.kernel.org>
Signed-off-by: Quinn Tran <quinn.tran@cavium.com>
Signed-off-by: Himanshu Madhani <himanshu.madhani@cavium.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/qla2xxx/qla_init.c |    2 --
 drivers/scsi/qla2xxx/qla_iocb.c |   17 -----------------
 2 files changed, 19 deletions(-)

--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -7591,7 +7591,6 @@ qla81xx_nvram_config(scsi_qla_host_t *vh
 	}
 	icb->firmware_options_2 &= cpu_to_le32(
 	    ~(BIT_3 | BIT_2 | BIT_1 | BIT_0));
-	vha->flags.process_response_queue = 0;
 	if (ha->zio_mode != QLA_ZIO_DISABLED) {
 		ha->zio_mode = QLA_ZIO_MODE_6;
 
@@ -7603,7 +7602,6 @@ qla81xx_nvram_config(scsi_qla_host_t *vh
 		icb->firmware_options_2 |= cpu_to_le32(
 		    (uint32_t)ha->zio_mode);
 		icb->interrupt_delay_timer = cpu_to_le16(ha->zio_timer);
-		vha->flags.process_response_queue = 1;
 	}
 
 	 /* enable RIDA Format2 */
--- a/drivers/scsi/qla2xxx/qla_iocb.c
+++ b/drivers/scsi/qla2xxx/qla_iocb.c
@@ -1524,12 +1524,6 @@ qla24xx_start_scsi(srb_t *sp)
 
 	/* Set chip new ring index. */
 	WRT_REG_DWORD(req->req_q_in, req->ring_index);
-	RD_REG_DWORD_RELAXED(&ha->iobase->isp24.hccr);
-
-	/* Manage unprocessed RIO/ZIO commands in response queue. */
-	if (vha->flags.process_response_queue &&
-		rsp->ring_ptr->signature != RESPONSE_PROCESSED)
-		qla24xx_process_response_queue(vha, rsp);
 
 	spin_unlock_irqrestore(&ha->hardware_lock, flags);
 	return QLA_SUCCESS;
@@ -1723,12 +1717,6 @@ qla24xx_dif_start_scsi(srb_t *sp)
 
 	/* Set chip new ring index. */
 	WRT_REG_DWORD(req->req_q_in, req->ring_index);
-	RD_REG_DWORD_RELAXED(&ha->iobase->isp24.hccr);
-
-	/* Manage unprocessed RIO/ZIO commands in response queue. */
-	if (vha->flags.process_response_queue &&
-	    rsp->ring_ptr->signature != RESPONSE_PROCESSED)
-		qla24xx_process_response_queue(vha, rsp);
 
 	spin_unlock_irqrestore(&ha->hardware_lock, flags);
 
@@ -1878,11 +1866,6 @@ qla2xxx_start_scsi_mq(srb_t *sp)
 	/* Set chip new ring index. */
 	WRT_REG_DWORD(req->req_q_in, req->ring_index);
 
-	/* Manage unprocessed RIO/ZIO commands in response queue. */
-	if (vha->flags.process_response_queue &&
-		rsp->ring_ptr->signature != RESPONSE_PROCESSED)
-		qla24xx_process_response_queue(vha, rsp);
-
 	spin_unlock_irqrestore(&qpair->qp_lock, flags);
 	return QLA_SUCCESS;
 


