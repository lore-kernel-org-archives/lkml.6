Return-Path: <khalid.aziz@oracle.com>
X-Google-Smtp-Source: AH8x225p6W3SDRGUQlijN7Sq+5qRpOCrI7MIHjxat1vGbzSMzyS6M3lhPKKuBUdDHXHY2vfOItHM
ARC-Seal: i=1; a=rsa-sha256; t=1519233432; cv=none;
        d=google.com; s=arc-20160816;
        b=nbmEjhHnwjwoP1BPuJBynvlE2WhDOS62qtV/tSUeOOAebNqHFNRjITnnOG4SsvcY+y
         /4oMP8ifFoHPQYRWKZpQQt/FPdY9zWAjZ/MvK2jlMx7gdOlaQgqJFKlxjQMzsR/2HlpE
         nLLYRzWkBxznc0yOboOeFdCFPRB9ueAF2FHHVtXcUOQJWUWr1lF2e6mU650NwKLhmW0O
         EFHhxexzFJAUhOHL4xPnqksyYnroG9wY77tjR7eucvVnbPaC7uBxZWDiX3ivFXp6RFIM
         3FnbxbcFQ+xaLg4p+EjEaP/mb90AspCDLpJkk/nw2Ohn9omaFh4gKf7bpKHJ8XrnMFdI
         BNzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=NxbTRPn0RuHG9VYIAhhQIgaatn1I1OF71ZHIgqrDpVA=;
        b=owN09nLsgZBzMsMSYe7zR1KnJa7Yorbl+GDwt2mYjD3PyFS4HBhmtHJOFw7Wo0bjy/
         kuUNT3//gLFDNleUwf9BtVS0DELIXYwPtMhhLX8SACvB0usRTebQ77J1gIsVDkqd8DrV
         dNAUv9uaQJv/BFnfQ0K4dsunuqjuvGSpdpP/KKHgy1105H61/rBRnaFu4Gw+Y05voy3e
         8ZCArorFET+mF47ErUNfRxV2SMymNMyeVUI/1kw0Y7WR15cbKubXbjcTnlvPJMBLmQ13
         oJcagfPG4euonR3YGXr9ue+XNyGUpCBbtigt97rWMk+2GkolavIBJGPK4iWBWQQne0zL
         LlBg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=ZSjBDxjr;
       spf=pass (google.com: domain of khalid.aziz@oracle.com designates 141.146.126.79 as permitted sender) smtp.mailfrom=khalid.aziz@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=ZSjBDxjr;
       spf=pass (google.com: domain of khalid.aziz@oracle.com designates 141.146.126.79 as permitted sender) smtp.mailfrom=khalid.aziz@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
From: Khalid Aziz <khalid.aziz@oracle.com>
To: akpm@linux-foundation.org, davem@davemloft.net,
        dave.hansen@linux.intel.com
Cc: Khalid Aziz <khalid.aziz@oracle.com>, kstewart@linuxfoundation.org,
        pombredanne@nexb.com, tglx@linutronix.de, anthony.yznaga@oracle.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, sparclinux@vger.kernel.org,
        Khalid Aziz <khalid@gonehiking.org>
Subject: [PATCH v12 09/11] mm: Allow arch code to override copy_highpage()
Date: Wed, 21 Feb 2018 10:15:51 -0700
Message-Id: <ecbafa2bfcc05f22183be2e7784ed11943b1d5b2.1519227112.git.khalid.aziz@oracle.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1519227112.git.khalid.aziz@oracle.com>
References: <cover.1519227112.git.khalid.aziz@oracle.com>
In-Reply-To: <cover.1519227112.git.khalid.aziz@oracle.com>
References: <cover.1519227112.git.khalid.aziz@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8811 signatures=668676
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802210211
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593031715838543761?=
X-GMAIL-MSGID: =?utf-8?q?1593031715838543761?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Some architectures can support metadata for memory pages and when a
page is copied, its metadata must also be copied. Sparc processors
from M7 onwards support metadata for memory pages. This metadata
provides tag based protection for access to memory pages. To maintain
this protection, the tag data must be copied to the new page when a
page is migrated across NUMA nodes. This patch allows arch specific
code to override default copy_highpage() and copy metadata along
with page data upon migration.

Signed-off-by: Khalid Aziz <khalid.aziz@oracle.com>
Cc: Khalid Aziz <khalid@gonehiking.org>
Reviewed-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
v9:
	- new patch

 include/linux/highmem.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/highmem.h b/include/linux/highmem.h
index 776f90f3a1cd..0690679832d4 100644
--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -237,6 +237,8 @@ static inline void copy_user_highpage(struct page *to, struct page *from,
 
 #endif
 
+#ifndef __HAVE_ARCH_COPY_HIGHPAGE
+
 static inline void copy_highpage(struct page *to, struct page *from)
 {
 	char *vfrom, *vto;
@@ -248,4 +250,6 @@ static inline void copy_highpage(struct page *to, struct page *from)
 	kunmap_atomic(vfrom);
 }
 
+#endif
+
 #endif /* _LINUX_HIGHMEM_H */
-- 
2.11.0
