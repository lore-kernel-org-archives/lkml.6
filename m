Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C835ECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:03:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3269120844
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:03:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="GYd+suWm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3269120844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731264AbeKIHlA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:41:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:60888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730308AbeKIHk6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:40:58 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 352AD2086C;
        Thu,  8 Nov 2018 22:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714609;
        bh=kah6PMwUdfbRRWVxAkUaZrM3Kfz2pkBTABG9GHdItqc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GYd+suWm3oRDEpXM8zmTRIcHVA1SDVsM1qDxiQ59EKvzlCt+VqEODjjaL8I68vaR0
         zNfE416ieOD+XQLFyoAba49AULqzUaIpJiSarnAAmdOW0B1173BZnuGxf/buYjU/BD
         5F1Si+F7U76727zjCg0NiGjzhKQz7U9Ma7BqhJhY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 042/171] efi/fb: Correct PCI_STD_RESOURCE_END usage
Date:   Thu,  8 Nov 2018 13:50:12 -0800
Message-Id: <20181108215130.557479097@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215127.257643509@linuxfoundation.org>
References: <20181108215127.257643509@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

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



