Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17A22C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 10:59:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF640214C1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 10:59:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="C2csGMd/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF640214C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727203AbeLDK7v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 05:59:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:44820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726541AbeLDK7r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 05:59:47 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A9511214D9;
        Tue,  4 Dec 2018 10:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543921187;
        bh=+qon3sDx99rrMXoRx29FA0e69KBurroIWmKuiJ4bmy8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C2csGMd/2vRz7Tyj3t4lP1eGLMbSD4UokTM6Y7y5/it2Klr7WiV0Aeljbe6eai6t3
         kQoLSNurvPVsBXqjzGEngyhEEQpXcztJw4XJBapxohf34w9nLP0dopvMTNu7cVG1Vs
         IpYTwuNtoOKWXs5Jn5QCcRs88WJLZXeC9Cx1/Eqo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH 4.19 079/139] PCI: layerscape: Fix wrong invocation of outbound window disable accessor
Date:   Tue,  4 Dec 2018 11:49:20 +0100
Message-Id: <20181204103653.414387867@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204103649.950154335@linuxfoundation.org>
References: <20181204103649.950154335@linuxfoundation.org>
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

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

commit c6fd6fe9dea44732cdcd970f1130b8cc50ad685a upstream.

The order of parameters is not correct when invoking the outbound
window disable routine. Fix it.

Fixes: 4a2745d760fa ("PCI: layerscape: Disable outbound windows configured by bootloader")
Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
[lorenzo.pieralisi@arm.com: commit log]
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/pci/controller/dwc/pci-layerscape.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/pci/controller/dwc/pci-layerscape.c
+++ b/drivers/pci/controller/dwc/pci-layerscape.c
@@ -88,7 +88,7 @@ static void ls_pcie_disable_outbound_atu
 	int i;
 
 	for (i = 0; i < PCIE_IATU_NUM; i++)
-		dw_pcie_disable_atu(pcie->pci, DW_PCIE_REGION_OUTBOUND, i);
+		dw_pcie_disable_atu(pcie->pci, i, DW_PCIE_REGION_OUTBOUND);
 }
 
 static int ls1021_pcie_link_up(struct dw_pcie *pci)


