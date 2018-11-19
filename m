Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81882C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:06:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41C9221582
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:06:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="O3HOeVWp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41C9221582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407229AbeKTDbF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:31:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:46346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405956AbeKTDbE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:31:04 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1226E2146D;
        Mon, 19 Nov 2018 17:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542647206;
        bh=gcLfoWP5bDcA1dwcMp7aF3wcYXNz7H/VcyBTUJTbZm4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O3HOeVWp4tiac43RqGus1XYnX5ial/lruwzT+9Kx05tyL5+yiKGdwWRzVW9+2V4hL
         BPzRwNFVh8vsC/k1He07s2HqyfIX5aFH7vpP2/JLpslwVaUpOjfeAA4MEA4KmmWvQ2
         8hHOL3S2Xu30VMPKIEBw+CVmBukZWZAj2RCVhn+s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Robert Jarzmik <robert.jarzmik@free.fr>,
        Arnd Bergmann <arnd@arndb.de>,
        Boris Brezillon <boris.brezillon@bootlin.com>
Subject: [PATCH 3.18 69/90] mtd: docg3: dont set conflicting BCH_CONST_PARAMS option
Date:   Mon, 19 Nov 2018 17:29:51 +0100
Message-Id: <20181119162631.432666788@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162620.585061184@linuxfoundation.org>
References: <20181119162620.585061184@linuxfoundation.org>
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

From: Arnd Bergmann <arnd@arndb.de>

commit be2e1c9dcf76886a83fb1c433a316e26d4ca2550 upstream.

I noticed during the creation of another bugfix that the BCH_CONST_PARAMS
option that is set by DOCG3 breaks setting variable parameters for any
other users of the BCH library code.

The only other user we have today is the MTD_NAND software BCH
implementation (most flash controllers use hardware BCH these days
and are not affected). I considered removing BCH_CONST_PARAMS entirely
because of the inherent conflict, but according to the description in
lib/bch.c there is a significant performance benefit in keeping it.

To avoid the immediate problem of the conflict between MTD_NAND_BCH
and DOCG3, this only sets the constant parameters if MTD_NAND_BCH
is disabled, which should fix the problem for all cases that
are affected. This should also work for all stable kernels.

Note that there is only one machine that actually seems to use the
DOCG3 driver (arch/arm/mach-pxa/mioa701.c), so most users should have
the driver disabled, but it almost certainly shows up if we wanted
to test random kernels on machines that use software BCH in MTD.

Fixes: d13d19ece39f ("mtd: docg3: add ECC correction code")
Cc: stable@vger.kernel.org
Cc: Robert Jarzmik <robert.jarzmik@free.fr>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mtd/devices/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/mtd/devices/Kconfig
+++ b/drivers/mtd/devices/Kconfig
@@ -200,7 +200,7 @@ comment "Disk-On-Chip Device Drivers"
 config MTD_DOCG3
 	tristate "M-Systems Disk-On-Chip G3"
 	select BCH
-	select BCH_CONST_PARAMS
+	select BCH_CONST_PARAMS if !MTD_NAND_BCH
 	select BITREVERSE
 	---help---
 	  This provides an MTD device driver for the M-Systems DiskOnChip


