Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752050AbeFEQjf (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 12:39:35 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:38335 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751748AbeFEQje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 12:39:34 -0400
X-Google-Smtp-Source: ADUXVKL61fLeTRgCibAVuJhyS/sAcEdUlNwox1sH1KmQZ92A/w6czAsZQNU5oa45jeBeNi4ri1D9DA==
From: Uros Bizjak <ubizjak@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>, x86@kernel.org
Subject: [PATCH] x86/asm: Use CC_SET/CC_OUT in percpu_cmpxchg8b_double
Date: Tue,  5 Jun 2018 18:39:09 +0200
Message-Id: <20180605163910.13015-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use CC_SET(z)/CC_OUT(z) instead of explicit setz instruction.
Using these two defines, the compiler that supports generation of
condition code outputs from inline assembly flags generates e.g.:

  cmpxchg8b %fs:(%esi)
  jne    172255 <__kmalloc+0x65>

instead of

  cmpxchg8b %fs:(%esi)
  sete   %al
  test   %al,%al
  je     172255 <__kmalloc+0x65>

Note that older compilers now generate

  cmpxchg8b %fs:(%esi)
  sete   %cl
  test   %cl,%cl
  je     173a85 <__kmalloc+0x65>

since we have to mark that cmpxchg8b instruction outputs to %eax
register and this way clobbers the value in the register.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: x86@kernel.org
---
 arch/x86/include/asm/percpu.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index a06b07399d17..e9202a0de8f0 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -450,9 +450,10 @@ do {									\
 	bool __ret;							\
 	typeof(pcp1) __o1 = (o1), __n1 = (n1);				\
 	typeof(pcp2) __o2 = (o2), __n2 = (n2);				\
-	asm volatile("cmpxchg8b "__percpu_arg(1)"\n\tsetz %0\n\t"	\
-		    : "=a" (__ret), "+m" (pcp1), "+m" (pcp2), "+d" (__o2) \
-		    :  "b" (__n1), "c" (__n2), "a" (__o1));		\
+	asm volatile("cmpxchg8b "__percpu_arg(1)			\
+		     CC_SET(z)						\
+		     : CC_OUT(z) (__ret), "+m" (pcp1), "+m" (pcp2), "+a" (__o1), "+d" (__o2) \
+		     : "b" (__n1), "c" (__n2));				\
 	__ret;								\
 })
 
-- 
2.17.1
