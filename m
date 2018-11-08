Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 342F8C43610
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:45:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFF4820857
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:45:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="p1picjWY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFF4820857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728862AbeKIIXd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 03:23:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:46888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727332AbeKIHcD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:32:03 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2315520840;
        Thu,  8 Nov 2018 21:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714076;
        bh=I2XuxfYnEAaj2Y+lwxYpaBRnHFMhupnJfXPORo6ly9I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p1picjWY2huSNn4ZBkq8fR3giLrTPibuDNjteWwplbzErIubJLwEGwjFQ3GyxeJ/t
         oqKFYV5z4cA9bZKT5yebJYyBQamUnQ2J7w89eSXMxlfDU7JIQlENtM87v3WgvD0DDi
         DP1Ngc8Y6KjmMzqDSnCN54PhhA6A8i18H8B94YXI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Maik Broemme <mbroemme@libmpq.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 043/144] PCI: Mark Atheros AR9580 to avoid bus reset
Date:   Thu,  8 Nov 2018 13:50:14 -0800
Message-Id: <20181108215057.964730708@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215054.826084593@linuxfoundation.org>
References: <20181108215054.826084593@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

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



