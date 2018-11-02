Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB734C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 13:04:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77836204FD
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 13:04:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77836204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727633AbeKBWL1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 18:11:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57584 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726125AbeKBWL1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 18:11:27 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8E62658E51;
        Fri,  2 Nov 2018 13:04:19 +0000 (UTC)
Received: from redhat.com (ovpn-124-238.rdu2.redhat.com [10.10.124.238])
        by smtp.corp.redhat.com (Postfix) with SMTP id ECDE51054FCF;
        Fri,  2 Nov 2018 13:04:11 +0000 (UTC)
Date:   Fri, 2 Nov 2018 09:04:11 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        bijan.mottahedeh@oracle.com, gedwards@ddn.com, joe@perches.com,
        lenaic@lhuard.fr, liang.z.li@intel.com, mhocko@kernel.org,
        mhocko@suse.com, stefanha@redhat.com, wei.w.wang@intel.com
Subject: Re: [PULL] vhost: cleanups and fixes
Message-ID: <20181102083018-mutt-send-email-mst@kernel.org>
References: <20181101171938-mutt-send-email-mst@kernel.org>
 <CAGXu5jJ0HgV2qN=wohEgro6ixqXHOHBTsvS5a9Dcpz8gxVo3bA@mail.gmail.com>
 <CAHk-=wicvws38JqzVF6oNEZ0jGzP6RecR6yAGtyzX3AkoJ321g@mail.gmail.com>
 <20181102114635.hi3q53kzmz4qljsf@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181102114635.hi3q53kzmz4qljsf@lakrids.cambridge.arm.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Fri, 02 Nov 2018 13:04:20 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 02, 2018 at 11:46:36AM +0000, Mark Rutland wrote:
> On Thu, Nov 01, 2018 at 04:06:19PM -0700, Linus Torvalds wrote:
> > On Thu, Nov 1, 2018 at 4:00 PM Kees Cook <keescook@chromium.org> wrote:
> > >
> > > +       memset(&rsp, 0, sizeof(rsp));
> > > +       rsp.response = VIRTIO_SCSI_S_FUNCTION_REJECTED;
> > > +       resp = vq->iov[out].iov_base;
> > > +       ret = __copy_to_user(resp, &rsp, sizeof(rsp));
> > >
> > > Is it actually safe to trust that iov_base has passed an earlier
> > > access_ok() check here? Why not just use copy_to_user() instead?
> > 
> > Good point.
> > 
> > We really should have removed those double-underscore things ages ago.
> 
> FWIW, on arm64 we always check/sanitize the user address as a result of
> our sanitization of speculated values. Almost all of our uaccess
> routines have an explicit access_ok().
> 
> All our uaccess routines mask the user pointer based on addr_limit,
> which prevents speculative or architectural uaccess to kernel addresses
> when addr_limit it USER_DS:
> 
>     4d8efc2d5ee4c9cc ("arm64: Use pointer masking to limit uaccess speculation")
> 
> We also inhibit speculative stores to addr_limit being forwarded under
> speculation:
> 
>     c2f0ad4fc089cff8 ("arm64: uaccess: Prevent speculative use of the current addr_limit")
> 
> ... and given all that, we folded explicit access_ok() checks into
> __{get,put}_user():
> 
>     84624087dd7e3b48 ("arm64: uaccess: Don't bother eliding access_ok checks in __{get, put}_user")
> 
> IMO we could/should do the same for __copy_{to,from}_user().
> 
> Thanks,
> Mark.

I've tried making access_ok mask the parameter it gets.  Works because
access_ok is a macro. Most users pass in a variable so that will block
attempts to use speculation to bypass the access_ok checks.

Not 100% as someone can copy the value before access_ok, but
then it's all mitigation anyway.

Places which call access_ok on a non-lvalue need to be fixed then but
there are not too many of these.

The advantage here is that a code like this:

access_ok
for(...)
	__get_user

isn't slowed down as the masking is outside the loop.

OTOH macros changing their arguments are kind of ugly.
What do others think?

Just to show what I mean:

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index aae77eb8491c..c4d12c8f47d7 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -7,6 +7,7 @@
 #include <linux/compiler.h>
 #include <linux/kasan-checks.h>
 #include <linux/string.h>
+#include <linux/nospec.h>
 #include <asm/asm.h>
 #include <asm/page.h>
 #include <asm/smap.h>
@@ -69,6 +70,33 @@ static inline bool __chk_range_not_ok(unsigned long addr, unsigned long size, un
 	__chk_range_not_ok((unsigned long __force)(addr), size, limit); \
 })
 
+/*
+ * Test whether a block of memory is a valid user space address.
+ * Returns 0 if the range is valid, address itself otherwise.
+ */
+static inline unsigned long __verify_range_nospec(unsigned long addr,
+						  unsigned long size,
+						  unsigned long limit)
+{
+	/* Be careful about overflow */
+	limit = array_index_nospec(limit, size);
+
+	/*
+	 * If we have used "sizeof()" for the size,
+	 * we know it won't overflow the limit (but
+	 * it might overflow the 'addr', so it's
+	 * important to subtract the size from the
+	 * limit, not add it to the address).
+	 */
+	if (__builtin_constant_p(size)) {
+		return array_index_nospec(addr, limit - size + 1);
+	}
+
+	/* Arbitrary sizes? Be careful about overflow */
+	return array_index_mask_nospec(limit, size) &
+		array_index_nospec(addr, limit - size + 1);
+}
+
 #ifdef CONFIG_DEBUG_ATOMIC_SLEEP
 # define WARN_ON_IN_IRQ()	WARN_ON_ONCE(!in_task())
 #else
@@ -95,12 +123,46 @@ static inline bool __chk_range_not_ok(unsigned long addr, unsigned long size, un
  * checks that the pointer is in the user space range - after calling
  * this function, memory access functions may still return -EFAULT.
  */
-#define access_ok(type, addr, size)					\
+#define unsafe_access_ok(type, addr, size)					\
 ({									\
 	WARN_ON_IN_IRQ();						\
 	likely(!__range_not_ok(addr, size, user_addr_max()));		\
 })
 
+/**
+ * access_ok_nospec: - Checks if a user space pointer is valid
+ * @type: Type of access: %VERIFY_READ or %VERIFY_WRITE.  Note that
+ *        %VERIFY_WRITE is a superset of %VERIFY_READ - if it is safe
+ *        to write to a block, it is always safe to read from it.
+ * @addr: User space pointer to start of block to check
+ * @size: Size of block to check
+ *
+ * Context: User context only. This function may sleep if pagefaults are
+ *          enabled.
+ *
+ * Checks if a pointer to a block of memory in user space is valid.
+ *
+ * Returns address itself (nonzero) if the memory block may be valid,
+ * zero if it is definitely invalid.
+ *
+ * To prevent speculation, the returned value must then be used
+ * for accesses.
+ *
+ * Note that, depending on architecture, this function probably just
+ * checks that the pointer is in the user space range - after calling
+ * this function, memory access functions may still return -EFAULT.
+ */
+#define access_ok_nospec(type, addr, size)			\
+({								\
+	WARN_ON_IN_IRQ();					\
+	__chk_user_ptr(addr);					\
+	addr = (typeof(addr) __force)				\
+	__verify_range_nospec((unsigned long __force)(addr),	\
+			       size, user_addr_max());		\
+})
+
+#define access_ok(type, addr, size) access_ok_nospec(type, addr, size)
+
 /*
  * These are the main single-value transfer routines.  They automatically
  * use the right size if we just have the right pointer type.
-- 
MST
