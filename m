Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA93BC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:40:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 904A1208E7
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544107206;
	bh=0mJ5bnZdhBC1/33pQ3VG9bRweuwRwgAcGaeVvfZ/SlE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=m6UT61/ZnDDWTkG+z+eHV3g51gaPVRbnbxcslQaIEtdA7kUGylHNVRNrBJkB+6AIE
	 bD7DBvPfll1to+FeAsjQFKbdKTUdLbQc2ZDa3RAPw4RtKy+FkTtvBJ/WL9aTM5OYlf
	 St5yQJJkdAhbjDvvEdffAH84FSkIAygvsIC4Y8/c=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 904A1208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729798AbeLFOkF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 09:40:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:44050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729699AbeLFOkD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 09:40:03 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4432420892;
        Thu,  6 Dec 2018 14:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544107202;
        bh=0mJ5bnZdhBC1/33pQ3VG9bRweuwRwgAcGaeVvfZ/SlE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HmhAAn3SVF00/6/ZrrIbltFLSpPOtzKl5PbHFHxIY9yjCWyD+dSwzvRsqQkJoYgbL
         nHGCO0FBhSyWKNbHVEDEYhtfLXCBJsLh+bxN4gw+Kg0tWwiDxzjO+fUieREGNhE3CU
         Kza0JtL1+mSIjKSYjOWe+lkaLZo5nSuqtM1vftIM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sam Bobroff <sbobroff@linux.ibm.com>,
        Dave Airlie <airlied@redhat.com>
Subject: [PATCH 4.19 14/41] drm/ast: Fix incorrect free on ioregs
Date:   Thu,  6 Dec 2018 15:38:54 +0100
Message-Id: <20181206142950.891060738@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206142949.757402551@linuxfoundation.org>
References: <20181206142949.757402551@linuxfoundation.org>
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

From: Sam Bobroff <sbobroff@linux.ibm.com>

commit dc25ab067645eabd037f1a23d49a666f9e0b8c68 upstream.

If the platform has no IO space, ioregs is placed next to the already
allocated regs. In this case, it should not be separately freed.

This prevents a kernel warning from __vunmap "Trying to vfree()
nonexistent vm area" when unloading the driver.

Fixes: 0dd68309b9c5 ("drm/ast: Try to use MMIO registers when PIO isn't supported")

Signed-off-by: Sam Bobroff <sbobroff@linux.ibm.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Dave Airlie <airlied@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/ast/ast_main.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/ast/ast_main.c
+++ b/drivers/gpu/drm/ast/ast_main.c
@@ -583,7 +583,8 @@ void ast_driver_unload(struct drm_device
 	drm_mode_config_cleanup(dev);
 
 	ast_mm_fini(ast);
-	pci_iounmap(dev->pdev, ast->ioregs);
+	if (ast->ioregs != ast->regs + AST_IO_MM_OFFSET)
+		pci_iounmap(dev->pdev, ast->ioregs);
 	pci_iounmap(dev->pdev, ast->regs);
 	kfree(ast);
 }


