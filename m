Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751928AbeCOGhr (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 02:37:47 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:40187 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751843AbeCOGho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 02:37:44 -0400
X-Google-Smtp-Source: AG47ELsxSsgh79RsW+D8SKuJ4Klg0qUaNvD9vZwRxU4U6eucjhkJjetaZmzGHhUrhZXZBZY3CqB8Fg==
Subject: [PATCH 3/4] scsi: arcmsr: Sleep to avoid CPU stuck too long for
 waiting adapter ready
From: Ching Huang <ching2048@areca.com.tw>
To: martin.petersen@oracle.com, James.Bottomley@HansenPartnership.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: dan.carpenter@oracle.com, hch@infradead.org, colin.king@canonical.com
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 15 Mar 2018 14:37:40 +0800
Message-ID: <1521095860.31371.34.camel@Centos6.3-64>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.3 (2.32.3-37.el6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ching Huang <ching2048@areca.com.tw>

Sleep to avoid CPU stuck too long for waiting adapter ready.

Signed-off-by: Ching Huang <ching2048@areca.com.tw>
---

diff --git a/drivers/scsi/arcmsr/arcmsr_hba.c b/drivers/scsi/arcmsr/arcmsr_hba.c
index 2f52c53..732b5d9 100755
--- a/drivers/scsi/arcmsr/arcmsr_hba.c
+++ b/drivers/scsi/arcmsr/arcmsr_hba.c
@@ -3807,6 +3807,8 @@ static void arcmsr_wait_firmware_ready(struct AdapterControlBlock *acb)
 	case ACB_ADAPTER_TYPE_A: {
 		struct MessageUnit_A __iomem *reg = acb->pmuA;
 		do {
+			if (!(acb->acb_flags & ACB_F_IOP_INITED))
+				msleep(20);
 			firmware_state = readl(&reg->outbound_msgaddr1);
 		} while ((firmware_state & ARCMSR_OUTBOUND_MESG1_FIRMWARE_OK) == 0);
 		}
@@ -3815,6 +3817,8 @@ static void arcmsr_wait_firmware_ready(struct AdapterControlBlock *acb)
 	case ACB_ADAPTER_TYPE_B: {
 		struct MessageUnit_B *reg = acb->pmuB;
 		do {
+			if (!(acb->acb_flags & ACB_F_IOP_INITED))
+				msleep(20);
 			firmware_state = readl(reg->iop2drv_doorbell);
 		} while ((firmware_state & ARCMSR_MESSAGE_FIRMWARE_OK) == 0);
 		writel(ARCMSR_DRV2IOP_END_OF_INTERRUPT, reg->drv2iop_doorbell);
@@ -3823,6 +3827,8 @@ static void arcmsr_wait_firmware_ready(struct AdapterControlBlock *acb)
 	case ACB_ADAPTER_TYPE_C: {
 		struct MessageUnit_C __iomem *reg = acb->pmuC;
 		do {
+			if (!(acb->acb_flags & ACB_F_IOP_INITED))
+				msleep(20);
 			firmware_state = readl(&reg->outbound_msgaddr1);
 		} while ((firmware_state & ARCMSR_HBCMU_MESSAGE_FIRMWARE_OK) == 0);
 		}
@@ -3830,6 +3836,8 @@ static void arcmsr_wait_firmware_ready(struct AdapterControlBlock *acb)
 	case ACB_ADAPTER_TYPE_D: {
 		struct MessageUnit_D *reg = acb->pmuD;
 		do {
+			if (!(acb->acb_flags & ACB_F_IOP_INITED))
+				msleep(20);
 			firmware_state = readl(reg->outbound_msgaddr1);
 		} while ((firmware_state &
 			ARCMSR_ARC1214_MESSAGE_FIRMWARE_OK) == 0);
@@ -3838,6 +3846,8 @@ static void arcmsr_wait_firmware_ready(struct AdapterControlBlock *acb)
 	case ACB_ADAPTER_TYPE_E: {
 		struct MessageUnit_E __iomem *reg = acb->pmuE;
 		do {
+			if (!(acb->acb_flags & ACB_F_IOP_INITED))
+				msleep(20);
 			firmware_state = readl(&reg->outbound_msgaddr1);
 		} while ((firmware_state & ARCMSR_HBEMU_MESSAGE_FIRMWARE_OK) == 0);
 		}
