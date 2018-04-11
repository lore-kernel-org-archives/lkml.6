Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+6BULpm0/6Z2qGkYCBD3YIGPf3xeRUDiES42fjGEeHQYHOhbCmqM3tE7JmcEn2h6D139og
ARC-Seal: i=1; a=rsa-sha256; t=1523472569; cv=none;
        d=google.com; s=arc-20160816;
        b=coHQvEb13J0ehQM+W3dvML7tBgdudtPPK5I314j/8hGl9N2z9u3RLOvg4iFwvG/LSu
         qBT+X5rXAPm8Wp/N48b6O/mMfuGUxzq8K5DbWPrdYHemNobiCRYnXbnCI/rBtN46Mq2s
         EXGtp+zE8kFvmANV++TuTJfpcN98Pb3FzDtrgfWymmS0wnH/0ac2XVw1R1KEr6/bhS0s
         LdedaAT01eUXYiHgydTN+1YhdQh2WOSmcdfq7qAqfo+5xJWHu2nRfzd0CrawFPDT1HNr
         sj9xBQ+3ZdGy4UZlT19OE01Cb18UY3up9JYC2gTDaPQi6gwODWMbJCikq4t5eEKQp0+X
         RtRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=zcOo885mizTsskKZR2DH8DF5TVKNglehnmw67M9SO/k=;
        b=phWQlHPb/W+FN8ucxgDhhlAc6OEJGLsloUS0q2pXQ2vEu/WFNhvqOhbqg6juU30T18
         tAq5A+Zb46ph2dR2cr6riogtcFNOz80AJFpRGlJrIS51gCuXSvu9CQM6vB0ihZZSCPsY
         aF2nPYvJE3ffiS1+Zm+yH/HorYEdzP/DEO+45TfAOmDtp8jPRXaTrRyQTUj2xWC8U2uZ
         l5vHWzEIwOzBRGbQpM4MfGtR5+NFYMYywi/x0sGyGkbtKFURIcFiiVSrK99fz/wB4PUp
         5bVHFTZWVV4nogPrFDHX/xa7WQY9RsHYYrkrr7sL/e+p78xEsEC17yw9jG1HB64jlCIz
         9d1A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Marcin Nowakowski <marcin.nowakowski@imgtec.com>,
	linux-mips@linux-mips.org,
	Ralf Baechle <ralf@linux-mips.org>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 132/190] MIPS: mm: adjust PKMAP location
Date: Wed, 11 Apr 2018 20:36:18 +0200
Message-Id: <20180411183600.007946835@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183550.114495991@linuxfoundation.org>
References: <20180411183550.114495991@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476772918023344?=
X-GMAIL-MSGID: =?utf-8?q?1597476772918023344?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marcin Nowakowski <marcin.nowakowski@imgtec.com>


[ Upstream commit c56e7a4c3e77f6fbd9b55c06c14eda65aae58958 ]

Space reserved for PKMap should span from PKMAP_BASE to FIXADDR_START.
For large page sizes this is not the case as eg. for 64k pages the range
currently defined is from 0xfe000000 to 0x102000000(!!) which obviously
isn't right.
Remove the hardcoded location and set the BASE address as an offset from
FIXADDR_START.

Since all PKMAP ptes have to be placed in a contiguous memory, ensure
that this is the case by placing them all in a single page. This is
achieved by aligning the end address to pkmap pages count pages.

Signed-off-by: Marcin Nowakowski <marcin.nowakowski@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/15950/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/mips/include/asm/pgtable-32.h |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/arch/mips/include/asm/pgtable-32.h
+++ b/arch/mips/include/asm/pgtable-32.h
@@ -18,6 +18,10 @@
 
 #include <asm-generic/pgtable-nopmd.h>
 
+#ifdef CONFIG_HIGHMEM
+#include <asm/highmem.h>
+#endif
+
 extern int temp_tlb_entry;
 
 /*
@@ -61,7 +65,8 @@ extern int add_temporary_entry(unsigned
 
 #define VMALLOC_START	  MAP_BASE
 
-#define PKMAP_BASE		(0xfe000000UL)
+#define PKMAP_END	((FIXADDR_START) & ~((LAST_PKMAP << PAGE_SHIFT)-1))
+#define PKMAP_BASE	(PKMAP_END - PAGE_SIZE * LAST_PKMAP)
 
 #ifdef CONFIG_HIGHMEM
 # define VMALLOC_END	(PKMAP_BASE-2*PAGE_SIZE)
