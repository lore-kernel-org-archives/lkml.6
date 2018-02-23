Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELv+7xGz+10hWbTJTDZcYXC6sJ/M7ohbjgwMYIhp3QiRhJnTCat7JYc8/YnacGABnGx2OMmI
ARC-Seal: i=1; a=rsa-sha256; t=1519410923; cv=none;
        d=google.com; s=arc-20160816;
        b=vYKsNiZ+K/ibxdpAMPrF8elOOnCIgBK3zud7OfLjhufs4wMItsNbCxsOkSx55O2hHT
         ZnV4a8C1qSoPmSMNmyFUR67vnVrJj6FYZGdQHT4CxLq69cBfXmdsIYEVyaNbPmL4/x+P
         vR8xgfSLAxydYMu+njex0ycKQjsLjOOeSfpn+1whL/XIWDZImxEH5hB/E5sd1GUXQrIE
         I2BDxnD91Mj1B3zDzqj+xiYJDmZbwEWBlHeWq6wyXgRCj+gFhCxE6VLmOsRt2iNrcBeQ
         qGF4OgP9KQBKAUQtJ5ogBjiQG6UwUyK7FPEnIlaZEm97eCHia6k/J7+bEN+CZDPQ7NeD
         I8Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=w+JU5RV7KnYAT2gPQDiCqeBhb30Xa3UGQXJC3de36Xo=;
        b=IwlJkqkzZocF4JgS2n4VWhum8Ad5rjyAsRW1PmQsf8pA6CIRlclZezCbMREGSNL5BL
         Fu4m/ZMCdzyuTGOtfwimWJ45WZOidQPlxnlMB4WhaIkNbtEGfAX5MJEg180YTy6Obiyk
         vMSZNelibRsyIZ/lltBs2AmA+ocuDRwfJ23YUsEt0K2/fzlF3w9fOQE11TGoOhF6HRpk
         WpCMI18VDtAs0ZOVayWJYtgg47KSxzLXbnXXxK57ua5N12pj77yLIOGMqSNCINRCcRy1
         gPaUjD7j6VSPCHzIOoZJKAKvc7UOBgkGqqa8ylodBdicOQ9yct4KK8Y0WnAOFcOi+T1p
         FWrQ==
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
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 059/193] x86/mm/kmmio: Fix mmiotrace for page unaligned addresses
Date: Fri, 23 Feb 2018 19:24:52 +0100
Message-Id: <20180223170335.220215513@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593217627914352720?=
X-GMAIL-MSGID: =?utf-8?q?1593217828551348582?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/mm/ioremap.c |    4 ++--
 arch/x86/mm/kmmio.c   |   12 +++++++-----
 2 files changed, 9 insertions(+), 7 deletions(-)

--- a/arch/x86/mm/ioremap.c
+++ b/arch/x86/mm/ioremap.c
@@ -348,11 +348,11 @@ void iounmap(volatile void __iomem *addr
 	    (void __force *)addr < phys_to_virt(ISA_END_ADDRESS))
 		return;
 
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
@@ -434,17 +434,18 @@ int register_kmmio_probe(struct kmmio_pr
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
@@ -453,7 +454,7 @@ int register_kmmio_probe(struct kmmio_pr
 	kmmio_count++;
 	list_add_rcu(&p->list, &kmmio_probes);
 	while (size < size_lim) {
-		if (add_kmmio_fault_page(p->addr + size))
+		if (add_kmmio_fault_page(addr + size))
 			pr_err("Unable to set page fault.\n");
 		size += page_level_size(l);
 	}
@@ -527,19 +528,20 @@ void unregister_kmmio_probe(struct kmmio
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
