Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51EF8C64EAE
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 21:50:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 203A02087A
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 21:50:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 203A02087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728986AbeI3EUp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 00:20:45 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:52106 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728818AbeI3ESg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 00:18:36 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N6G-0000Gy-Jn; Sat, 29 Sep 2018 22:48:32 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N5w-0006rL-4h; Sat, 29 Sep 2018 22:48:12 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Konrad Rzeszutek Wilk" <konrad.wilk@oracle.com>,
        "David Woodhouse" <dwmw@amazon.co.uk>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Jim Mattson" <jmattson@google.com>
Date:   Sat, 29 Sep 2018 22:43:07 +0100
Message-ID: <lsq.1538257387.550512017@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 031/131] x86/cpu: Make alternative_msr_write work for
 32-bit code
In-Reply-To: <lsq.1538257386.330095874@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.59-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Jim Mattson <jmattson@google.com>

commit 5f2b745f5e1304f438f9b2cd03ebc8120b6e0d3b upstream.

Cast val and (val >> 32) to (u32), so that they fit in a
general-purpose register in both 32-bit and 64-bit code.

[ tglx: Made it u32 instead of uintptr_t ]

Fixes: c65732e4f721 ("x86/cpu: Restore CPUID_8000_0008_EBX reload")
Signed-off-by: Jim Mattson <jmattson@google.com>
Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/include/asm/nospec-branch.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -219,8 +219,8 @@ void alternative_msr_write(unsigned int
 {
 	asm volatile(ALTERNATIVE("", "wrmsr", %c[feature])
 		: : "c" (msr),
-		    "a" (val),
-		    "d" (val >> 32),
+		    "a" ((u32)val),
+		    "d" ((u32)(val >> 32)),
 		    [feature] "i" (feature)
 		: "memory");
 }

