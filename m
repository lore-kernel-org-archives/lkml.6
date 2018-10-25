Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49951ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:14:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B9F42084A
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:14:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="uifSirRD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B9F42084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728619AbeJYWrk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:47:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:55792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727505AbeJYWrj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:47:39 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BDF3B20848;
        Thu, 25 Oct 2018 14:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540476883;
        bh=oEbptfxUcBjfEGTU0tN3sj/WqJVU6PsBjEMUtn4TZAg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uifSirRDS4SU5jCI7hRS1RJNiAL+A4WOR5/YXd6Qe2I42dkz1BwErySZZuXULgifX
         KBTizosjq/PU2FKE3tcXkuekgBb70zkCMomho928gNwCg6NDBLiSbOdAjL+uKv/Uuk
         OnznGtty73fxf3KeUKplslbuaRJu1dxIrKo3S0PE=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 11/98] efi/fb: Correct PCI_STD_RESOURCE_END usage
Date:   Thu, 25 Oct 2018 10:12:56 -0400
Message-Id: <20181025141423.213774-11-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141423.213774-1-sashal@kernel.org>
References: <20181025141423.213774-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

[ Upstream commit 92a16c86299c64f58f320e491977408ba31b8c3c ]

PCI_STD_RESOURCE_END is (confusingly) the index of the last valid BAR, not
the *number* of BARs.  To iterate through all possible BARs, we need to
include PCI_STD_RESOURCE_END.

Fixes: 55d728a40d36 ("efi/fb: Avoid reconfiguration of BAR that covers the framebuffer")
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/fbdev/efifb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/efifb.c b/drivers/video/fbdev/efifb.c
index 6f2e729a308f..f4b6d063a4b7 100644
--- a/drivers/video/fbdev/efifb.c
+++ b/drivers/video/fbdev/efifb.c
@@ -375,7 +375,7 @@ static void efifb_fixup_resources(struct pci_dev *dev)
 	if (!base)
 		return;
 
-	for (i = 0; i < PCI_STD_RESOURCE_END; i++) {
+	for (i = 0; i <= PCI_STD_RESOURCE_END; i++) {
 		struct resource *res = &dev->resource[i];
 
 		if (!(res->flags & IORESOURCE_MEM))
-- 
2.17.1

