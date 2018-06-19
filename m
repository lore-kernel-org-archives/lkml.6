Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58FD7C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 05:07:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C35920874
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 05:07:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=roeck-us.net header.i=@roeck-us.net header.b="lg7BLrE2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C35920874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756035AbeFSFHP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 01:07:15 -0400
Received: from bh-25.webhostbox.net ([208.91.199.152]:40006 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755685AbeFSFHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 01:07:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=Message-Id:Date:Subject:Cc:To:From:Sender:
        Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Z8cgD585kDnUvVqPEvFGplPJrwxAwOKkUDpJZ22iRLw=; b=lg7BLrE2LKnr6iL+zQOLNMV+jg
        k6o7DI0EY+Kfyy2O9LDx1gDfkHoBrDWr89+4yb9/5fU3zSEU/RvPwVawjse1p+z6ETUf9RrXPJDNh
        AeEdVjzU96fYK8gbPilXykE4VbmTdUANmn0Xg3f0COl3q7f9LibE4XEnHTvloX3e7/+ijGKHEf9NM
        4KlDifY/GpbUHIMaQa+oeuEUAEfN73rtVZHqk7OPxLrsTEJASNP3/swOSQDFigFbktsMEwrdPYD6/
        CbTxnvpx9Q/Tk56x22IedYN+ZmxCzKOdpNUd9u2zwQ01Ia78YX3N1PMSqkTdUS5UjAlSqQcyYIZf3
        gGLE0bJQ==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:41206 helo=localhost)
        by bh-25.webhostbox.net with esmtpa (Exim 4.89)
        (envelope-from <linux@roeck-us.net>)
        id 1fV8rG-000M8D-Jd; Tue, 19 Jun 2018 05:07:11 +0000
From:   Guenter Roeck <linux@roeck-us.net>
To:     Russell King <linux@armlinux.org.uk>
Cc:     Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: [RFC PATCH] ARM: Use logical or instead of addition for badr address calculation
Date:   Mon, 18 Jun 2018 22:07:08 -0700
Message-Id: <1529384828-2452-1-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.7.4
X-Authenticated_sender: guenter@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: authenticated_id: guenter@roeck-us.net
X-Authenticated-Sender: bh-25.webhostbox.net: guenter@roeck-us.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modern assemblers may take the ISA into account when resolving local
symbols. This can result in bad address calculations when using badr
in the wrong location since the offset + 1 may be added twice, resulting
in an even address target for THUMB instructions. This in turn results
in an exception at (destination address + 2).

Unhandled exception: IPSR = 00000006 LR = fffffff1
CPU: 0 PID: 1 Comm: init Not tainted 4.18.0-rc1-00026-gf773e5bdf0c9 #15
Hardware name: MPS2 (Device Tree Support)
PC is at ret_fast_syscall+0x2/0x58
LR is at tty_ioctl+0x2a5/0x528
pc : [<21009002>]    lr : [<210d1535>]    psr: 4000000b
sp : 21825fa8  ip : 0000001c  fp : 21a95892
r10: 00000000  r9 : 21824000  r8 : 210091c0
r7 : 00000036  r6 : 21ae1ee0  r5 : 00000000  r4 : 21ae1f3c
r3 : 00000000  r2 : 3d9adc25  r1 : 00000000  r0 : 00000000
xPSR: 4000000b
CPU: 0 PID: 1 Comm: init Not tainted 4.18.0-rc1-00026-gf773e5bdf0c9 #15
Hardware name: MPS2 (Device Tree Support)
[<2100bd8d>] (unwind_backtrace) from [<2100b13b>] (show_stack+0xb/0xc)
[<2100b13b>] (show_stack) from [<2100b87b>] (__invalid_entry+0x4b/0x4c)

Fix the problem by using a logical or instead of an addition. This is
less efficient but guaranteed to work.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
RFC: I don't really like this, but my ARM assembler knowledge is quite
limited. Just dropping the "+ 1" from badr doesn't work because some
other code needs it (the image hangs completely if I try that).
Ultimately I don't even know if the invoke_syscall macro should just
have used adr instead of badr (but then how did this ever work ?).

Seen with various toolchains based on gcc 7.x and binutils 2.30 when
building and testing MPS2 images.

 arch/arm/include/asm/assembler.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/assembler.h b/arch/arm/include/asm/assembler.h
index 0cd4dccbae78..24c87ff2060f 100644
--- a/arch/arm/include/asm/assembler.h
+++ b/arch/arm/include/asm/assembler.h
@@ -195,7 +195,8 @@
 	.irp	c,,eq,ne,cs,cc,mi,pl,vs,vc,hi,ls,ge,lt,gt,le,hs,lo
 	.macro	badr\c, rd, sym
 #ifdef CONFIG_THUMB2_KERNEL
-	adr\c	\rd, \sym + 1
+	adr\c	\rd, \sym
+	orr	\rd, #1
 #else
 	adr\c	\rd, \sym
 #endif
-- 
2.7.4

