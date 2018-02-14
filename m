Return-Path: <kernel-hardening-return-11778-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x226+CTqWuZCwwgYMVpmcR3jswed6gsKjWezr5ugncX5rAQBIUFKvc23hf3E0xn+io2ngnuWY
ARC-Seal: i=1; a=rsa-sha256; t=1518639167; cv=none;
        d=google.com; s=arc-20160816;
        b=b7dSniyjxjUCcBPFMsY44Ttv1vNAFDg3Y7fpZcXLKTfBxSuRiBtNSrFI87gok7ubdu
         NuIoZ0Ak8ZGI5xfn6EjnuImd9xT9KKkv2LSNkizG0Q2sObPUya4DQf6Su9Bibn1qx2kz
         rmRIIiQmIlqNOOGhQR2W2Z3YkWj0tuN8VYSFDha95pr+saPKFQ32DxkqeVlLIBzfx9pp
         ElDSIUtFsQtyPak7qsqwqoHzMyNStBHbkZAGa/YnaZqEvy2wN33NODJ5gfMs59XvXpuB
         yu9356t+nLm3orVdidw6KihTrz6vJX1RYrNR3q1DF/gek5h7q9CVrxlNlc+d7v2mO5NY
         qfNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:delivered-to:list-id:list-subscribe:list-unsubscribe
         :list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=cAdBwm/zWVPodVO96DuAWxPAhDUwcfsDNzKiQMRmZCw=;
        b=zdaJXYxFVqKgRVDMJ77vb9wRP0ek7X6pc+jGzRjoDMIb/HFq05uYf4kSpRmdAMfuih
         4Di3ycEYCgVXCk90HaTew93297AV/Z7S9RnqL/VtxHRdin8kLIDTpVbWKHZ3IrUqj0vv
         7mJ5VZU09nnoGwakIkLmwGO9MmxE3v2NPcoziGwcGZaxCG4IG4N3W12x8YtMIxpZrFwu
         Z2o72uq3MmN0aWbZD9dRIEuob7viqpnz/3r6S5MuWHhvKoRL4EOpCMf4Zr/g64xh4cgn
         4VLV+qrMzVIoLQMql+LYpv3JNd42rngnR6YZZciiO3tO1qcqINDQ04vxCwCvzYtWeQkI
         GTcQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=fail header.i=@infradead.org header.s=bombadil.20170209 header.b=b3ir5amo;
       spf=pass (google.com: domain of kernel-hardening-return-11778-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11778-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=fail header.i=@infradead.org header.s=bombadil.20170209 header.b=b3ir5amo;
       spf=pass (google.com: domain of kernel-hardening-return-11778-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11778-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
From: Matthew Wilcox <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox <mawilcox@microsoft.com>,
	linux-mm@kvack.org,
	Kees Cook <keescook@chromium.org>,
	linux-kernel@vger.kernel.org,
	kernel-hardening@lists.openwall.com,
	Joe Perches <joe@perches.com>
Subject: [PATCH v2 2/8] mm: Add kvmalloc_ab_c and kvzalloc_struct
Date: Wed, 14 Feb 2018 12:11:48 -0800
Message-Id: <20180214201154.10186-3-willy@infradead.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180214201154.10186-1-willy@infradead.org>
References: <20180214201154.10186-1-willy@infradead.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592408583578566616?=
X-GMAIL-MSGID: =?utf-8?q?1592408583578566616?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Matthew Wilcox <mawilcox@microsoft.com>

We have kvmalloc_array in order to safely allocate an array with a
number of elements specified by userspace (avoiding arithmetic overflow
leading to a buffer overrun).  But it's fairly common to have a header
in front of that array (eg specifying the length of the array), so we
need a helper function for that situation.

kvmalloc_ab_c() is the workhorse that does the calculation, but in spite
of our best efforts to name the arguments, it's really hard to remember
which order to put the arguments in.  kvzalloc_struct() eliminates that
effort; you tell it about the struct you're allocating, and it puts the
arguments in the right order for you (and checks that the arguments
you've given are at least plausible).

For comparison between the three schemes:

	sev = kvzalloc(sizeof(*sev) + sizeof(struct v4l2_kevent) * elems,
			GFP_KERNEL);
	sev = kvzalloc_ab_c(elems, sizeof(struct v4l2_kevent), sizeof(*sev),
			GFP_KERNEL);
	sev = kvzalloc_struct(sev, events, elems, GFP_KERNEL);

Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
---
 include/linux/mm.h | 51 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 81bd7f0be286..3b07ba12c8cc 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -557,6 +557,57 @@ static inline void *kvmalloc_array(size_t n, size_t size, gfp_t flags)
 	return kvmalloc(n * size, flags);
 }
 
+/**
+ * kvmalloc_ab_c() - Allocate (a * b + c) bytes of memory.
+ * @n: Number of elements.
+ * @size: Size of each element (should be constant).
+ * @c: Size of header (should be constant).
+ * @gfp: Memory allocation flags.
+ *
+ * Use this function to allocate @n * @size + @c bytes of memory.  This
+ * function is safe to use when @n is controlled from userspace; it will
+ * return %NULL if the required amount of memory cannot be allocated.
+ * Use kvfree() to free the allocated memory.
+ *
+ * The kvzalloc_struct() function is easier to use as it has typechecking
+ * and you do not need to remember which of the arguments should be constants.
+ *
+ * Context: Process context.  May sleep; the @gfp flags should be based on
+ *	    %GFP_KERNEL.
+ * Return: A pointer to the allocated memory or %NULL.
+ */
+static inline __must_check
+void *kvmalloc_ab_c(size_t n, size_t size, size_t c, gfp_t gfp)
+{
+	if (size != 0 && n > (SIZE_MAX - c) / size)
+		return NULL;
+
+	return kvmalloc(n * size + c, gfp);
+}
+#define kvzalloc_ab_c(a, b, c, gfp) kvmalloc_ab_c(a, b, c, (gfp) | __GFP_ZERO)
+
+/**
+ * kvzalloc_struct() - Allocate and zero-fill a structure containing a
+ *		       variable length array.
+ * @p: Pointer to the structure.
+ * @member: Name of the array member.
+ * @n: Number of elements in the array.
+ * @gfp: Memory allocation flags.
+ *
+ * Allocate (and zero-fill) enough memory for a structure with an array
+ * of @n elements.  This function is safe to use when @n is specified by
+ * userspace as the arithmetic will not overflow.
+ * Use kvfree() to free the allocated memory.
+ *
+ * Context: Process context.  May sleep; the @gfp flags should be based on
+ *	    %GFP_KERNEL.
+ * Return: Zero-filled memory or a NULL pointer.
+ */
+#define kvzalloc_struct(p, member, n, gfp)				\
+	(typeof(p))kvzalloc_ab_c(n,					\
+		sizeof(*(p)->member) + __must_be_array((p)->member),	\
+		offsetof(typeof(*(p)), member), gfp)
+
 extern void kvfree(const void *addr);
 
 static inline atomic_t *compound_mapcount_ptr(struct page *page)
-- 
2.15.1
