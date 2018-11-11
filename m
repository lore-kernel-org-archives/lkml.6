Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4819CC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:17:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1621A20817
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:17:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1621A20817
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731711AbeKLGHE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:07:04 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:53304 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726652AbeKLGHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 01:07:04 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvt6-0000oN-Oa; Sun, 11 Nov 2018 19:59:16 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsQ-0001T3-7d; Sun, 11 Nov 2018 19:58:34 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Dennis Dalessandro" <dennis.dalessandro@intel.com>,
        "Mike Marciniszyn" <mike.marciniszyn@intel.com>,
        "Doug Ledford" <dledford@redhat.com>,
        "Don Dutile" <ddutile@redhat.com>,
        "Alex Estrin" <alex.estrin@intel.com>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.672277376@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 083/366] IB/isert: Fix for lib/dma_debug check_sync
 warning
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

From: Alex Estrin <alex.estrin@intel.com>

commit 763b69654bfb88ea3230d015e7d755ee8339f8ee upstream.

The following error message occurs on a target host in a debug build
during session login:

[ 3524.411874] WARNING: CPU: 5 PID: 12063 at lib/dma-debug.c:1207 check_sync+0x4ec/0x5b0
[ 3524.421057] infiniband hfi1_0: DMA-API: device driver tries to sync DMA memory it has not allocated [device address=0x0000000000000000] [size=76 bytes]
......snip .....

[ 3524.535846] CPU: 5 PID: 12063 Comm: iscsi_np Kdump: loaded Not tainted 3.10.0-862.el7.x86_64.debug #1
[ 3524.546764] Hardware name: Dell Inc. PowerEdge R430/03XKDV, BIOS 1.2.6 06/08/2015
[ 3524.555740] Call Trace:
[ 3524.559102]  [<ffffffffa5fe915b>] dump_stack+0x19/0x1b
[ 3524.565477]  [<ffffffffa58a2f58>] __warn+0xd8/0x100
[ 3524.571557]  [<ffffffffa58a2fdf>] warn_slowpath_fmt+0x5f/0x80
[ 3524.578610]  [<ffffffffa5bf5b8c>] check_sync+0x4ec/0x5b0
[ 3524.585177]  [<ffffffffa58efc3f>] ? set_cpus_allowed_ptr+0x5f/0x1c0
[ 3524.592812]  [<ffffffffa5bf5cd0>] debug_dma_sync_single_for_cpu+0x80/0x90
[ 3524.601029]  [<ffffffffa586add3>] ? x2apic_send_IPI_mask+0x13/0x20
[ 3524.608574]  [<ffffffffa585ee1b>] ? native_smp_send_reschedule+0x5b/0x80
[ 3524.616699]  [<ffffffffa58e9b76>] ? resched_curr+0xf6/0x140
[ 3524.623567]  [<ffffffffc0879af0>] isert_create_send_desc.isra.26+0xe0/0x110 [ib_isert]
[ 3524.633060]  [<ffffffffc087af95>] isert_put_login_tx+0x55/0x8b0 [ib_isert]
[ 3524.641383]  [<ffffffffa58ef114>] ? try_to_wake_up+0x1a4/0x430
[ 3524.648561]  [<ffffffffc098cfed>] iscsi_target_do_tx_login_io+0xdd/0x230 [iscsi_target_mod]
[ 3524.658557]  [<ffffffffc098d827>] iscsi_target_do_login+0x1a7/0x600 [iscsi_target_mod]
[ 3524.668084]  [<ffffffffa59f9bc9>] ? kstrdup+0x49/0x60
[ 3524.674420]  [<ffffffffc098e976>] iscsi_target_start_negotiation+0x56/0xc0 [iscsi_target_mod]
[ 3524.684656]  [<ffffffffc098c2ee>] __iscsi_target_login_thread+0x90e/0x1070 [iscsi_target_mod]
[ 3524.694901]  [<ffffffffc098ca50>] ? __iscsi_target_login_thread+0x1070/0x1070 [iscsi_target_mod]
[ 3524.705446]  [<ffffffffc098ca50>] ? __iscsi_target_login_thread+0x1070/0x1070 [iscsi_target_mod]
[ 3524.715976]  [<ffffffffc098ca78>] iscsi_target_login_thread+0x28/0x60 [iscsi_target_mod]
[ 3524.725739]  [<ffffffffa58d60ff>] kthread+0xef/0x100
[ 3524.732007]  [<ffffffffa58d6010>] ? insert_kthread_work+0x80/0x80
[ 3524.739540]  [<ffffffffa5fff1b7>] ret_from_fork_nospec_begin+0x21/0x21
[ 3524.747558]  [<ffffffffa58d6010>] ? insert_kthread_work+0x80/0x80
[ 3524.755088] ---[ end trace 23f8bf9238bd1ed8 ]---
[ 3595.510822] iSCSI/iqn.1994-05.com.redhat:537fa56299: Unsupported SCSI Opcode 0xa3, sending CHECK_CONDITION.

The code calls dma_sync on login_tx_desc->dma_addr prior to initializing it
with dma-mapped address.
login_tx_desc is a part of iser_conn structure and is used only once
during login negotiation, so the issue is fixed by eliminating
dma_sync call for this buffer using a special case routine.

Reviewed-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
Reviewed-by: Don Dutile <ddutile@redhat.com>
Signed-off-by: Alex Estrin <alex.estrin@intel.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
Signed-off-by: Doug Ledford <dledford@redhat.com>
[bwh: Backported to 3.16:
 - Parameters to isert_create_send_desc() are not redundant; forward them
   all to __isert_create_send_desc()
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/infiniband/ulp/isert/ib_isert.c | 26 ++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

--- a/drivers/infiniband/ulp/isert/ib_isert.c
+++ b/drivers/infiniband/ulp/isert/ib_isert.c
@@ -1033,14 +1033,10 @@ isert_post_send(struct isert_conn *isert
 }
 
 static void
-isert_create_send_desc(struct isert_conn *isert_conn,
-		       struct isert_cmd *isert_cmd,
-		       struct iser_tx_desc *tx_desc)
+__isert_create_send_desc(struct isert_conn *isert_conn,
+			 struct isert_cmd *isert_cmd,
+			 struct iser_tx_desc *tx_desc)
 {
-	struct ib_device *ib_dev = isert_conn->conn_cm_id->device;
-
-	ib_dma_sync_single_for_cpu(ib_dev, tx_desc->dma_addr,
-				   ISER_HEADERS_LEN, DMA_TO_DEVICE);
 
 	memset(&tx_desc->iser_header, 0, sizeof(struct iser_hdr));
 	tx_desc->iser_header.flags = ISER_VER;
@@ -1054,6 +1050,19 @@ isert_create_send_desc(struct isert_conn
 	}
 }
 
+static void
+isert_create_send_desc(struct isert_conn *isert_conn,
+		       struct isert_cmd *isert_cmd,
+		       struct iser_tx_desc *tx_desc)
+{
+	struct ib_device *ib_dev = isert_conn->conn_cm_id->device;
+
+	ib_dma_sync_single_for_cpu(ib_dev, tx_desc->dma_addr,
+				   ISER_HEADERS_LEN, DMA_TO_DEVICE);
+
+	__isert_create_send_desc(isert_conn, isert_cmd, tx_desc);
+}
+
 static int
 isert_init_tx_hdrs(struct isert_conn *isert_conn,
 		   struct iser_tx_desc *tx_desc)
@@ -1150,7 +1159,7 @@ isert_put_login_tx(struct iscsi_conn *co
 	struct iser_tx_desc *tx_desc = &isert_conn->conn_login_tx_desc;
 	int ret;
 
-	isert_create_send_desc(isert_conn, NULL, tx_desc);
+	__isert_create_send_desc(isert_conn, NULL, tx_desc);
 
 	memcpy(&tx_desc->iscsi_header, &login->rsp[0],
 	       sizeof(struct iscsi_hdr));

