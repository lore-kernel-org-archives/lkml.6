Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224xT+KhgsmSTLS71U69wfQdUuZZjHx/H7J4lcFQGnd0hdfNe1h9l9VxZysRHTCI7p7uyFbn
ARC-Seal: i=1; a=rsa-sha256; t=1517855080; cv=none;
        d=google.com; s=arc-20160816;
        b=p8ZhlSHkMN18TJYbkALYaxRw4kVtv9rxY0krh6XJiPN+BHclTpkkqPdO+nVU2XHo9w
         MrSFHSz/7IyFk4FwkCSzRoaR3vvl8Hdukh14IJZXA/KCgkpV61uQ/PtsUPsaUI9XqrAW
         cqeMifsNKrYPTk5focQJY3WW6n5EbEzJJzyH9grRrZ90bJ/JYDYLs7l51tcf5lh04uq2
         b0YZflrBUU3iIrf6M2+r6+8ISXC9bil53Bcj9Y24Y3Yt78vcrhJHnUpmFdh3R2TImDqO
         XdNKQ5EC9NO66p3zdCoB4HgtzStaxMqxvtpD1rJ9m8z3H6h9oACcGlZ0Fs3YsvdphzSu
         jqrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=bLRGGgxbbF1S/s+kS8Ha3QGxuYjsfbbaRVG4pJ4Xcoc=;
        b=zObONtZyVRkZqa2B+fTVQiqLkUn5fOnrZAAUqKpWZSNFZugD9eS5rp8+fbmblv3Jey
         psbqGHODM45Fjf2rVhIsFHQnnQnjL1/nqCWIQ1OeZ8g0A79TUi2pCDiigHU4ne3/LvJX
         ELjyEkdAM9U+ELSCnzQDimxHA5Mnj+u56pV1rlkCmAOGHEBVMIXZyzGA3g21gNCU4GQ7
         TCrUeaFLLKwTvVcQj49pLdqaP0VklyeO36CvjvZ7lp8bqXx/iGPMODBBTBH6gZjqK7/b
         hs6DnWj89999UY5Z1V7tBFvtX+4ozO2AYh+qYDpsW16/NS8MHhGU99cErXFgh+Pjv6w4
         pjxw==
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
Subject: [PATCH 4.14 38/64] x86: Implement array_index_mask_nospec
Date: Mon,  5 Feb 2018 10:22:57 -0800
Message-Id: <20180205182140.147895085@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180205182138.571333346@linuxfoundation.org>
References: <20180205182138.571333346@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591586408458686417?=
X-GMAIL-MSGID: =?utf-8?q?1591586408458686417?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
