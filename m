Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+blK9fnfJujw1i+LGmAstHGlGlE95qZqtkJaQQoy3XHANsB6aAXPC1y7LDGQry/6piX8We
ARC-Seal: i=1; a=rsa-sha256; t=1523473453; cv=none;
        d=google.com; s=arc-20160816;
        b=gop3E9ht1N5w7lkgE0holWf4U1pXQG/kE3+ClinR4E0F2Up0HPCAABPP0+eqRu+1Kh
         Oi93PklkhvX5duPKIcWGS6BH7MlqA5Dmw+UfHSWuVgZ8ltX/6wUqDGxpXKFTQpzc0KQL
         ytw98CGou8XApBpflXlHQYJS3Seq/tO9z0n9xBqWwgundtT4Pdv6oFO4a7pLMYjIA453
         sm2HCvJ2Ym1+0QJ4rPif/9cnh58Ox7P/HC6cOluzLfzur2eTWZfoUZoWaY+r0S4LlQzk
         uPJqhDnHkdhQ8QpBVVNlTwMmISCA6ySq3GrAF1k3VRU4tJtEL/0I/O5T/Gt/gjBc6I4C
         rQbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=76oUaGNBpEtZGCiEBb2Kukh/b6klqUGmM4emU92mS6g=;
        b=PxeGNi2sZ0ShTMQYbvwDN0VmWTCmtypAw54xH86pKxlQ6FrzeGYvg05hS08E8I4yww
         pPMrXe8lJgncLP2ATg+qIWfkMKCut50MnhU6omplMYl2DWSTcNV909g7FDMHJNBLudZS
         o9ZCG5wVUXPjGWFmqBKnqOMimGEBMNmU3rAE4rJopj7w2Q7eS9YyCIk7nm5Xj3tzdH7J
         WHO4J/bUqoOYQicM9KsxC0AJrkH4IzmLBwwoyyA2n4bH47Bj1yTSwxb1hEPpYSud1IA+
         +R6HWS7vN8HJmFXMjogFpkthxNmf4bNBPP2T2ywzzhWPuDzyJ8AFB55TAOh+j+4vrZqV
         mOnA==
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
Subject: [PATCH 4.9 219/310] MIPS: mm: adjust PKMAP location
Date: Wed, 11 Apr 2018 20:35:58 +0200
Message-Id: <20180411183631.971996975@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476772918023344?=
X-GMAIL-MSGID: =?utf-8?q?1597477700218676494?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
