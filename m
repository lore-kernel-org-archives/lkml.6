Return-Path: <willy@infradead.org>
X-Google-Smtp-Source: AB8JxZqVTOuCeFhfHAMHKoE+eJMPcmSNejF1vRRkoFBhT72r2VGDXkuQSHt5dcTAwOL0jg2+KeF9
ARC-Seal: i=1; a=rsa-sha256; t=1524885494; cv=none;
        d=google.com; s=arc-20160816;
        b=PoAmZprQFnUreCY4uBOSMQiwbYv66aAUeFQXZZxG60iVsJsZT/2I4mIQaHuNJ4TYIi
         BxZ95CkPDN4DicG7pDr6K47u8dSx88zlyiiRBUAAtzYOgId5uTmQHDqcxzdCF0Nu7XnV
         IU5trF9JJJp+6e7mzHaXU2FqNxksYL5ZxyFhThzxzB67qK0E4C9KYT1yrRVcHZOork6U
         hAW3Tyc5TkY4wnpuwS+OIEpH7iIslM6HlOeCNv96xWEQ2byti+jJCusgxKIoyEUI/EZG
         g9QSGoilUeCPxBTcAbsMJ2tFZsFohHBnflBx6K9pz1IUedQX+XbFI8j1hRs5cupH31v9
         V7GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=6vx15GDvlffGh9BlRG5mECC/tpSjc6SgAFVL6JXUqxE=;
        b=GtyOfMxIhYPDhwJYsL897fYSx8Z42+eBYjgvrAws8/4rhyXIJJ4OURPjQdOxwk/eY1
         GnDM8dZ0sTM804ggLULuu170ycui5C3QybH/nm3MYGI7J4wT7JYXfYHPjxOHFMz3PtpD
         JmLFIyN3MmJlDl/I0fMbeLIm5pX9luKTQaJPH4GEEcVWe3PlhjixFB+AqLUeiS+U7FEK
         EYt086qyXA06XbMlCdiscCuxShjPHS/Er1XddtS3L8dGu/nvfnTAXvrL8/LncGBfKDm+
         nH9oolo58d97oJevpzPDrvod14i6H3jCpin/i8nBYueKlYGyJzfBmAVZzVCcQKGNwv3j
         5d7w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=L8zilVj2;
       spf=pass (google.com: best guess record for domain of willy@infradead.org designates 2607:7c80:54:e::133 as permitted sender) smtp.mailfrom=willy@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=L8zilVj2;
       spf=pass (google.com: best guess record for domain of willy@infradead.org designates 2607:7c80:54:e::133 as permitted sender) smtp.mailfrom=willy@infradead.org
Date: Fri, 27 Apr 2018 20:18:10 -0700
From: Matthew Wilcox <willy@infradead.org>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: arnd@arndb.de, gregkh@linuxfoundation.org, linux-arch@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
	Fenghua Yu <fenghua.yu@intel.com>, linux-ia64@vger.kernel.org
Subject: Re: [PATCH] mm: provide a fallback for PAGE_KERNEL_RO for
 architectures
Message-ID: <20180428031810.GA14566@bombadil.infradead.org>
References: <20180428001526.22475-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180428001526.22475-1-mcgrof@kernel.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598946836077947117?=
X-GMAIL-MSGID: =?utf-8?q?1598958332334052432?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Apr 27, 2018 at 05:15:26PM -0700, Luis R. Rodriguez wrote:
> Some architectures do not define PAGE_KERNEL_RO, best we can do
> for them is to provide a fallback onto PAGE_KERNEL. Remove the
> hack from the firmware loader and move it onto the asm-generic
> header, and document while at it the affected architectures
> which do not have a PAGE_KERNEL_RO:
> 
>   o alpha
>   o ia64
>   o m68k
>   o mips
>   o sparc64
>   o sparc

ia64 doesn't have it?

*fx: riffles through architecture book*

That seems like an oversight of the Linux port.  Tony, Fenghua, any thoughts?

(also, Luis, maybe move the PAGE_KERNEL_EXEC fallback the same way you
moved the PAGE_KERNEL_RO fallback?)

--- >8 ---

ia64: Add PAGE_KERNEL_RO and PAGE_KERNEL_EXEC

The rest of the kernel was falling back to simple PAGE_KERNEL pages; using
PAGE_KERNEL_RO and PAGE_KERNEL_EXEC provide better protection against
unintended writes.

Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>

diff --git a/arch/ia64/include/asm/pgtable.h b/arch/ia64/include/asm/pgtable.h
index 165827774bea..041a32a7960d 100644
--- a/arch/ia64/include/asm/pgtable.h
+++ b/arch/ia64/include/asm/pgtable.h
@@ -23,7 +23,7 @@
 
 /*
  * First, define the various bits in a PTE.  Note that the PTE format
- * matches the VHPT short format, the firt doubleword of the VHPD long
+ * matches the VHPT short format, the first doubleword of the VHPD long
  * format, and the first doubleword of the TLB insertion format.
  */
 #define _PAGE_P_BIT		0
@@ -142,9 +142,11 @@
 #define PAGE_COPY_EXEC	__pgprot(__ACCESS_BITS | _PAGE_PL_3 | _PAGE_AR_RX)
 #define PAGE_GATE	__pgprot(__ACCESS_BITS | _PAGE_PL_0 | _PAGE_AR_X_RX)
 #define PAGE_KERNEL	__pgprot(__DIRTY_BITS  | _PAGE_PL_0 | _PAGE_AR_RWX)
-#define PAGE_KERNELRX	__pgprot(__ACCESS_BITS | _PAGE_PL_0 | _PAGE_AR_RX)
+#define PAGE_KERNEL_RO	__pgprot(__ACCESS_BITS | _PAGE_PL_0 | _PAGE_AR_R)
+#define PAGE_KERNEL_RX	__pgprot(__ACCESS_BITS | _PAGE_PL_0 | _PAGE_AR_RX)
 #define PAGE_KERNEL_UC	__pgprot(__DIRTY_BITS  | _PAGE_PL_0 | _PAGE_AR_RWX | \
 				 _PAGE_MA_UC)
+#define PAGE_KERNEL_EXEC	PAGE_KERNEL_RX
 
 # ifndef __ASSEMBLY__
 
