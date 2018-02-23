Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtm2vm2sz4mkjV+PKMc9P5pARTqirhM+ngUx5fYBMojUO42iusAzJdeMd7O2+mwZS1gzvf9
ARC-Seal: i=1; a=rsa-sha256; t=1519412171; cv=none;
        d=google.com; s=arc-20160816;
        b=y8RTaQ+S+pRUYfhrvJes4Kc+8eO5qX655pt5EsPo6IZpFcwhL34gVzecYgiMKeeJl3
         hwje7Xo+M3GrNOvhpbtd4Gfq1VG8qXfAEFMUrWRQ79bhxlWLkks8vlZeYI2RxDyol4BK
         6CKt0Gh6qjCA4H4Xe4tlr3yqWfjNNqu6VrAbwoGx8+U0k3Ye3HX2j4Caz7wCnP8Dutne
         hQrTX7UmgttadUTZvUCBryWQWAUJv+U4ulo4r47hJ28cAfF/NIZdYI/zYxuEJYcmF06N
         sZ+LF6hS/UIRoBZ/d1lBcCgRFEyUnLzULCzmkZ4YgJBXqI+qARA/x6LkEGpt9mw5FG9d
         7tLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=AqjO7q8vzlqakhM/YU2L42myq/51gIKu/Mm5opxfZ8k=;
        b=IkafqKNJJUMpjlg+xWaEOJE5k7g6VQottz9Jq5chGEWEhb2lfVBlkAX4467bsQYS6p
         GfyroizSTK7Hyfj8BNmlQtJ5vnJUq0hm/N5BUmxa/9YgUyXIajBiN44q9GyngHPIP//5
         xsY1/CjN222KeI1I94XPwoL7bU/ziviNRKdaNCnjz1jI2bx7lH1smsb1Fz4NlSgroj7W
         2Ci/Es6XBokVmpTIUr3eBrFhr4kKY4ZqlPwMTOA9YlG9V21oX9+cDZ78/w8QHjFGxNEy
         V6VcI5NvSOcOibbeMyKz4si21907gweONhYVikDWo4ebSkaL6fL3ynQ7f6o3twj8ygI6
         W9Uw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Lyude <lyude@redhat.com>,
	Karol Herbst <kherbst@redhat.com>,
	Pekka Paalanen <ppaalanen@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	nouveau@lists.freedesktop.org,
	Ingo Molnar <mingo@kernel.org>,
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 148/159] x86/mm/kmmio: Fix mmiotrace for page unaligned addresses
Date: Fri, 23 Feb 2018 19:27:36 +0100
Message-Id: <20180223170800.883691621@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170743.086611315@linuxfoundation.org>
References: <20180223170743.086611315@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593217627914352720?=
X-GMAIL-MSGID: =?utf-8?q?1593219137940438466?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Karol Herbst <kherbst@redhat.com>


[ Upstream commit 6d60ce384d1d5ca32b595244db4077a419acc687 ]

If something calls ioremap() with an address not aligned to PAGE_SIZE, the
returned address might be not aligned as well. This led to a probe
registered on exactly the returned address, but the entire page was armed
for mmiotracing.

On calling iounmap() the address passed to unregister_kmmio_probe() was
PAGE_SIZE aligned by the caller leading to a complete freeze of the
machine.

We should always page align addresses while (un)registerung mappings,
because the mmiotracer works on top of pages, not mappings. We still keep
track of the probes based on their real addresses and lengths though,
because the mmiotrace still needs to know what are mapped memory regions.

Also move the call to mmiotrace_iounmap() prior page aligning the address,
so that all probes are unregistered properly, otherwise the kernel ends up
failing memory allocations randomly after disabling the mmiotracer.

Tested-by: Lyude <lyude@redhat.com>
Signed-off-by: Karol Herbst <kherbst@redhat.com>
Acked-by: Pekka Paalanen <ppaalanen@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: nouveau@lists.freedesktop.org
Link: http://lkml.kernel.org/r/20171127075139.4928-1-kherbst@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/mm/ioremap.c |    4 ++--
 arch/x86/mm/kmmio.c   |   12 +++++++-----
 2 files changed, 9 insertions(+), 7 deletions(-)

--- a/arch/x86/mm/ioremap.c
+++ b/arch/x86/mm/ioremap.c
@@ -349,11 +349,11 @@ void iounmap(volatile void __iomem *addr
 		return;
 	}
 
+	mmiotrace_iounmap(addr);
+
 	addr = (volatile void __iomem *)
 		(PAGE_MASK & (unsigned long __force)addr);
 
-	mmiotrace_iounmap(addr);
-
 	/* Use the vm area unlocked, assuming the caller
 	   ensures there isn't another iounmap for the same address
 	   in parallel. Reuse of the virtual address is prevented by
--- a/arch/x86/mm/kmmio.c
+++ b/arch/x86/mm/kmmio.c
@@ -435,17 +435,18 @@ int register_kmmio_probe(struct kmmio_pr
 	unsigned long flags;
 	int ret = 0;
 	unsigned long size = 0;
+	unsigned long addr = p->addr & PAGE_MASK;
 	const unsigned long size_lim = p->len + (p->addr & ~PAGE_MASK);
 	unsigned int l;
 	pte_t *pte;
 
 	spin_lock_irqsave(&kmmio_lock, flags);
-	if (get_kmmio_probe(p->addr)) {
+	if (get_kmmio_probe(addr)) {
 		ret = -EEXIST;
 		goto out;
 	}
 
-	pte = lookup_address(p->addr, &l);
+	pte = lookup_address(addr, &l);
 	if (!pte) {
 		ret = -EINVAL;
 		goto out;
@@ -454,7 +455,7 @@ int register_kmmio_probe(struct kmmio_pr
 	kmmio_count++;
 	list_add_rcu(&p->list, &kmmio_probes);
 	while (size < size_lim) {
-		if (add_kmmio_fault_page(p->addr + size))
+		if (add_kmmio_fault_page(addr + size))
 			pr_err("Unable to set page fault.\n");
 		size += page_level_size(l);
 	}
@@ -528,19 +529,20 @@ void unregister_kmmio_probe(struct kmmio
 {
 	unsigned long flags;
 	unsigned long size = 0;
+	unsigned long addr = p->addr & PAGE_MASK;
 	const unsigned long size_lim = p->len + (p->addr & ~PAGE_MASK);
 	struct kmmio_fault_page *release_list = NULL;
 	struct kmmio_delayed_release *drelease;
 	unsigned int l;
 	pte_t *pte;
 
-	pte = lookup_address(p->addr, &l);
+	pte = lookup_address(addr, &l);
 	if (!pte)
 		return;
 
 	spin_lock_irqsave(&kmmio_lock, flags);
 	while (size < size_lim) {
-		release_kmmio_fault_page(p->addr + size, &release_list);
+		release_kmmio_fault_page(addr + size, &release_list);
 		size += page_level_size(l);
 	}
 	list_del_rcu(&p->list);
