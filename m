Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38557C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 09:30:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F18DD20881
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 09:30:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F18DD20881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933094AbeGIJaw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 05:30:52 -0400
Received: from baptiste.telenet-ops.be ([195.130.132.51]:53580 "EHLO
        baptiste.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932869AbeGIJao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 05:30:44 -0400
Received: from ayla.of.borg ([84.194.111.163])
        by baptiste.telenet-ops.be with bizsmtp
        id 8ZWi1y00W3XaVaC01ZWibW; Mon, 09 Jul 2018 11:30:43 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ayla.of.borg with esmtp (Exim 4.86_2)
        (envelope-from <geert@linux-m68k.org>)
        id 1fcSVG-0002dm-PO; Mon, 09 Jul 2018 11:30:42 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1fcSVG-00069Y-Nz; Mon, 09 Jul 2018 11:30:42 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Greg Ungerer <gerg@linux-m68k.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Helge Deller <deller@gmx.de>
Cc:     linux-m68k@lists.linux-m68k.org, netdev@vger.kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 3/5] Input: hilkbd - Add casts to HP9000/300 I/O accessors
Date:   Mon,  9 Jul 2018 11:30:38 +0200
Message-Id: <20180709093040.23597-4-geert@linux-m68k.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180709093040.23597-1-geert@linux-m68k.org>
References: <20180709093040.23597-1-geert@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Internally, hilkbd uses "unsigned long" I/O addresses everywhere.
This works fine as:
  - On PA-RISC, hilkbd uses the gsc_{read,write}b() I/O accessors, which
    take "unsigned long" addresses,
  - On m68k, hilkbd uses {read,write}b(), which are currently mapped to
    {in,out}_8(), and convert the passed addresses to pointers
    internally.

However, the asm-generic version of {read,write}b() does not perform
such conversions, and requires passing pointers instead.  Hence add
casts to prepare for switching m68k to the asm-generic version.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
This is a dependency for "m68k/io: Switch mmu variant to
<asm-generic/io.h>".

v2:
  - No changes.
---
 drivers/input/keyboard/hilkbd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/keyboard/hilkbd.c b/drivers/input/keyboard/hilkbd.c
index a4e404aaf64bdb82..5c7afdec192c139b 100644
--- a/drivers/input/keyboard/hilkbd.c
+++ b/drivers/input/keyboard/hilkbd.c
@@ -57,8 +57,8 @@ MODULE_LICENSE("GPL v2");
  #define HIL_DATA		0x1
  #define HIL_CMD		0x3
  #define HIL_IRQ		2
- #define hil_readb(p)		readb(p)
- #define hil_writeb(v,p)	writeb((v),(p))
+ #define hil_readb(p)		readb((const volatile void __iomem *)(p))
+ #define hil_writeb(v, p)	writeb((v), (volatile void __iomem *)(p))
 
 #else
 #error "HIL is not supported on this platform"
-- 
2.17.1

