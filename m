Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D181C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:38:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EB8320868
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547570306;
	bh=Y+KvPHh/UdWwPp0ybdebSVSkTlVgWNIACLVKr6x2lvA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QrWTRyflo6UoezVZ0Tz6kHfjF+UcFsULpdpZpSkcKUFU7ze0kOlC38mBWRqXW2+HS
	 IwGyTR9ZYtibAa2X5R0TUO9IBoeFBlo60ZUCMmUeHRNyR/F0HhluTTBiy89zlaUDEG
	 3Deq56rVNH8lz2H3KiSTlv0cQwBkK3KFzDajQ5go=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732086AbfAOQiY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 11:38:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:54184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732051AbfAOQiW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 11:38:22 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D21620868;
        Tue, 15 Jan 2019 16:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547570302;
        bh=Y+KvPHh/UdWwPp0ybdebSVSkTlVgWNIACLVKr6x2lvA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TAfQwDCKNbLD4EEPha3exGp6RiUxtQYskp4zqm6ucSNSGKjDEksYKb4bDuduWfC+K
         5jXCnad8A4mESukt0BkiFZnb+DNY2OdhCJep8+XxdV7Tb/EZCzGyy7ztn7lpq5lk80
         gTo2SSCJmQsiFUHrmeqxokcEMl84pRx7Z7kWEsQs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ley Foon Tan <lftan@altera.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Claudius Heine <claudius.heine.ext@siemens.com>
Subject: [PATCH 4.4 42/51] PCI: altera: Check link status before retrain link
Date:   Tue, 15 Jan 2019 17:35:38 +0100
Message-Id: <20190115154853.319380189@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190115154846.928796000@linuxfoundation.org>
References: <20190115154846.928796000@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ley Foon Tan <lftan@altera.com>

commit c622032ebc538cb3869c312ae3ad235a99da84b6 upstream.

Check the link status before retraining.  If the link is not up, don't
bother trying to retrain it.

[bhelgaas: split code move to separate patch, changelog]
Signed-off-by: Ley Foon Tan <lftan@altera.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: Claudius Heine <claudius.heine.ext@siemens.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/pci/host/pcie-altera.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/pci/host/pcie-altera.c
+++ b/drivers/pci/host/pcie-altera.c
@@ -100,6 +100,10 @@ static bool altera_pcie_link_is_up(struc
 static void altera_pcie_retrain(struct pci_dev *dev)
 {
 	u16 linkcap, linkstat;
+	struct altera_pcie *pcie = dev->bus->sysdata;
+
+	if (!altera_pcie_link_is_up(pcie))
+		return;
 
 	/*
 	 * Set the retrain bit if the PCIe rootport support > 2.5GB/s, but


