Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968726AbeE1KTW (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:19:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:39218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936919AbeE1KTO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:19:14 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Meelis Roos <mroos@linux.ee>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Himanshu Madhani <himanshu.madhani@cavium.com>,
        Laurence Oberman <loberman@redhat.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 076/268] scsi: qla2xxx: Avoid triggering undefined behavior in qla2x00_mbx_completion()
Date: Mon, 28 May 2018 12:00:50 +0200
Message-Id: <20180528100210.454472271@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100202.045206534@linuxfoundation.org>
References: <20180528100202.045206534@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bart Van Assche <bart.vanassche@wdc.com>

[ Upstream commit c02189e12ce3bf3808cb880569d3b10249f50bd9 ]

A left shift must shift less than the bit width of the left argument.
Avoid triggering undefined behavior if ha->mbx_count == 32.

This patch avoids that UBSAN reports the following complaint:

UBSAN: Undefined behaviour in drivers/scsi/qla2xxx/qla_isr.c:275:14
shift exponent 32 is too large for 32-bit type 'int'
Call Trace:
 dump_stack+0x4e/0x6c
 ubsan_epilogue+0xd/0x3b
 __ubsan_handle_shift_out_of_bounds+0x112/0x14c
 qla2x00_mbx_completion+0x1c5/0x25d [qla2xxx]
 qla2300_intr_handler+0x1ea/0x3bb [qla2xxx]
 qla2x00_mailbox_command+0x77b/0x139a [qla2xxx]
 qla2x00_mbx_reg_test+0x83/0x114 [qla2xxx]
 qla2x00_chip_diag+0x354/0x45f [qla2xxx]
 qla2x00_initialize_adapter+0x2c2/0xa4e [qla2xxx]
 qla2x00_probe_one+0x1681/0x392e [qla2xxx]
 pci_device_probe+0x10b/0x1f1
 driver_probe_device+0x21f/0x3a4
 __driver_attach+0xa9/0xe1
 bus_for_each_dev+0x6e/0xb5
 driver_attach+0x22/0x3c
 bus_add_driver+0x1d1/0x2ae
 driver_register+0x78/0x130
 __pci_register_driver+0x75/0xa8
 qla2x00_module_init+0x21b/0x267 [qla2xxx]
 do_one_initcall+0x5a/0x1e2
 do_init_module+0x9d/0x285
 load_module+0x20db/0x38e3
 SYSC_finit_module+0xa8/0xbc
 SyS_finit_module+0x9/0xb
 do_syscall_64+0x77/0x271
 entry_SYSCALL64_slow_path+0x25/0x25

Reported-by: Meelis Roos <mroos@linux.ee>
Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Himanshu Madhani <himanshu.madhani@cavium.com>
Reviewed-by: Laurence Oberman <loberman@redhat.com>
Acked-by: Himanshu Madhani <himanshu.madhani@cavium.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/qla2xxx/qla_isr.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/drivers/scsi/qla2xxx/qla_isr.c
+++ b/drivers/scsi/qla2xxx/qla_isr.c
@@ -268,7 +268,8 @@ qla2x00_mbx_completion(scsi_qla_host_t *
 	struct device_reg_2xxx __iomem *reg = &ha->iobase->isp;
 
 	/* Read all mbox registers? */
-	mboxes = (1 << ha->mbx_count) - 1;
+	WARN_ON_ONCE(ha->mbx_count > 32);
+	mboxes = (1ULL << ha->mbx_count) - 1;
 	if (!ha->mcp)
 		ql_dbg(ql_dbg_async, vha, 0x5001, "MBX pointer ERROR.\n");
 	else
@@ -2495,7 +2496,8 @@ qla24xx_mbx_completion(scsi_qla_host_t *
 	struct device_reg_24xx __iomem *reg = &ha->iobase->isp24;
 
 	/* Read all mbox registers? */
-	mboxes = (1 << ha->mbx_count) - 1;
+	WARN_ON_ONCE(ha->mbx_count > 32);
+	mboxes = (1ULL << ha->mbx_count) - 1;
 	if (!ha->mcp)
 		ql_dbg(ql_dbg_async, vha, 0x504e, "MBX pointer ERROR.\n");
 	else
