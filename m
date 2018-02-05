Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227OWO+ckkX1qY+xdx+wvsriHXBVxlizktFeLgjTw8yuu/m0XaYVkY/cuBN8/6njF5RpTrrC
ARC-Seal: i=1; a=rsa-sha256; t=1517855129; cv=none;
        d=google.com; s=arc-20160816;
        b=QZYLAqaxt4AKqdzWXFJ09n6jd6GWPQEdqAkWx7VLn3pmy0FEgaei/fvWYJHnVwFbv7
         aHBckeg0ICCcxOuAyfKFRNLMl1IDCZd71jDWSTgDwvT8ikaPU+9r02lQxkMlBhmzAb2+
         iG9i4qlXpIBsZHlLBhYG6TDxtpMApxhF+n7Ap16jOmwHEq9I4pzwSv8ioKpwZKgYLE89
         RHy2Kw1xhzab4njQDy1DDuoG5WUvZXroV93RkQVQq3xJx/WwVCpBW7PNil4TUjGAl9mD
         moho0Icdeihufm6Zh/4H9P0WphZ8TMlKa9/fswNh5KRq2qmG8UUC+/rqRbfLJmD6ooMm
         rE2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=kGZP3higEqeYxmBKeoVGHRwOyUjijKJvmWQkLcgktlE=;
        b=eX47DEHS1LvIqMC3OfZvanvC9o1lquHtRl87Go0jWul4ZdToZa72ADplvB1y94cXOc
         C0mnnNdPZK08bPgVCDJ4sjEZ90bsscrMEVUn2NSn4Aq6ZEId8ZXSmnEWxYqITbByhVKo
         xKRsaCyvVsNqX+nws8hFR9P8G4DP5tc9buFKHt7ZhbrhUooi8NPF0fTrkakjIZnJmqcl
         1D3FG6U5QC5c9CRG7tTYIEJGd6TIr/9VAMFRR5MzWnKUdKwvb/eaykPM4g/BveA66dsW
         cgRGG8ocijEZPIh6mNEMxZVeS9P4yfeasfbZ09FTiyFavBppHmve0nUqq5uC/kWnDhth
         moVA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-arch@vger.kernel.org,
	kernel-hardening@lists.openwall.com,
	alan@linux.intel.com
Subject: [PATCH 4.15 34/60] x86: Implement array_index_mask_nospec
Date: Mon,  5 Feb 2018 10:23:07 -0800
Message-Id: <20180205182215.361264698@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180205182213.902626065@linuxfoundation.org>
References: <20180205182213.902626065@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591586408458686417?=
X-GMAIL-MSGID: =?utf-8?q?1591586460752709166?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Williams dan.j.williams@intel.com

commit babdde2698d482b6c0de1eab4f697cf5856c5859

array_index_nospec() uses a mask to sanitize user controllable array
indexes, i.e. generate a 0 mask if 'index' >= 'size', and a ~0 mask
otherwise. While the default array_index_mask_nospec() handles the
carry-bit from the (index - size) result in software.

The x86 array_index_mask_nospec() does the same, but the carry-bit is
handled in the processor CF flag without conditional instructions in the
control flow.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arch@vger.kernel.org
Cc: kernel-hardening@lists.openwall.com
Cc: gregkh@linuxfoundation.org
Cc: alan@linux.intel.com
Link: https://lkml.kernel.org/r/151727414808.33451.1873237130672785331.stgit@dwillia2-desk3.amr.corp.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


---
 arch/x86/include/asm/barrier.h |   24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

--- a/arch/x86/include/asm/barrier.h
+++ b/arch/x86/include/asm/barrier.h
@@ -24,6 +24,30 @@
 #define wmb()	asm volatile("sfence" ::: "memory")
 #endif
 
+/**
+ * array_index_mask_nospec() - generate a mask that is ~0UL when the
+ * 	bounds check succeeds and 0 otherwise
+ * @index: array element index
+ * @size: number of elements in array
+ *
+ * Returns:
+ *     0 - (index < size)
+ */
+static inline unsigned long array_index_mask_nospec(unsigned long index,
+		unsigned long size)
+{
+	unsigned long mask;
+
+	asm ("cmp %1,%2; sbb %0,%0;"
+			:"=r" (mask)
+			:"r"(size),"r" (index)
+			:"cc");
+	return mask;
+}
+
+/* Override the default implementation from linux/nospec.h. */
+#define array_index_mask_nospec array_index_mask_nospec
+
 #ifdef CONFIG_X86_PPRO_FENCE
 #define dma_rmb()	rmb()
 #else
