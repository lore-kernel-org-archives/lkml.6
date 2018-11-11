Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50B17C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:39:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10CE220871
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:39:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="eM1563V2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10CE220871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388242AbeKLJaL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 04:30:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:41934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732379AbeKLITo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:19:44 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 49CF9223D0;
        Sun, 11 Nov 2018 22:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975388;
        bh=00/kpto2FemHKus8ku6jcCUUcTRDfp2x79whSXY3wOw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eM1563V2uNBesCsfoMOSy3Ieom9dTjS/cDy+sBR2ZDonyXeZPav8hpdaCH9feX5Tg
         Egpc7tXwJhOFV8jgQKmV/vEVdPNbVNr+Pj2gskb6LyW0u91rJRABccUFjCmWFnfGeC
         HGRIZSew9ThRl2P6i+rvurXx8WQB9/8Xu4T+Rbos=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jian-Hong Pan <jian-hong@endlessm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.18 050/350] r8169: Enable MSI-X on RTL8106e
Date:   Sun, 11 Nov 2018 14:18:34 -0800
Message-Id: <20181111221709.250552071@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221707.043394111@linuxfoundation.org>
References: <20181111221707.043394111@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/realtek/r8169.c |    9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

--- a/drivers/net/ethernet/realtek/r8169.c
+++ b/drivers/net/ethernet/realtek/r8169.c
@@ -7539,20 +7539,17 @@ static int rtl_alloc_irq(struct rtl8169_
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
 


