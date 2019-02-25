Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 671D8C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 15:06:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D8802087C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 15:06:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tirSqNTG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727550AbfBYPGL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 10:06:11 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:42488 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726675AbfBYPGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 10:06:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=WoLbm1TVsFnDI1P7PMwVxgP6CrGU1zZ2knO00q8Q7m0=; b=tirSqNTGZB5chhxerl325h+7c
        n2bJPOblVGC6ph1FusoeQZF81zFfxd99A4z1DxmOylEJfk49GqNnwM6sm2hLjKKtXOYWv0WHius0a
        Vx0vRS1VhSlbsnBXctgP+AERJ15p24Qan5Jp7ffD7uL40N4K0Mme4NvK2TuSmfHV2A7+W8MEdzPMk
        mzxwmfyHTtNDC/VoKgzrQvWcwbkWCNDU/yXhlxqUa4uj70zbyL1jOYzgdnQC/MQ6CGEfB+1RFOy32
        6x4Lq1lHQnr0+K+XCzV6Z9/oMqfiZun/aQscqS3PT6Px+2FcQklao5dYZMkhMQjTb5zfY62FuqdG8
        LlLZNA96Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gyHpV-0002Yf-3j; Mon, 25 Feb 2019 15:06:05 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8C86E2030C216; Mon, 25 Feb 2019 16:06:03 +0100 (CET)
Date:   Mon, 25 Feb 2019 16:06:03 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Changbin Du <changbin.du@gmail.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Nadav Amit <namit@vmware.com>
Subject: Re: [RFC PATCH 2/4] uaccess: Add non-pagefault user-space read
 functions
Message-ID: <20190225150603.GE32494@hirez.programming.kicks-ass.net>
References: <155110348217.21156.3874419272673328527.stgit@devbox>
 <155110354092.21156.13871336589042178985.stgit@devbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <155110354092.21156.13871336589042178985.stgit@devbox>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 25, 2019 at 11:05:41PM +0900, Masami Hiramatsu wrote:

> +static __always_inline long __strncpy_from_unsafe_user(char *dst,
> +			 const char __user *unsafe_addr, long count)
> +{
> +	if (!access_ok(unsafe_addr, count))
> +		return -EFAULT;
> +
> +	return strncpy_from_unsafe_common(dst, unsafe_addr, count);
> +}

Would something like so work for people?

---
 arch/x86/include/asm/uaccess.h |  8 +++++++-
 include/linux/uaccess.h        | 18 ++++++++++++++++++
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index 780f2b42c8ef..3125d129d3b6 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -92,12 +92,18 @@ static inline bool __chk_range_not_ok(unsigned long addr, unsigned long size, un
  * checks that the pointer is in the user space range - after calling
  * this function, memory access functions may still return -EFAULT.
  */
-#define access_ok(addr, size)					\
+#define access_ok(addr, size)						\
 ({									\
 	WARN_ON_IN_IRQ();						\
 	likely(!__range_not_ok(addr, size, user_addr_max()));		\
 })
 
+#define user_access_ok(addr, size)					\
+({									\
+	WARN_ON_ONCE(!segment_eq(get_fs(), USER_DS));			\
+	likely(!__range_not_ok(addr, size, user_addr_max()));		\
+})
+
 /*
  * These are the main single-value transfer routines.  They automatically
  * use the right size if we just have the right pointer type.
diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index 37b226e8df13..088f2ae09e14 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -10,6 +10,24 @@
 
 #include <asm/uaccess.h>
 
+/**
+ * user_access_ok: Checks if a user space pointer is valid
+ * @addr: User space pointer to start of block to check
+ * @size: Size of block to check
+ *
+ * Context: User context or explicit set_fs(USER_DS).
+ *
+ * This function is very much like access_ok(), except it (may) have different
+ * context validation. In general we must be very careful when using this.
+ */
+#ifndef user_access_ok
+#define user_access_ok(addr, size)					\
+({									\
+	WARN_ON_ONCE(!segment_eq(get_fs(), USER_DS));			\
+	access_ok(addr, size);						\
+})
+#endif
+
 /*
  * Architectures should provide two primitives (raw_copy_{to,from}_user())
  * and get rid of their private instances of copy_{to,from}_user() and

> +/**
> + * strncpy_from_unsafe_user: - Copy a NUL terminated string from unsafe user
> + *				address.
> + * @dst:   Destination address, in kernel space.  This buffer must be at
> + *         least @count bytes long.
> + * @unsafe_addr: Unsafe user address.
> + * @count: Maximum number of bytes to copy, including the trailing NUL.
> + *
> + * Copies a NUL-terminated string from unsafe user address to kernel buffer.
> + *
> + * On success, returns the length of the string INCLUDING the trailing NUL.
> + *
> + * If access fails, returns -EFAULT (some data may have been copied
> + * and the trailing NUL added).
> + *
> + * If @count is smaller than the length of the string, copies @count-1 bytes,
> + * sets the last byte of @dst buffer to NUL and returns @count.
> + */
> +long strncpy_from_unsafe_user(char *dst, const void __user *unsafe_addr,
> +			      long count)
> +{
> +	mm_segment_t old_fs = get_fs();
> +	long ret;
> +
> +	if (unlikely(count <= 0))
> +		return 0;
> +
> +	if (segment_eq(old_fs, USER_DS)) {
> +		ret = __strncpy_from_unsafe_user(dst, unsafe_addr, count);
> +	} else {
> +		set_fs(USER_DS);
> +		ret = __strncpy_from_unsafe_user(dst, unsafe_addr, count);
> +		set_fs(old_fs);
> +	}
> +	return ret;
>  }

Is that really worth the effort?

Why not keep it simple:

	mm_segment_t old_fs = get_fs();

	set_fs(USER_DS);
	ret = __strncpy...();
	set_fs(old_fd);

	return ret;
?
