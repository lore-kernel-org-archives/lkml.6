Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E24A4C28CF8
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 08:48:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA8F62064E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 08:48:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA8F62064E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbeJOQcY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 12:32:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:38520 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726273AbeJOQcY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 12:32:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id ADD70AFD9;
        Mon, 15 Oct 2018 08:48:04 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     hpa@zytor.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        Juergen Gross <jgross@suse.com>
Subject: [PATCH] x86: modify inline asm constraints in __cmpxchg_double()
Date:   Mon, 15 Oct 2018 10:48:02 +0200
Message-Id: <20181015084802.30934-1-jgross@suse.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some gcc versions seem to have problems with the constraints in
__cmpxchg_double() as they suddenly issue a build error when random
parts of sources calling __cmpxchg_double() are modified, like e.g.
slub.c. This has been observed on Debian systems only so far.

Using "0" instead of "a" in the input constraints has the same
semantics while avoiding that build error.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
I should note that I have observed gcc hangs instead sometimes. Not
taking any patches modifying users of __cmpxchg_double() due to a gcc
bug which seems to be distro-specific is a bad move IMO.

I'd rather make it clear from build behavior that this is a bug in gcc
by letting the build hang instead of throwing error warnings not in any
way related to changes in the code.

The gcc bug is filed under:

https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=908154
---
 arch/x86/include/asm/cmpxchg.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/cmpxchg.h b/arch/x86/include/asm/cmpxchg.h
index a55d79b233d3..b3b4d61a8969 100644
--- a/arch/x86/include/asm/cmpxchg.h
+++ b/arch/x86/include/asm/cmpxchg.h
@@ -245,7 +245,7 @@ extern void __add_wrong_size(void)
 	asm volatile(pfx "cmpxchg%c4b %2; sete %0"			\
 		     : "=a" (__ret), "+d" (__old2),			\
 		       "+m" (*(p1)), "+m" (*(p2))			\
-		     : "i" (2 * sizeof(long)), "a" (__old1),		\
+		     : "i" (2 * sizeof(long)), "0" (__old1),		\
 		       "b" (__new1), "c" (__new2));			\
 	__ret;								\
 })
-- 
2.16.4

