Return-Path: <schwidefsky@de.ibm.com>
X-Google-Smtp-Source: AH8x227LORtAHpPArJvBvSml50c7yS6FYIYLzDMkGS31c/terpLEkkHXfN9DxpUZBExgG+4T9G2y
ARC-Seal: i=1; a=rsa-sha256; t=1517986823; cv=none;
        d=google.com; s=arc-20160816;
        b=I+MD9M8MSrvbjmRUGnFURbi4ZobxNM0v/4MRcX3lhUe0xbmfEEZUMmTkrK6ZM1SK99
         h0t1SLZ8ezWI5fW+8QSWvTrKIickCOcULRcqJ415gzW6RFwYJUKyG4aJPNRLmTm0o9/v
         fSJsx7fQ311xWAcOlXOkSKlnZz88px8HcrqceE8AgEeHjBsQAxNS8BAtKZUVnUk1/fq1
         /CZRQFrVUTYPYMhNKKsSsZ5D0uM1PgDLu5DBhp67WOi8LJwbwxxIbcMBNGln9X7YGLMo
         C12XVmbrMLax/JQdEcSanxvL8DCT0ZWpI1p/pkxY8jhndUNyyHNKcgjGzK6wfDMf1VHx
         fNmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:references:in-reply-to:date:subject:cc:to:from
         :arc-authentication-results;
        bh=R+IQhnx0RySWHG6TQPFT98WMKlKA4joluJu5wZiMaLg=;
        b=LN5nuOflDIR4/h8VgvxfLbLsUGxAtN5O5gJbsU4XamPani/oelaCIh1LwB66H2YAE5
         fUk5ycLR/WyetSps9Vu4UkI703P8vkpq2wVqhKa/tNfrvv1LWmgqgKQCtLLDnZ22ZF3i
         gJqRUk5/fQm5UuSnGlI4Oji8TPlgfENVMMtMqyBWCUnpJH6azppdJQUjhxDuLYwEcQP6
         AXa1ePr5dIAR+pXQtU6Pf8unwDB4GJJvB2PK0/X2B8M/dGzPwWU1f35GQuLNiuPOZkk7
         mO8NXOuX0Vztlaq9M3RjNTj8AB2EMFQjq8qD/7WY9LaLfye/V87Xv+pixIMN7qkzZO5o
         yo0w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of schwidefsky@de.ibm.com designates 148.163.158.5 as permitted sender) smtp.mailfrom=schwidefsky@de.ibm.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of schwidefsky@de.ibm.com designates 148.163.158.5 as permitted sender) smtp.mailfrom=schwidefsky@de.ibm.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=ibm.com
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jon Masters <jcm@redhat.com>, Marcus Meissner <meissner@suse.de>,
        Jiri Kosina <jkosina@suse.cz>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Pavel Machek <pavel@ucw.cz>,
        David Woodhouse <dwmw2@infradead.org>
Subject: [PATCH 2/6] s390: add optimized array_index_mask_nospec
Date: Wed,  7 Feb 2018 08:00:07 +0100
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1517986811-27819-1-git-send-email-schwidefsky@de.ibm.com>
References: <1517986811-27819-1-git-send-email-schwidefsky@de.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18020707-0040-0000-0000-0000042D3883
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18020707-0041-0000-0000-000020D0E9D0
Message-Id: <1517986811-27819-3-git-send-email-schwidefsky@de.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-07_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802070089
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591724551566964006?=
X-GMAIL-MSGID: =?utf-8?q?1591724551566964006?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add an optimized version of the array_index_mask_nospec function for
s390 based on a compare and a subtract with borrow.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---
 arch/s390/include/asm/barrier.h | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/s390/include/asm/barrier.h b/arch/s390/include/asm/barrier.h
index 1043260..f9eddbc 100644
--- a/arch/s390/include/asm/barrier.h
+++ b/arch/s390/include/asm/barrier.h
@@ -49,6 +49,30 @@ do {									\
 #define __smp_mb__before_atomic()	barrier()
 #define __smp_mb__after_atomic()	barrier()
 
+/**
+ * array_index_mask_nospec - generate a mask for array_idx() that is
+ * ~0UL when the bounds check succeeds and 0 otherwise
+ * @index: array element index
+ * @size: number of elements in array
+ */
+#define array_index_mask_nospec array_index_mask_nospec
+static inline unsigned long array_index_mask_nospec(unsigned long index,
+						    unsigned long size)
+{
+	unsigned long mask;
+
+	if (__builtin_constant_p(size) && size > 0) {
+		asm("	clgr	%2,%1\n"
+		    "	slbgr	%0,%0\n"
+		    :"=d" (mask) : "d" (size-1), "d" (index) :"cc");
+		return mask;
+	}
+	asm("	clgr	%1,%2\n"
+	    "	slbgr	%0,%0\n"
+	    :"=d" (mask) : "d" (size), "d" (index) :"cc");
+	return ~mask;
+}
+
 #include <asm-generic/barrier.h>
 
 #endif /* __ASM_BARRIER_H */
-- 
2.7.4
