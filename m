Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E11CC6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 20:57:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25FC0258D4
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 20:57:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=roeck-us.net header.i=@roeck-us.net header.b="lhP8IR/f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25FC0258D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752763AbeGAU5i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 16:57:38 -0400
Received: from bh-25.webhostbox.net ([208.91.199.152]:54747 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752535AbeGAU5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 16:57:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=Message-Id:Date:Subject:Cc:To:From:Sender:
        Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=bf4Y/eUZbkyjdVC7DcmqFzASRcmvMxAYR9UFOsgyrzA=; b=lhP8IR/fJBiMPBd4OVw1lpLTKG
        kDrM5PAdJI04W6S1GcGyo3GSc6RDj2Z//ryBkzOwPgUzKmmjFI2lkmu55/qUOTW8iiU1dURgFCt7T
        UZt3VnA1WZMNI/xV4clrkOWe5Yp2rosG5OzBv06ZX0b6cSN8ycKJvn/By5L0mZPtJK7tfUXUipi6q
        v76X0CEnDfwwvBgtuJG8FhoSI700cd9lqARBeMFHGp5MDcxeqvPKcPqY6hdVYRMHgBjmjf9kulfms
        nzgBjiriX/y7kdu3yS9/LjXQwY7HU2F7KTxAXTV/VBdtymInyoVxjtLcrH0B+N+0QVrqpBrvKsyxJ
        keag+TnA==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:48694 helo=localhost)
        by bh-25.webhostbox.net with esmtpa (Exim 4.89)
        (envelope-from <linux@roeck-us.net>)
        id 1fZjPZ-007eTZ-GW; Sun, 01 Jul 2018 20:57:33 +0000
From:   Guenter Roeck <linux@roeck-us.net>
To:     linux-kernel@vger.kernel.org
Cc:     Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] test_hexdump: Replace strncpy with memcpy
Date:   Sun,  1 Jul 2018 13:57:30 -0700
Message-Id: <1530478650-20922-1-git-send-email-linux@roeck-us.net>
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

gcc 8.1.0 complains:

lib/test_hexdump.c:84:3: warning:
	'strncpy' output truncated before terminating
	nul copying as many bytes from a string as its length
lib/test_hexdump.c:82:19: note: length computed here

Using strncpy() is indeed less than perfect since the length of data to
be copied has already been determined with strlen(). Replace strncpy()
with memcpy() to address the warning and optimize the code a little.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 lib/test_hexdump.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/test_hexdump.c b/lib/test_hexdump.c
index 3f415d8101f3..1c3c513add77 100644
--- a/lib/test_hexdump.c
+++ b/lib/test_hexdump.c
@@ -81,7 +81,7 @@ static void __init test_hexdump_prepare_test(size_t len, int rowsize,
 		const char *q = *result++;
 		size_t amount = strlen(q);
 
-		strncpy(p, q, amount);
+		memcpy(p, q, amount);
 		p += amount;
 
 		*p++ = ' ';
-- 
2.7.4

