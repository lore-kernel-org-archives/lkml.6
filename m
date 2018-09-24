Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50BF6C43382
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 22:45:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10BB920843
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 22:45:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10BB920843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727622AbeIYEt5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 00:49:57 -0400
Received: from muru.com ([72.249.23.125]:57100 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727397AbeIYEtw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 00:49:52 -0400
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id D07458140;
        Mon, 24 Sep 2018 22:49:42 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     linux-omap@vger.kernel.org
Cc:     Dave Gerlach <d-gerlach@ti.com>, Faiz Abbas <faiz_abbas@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Keerthy <j-keerthy@ti.com>, Nishanth Menon <nm@ti.com>,
        Suman Anna <s-anna@ti.com>, Tero Kristo <t-kristo@ti.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 4/4] bus: ti-sysc: Detect devices on am335x when DEBUG is enabled
Date:   Mon, 24 Sep 2018 15:44:45 -0700
Message-Id: <20180924224445.97239-5-tony@atomide.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924224445.97239-1-tony@atomide.com>
References: <20180924224445.97239-1-tony@atomide.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When debug is enabled, we want to see what devices we're detecting
to make things a bit easier for us.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/bus/ti-sysc.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -899,7 +899,8 @@ static const struct sysc_revision_quirk sysc_revision_quirks[] = {
 	SYSC_QUIRK("aess", 0, 0, 0x10, -1, 0x40000000, 0xffffffff, 0),
 	SYSC_QUIRK("control", 0, 0, 0x10, -1, 0x40000900, 0xffffffff, 0),
 	SYSC_QUIRK("cpgmac", 0, 0x1200, 0x1208, 0x1204, 0x4edb1902,
-		   0xffffffff, 0),
+		   0xffff00f0, 0),
+	SYSC_QUIRK("dcan", 0, 0, -1, -1, 0xffffffff, 0xffffffff, 0),
 	SYSC_QUIRK("dcan", 0, 0, -1, -1, 0x00001401, 0xffffffff, 0),
 	SYSC_QUIRK("dwc3", 0, 0, 0x10, -1, 0x500a0200, 0xffffffff, 0),
 	SYSC_QUIRK("epwmss", 0, 0, 0x4, -1, 0x47400001, 0xffffffff, 0),
@@ -909,6 +910,7 @@ static const struct sysc_revision_quirk sysc_revision_quirks[] = {
 	SYSC_QUIRK("hsi", 0, 0, 0x10, 0x14, 0x50043101, 0xffffffff, 0),
 	SYSC_QUIRK("iss", 0, 0, 0x10, -1, 0x40000101, 0xffffffff, 0),
 	SYSC_QUIRK("i2c", 0, 0, 0x10, 0x90, 0x5040000a, 0xfffffff0, 0),
+	SYSC_QUIRK("lcdc", 0, 0, 0x54, -1, 0x4f201000, 0xffffffff, 0),
 	SYSC_QUIRK("mcasp", 0, 0, 0x4, -1, 0x44306302, 0xffffffff, 0),
 	SYSC_QUIRK("mcasp", 0, 0, 0x4, -1, 0x44307b02, 0xffffffff, 0),
 	SYSC_QUIRK("mcbsp", 0, -1, 0x8c, -1, 0, 0, 0),
@@ -920,8 +922,10 @@ static const struct sysc_revision_quirk sysc_revision_quirks[] = {
 	SYSC_QUIRK("ocp2scp", 0, 0, -1, -1, 0x50060007, 0xffffffff, 0),
 	SYSC_QUIRK("padconf", 0, 0, 0x10, -1, 0x4fff0800, 0xffffffff, 0),
 	SYSC_QUIRK("prcm", 0, 0, -1, -1, 0x40000100, 0xffffffff, 0),
+	SYSC_QUIRK("prcm", 0, 0, -1, -1, 0x00004102, 0xffffffff, 0),
 	SYSC_QUIRK("prcm", 0, 0, -1, -1, 0x40000400, 0xffffffff, 0),
 	SYSC_QUIRK("scm", 0, 0, 0x10, -1, 0x40000900, 0xffffffff, 0),
+	SYSC_QUIRK("scm", 0, 0, -1, -1, 0x4e8b0100, 0xffffffff, 0),
 	SYSC_QUIRK("scm", 0, 0, -1, -1, 0x4f000100, 0xffffffff, 0),
 	SYSC_QUIRK("scrm", 0, 0, -1, -1, 0x00000010, 0xffffffff, 0),
 	SYSC_QUIRK("sdio", 0, 0, 0x10, -1, 0x40202301, 0xffffffff, 0),
@@ -931,7 +935,7 @@ static const struct sysc_revision_quirk sysc_revision_quirks[] = {
 	SYSC_QUIRK("slimbus", 0, 0, 0x10, -1, 0x40002903, 0xffffffff, 0),
 	SYSC_QUIRK("spinlock", 0, 0, 0x10, -1, 0x50020000, 0xffffffff, 0),
 	SYSC_QUIRK("rng", 0, 0x1fe0, 0x1fe4, -1, 0x00000020, 0xffffffff, 0),
-	SYSC_QUIRK("rtc", 0, 0x74, 0x78, -1, 0x4eb01908, 0xffffffff, 0),
+	SYSC_QUIRK("rtc", 0, 0x74, 0x78, -1, 0x4eb01908, 0xfffff0f0, 0),
 	SYSC_QUIRK("timer32k", 0, 0, 0x4, -1, 0x00000060, 0xffffffff, 0),
 	SYSC_QUIRK("usbhstll", 0, 0, 0x10, 0x14, 0x00000004, 0xffffffff, 0),
 	SYSC_QUIRK("usb_host_hs", 0, 0, 0x10, 0x14, 0x50700100, 0xffffffff, 0),
-- 
2.19.0
