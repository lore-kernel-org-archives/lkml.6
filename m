Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0BC6C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:09:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8692B21726
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548169766;
	bh=lOvZvWo200NC275nlkwf3zbnjVPp4SsmUV2BEn9lBKE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kYydr13wOfe3Xsqoyt9Ta6qxh4KbCzeFGoSdPITuJ2PeYlw6MvQgmpDRgusmivR9J
	 1j2maO6EZ4A/rpNXGSypDNWFgxz3QJm9MfTNguQKrd+XnCKw07ujULhhn50h6TXxFX
	 im2KfR7vWfXH92fCKazUBsrY3W3/5mYjJUXJYQ2U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729078AbfAVPJY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 10:09:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:48648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729052AbfAVPJX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 10:09:23 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2118E21721;
        Tue, 22 Jan 2019 15:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548169762;
        bh=lOvZvWo200NC275nlkwf3zbnjVPp4SsmUV2BEn9lBKE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KiFaggMlk5fSvyifHYNgtDyjD8yDrv4oWvbH5r7JX9GtNAOmvywzTBlZqWnOiFpLN
         uUWlEDsAnANNJk/eOunNgluWnSdSL7Zuo19i8BjOmCXjmwMPqySEmzK9+EBhWdpPPY
         5tNIvBK2n2Iz1TFNrVAustOzb9g+woB5H3D0yRuc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     James Bottomley <jejb@linux.ibm.com>,
        Martin Petersen <martin.petersen@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Varun Prakash <varun@chelsio.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Oza Pawandeep <poza@codeaurora.org>
Subject: [PATCH 2/7] scsi: csiostor: no need to check return value of debugfs_create functions
Date:   Tue, 22 Jan 2019 16:09:01 +0100
Message-Id: <20190122150906.12470-3-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190122150906.12470-1-gregkh@linuxfoundation.org>
References: <20190122150906.12470-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When calling debugfs functions, there is no need to ever check the
return value.  The function can work or not, but the code logic should
never do something different based on this.

Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Varun Prakash <varun@chelsio.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Oza Pawandeep <poza@codeaurora.org>
Cc: linux-scsi@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/csiostor/csio_init.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/scsi/csiostor/csio_init.c b/drivers/scsi/csiostor/csio_init.c
index cf629380a981..460e4ee1c8fe 100644
--- a/drivers/scsi/csiostor/csio_init.c
+++ b/drivers/scsi/csiostor/csio_init.c
@@ -167,14 +167,10 @@ csio_dfs_destroy(struct csio_hw *hw)
  * csio_dfs_init - Debug filesystem initialization for the module.
  *
  */
-static int
+static void
 csio_dfs_init(void)
 {
 	csio_debugfs_root = debugfs_create_dir(KBUILD_MODNAME, NULL);
-	if (!csio_debugfs_root)
-		pr_warn("Could not create debugfs entry, continuing\n");
-
-	return 0;
 }
 
 /*
-- 
2.20.1

