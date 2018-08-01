Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 123F4C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:52:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBD83208A4
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:52:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBD83208A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390658AbeHATjk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:39:40 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50242 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405993AbeHATIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:08:41 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 4C7AF110E;
        Wed,  1 Aug 2018 17:04:49 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chad Dupuis <chad.dupuis@cavium.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 219/336] scsi: qedf: Set the UNLOADING flag when removing a vport
Date:   Wed,  1 Aug 2018 18:49:14 +0200
Message-Id: <20180801165037.453473878@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801165028.930831994@linuxfoundation.org>
References: <20180801165028.930831994@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chad Dupuis <chad.dupuis@cavium.com>

[ Upstream commit 4f4616ceebaf045c59e8a6aa01f08826d18d5c63 ]

Similar to what we do when we remove a PCI function, set the
QEDF_UNLOADING flag to prevent any requests from being queued while a
vport is being deleted.  This prevents any requests from getting stuck
in limbo when the vport is unloaded or deleted.

Fixes the crash:

PID: 106676  TASK: ffff9a436aa90000  CPU: 12  COMMAND: "multipathd"
 #0 [ffff9a43567d3550] machine_kexec+522 at ffffffffaca60b2a
 #1 [ffff9a43567d35b0] __crash_kexec+114 at ffffffffacb13512
 #2 [ffff9a43567d3680] crash_kexec+48 at ffffffffacb13600
 #3 [ffff9a43567d3698] oops_end+168 at ffffffffad117768
 #4 [ffff9a43567d36c0] no_context+645 at ffffffffad106f52
 #5 [ffff9a43567d3710] __bad_area_nosemaphore+116 at ffffffffad106fe9
 #6 [ffff9a43567d3760] bad_area+70 at ffffffffad107379
 #7 [ffff9a43567d3788] __do_page_fault+1247 at ffffffffad11a8cf
 #8 [ffff9a43567d37f0] do_page_fault+53 at ffffffffad11a915
 #9 [ffff9a43567d3820] page_fault+40 at ffffffffad116768
    [exception RIP: qedf_init_task+61]
    RIP: ffffffffc0e13c2d  RSP: ffff9a43567d38d0  RFLAGS: 00010046
    RAX: 0000000000000000  RBX: ffffbe920472c738  RCX: ffff9a434fa0e3e8
    RDX: ffff9a434f695280  RSI: ffffbe920472c738  RDI: ffff9a43aa359c80
    RBP: ffff9a43567d3950   R8: 0000000000000c15   R9: ffff9a3fb09b9880
    R10: ffff9a434fa0e3e8  R11: ffff9a43567d35ce  R12: 0000000000000000
    R13: ffff9a434f695280  R14: ffff9a43aa359c80  R15: ffff9a3fb9e005c0
    ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018

Signed-off-by: Chad Dupuis <chad.dupuis@cavium.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/qedf/qedf_main.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

--- a/drivers/scsi/qedf/qedf_main.c
+++ b/drivers/scsi/qedf/qedf_main.c
@@ -1647,6 +1647,15 @@ static int qedf_vport_destroy(struct fc_
 	struct Scsi_Host *shost = vport_to_shost(vport);
 	struct fc_lport *n_port = shost_priv(shost);
 	struct fc_lport *vn_port = vport->dd_data;
+	struct qedf_ctx *qedf = lport_priv(vn_port);
+
+	if (!qedf) {
+		QEDF_ERR(NULL, "qedf is NULL.\n");
+		goto out;
+	}
+
+	/* Set unloading bit on vport qedf_ctx to prevent more I/O */
+	set_bit(QEDF_UNLOADING, &qedf->flags);
 
 	mutex_lock(&n_port->lp_mutex);
 	list_del(&vn_port->list);
@@ -1673,6 +1682,7 @@ static int qedf_vport_destroy(struct fc_
 	if (vn_port->host)
 		scsi_host_put(vn_port->host);
 
+out:
 	return 0;
 }
 


