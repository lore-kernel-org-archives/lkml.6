Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96066C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:25:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 614AB20855
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548696327;
	bh=SfeZGNBJC8y7PsT3PChTE0GMximgE5+qk8Jer44np60=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HpSobXPpshy10vQP+yJfXK5MMXbViM+oJoIuBVzAm+g46WeEBkczKBOmfSDDxroUt
	 3dbhknbnAJ/37SR2Zr15xcDePuIJnPQLg2yRZXSDXm+6iZcWJwbfclnU8oT8f+Tg19
	 f3HsL5m8hv4XVpO2T058kzi94XP0b98gBOtE+/4w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730095AbfA1QBM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:01:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:46454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730934AbfA1QBJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:01:09 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 59A2B21848;
        Mon, 28 Jan 2019 16:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548691268;
        bh=SfeZGNBJC8y7PsT3PChTE0GMximgE5+qk8Jer44np60=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PO3j8j0H90fDuR7PMDDK+ckJuLD4jDn1HxMgR+zF2MG+t1qrpHli2Akm3mqFU6PM5
         EAsdwEBhLzXUr5xrhPwJkG7puCoUDvfmrCWEhV4wU2QSFiqLN9rB38UyOS6LLMo7+q
         vj3MTZx7E2zR4VEODxtOWeNdEocgxSWaGMBpzmL8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Anatolij Gustschin <agust@denx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-fpga@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 039/258] fpga: altera-cvp: fix 'bad IO access' on x86_64
Date:   Mon, 28 Jan 2019 10:55:45 -0500
Message-Id: <20190128155924.51521-39-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128155924.51521-1-sashal@kernel.org>
References: <20190128155924.51521-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anatolij Gustschin <agust@denx.de>

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

