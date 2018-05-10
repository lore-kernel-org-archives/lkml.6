Return-Path: <mcgrof@kernel.org>
X-Google-Smtp-Source: AB8JxZrM/UNcJj1NArdvZ7eFXyP4CyOk8hGDfHL1ZUNm1tCJZZUFSpfCVvDMoip8x2Ge2jMzTTBH
ARC-Seal: i=1; a=rsa-sha256; t=1525978515; cv=none;
        d=google.com; s=arc-20160816;
        b=HFN5xIaN1bBuCoMGAeNsJHs03mQtH1jGt423O0/4jaPJRWE1y/lGVXBOtAEyJHNaQ+
         c8uk4xW3Uu6WSspK0OdCYYlMl7yoGXoN6LiO2xqWKOLph/1LWfJ0RzkTLgagBRNb7y8M
         jUhBwhMRtRDGhetZEAQpxfYYTgtnRXGdqvpNsPPPGNs8CT6mYceB8Nb/l7hWjzSoP/Yn
         TVWaL5xW4zmyiwU66H02euMb6vWT3MA84k0c8pxzv4ohDls1RSS/ovQmFoBI2Z4YRIbu
         vc2kn4Z9r/0pwqn4DUyDYYMyiLiPyp+IexQvcZwKzjy4qBtQ3ivJemFFE/ABa101DkOE
         wA5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=Ey4I0LBXWwGtnNiRrEmL5OiifRP1sHYRz5EdaSU7Y3c=;
        b=CnbCLLHAa94Tj1NLZZYQPaGH3xJ1b9oUXGpBNgHSNKuND13qDjbAAtith4a+JggZQM
         YOz//gIrQk44tOsR1BSa5w5n8Assu4QQM4KG3MYzET+LR7bX6Ikx4GcpnbvuMwsw8iNz
         bmlpY+Qam0bzQwTl7Y3xD5F2Lpfwszw7PpBQEP0AH3y3V1Que6rhNqFwUJutaT4Log4A
         WolXy3Y6+FHdhhAM0s29oF5d/3QqX/hscAEGROdcbS1TMNVWfpbpFLXtwCUF/2cCCQ7m
         OagxyjN377cPdWkHuYl+A9q8qacI9utlEvdESbe0QszST6Et3uQ47p/hHItFOuwV62sk
         Vc5Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=lldQ0M/P;
       spf=pass (google.com: domain of mcgrof@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=mcgrof@kernel.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=lldQ0M/P;
       spf=pass (google.com: domain of mcgrof@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=mcgrof@kernel.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=kernel.org
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: arnd@arndb.de
Cc: gregkh@linuxfoundation.org,
	willy@infradead.org,
	geert@linux-m68k.org,
	linux-m68k@lists.linux-m68k.org,
	linux-arch@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	"Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: [PATCH v3 2/2] mm: provide a fallback for PAGE_KERNEL_EXEC for architectures
Date: Thu, 10 May 2018 11:55:07 -0700
Message-Id: <20180510185507.2439-3-mcgrof@kernel.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180510185507.2439-1-mcgrof@kernel.org>
References: <20180510185507.2439-1-mcgrof@kernel.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600039619823069048?=
X-GMAIL-MSGID: =?utf-8?q?1600104448291706193?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Some architectures just don't have PAGE_KERNEL_EXEC. The mm/nommu.c
and mm/vmalloc.c code have been using PAGE_KERNEL as a fallback for
years. Move this fallback to asm-generic.

Suggested-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
---
 include/asm-generic/pgtable.h | 4 ++++
 mm/nommu.c                    | 4 ----
 mm/vmalloc.c                  | 4 ----
 3 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/include/asm-generic/pgtable.h b/include/asm-generic/pgtable.h
index 4e310e543fc8..81371468ed5a 100644
--- a/include/asm-generic/pgtable.h
+++ b/include/asm-generic/pgtable.h
@@ -1097,6 +1097,10 @@ static inline void init_espfix_bsp(void) { }
 # define PAGE_KERNEL_RO PAGE_KERNEL
 #endif
 
+#ifndef PAGE_KERNEL_EXEC
+# define PAGE_KERNEL_EXEC PAGE_KERNEL
+#endif
+
 #endif /* !__ASSEMBLY__ */
 
 #ifndef io_remap_pfn_range
diff --git a/mm/nommu.c b/mm/nommu.c
index 13723736d38f..08ad4dcd281d 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -364,10 +364,6 @@ void *vzalloc_node(unsigned long size, int node)
 }
 EXPORT_SYMBOL(vzalloc_node);
 
-#ifndef PAGE_KERNEL_EXEC
-# define PAGE_KERNEL_EXEC PAGE_KERNEL
-#endif
-
 /**
  *	vmalloc_exec  -  allocate virtually contiguous, executable memory
  *	@size:		allocation size
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index ebff729cc956..89543d13e32a 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -1920,10 +1920,6 @@ void *vzalloc_node(unsigned long size, int node)
 }
 EXPORT_SYMBOL(vzalloc_node);
 
-#ifndef PAGE_KERNEL_EXEC
-# define PAGE_KERNEL_EXEC PAGE_KERNEL
-#endif
-
 /**
  *	vmalloc_exec  -  allocate virtually contiguous, executable memory
  *	@size:		allocation size
-- 
2.17.0
