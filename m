Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08EC6C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 03:15:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C954C20685
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 03:15:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C954C20685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=andestech.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391950AbeKVNwi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 08:52:38 -0500
Received: from 59-120-53-16.HINET-IP.hinet.net ([59.120.53.16]:10219 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2391929AbeKVNwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 08:52:37 -0500
Received: from mail.andestech.com (atcpcs16.andestech.com [10.0.1.222])
        by ATCSQR.andestech.com with ESMTP id wAM3EJS0012569;
        Thu, 22 Nov 2018 11:14:19 +0800 (GMT-8)
        (envelope-from vincentc@andestech.com)
Received: from atcsqa06.andestech.com (10.0.15.65) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.123.3; Thu, 22 Nov 2018
 11:15:03 +0800
From:   Vincent Chen <vincentc@andestech.com>
To:     <green.hu@gmail.com>, <arnd@arndb.de>
CC:     <linux-kernel@vger.kernel.org>, <vincentc@andestech.com>
Subject: [PATCH v4 4/5] math-emu/op-2.h: Use statement expressions to prevent negative constant shift
Date:   Thu, 22 Nov 2018 11:14:37 +0800
Message-ID: <1542856478-795-5-git-send-email-vincentc@andestech.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542856478-795-1-git-send-email-vincentc@andestech.com>
References: <1542856478-795-1-git-send-email-vincentc@andestech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.15.65]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com wAM3EJS0012569
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This modification is quoted from glibc 'commit <
sysdeps/unix/sysv/linux/sparc/sparc64/dl-procinfo.c: Moved to>
(fe0b1e854ad32a69b260)'

Signed-off-by: Vincent Chen <vincentc@andestech.com>
---
 include/math-emu/op-2.h |   97 ++++++++++++++++++++++------------------------
 1 files changed, 46 insertions(+), 51 deletions(-)

diff --git a/include/math-emu/op-2.h b/include/math-emu/op-2.h
index 4f26ecc..13a374f 100644
--- a/include/math-emu/op-2.h
+++ b/include/math-emu/op-2.h
@@ -31,61 +31,56 @@
 #define _FP_FRAC_HIGH_2(X)	(X##_f1)
 #define _FP_FRAC_LOW_2(X)	(X##_f0)
 #define _FP_FRAC_WORD_2(X,w)	(X##_f##w)
+#define _FP_FRAC_SLL_2(X, N) (						       \
+	(void) (((N) < _FP_W_TYPE_SIZE)					       \
+	  ? ({								       \
+		if (__builtin_constant_p(N) && (N) == 1) {		       \
+			X##_f1 = X##_f1 + X##_f1 +			       \
+				(((_FP_WS_TYPE) (X##_f0)) < 0);		       \
+			X##_f0 += X##_f0;				       \
+		} else {						       \
+			X##_f1 = X##_f1 << (N) | X##_f0 >>		       \
+						(_FP_W_TYPE_SIZE - (N));       \
+			X##_f0 <<= (N);					       \
+		}							       \
+		0;							       \
+	    })								       \
+	  : ({								       \
+	      X##_f1 = X##_f0 << ((N) - _FP_W_TYPE_SIZE);		       \
+	      X##_f0 = 0;						       \
+	  })))
+
+
+#define _FP_FRAC_SRL_2(X, N) (						       \
+	(void) (((N) < _FP_W_TYPE_SIZE)					       \
+	  ? ({								       \
+	      X##_f0 = X##_f0 >> (N) | X##_f1 << (_FP_W_TYPE_SIZE - (N));      \
+	      X##_f1 >>= (N);						       \
+	    })								       \
+	  : ({								       \
+	      X##_f0 = X##_f1 >> ((N) - _FP_W_TYPE_SIZE);		       \
+	      X##_f1 = 0;						       \
+	    })))
 
-#define _FP_FRAC_SLL_2(X,N)						\
-  do {									\
-    if ((N) < _FP_W_TYPE_SIZE)						\
-      {									\
-	if (__builtin_constant_p(N) && (N) == 1) 			\
-	  {								\
-	    X##_f1 = X##_f1 + X##_f1 + (((_FP_WS_TYPE)(X##_f0)) < 0);	\
-	    X##_f0 += X##_f0;						\
-	  }								\
-	else								\
-	  {								\
-	    X##_f1 = X##_f1 << (N) | X##_f0 >> (_FP_W_TYPE_SIZE - (N));	\
-	    X##_f0 <<= (N);						\
-	  }								\
-      }									\
-    else								\
-      {									\
-	X##_f1 = X##_f0 << ((N) - _FP_W_TYPE_SIZE);			\
-	X##_f0 = 0;							\
-      }									\
-  } while (0)
-
-#define _FP_FRAC_SRL_2(X,N)						\
-  do {									\
-    if ((N) < _FP_W_TYPE_SIZE)						\
-      {									\
-	X##_f0 = X##_f0 >> (N) | X##_f1 << (_FP_W_TYPE_SIZE - (N));	\
-	X##_f1 >>= (N);							\
-      }									\
-    else								\
-      {									\
-	X##_f0 = X##_f1 >> ((N) - _FP_W_TYPE_SIZE);			\
-	X##_f1 = 0;							\
-      }									\
-  } while (0)
 
 /* Right shift with sticky-lsb.  */
-#define _FP_FRAC_SRS_2(X,N,sz)						\
-  do {									\
-    if ((N) < _FP_W_TYPE_SIZE)						\
-      {									\
-	X##_f0 = (X##_f1 << (_FP_W_TYPE_SIZE - (N)) | X##_f0 >> (N) |	\
-		  (__builtin_constant_p(N) && (N) == 1			\
-		   ? X##_f0 & 1						\
-		   : (X##_f0 << (_FP_W_TYPE_SIZE - (N))) != 0));	\
-	X##_f1 >>= (N);							\
-      }									\
-    else								\
-      {									\
-	X##_f0 = (X##_f1 >> ((N) - _FP_W_TYPE_SIZE) |			\
-		(((X##_f1 << (2*_FP_W_TYPE_SIZE - (N))) | X##_f0) != 0)); \
-	X##_f1 = 0;							\
-      }									\
-  } while (0)
+#define _FP_FRAC_SRS_2(X, N, sz) (					       \
+	(void) (((N) < _FP_W_TYPE_SIZE)					       \
+	  ? ({								       \
+	      X##_f0 = (X##_f1 << (_FP_W_TYPE_SIZE - (N)) | X##_f0 >> (N)      \
+			| (__builtin_constant_p(N) && (N) == 1		       \
+			   ? X##_f0 & 1					       \
+			   : (X##_f0 << (_FP_W_TYPE_SIZE - (N))) != 0));       \
+		X##_f1 >>= (N);						       \
+	    })								       \
+	  : ({								       \
+	      X##_f0 = (X##_f1 >> ((N) - _FP_W_TYPE_SIZE)		       \
+			| ((((N) == _FP_W_TYPE_SIZE			       \
+			     ? 0					       \
+			     : (X##_f1 << (2*_FP_W_TYPE_SIZE - (N))))          \
+			    | X##_f0) != 0));				       \
+	      X##_f1 = 0;						       \
+	    })))
 
 #define _FP_FRAC_ADDI_2(X,I)	\
   __FP_FRAC_ADDI_2(X##_f1, X##_f0, I)
-- 
1.7.1

