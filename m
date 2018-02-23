Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2279TK0k2gpC5RT543apveImn1Oaeglb+IU27kt5mE5M/hYa6k+U9I0jbQgMblvyEUbsbS09
ARC-Seal: i=1; a=rsa-sha256; t=1519411258; cv=none;
        d=google.com; s=arc-20160816;
        b=OFlV+dDYc0PJpjKtw8D/oTA3IRNTNwlzrp2pbskXWxEI0zrdr08ihkSZdz/twMo6qi
         6OapOkroZQ4AJFZc7sABx7XSRJsRhlX+rTkZ28NyiaihNkbNT0DlpOxnaCjwCuEVOX2h
         tsf3elWtcg5kSMcxsqQBwIlwbrBuomSP2Ud6qk4sYoLFEAyIE9tQPGikeJyu84ew/9Kc
         phAN2D0My/IRdxwUULF7kSt1XXkNTaEtaBdVFs7KtBpbaXkz3DaAt2SIG5ddueo0hwKZ
         pr2Msxx9MNJoFdKZvv1io66MD2niUZZTDC6iYYyT39dUDl6KYxEIt10BytDcEltvB3hY
         JEjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=wKZsoUg8Jks9QaizcZ74pMvc3P6RBClHMAcZxnA2Y0M=;
        b=XBAFkDmMsTTzwzGADzulI9HhZa1RB2inaTkcozf87587mHuWHWzP2SP4nB0VmcmCMV
         BnbXCyintbXVfI7jHSKNH7uW407gZkvg0NmB5FX67FU1kPpNVxM4OD3NbkzmpzfuOoKZ
         hfjE2yOrL8Tkccp1D9kA6fy+gPQf9AdtXAUzN4zq/hvcYZtp+snyUN1NVtCxvrVaFins
         90fVQOxp0FUMyj3dH+XymZQGGX/eSTEKxxtywDHJr1riaHRhYHQnXFowXYQsd0oMH5ed
         qi17VIJbHALRivEnQmk/V4jx1e7lVNgElQ9qzQqRj2PJnD+XJKgOnJdp3qQyczisweWv
         QelQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-arch@vger.kernel.org,
	kernel-hardening@lists.openwall.com,
	alan@linux.intel.com,
	David Woodhouse <dwmw@amazon.co.uk>,
	Jack Wang <jinpu.wang@profitbricks.com>
Subject: [PATCH 4.4 175/193] x86: Implement array_index_mask_nospec
Date: Fri, 23 Feb 2018 19:26:48 +0100
Message-Id: <20180223170353.463068875@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593218179864531574?=
X-GMAIL-MSGID: =?utf-8?q?1593218179864531574?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Williams <dan.j.williams@intel.com>

(cherry picked from commit babdde2698d482b6c0de1eab4f697cf5856c5859)

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
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
[jwang:chery pick to 4.4]
Signed-off-by: Jack Wang <jinpu.wang@profitbricks.com>
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
