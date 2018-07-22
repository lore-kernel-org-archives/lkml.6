Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3D7BECDFB8
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 21:20:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6432D20878
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 21:20:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6432D20878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387725AbeGVWSW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 18:18:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:38748 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730377AbeGVWSW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 18:18:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CE17AAFC9;
        Sun, 22 Jul 2018 21:20:19 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-kernel@vger.kernel.org,
        Ian Pozella <Ian.Pozella@imgtec.com>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        James Hartley <james.hartley@sondrel.com>,
        Rahul Bedarkar <rahulbedarkar89@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: [PATCH 04/15] MIPS: dts: img: pistachio_marduk: Switch mmc to 1 bit mode
Date:   Sun, 22 Jul 2018 23:19:59 +0200
Message-Id: <20180722212010.3979-5-afaerber@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180722212010.3979-1-afaerber@suse.de>
References: <20180722212010.3979-1-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ian Pozella <Ian.Pozella@imgtec.com>

The mmc block in Pistachio allows 1 to 8 data bits to be used.
Marduk uses 4 bits allowing the upper 4 bits to be allocated
to the Mikrobus ports. However these bits are still connected
internally meaning the mmc block recieves signals on all data lines
and seems the internal HW CRC checks get corrupted by this erroneous
data.

We cannot control what data is sent on these lines because they go
to external ports. 1 bit mode does not exhibit the issue hence the
safe default is to use this. If a user knows that in their use case
they will not use the upper bits then they can set to 4 bit mode in
order to improve performance.

Also make sure that the upper 4 bits don't get allocated to the mmc
driver (the default is to assign all 8 pins) so they can be allocated
to other drivers. Allocating all 4 despite setting 1 bit mode as this
matches what is there in hardware.

Signed-off-by: Ian Pozella <Ian.Pozella@imgtec.com>
Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 arch/mips/boot/dts/img/pistachio_marduk.dts | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/mips/boot/dts/img/pistachio_marduk.dts b/arch/mips/boot/dts/img/pistachio_marduk.dts
index 29358d1f7027..5557a6ad61c3 100644
--- a/arch/mips/boot/dts/img/pistachio_marduk.dts
+++ b/arch/mips/boot/dts/img/pistachio_marduk.dts
@@ -120,6 +120,7 @@
 
 &pin_sdhost_data {
 	drive-strength = <2>;
+	pins = "mfio17", "mfio18", "mfio19", "mfio20";
 };
 
 &pwm {
@@ -132,7 +133,7 @@
 
 &sdhost {
 	status = "okay";
-	bus-width = <4>;
+	bus-width = <1>;
 	disable-wp;
 };
 
-- 
2.16.4

