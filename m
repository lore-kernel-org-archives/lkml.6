Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 413B9C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:18:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF46B20664
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:18:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qPXKIjW+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF46B20664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732006AbeKAIS7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:18:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:35482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731756AbeKAILh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:11:37 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B3E420840;
        Wed, 31 Oct 2018 23:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541027485;
        bh=SqACrfgs/d9XmZW6O+9DDLSbq6aVAwoKyYNB3IL8bgg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qPXKIjW+IIlXiq5qRTmfA3AfMUmdn5ldmq6Qrk53aAdi9j7Ra6iDEP965IuO4oavZ
         tq6ze9CcKcviQo5ohJOyy3Pe6zvUH/JTjnhNJz0Lpb7FPavAGrNngcd1yS+wPcbaQ8
         5MGGQwgDVkkO6m1mYa5OfD+nKb2u91FRzb/BUTXo=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jorgen Hansen <jhansen@vmware.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 35/48] VMCI: Resource wildcard match fixed
Date:   Wed, 31 Oct 2018 19:10:41 -0400
Message-Id: <20181031231054.29333-35-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181031231054.29333-1-sashal@kernel.org>
References: <20181031231054.29333-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jorgen Hansen <jhansen@vmware.com>

[ Upstream commit 11924ba5e671d6caef1516923e2bd8c72929a3fe ]

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
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
index 9a53a30de445..f1164602cec1 100644
--- a/drivers/misc/vmw_vmci/vmci_resource.c
+++ b/drivers/misc/vmw_vmci/vmci_resource.c
@@ -56,7 +56,8 @@ static struct vmci_resource *vmci_resource_lookup(struct vmci_handle handle,
 
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

