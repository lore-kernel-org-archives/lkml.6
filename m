Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F01A6C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 13:27:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7BAC20838
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 13:27:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xp+SfNm7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7BAC20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728395AbeJ3WVM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 18:21:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:52078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728379AbeJ3WVL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 18:21:11 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF8CD2080A;
        Tue, 30 Oct 2018 13:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540906063;
        bh=M2ZZGbGCcO0EqNZtMik8YI+woAbLBCsG882T6AYYYlU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xp+SfNm7CnxT+TVBeX/WAbAHNe+LZfJ38JKMVTfooaq6cpy6ML5wYa3u+z3F4bZR+
         fvTXRF0gMi91cwicSQG5Dv3zEz/NkaGPi8uur44fe9iVp1u+k0VxWfrqEbplZSfYbH
         IHia4yeuMWQHKS/NqBu+S8ZP4eTIHAQeuvbOsQcc=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jian-Hong Pan <jian-hong@endlessm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 15/33] r8169: Enable MSI-X on RTL8106e
Date:   Tue, 30 Oct 2018 09:26:39 -0400
Message-Id: <20181030132657.217970-15-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181030132657.217970-1-sashal@kernel.org>
References: <20181030132657.217970-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jian-Hong Pan <jian-hong@endlessm.com>

[ Upstream commit d49c88d7677ba737e9d2759a87db0402d5ab2607 ]

Originally, we have an issue where r8169 MSI-X interrupt is broken after
S3 suspend/resume on RTL8106e of ASUS X441UAR.

02:00.0 Ethernet controller [0200]: Realtek Semiconductor Co., Ltd.
RTL8101/2/6E PCI Express Fast/Gigabit Ethernet controller [10ec:8136]
(rev 07)
	Subsystem: ASUSTeK Computer Inc. RTL810xE PCI Express Fast
Ethernet controller [1043:200f]
	Flags: bus master, fast devsel, latency 0, IRQ 16
	I/O ports at e000 [size=256]
	Memory at ef100000 (64-bit, non-prefetchable) [size=4K]
	Memory at e0000000 (64-bit, prefetchable) [size=16K]
	Capabilities: [40] Power Management version 3
	Capabilities: [50] MSI: Enable- Count=1/1 Maskable- 64bit+
	Capabilities: [70] Express Endpoint, MSI 01
	Capabilities: [b0] MSI-X: Enable+ Count=4 Masked-
	Capabilities: [d0] Vital Product Data
	Capabilities: [100] Advanced Error Reporting
	Capabilities: [140] Virtual Channel
	Capabilities: [160] Device Serial Number 01-00-00-00-36-4c-e0-00
	Capabilities: [170] Latency Tolerance Reporting
	Kernel driver in use: r8169
	Kernel modules: r8169

We found the all of the values in PCI BAR=4 of the ethernet adapter
become 0xFF after system resumes.  That breaks the MSI-X interrupt.
Therefore, we can only fall back to MSI interrupt to fix the issue at
that time.

However, there is a commit which resolves the drivers getting nothing in
PCI BAR=4 after system resumes.  It is 04cb3ae895d7 "PCI: Reprogram
bridge prefetch registers on resume" by Daniel Drake.

After apply the patch, the ethernet adapter works fine before suspend
and after resume.  So, we can revert the workaround after the commit
"PCI: Reprogram bridge prefetch registers on resume" is merged into main
tree.

This patch reverts commit 7bb05b85bc2d1a1b647b91424b2ed4a18e6ecd81
"r8169: don't use MSI-X on RTL8106e".

Buglink: https://bugzilla.kernel.org/show_bug.cgi?id=201181
Fixes: 7bb05b85bc2d ("r8169: don't use MSI-X on RTL8106e")
Signed-off-by: Jian-Hong Pan <jian-hong@endlessm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/realtek/r8169.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169.c b/drivers/net/ethernet/realtek/r8169.c
index 627c5cd8f786..36422f783fe7 100644
--- a/drivers/net/ethernet/realtek/r8169.c
+++ b/drivers/net/ethernet/realtek/r8169.c
@@ -7541,20 +7541,17 @@ static int rtl_alloc_irq(struct rtl8169_private *tp)
 {
 	unsigned int flags;
 
-	switch (tp->mac_version) {
-	case RTL_GIGA_MAC_VER_01 ... RTL_GIGA_MAC_VER_06:
+	if (tp->mac_version <= RTL_GIGA_MAC_VER_06) {
 		RTL_W8(tp, Cfg9346, Cfg9346_Unlock);
 		RTL_W8(tp, Config2, RTL_R8(tp, Config2) & ~MSIEnable);
 		RTL_W8(tp, Cfg9346, Cfg9346_Lock);
 		flags = PCI_IRQ_LEGACY;
-		break;
-	case RTL_GIGA_MAC_VER_39 ... RTL_GIGA_MAC_VER_40:
+	} else if (tp->mac_version == RTL_GIGA_MAC_VER_40) {
 		/* This version was reported to have issues with resume
 		 * from suspend when using MSI-X
 		 */
 		flags = PCI_IRQ_LEGACY | PCI_IRQ_MSI;
-		break;
-	default:
+	} else {
 		flags = PCI_IRQ_ALL_TYPES;
 	}
 
-- 
2.17.1

