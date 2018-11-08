Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BE79ECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:59:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 197BA2146D
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:59:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="LPPYLnKs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 197BA2146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730156AbeKIHhQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:37:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:55132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728855AbeKIHhP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:37:15 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47F6620989;
        Thu,  8 Nov 2018 21:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714386;
        bh=xIjwm6tDJte1AxCXimVGu7oL6STW0FKX+/5ps3r8QzM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LPPYLnKsv1yypgTdSodzJWG3+4jltKUjPeE9B9t4aP8lp8E0OSeQErQ8WGnd/PHOR
         IZTP3qNzYHE37WEUJM9O8f61a1ib58TlNt3OlkM/mn9WL0zjm+b2c6ybYrQlNxL6Az
         yqmMor4Ss10oRpfsy76dlQk3WhoPJAHUC6G2KdC0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Jeffery <djeffery@redhat.com>,
        "Ewan D. Milne" <emilne@redhat.com>,
        Laurence Oberman <loberman@redhat.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 047/114] scsi: Add STARGET_CREATED_REMOVE state to scsi_target_state
Date:   Thu,  8 Nov 2018 13:51:02 -0800
Message-Id: <20181108215105.424126117@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215059.051093652@linuxfoundation.org>
References: <20181108215059.051093652@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit f9279c968c257ee39b0d7bd2571a4d231a67bcc1 ]

The addition of the STARGET_REMOVE state had the side effect of
introducing a race condition that can cause a crash.

scsi_target_reap_ref_release() checks the starget->state to
see if it still in STARGET_CREATED, and if so, skips calling
transport_remove_device() and device_del(), because the starget->state
is only set to STARGET_RUNNING after scsi_target_add() has called
device_add() and transport_add_device().

However, if an rport loss occurs while a target is being scanned,
it can happen that scsi_remove_target() will be called while the
starget is still in the STARGET_CREATED state.  In this case, the
starget->state will be set to STARGET_REMOVE, and as a result,
scsi_target_reap_ref_release() will take the wrong path.  The end
result is a panic:

[ 1255.356653] Oops: 0000 [#1] SMP
[ 1255.360154] Modules linked in: x86_pkg_temp_thermal kvm_intel kvm irqbypass crc32c_intel ghash_clmulni_i
[ 1255.393234] CPU: 5 PID: 149 Comm: kworker/u96:4 Tainted: G        W       4.11.0+ #8
[ 1255.401879] Hardware name: Dell Inc. PowerEdge R320/08VT7V, BIOS 2.0.22 11/19/2013
[ 1255.410327] Workqueue: scsi_wq_6 fc_scsi_scan_rport [scsi_transport_fc]
[ 1255.417720] task: ffff88060ca8c8c0 task.stack: ffffc900048a8000
[ 1255.424331] RIP: 0010:kernfs_find_ns+0x13/0xc0
[ 1255.429287] RSP: 0018:ffffc900048abbf0 EFLAGS: 00010246
[ 1255.435123] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
[ 1255.443083] RDX: 0000000000000000 RSI: ffffffff8188d659 RDI: 0000000000000000
[ 1255.451043] RBP: ffffc900048abc10 R08: 0000000000000000 R09: 0000012433fe0025
[ 1255.459005] R10: 0000000025e5a4b5 R11: 0000000025e5a4b5 R12: ffffffff8188d659
[ 1255.466972] R13: 0000000000000000 R14: ffff8805f55e5088 R15: 0000000000000000
[ 1255.474931] FS:  0000000000000000(0000) GS:ffff880616b40000(0000) knlGS:0000000000000000
[ 1255.483959] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1255.490370] CR2: 0000000000000068 CR3: 0000000001c09000 CR4: 00000000000406e0
[ 1255.498332] Call Trace:
[ 1255.501058]  kernfs_find_and_get_ns+0x31/0x60
[ 1255.505916]  sysfs_unmerge_group+0x1d/0x60
[ 1255.510498]  dpm_sysfs_remove+0x22/0x60
[ 1255.514783]  device_del+0xf4/0x2e0
[ 1255.518577]  ? device_remove_file+0x19/0x20
[ 1255.523241]  attribute_container_class_device_del+0x1a/0x20
[ 1255.529457]  transport_remove_classdev+0x4e/0x60
[ 1255.534607]  ? transport_add_class_device+0x40/0x40
[ 1255.540046]  attribute_container_device_trigger+0xb0/0xc0
[ 1255.546069]  transport_remove_device+0x15/0x20
[ 1255.551025]  scsi_target_reap_ref_release+0x25/0x40
[ 1255.556467]  scsi_target_reap+0x2e/0x40
[ 1255.560744]  __scsi_scan_target+0xaa/0x5b0
[ 1255.565312]  scsi_scan_target+0xec/0x100
[ 1255.569689]  fc_scsi_scan_rport+0xb1/0xc0 [scsi_transport_fc]
[ 1255.576099]  process_one_work+0x14b/0x390
[ 1255.580569]  worker_thread+0x4b/0x390
[ 1255.584651]  kthread+0x109/0x140
[ 1255.588251]  ? rescuer_thread+0x330/0x330
[ 1255.592730]  ? kthread_park+0x60/0x60
[ 1255.596815]  ret_from_fork+0x29/0x40
[ 1255.600801] Code: 24 08 48 83 42 40 01 5b 41 5c 5d c3 66 66 66 2e 0f 1f 84 00 00 00 00 00 66 66 66 66 90
[ 1255.621876] RIP: kernfs_find_ns+0x13/0xc0 RSP: ffffc900048abbf0
[ 1255.628479] CR2: 0000000000000068
[ 1255.632756] ---[ end trace 34a69ba0477d036f ]---

Fix this by adding another scsi_target state STARGET_CREATED_REMOVE
to distinguish this case.

Fixes: f05795d3d771 ("scsi: Add intermediate STARGET_REMOVE state to scsi_target_state")
Reported-by: David Jeffery <djeffery@redhat.com>
Signed-off-by: Ewan D. Milne <emilne@redhat.com>
Cc: <stable@vger.kernel.org>
Reviewed-by: Laurence Oberman <loberman@redhat.com>
Tested-by: Laurence Oberman <loberman@redhat.com>
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/scsi_scan.c   | 5 +++--
 drivers/scsi/scsi_sysfs.c  | 8 ++++++--
 include/scsi/scsi_device.h | 1 +
 3 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/scsi_scan.c b/drivers/scsi/scsi_scan.c
index 692445bcca6f..850ddc5fac04 100644
--- a/drivers/scsi/scsi_scan.c
+++ b/drivers/scsi/scsi_scan.c
@@ -381,11 +381,12 @@ static void scsi_target_reap_ref_release(struct kref *kref)
 		= container_of(kref, struct scsi_target, reap_ref);
 
 	/*
-	 * if we get here and the target is still in the CREATED state that
+	 * if we get here and the target is still in a CREATED state that
 	 * means it was allocated but never made visible (because a scan
 	 * turned up no LUNs), so don't call device_del() on it.
 	 */
-	if (starget->state != STARGET_CREATED) {
+	if ((starget->state != STARGET_CREATED) &&
+	    (starget->state != STARGET_CREATED_REMOVE)) {
 		transport_remove_device(&starget->dev);
 		device_del(&starget->dev);
 	}
diff --git a/drivers/scsi/scsi_sysfs.c b/drivers/scsi/scsi_sysfs.c
index 8db0c48943d6..085e470d1c49 100644
--- a/drivers/scsi/scsi_sysfs.c
+++ b/drivers/scsi/scsi_sysfs.c
@@ -1212,11 +1212,15 @@ restart:
 	spin_lock_irqsave(shost->host_lock, flags);
 	list_for_each_entry(starget, &shost->__targets, siblings) {
 		if (starget->state == STARGET_DEL ||
-		    starget->state == STARGET_REMOVE)
+		    starget->state == STARGET_REMOVE ||
+		    starget->state == STARGET_CREATED_REMOVE)
 			continue;
 		if (starget->dev.parent == dev || &starget->dev == dev) {
 			kref_get(&starget->reap_ref);
-			starget->state = STARGET_REMOVE;
+			if (starget->state == STARGET_CREATED)
+				starget->state = STARGET_CREATED_REMOVE;
+			else
+				starget->state = STARGET_REMOVE;
 			spin_unlock_irqrestore(shost->host_lock, flags);
 			__scsi_remove_target(starget);
 			scsi_target_reap(starget);
diff --git a/include/scsi/scsi_device.h b/include/scsi/scsi_device.h
index 293b9a7f53bc..fb53a94a5e8b 100644
--- a/include/scsi/scsi_device.h
+++ b/include/scsi/scsi_device.h
@@ -240,6 +240,7 @@ enum scsi_target_state {
 	STARGET_CREATED = 1,
 	STARGET_RUNNING,
 	STARGET_REMOVE,
+	STARGET_CREATED_REMOVE,
 	STARGET_DEL,
 };
 
-- 
2.17.1



