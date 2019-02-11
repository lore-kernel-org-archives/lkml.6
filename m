Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEC90C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:49:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7647821855
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549900174;
	bh=0GMVX2udWb1qj0pKX1eNhHD+Yzy2OJIxyDFLhfQ00Bw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=A1/mqW6sy9m+ZbpkOXbQmrZUcvza3scDdmzF8Px3lKa7sZqVTwhOWNso5QQGZ6ck0
	 SSgdvMSrIRs+IP0Nxzg71i/xJody/0uDdgQyhuhfI/f1hVVky285ZFy9VicSxGydLM
	 2ZF3BeGF8jpOabXIOP/eQ7phmyddc+IIJcv90UUg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731930AbfBKOjq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:39:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:50148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731917AbfBKOjl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:39:41 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 06A432082F;
        Mon, 11 Feb 2019 14:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549895980;
        bh=0GMVX2udWb1qj0pKX1eNhHD+Yzy2OJIxyDFLhfQ00Bw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zdh/d0zApXiZfhlv5U+9lmCHHDH6FCUdqT9fLlVU543/Jiyv8hoOSCqyBeKT78vLo
         biAKGTKjs/IxnoEtMtTjD+7HwlHZztH6IBE3PiZYnvsjd8a+DX2vknwl+a9oojpSCs
         KEvap35v1soPToTiVXElCvMOOAGb3hOqHyMQzmpc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Anatolij Gustschin <agust@denx.de>,
        Alan Tull <atull@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 034/313] fpga: altera-cvp: fix bad IO access on x86_64
Date:   Mon, 11 Feb 2019 15:15:14 +0100
Message-Id: <20190211141855.735637309@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141852.749630980@linuxfoundation.org>
References: <20190211141852.749630980@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 187fade88ca0ff2df9d360ca751d948d73db7095 ]

If mapping the CvP BAR fails, we still can configure the FPGA via
PCI config space access. In this case the iomap pointer is NULL.
On x86_64, passing NULL address to pci_iounmap() generates
"Bad IO access at port 0x0" output with stack call trace. Fix it.

Signed-off-by: Anatolij Gustschin <agust@denx.de>
Acked-by: Alan Tull <atull@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/fpga/altera-cvp.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/fpga/altera-cvp.c b/drivers/fpga/altera-cvp.c
index 1f4c26b4794a..7a42c194b944 100644
--- a/drivers/fpga/altera-cvp.c
+++ b/drivers/fpga/altera-cvp.c
@@ -480,7 +480,8 @@ static int altera_cvp_probe(struct pci_dev *pdev,
 	return 0;
 
 err_unmap:
-	pci_iounmap(pdev, conf->map);
+	if (conf->map)
+		pci_iounmap(pdev, conf->map);
 	pci_release_region(pdev, CVP_BAR);
 err_disable:
 	cmd &= ~PCI_COMMAND_MEMORY;
@@ -495,7 +496,8 @@ static void altera_cvp_remove(struct pci_dev *pdev)
 	u16 cmd;
 
 	fpga_mgr_unregister(mgr);
-	pci_iounmap(pdev, conf->map);
+	if (conf->map)
+		pci_iounmap(pdev, conf->map);
 	pci_release_region(pdev, CVP_BAR);
 	pci_read_config_word(pdev, PCI_COMMAND, &cmd);
 	cmd &= ~PCI_COMMAND_MEMORY;
-- 
2.19.1



