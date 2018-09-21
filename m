Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB27FECE562
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 07:46:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AB2021522
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 07:46:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AB2021522
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389341AbeIUNdu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 09:33:50 -0400
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:10508 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388875AbeIUNdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 09:33:50 -0400
X-Greylist: delayed 909 seconds by postgrey-1.27 at vger.kernel.org; Fri, 21 Sep 2018 09:33:49 EDT
Received: from sc9-mailhost3.vmware.com (10.113.161.73) by
 EX13-EDG-OU-002.vmware.com (10.113.208.156) with Microsoft SMTP Server id
 15.0.1156.6; Fri, 21 Sep 2018 00:30:37 -0700
Received: from jhansen-ubuntu-1804.eng.vmware.com (prmh-lab-net3-dhcp232-224.eng.vmware.com [10.24.232.224])
        by sc9-mailhost3.vmware.com (Postfix) with ESMTP id 49A9040840;
        Fri, 21 Sep 2018 00:31:05 -0700 (PDT)
From:   Jorgen Hansen <jhansen@vmware.com>
To:     <linux-kernel@vger.kernel.org>,
        <virtualization@lists.linux-foundation.org>
CC:     <gregkh@linuxfoundation.org>, <pv-drivers@vmware.com>,
        Jorgen Hansen <jhansen@vmware.com>
Subject: [PATCH] VMCI: Resource wildcard match fixed
Date:   Fri, 21 Sep 2018 00:31:05 -0700
Message-ID: <20180921073105.5758-1-jhansen@vmware.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (EX13-EDG-OU-002.vmware.com: jhansen@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When adding a VMCI resource, the check for an existing entry
would ignore that the new entry could be a wildcard. This could
result in multiple resource entries that would match a given
handle. One disastrous outcome of this is that the
refcounting used to ensure that delayed callbacks for VMCI
datagrams have run before the datagram is destroyed can be
wrong, since the refcount could be increased on the duplicate
entry. This in turn leads to a use after free bug. This issue
was discovered by Hangbin Liu using KASAN and syzkaller.

Fixes: bc63dedb7d46 ("VMCI: resource object implementation")
Reported-by: Hangbin Liu <liuhangbin@gmail.com>
Reviewed-by: Adit Ranadive <aditr@vmware.com>
Reviewed-by: Vishnu Dasa <vdasa@vmware.com>
Signed-off-by: Jorgen Hansen <jhansen@vmware.com>
---
 drivers/misc/vmw_vmci/vmci_driver.c   | 2 +-
 drivers/misc/vmw_vmci/vmci_resource.c | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/vmw_vmci/vmci_driver.c b/drivers/misc/vmw_vmci/vmci_driver.c
index d7eaf1eb11e7..003bfba40758 100644
--- a/drivers/misc/vmw_vmci/vmci_driver.c
+++ b/drivers/misc/vmw_vmci/vmci_driver.c
@@ -113,5 +113,5 @@ module_exit(vmci_drv_exit);
 
 MODULE_AUTHOR("VMware, Inc.");
 MODULE_DESCRIPTION("VMware Virtual Machine Communication Interface.");
-MODULE_VERSION("1.1.5.0-k");
+MODULE_VERSION("1.1.6.0-k");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/misc/vmw_vmci/vmci_resource.c b/drivers/misc/vmw_vmci/vmci_resource.c
index 1ab6e8737a5f..da1ee2e1ba99 100644
--- a/drivers/misc/vmw_vmci/vmci_resource.c
+++ b/drivers/misc/vmw_vmci/vmci_resource.c
@@ -57,7 +57,8 @@ static struct vmci_resource *vmci_resource_lookup(struct vmci_handle handle,
 
 		if (r->type == type &&
 		    rid == handle.resource &&
-		    (cid == handle.context || cid == VMCI_INVALID_ID)) {
+		    (cid == handle.context || cid == VMCI_INVALID_ID ||
+		     handle.context == VMCI_INVALID_ID)) {
 			resource = r;
 			break;
 		}
-- 
2.17.1

