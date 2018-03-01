Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032138AbeCAP07 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 10:26:59 -0500
Received: from mail-ot0-f193.google.com ([74.125.82.193]:34827 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032010AbeCAP04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 10:26:56 -0500
X-Google-Smtp-Source: AG47ELsC5ZkQj8ah3ARsV2MIzShQCIZ3XrsrzB7YHFRVTiZ6jFRLu52Of0lQmt2Ttb4RaUa/D918WA==
From: Rob Herring <robh@kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Subject: [PATCH] powerpc: boot: add strrchr function
Date: Thu,  1 Mar 2018 09:26:54 -0600
Message-Id: <20180301152654.29275-1-robh@kernel.org>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

libfdt gained a new dependency on strrchr, so copy the implementation
from lib/string.c. Most of the string functions are in assembly, but
stdio.c already has strnlen, so add strrchr there.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Rob Herring <robh@kernel.org>
---
Please ack. This is a dependency for dtc/libfdt sync with upstream.

 arch/powerpc/boot/stdio.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/powerpc/boot/stdio.c b/arch/powerpc/boot/stdio.c
index a701261b1781..98042eff7b26 100644
--- a/arch/powerpc/boot/stdio.c
+++ b/arch/powerpc/boot/stdio.c
@@ -21,6 +21,16 @@ size_t strnlen(const char * s, size_t count)
 	return sc - s;
 }
 
+char *strrchr(const char *s, int c)
+{
+	const char *last = NULL;
+	do {
+		if (*s == (char)c)
+			last = s;
+	} while (*s++);
+	return (char *)last;
+}
+
 #ifdef __powerpc64__
 
 # define do_div(n, base) ({						\
-- 
2.14.1
