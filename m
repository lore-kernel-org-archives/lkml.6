Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC907C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:29:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D0732083E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:29:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="yYGgXDpE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D0732083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730424AbeJYWwP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:52:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:34200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727716AbeJYWwP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:52:15 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 798A320834;
        Thu, 25 Oct 2018 14:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540477157;
        bh=YCb22vZq/ZPqfOr8fvnObLi2pctAxtAE0vzr66qzzrM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yYGgXDpErWRVuis3eL2ugl3lgu9PaoLAxn6iSizh1zbc/SMKYihao9AjDVQsDf9Uh
         PORhqb4nFOVa7GLUIbNpldzT1s2653cz6bQmzl6b+NrsVqzAC368Dgv74leDDuXPsP
         u+OZWAZN0Ui6KFx9oPYQ2ksFb3kQQd2lgc98xBj4=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Maik Broemme <mbroemme@libmpq.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 3.18 13/98] PCI: Mark Atheros AR9580 to avoid bus reset
Date:   Thu, 25 Oct 2018 10:17:28 -0400
Message-Id: <20181025141853.214051-13-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141853.214051-1-sashal@kernel.org>
References: <20181025141853.214051-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maik Broemme <mbroemme@libmpq.org>

[ Upstream commit 8e2e03179923479ca0c0b6fdc7c93ecf89bce7a8 ]

Similar to the AR93xx and the AR94xx series, the AR95xx also have the same
quirk for the Bus Reset.  It will lead to instant system reset if the
device is assigned via VFIO to a KVM VM.  I've been able reproduce this
behavior with a MikroTik R11e-2HnD.

Fixes: c3e59ee4e766 ("PCI: Mark Atheros AR93xx to avoid bus reset")
Signed-off-by: Maik Broemme <mbroemme@libmpq.org>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
CC: stable@vger.kernel.org	# v3.14+
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/quirks.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 9e86ace95832..0b75b47a5329 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3081,6 +3081,7 @@ static void quirk_no_bus_reset(struct pci_dev *dev)
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x0030, quirk_no_bus_reset);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x0032, quirk_no_bus_reset);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x003c, quirk_no_bus_reset);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x0033, quirk_no_bus_reset);
 
 #ifdef CONFIG_ACPI
 /*
-- 
2.17.1

