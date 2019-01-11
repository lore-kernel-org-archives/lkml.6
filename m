Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92F33C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 16:57:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 265FC20874
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 16:57:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388208AbfAKQ5r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 11:57:47 -0500
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:46544 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731195AbfAKQ5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 11:57:47 -0500
Received: from sc9-mailhost2.vmware.com (10.113.161.72) by
 EX13-EDG-OU-001.vmware.com (10.113.208.155) with Microsoft SMTP Server id
 15.0.1156.6; Fri, 11 Jan 2019 08:57:29 -0800
Received: from pa-dbc1104.eng.vmware.com (pa-dbc1104.eng.vmware.com [10.162.210.4])
        by sc9-mailhost2.vmware.com (Postfix) with ESMTP id 7803FB1E8C;
        Fri, 11 Jan 2019 11:57:45 -0500 (EST)
From:   Jorgen Hansen <jhansen@vmware.com>
To:     <linux-kernel@vger.kernel.org>,
        <virtualization@lists.linux-foundation.org>
CC:     <gregkh@linuxfoundation.org>, <pv-drivers@vmware.com>,
        Jorgen Hansen <jhansen@vmware.com>
Subject: [PATCH] VMCI: Verify PPNs before sending to device
Date:   Fri, 11 Jan 2019 08:57:45 -0800
Message-ID: <1547225865-53408-1-git-send-email-jhansen@vmware.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (EX13-EDG-OU-001.vmware.com: jhansen@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current version of the VMCI device only supports 32 bit PPNs,
so check whether we are truncating PPNs, and fail the operation
if we do. One such check did exist, but was wrong. Another
check was missing.

Testing through code modification: constructed PPN not representable
by 32-bit and observed that failure was reported.

Fixes: 1f166439917b ("VMCI: guest side driver implementation.")
Fixes: 06164d2b72aa ("VMCI: queue pairs implementation.")

Signed-off-by: Jorgen Hansen <jhansen@vmware.com>
Reviewed-by: Adit Ranadive <aditr@vmware.com>
Reviewed-by: Vishnu Dasa <vdasa@vmware.com>
---
 drivers/misc/vmw_vmci/vmci_guest.c      | 10 +++++++---
 drivers/misc/vmw_vmci/vmci_queue_pair.c | 10 ++++------
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/misc/vmw_vmci/vmci_guest.c b/drivers/misc/vmw_vmci/vmci_guest.c
index dad5abee656e..02bb3866cf9e 100644
--- a/drivers/misc/vmw_vmci/vmci_guest.c
+++ b/drivers/misc/vmw_vmci/vmci_guest.c
@@ -532,10 +532,14 @@ static int vmci_guest_probe_device(struct pci_dev *pdev,
 	if (capabilities & VMCI_CAPS_NOTIFICATIONS) {
 		unsigned long bitmap_ppn =
 			vmci_dev->notification_base >> PAGE_SHIFT;
-		if (!vmci_dbell_register_notification_bitmap(bitmap_ppn)) {
+		u32 bitmap_ppn32 = bitmap_ppn;
+
+		if ((sizeof(bitmap_ppn) > sizeof(bitmap_ppn32)
+		     && bitmap_ppn != bitmap_ppn32) ||
+		    !vmci_dbell_register_notification_bitmap(bitmap_ppn)) {
 			dev_warn(&pdev->dev,
-				 "VMCI device unable to register notification bitmap with PPN 0x%x\n",
-				 (u32) bitmap_ppn);
+				 "VMCI device unable to register notification bitmap with PPN 0x%lx\n",
+				 bitmap_ppn);
 			error = -ENXIO;
 			goto err_remove_vmci_dev_g;
 		}
diff --git a/drivers/misc/vmw_vmci/vmci_queue_pair.c b/drivers/misc/vmw_vmci/vmci_queue_pair.c
index 264f4ed8eef2..1da4f6cb01b2 100644
--- a/drivers/misc/vmw_vmci/vmci_queue_pair.c
+++ b/drivers/misc/vmw_vmci/vmci_queue_pair.c
@@ -465,9 +465,8 @@ static int qp_alloc_ppn_set(void *prod_q,
 	for (i = 0; i < num_produce_pages; i++) {
 		unsigned long pfn;
 
-		produce_ppns[i] =
-			produce_q->kernel_if->u.g.pas[i] >> PAGE_SHIFT;
-		pfn = produce_ppns[i];
+		pfn = produce_q->kernel_if->u.g.pas[i] >> PAGE_SHIFT;
+		produce_ppns[i] = pfn;
 
 		/* Fail allocation if PFN isn't supported by hypervisor. */
 		if (sizeof(pfn) > sizeof(*produce_ppns)
@@ -478,9 +477,8 @@ static int qp_alloc_ppn_set(void *prod_q,
 	for (i = 0; i < num_consume_pages; i++) {
 		unsigned long pfn;
 
-		consume_ppns[i] =
-			consume_q->kernel_if->u.g.pas[i] >> PAGE_SHIFT;
-		pfn = consume_ppns[i];
+		pfn = consume_q->kernel_if->u.g.pas[i] >> PAGE_SHIFT;
+		consume_ppns[i] = pfn;
 
 		/* Fail allocation if PFN isn't supported by hypervisor. */
 		if (sizeof(pfn) > sizeof(*consume_ppns)
-- 
2.17.1

