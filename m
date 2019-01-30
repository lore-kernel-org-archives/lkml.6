Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2E74C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:40:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 920AB2087F
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:40:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732342AbfA3Qk4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 11:40:56 -0500
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:27370 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732089AbfA3Qkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 11:40:51 -0500
X-IronPort-AV: E=Sophos;i="5.56,541,1539648000"; 
   d="scan'208";a="384274779"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1d-2c665b5d.us-east-1.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 30 Jan 2019 16:40:49 +0000
Received: from u54ee758033e858cfa736 (iad7-ws-svc-lb50-vlan3.amazon.com [10.0.93.214])
        by email-inbound-relay-1d-2c665b5d.us-east-1.amazon.com (8.14.7/8.14.7) with ESMTP id x0UGehEJ057109
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Wed, 30 Jan 2019 16:40:45 GMT
Received: from u54ee758033e858cfa736.ant.amazon.com (localhost [127.0.0.1])
        by u54ee758033e858cfa736 (8.15.2/8.15.2/Debian-3) with ESMTP id x0UGegQA013454;
        Wed, 30 Jan 2019 17:40:42 +0100
Received: (from jsteckli@localhost)
        by u54ee758033e858cfa736.ant.amazon.com (8.15.2/8.15.2/Submit) id x0UGefPX013451;
        Wed, 30 Jan 2019 17:40:41 +0100
From:   Julian Stecklina <js@alien8.de>
To:     x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        hpa@zytor.com, linux-kernel@vger.kernel.org, jschoenh@amazon.de,
        Julian Stecklina <jsteckli@amazon.de>
Subject: [PATCH 2/2] x86/boot: increase maximum number of avoided KASLR regions
Date:   Wed, 30 Jan 2019 17:40:03 +0100
Message-Id: <1548866403-13390-2-git-send-email-js@alien8.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548866403-13390-1-git-send-email-js@alien8.de>
References: <1548866403-13390-1-git-send-email-js@alien8.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Julian Stecklina <jsteckli@amazon.de>

The boot code has a limit of 4 "non-standard" regions to avoid for
KASLR. This limit is easy to reach when supplying memmap= parameters to
the kernel. In this case, KASLR would be disabled.

Increase the limit to avoid turning off KASLR even when the user is
heavily manipulating the memory map.

Signed-off-by: Julian Stecklina <jsteckli@amazon.de>
---
 arch/x86/boot/compressed/kaslr.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index 5657e34..f078d60 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -92,8 +92,8 @@ struct mem_vector {
 	unsigned long long size;
 };
 
-/* Only supporting at most 4 unusable memmap regions with kaslr */
-#define MAX_MEMMAP_REGIONS	4
+/* Only supporting at most this many unusable memmap regions with kaslr */
+#define MAX_MEMMAP_REGIONS	16
 
 static bool memmap_too_large;
 
@@ -213,7 +213,7 @@ static void mem_avoid_memmap(char *str)
 		i++;
 	}
 
-	/* More than 4 memmaps, fail kaslr */
+	/* Can't store all regions, fail kaslr */
 	if ((i >= MAX_MEMMAP_REGIONS) && str)
 		memmap_too_large = true;
 }
-- 
2.7.4

