Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77033C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:53:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D488214C1
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:53:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y59rhGf/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D488214C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390766AbeKTDRh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:17:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:56090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389985AbeKTDRg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:17:36 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D737921104;
        Mon, 19 Nov 2018 16:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542646402;
        bh=8JwLIRtnmwdhRAKSChuEXRfBsArmbLrDkpcwxP5G4Mk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y59rhGf/f7uIql7k6bi+Y41I476/fHvS8vM77WUx280XEak9o8FRhp8aAP6sVo/iq
         e/8s/dhMBJXw0xJ21nxtQJ9+z4a49s3l+w1SVD6IN34CIm0pGvK6nPOL6sh7nqhs5f
         nCFq9dUgdBPeBo8MopQUdd9PF/9zPMGXD4K8K+QA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Helge Deller <deller@gmx.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 27/83] parisc: Fix HPMC handler by increasing size to multiple of 16 bytes
Date:   Mon, 19 Nov 2018 17:28:53 +0100
Message-Id: <20181119162617.793311938@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162612.046511542@linuxfoundation.org>
References: <20181119162612.046511542@linuxfoundation.org>
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

[ Upstream commit d5654e156bc4d68a87bbaa6d7e020baceddf6e68 ]

Make sure that the HPMC (High Priority Machine Check) handler is 16-byte
aligned and that it's length in the IVT is a multiple of 16 bytes.
Otherwise PDC may decide not to call the HPMC crash handler.

Signed-off-by: Helge Deller <deller@gmx.de>
Cc: stable@vger.kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/parisc/kernel/hpmc.S | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/parisc/kernel/hpmc.S b/arch/parisc/kernel/hpmc.S
index 38d461aec46d..407b3aa5aa07 100644
--- a/arch/parisc/kernel/hpmc.S
+++ b/arch/parisc/kernel/hpmc.S
@@ -83,6 +83,7 @@ END(hpmc_pim_data)
 	.text
 
 	.import intr_save, code
+	.align 16
 ENTRY_CFI(os_hpmc)
 .os_hpmc:
 
@@ -299,12 +300,15 @@ os_hpmc_6:
 
 	b .
 	nop
+	.align 16	/* make function length multiple of 16 bytes */
 ENDPROC_CFI(os_hpmc)
 .os_hpmc_end:
 
 
 	__INITRODATA
+.globl os_hpmc_size
 	.align 4
-	.export os_hpmc_size
+	.type   os_hpmc_size, @object
+	.size   os_hpmc_size, 4
 os_hpmc_size:
 	.word .os_hpmc_end-.os_hpmc
-- 
2.17.1



