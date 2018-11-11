Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0743AC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:15:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C92DA2148E
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:15:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C92DA2148E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731775AbeKLGFG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:05:06 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:53024 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725905AbeKLGFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 01:05:05 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvt8-0000lJ-KN; Sun, 11 Nov 2018 19:59:18 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsP-0001Rp-PW; Sun, 11 Nov 2018 19:58:33 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Geert Uytterhoeven" <geert@linux-m68k.org>,
        "Miquel Raynal" <miquel.raynal@bootlin.com>,
        "Boris Brezillon" <boris.brezillon@bootlin.com>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.249488773@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 072/366] m68k: Implement ndelay() as an inline
 function to force type checking/casting
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Boris Brezillon <boris.brezillon@bootlin.com>

commit d8441ba80c55aad435e4b98fe0d7ad5d21e46bf9 upstream.

ndelay() is supposed to take an unsigned long, but if you define
ndelay() as a macro and the caller pass an unsigned long long instead
of an unsigned long, the unsigned long long to unsigned long cast is
not done and we end up with an "undefined reference to `__udivdi3'"
error at link time.

Fix that by making ndelay() an inline function and then defining dummy
ndelay() macro that redirects to the ndelay() function (it's how most
archs do to implement ndelay()).

Fixes: c8ee038bd148 ("m68k: Implement ndelay() based on the existing udelay() logic")
Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
[geert: Remove comment now it is no longer a macro]
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/m68k/include/asm/delay.h | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

--- a/arch/m68k/include/asm/delay.h
+++ b/arch/m68k/include/asm/delay.h
@@ -48,8 +48,6 @@ extern void __bad_udelay(void);
  * The simpler m68k and ColdFire processors do not have a 32*32->64
  * multiply instruction. So we need to handle them a little differently.
  * We use a bit of shifting and a single 32*32->32 multiply to get close.
- * This is a macro so that the const version can factor out the first
- * multiply and shift.
  */
 #define	HZSCALE		(268435456 / (1000000 / HZ))
 
@@ -114,6 +112,13 @@ static inline void __udelay(unsigned lon
  */
 #define	HZSCALE		(268435456 / (1000000 / HZ))
 
-#define ndelay(n) __delay(DIV_ROUND_UP((n) * ((((HZSCALE) >> 11) * (loops_per_jiffy >> 11)) >> 6), 1000))
+static inline void ndelay(unsigned long nsec)
+{
+	__delay(DIV_ROUND_UP(nsec *
+			     ((((HZSCALE) >> 11) *
+			       (loops_per_jiffy >> 11)) >> 6),
+			     1000));
+}
+#define ndelay(n) ndelay(n)
 
 #endif /* defined(_M68K_DELAY_H) */

