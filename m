Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B517C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:18:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C37C20879
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548170328;
	bh=RPbjgK1y+1ySgVYJDdgMdSN/kkpnmP5oh0vPnpViObY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YFzkjrzFK4Eq8rxigQpUI6Hs7Bzx/NcdxFAV7PeOSIld8KdcfhLqkX3/KDE9RbxLT
	 Z/ebX/BxcJqfTVW4gNNSN+ywDTXxO8kzgPlOs8ZS9SMrIiXgV99dYIHiPKHeaDPKWd
	 EIjst8WKHowymQMgVpW9dmgXl1UbQmuxwsIRCMaE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729234AbfAVPSq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 10:18:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:59308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729287AbfAVPS3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 10:18:29 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 24804217D4;
        Tue, 22 Jan 2019 15:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548170308;
        bh=RPbjgK1y+1ySgVYJDdgMdSN/kkpnmP5oh0vPnpViObY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UturEpUyV/vZGgxeg7XA5N/SMJwn20VlXZ+Ve3o362aMg9eTlzNGWxeYJQfSVAeQf
         7W6WLZF3rYSBc+8TuElvM9cHl/jJDTOscsI5t9xcFpVJ/GXxmJoRCGrGAap2AikAfE
         1x00lA+69WCOGHPe6+wznNtfspI+5Gkab7NM0lnM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christian Benvenuti <benve@cisco.com>,
        Nelson Escobar <neescoba@cisco.com>,
        Parvi Kaustubhi <pkaustub@cisco.com>
Subject: [PATCH 7/8] infiniband: usnic: no need to check return value of debugfs_create functions
Date:   Tue, 22 Jan 2019 16:17:59 +0100
Message-Id: <20190122151800.15092-8-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190122151800.15092-1-gregkh@linuxfoundation.org>
References: <20190122151800.15092-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When calling debugfs functions, there is no need to ever check the
return value.  The function can work or not, but the code logic should
never do something different based on this.

Cc: Christian Benvenuti <benve@cisco.com>
Cc: Nelson Escobar <neescoba@cisco.com>
Cc: Parvi Kaustubhi <pkaustub@cisco.com>
Cc: Doug Ledford <dledford@redhat.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-rdma@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/hw/usnic/usnic_debugfs.c | 26 ---------------------
 1 file changed, 26 deletions(-)

diff --git a/drivers/infiniband/hw/usnic/usnic_debugfs.c b/drivers/infiniband/hw/usnic/usnic_debugfs.c
index a3115709fb03..e5a3f02fb078 100644
--- a/drivers/infiniband/hw/usnic/usnic_debugfs.c
+++ b/drivers/infiniband/hw/usnic/usnic_debugfs.c
@@ -113,42 +113,21 @@ static const struct file_operations flowinfo_ops = {
 void usnic_debugfs_init(void)
 {
 	debugfs_root = debugfs_create_dir(DRV_NAME, NULL);
-	if (IS_ERR(debugfs_root)) {
-		usnic_err("Failed to create debugfs root dir, check if debugfs is enabled in kernel configuration\n");
-		goto out_clear_root;
-	}
 
 	flows_dentry = debugfs_create_dir("flows", debugfs_root);
-	if (IS_ERR_OR_NULL(flows_dentry)) {
-		usnic_err("Failed to create debugfs flow dir with err %ld\n",
-				PTR_ERR(flows_dentry));
-		goto out_free_root;
-	}
 
 	debugfs_create_file("build-info", S_IRUGO, debugfs_root,
 				NULL, &usnic_debugfs_buildinfo_ops);
-	return;
-
-out_free_root:
-	debugfs_remove_recursive(debugfs_root);
-out_clear_root:
-	debugfs_root = NULL;
 }
 
 void usnic_debugfs_exit(void)
 {
-	if (!debugfs_root)
-		return;
-
 	debugfs_remove_recursive(debugfs_root);
 	debugfs_root = NULL;
 }
 
 void usnic_debugfs_flow_add(struct usnic_ib_qp_grp_flow *qp_flow)
 {
-	if (IS_ERR_OR_NULL(flows_dentry))
-		return;
-
 	scnprintf(qp_flow->dentry_name, sizeof(qp_flow->dentry_name),
 			"%u", qp_flow->flow->flow_id);
 	qp_flow->dbgfs_dentry = debugfs_create_file(qp_flow->dentry_name,
@@ -156,11 +135,6 @@ void usnic_debugfs_flow_add(struct usnic_ib_qp_grp_flow *qp_flow)
 							flows_dentry,
 							qp_flow,
 							&flowinfo_ops);
-	if (IS_ERR_OR_NULL(qp_flow->dbgfs_dentry)) {
-		usnic_err("Failed to create dbg fs entry for flow %u with error %ld\n",
-				qp_flow->flow->flow_id,
-				PTR_ERR(qp_flow->dbgfs_dentry));
-	}
 }
 
 void usnic_debugfs_flow_remove(struct usnic_ib_qp_grp_flow *qp_flow)
-- 
2.20.1

