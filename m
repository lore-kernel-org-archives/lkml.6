Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18AECC004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 23:11:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22DCB20645
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 23:11:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22DCB20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=iogearbox.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728371AbeJWHbo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 03:31:44 -0400
Received: from www62.your-server.de ([213.133.104.62]:44032 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbeJWHbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 03:31:44 -0400
Received: from [62.203.87.61] (helo=localhost)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1gEjLn-0006lD-5d; Tue, 23 Oct 2018 01:11:07 +0200
From:   Daniel Borkmann <daniel@iogearbox.net>
To:     ast@kernel.org
Cc:     rick.p.edgecombe@intel.com, eric.dumazet@gmail.com,
        jannh@google.com, keescook@chromium.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf] bpf: add bpf_jit_limit knob to restrict unpriv allocations
Date:   Tue, 23 Oct 2018 01:11:04 +0200
Message-Id: <20181022231104.3443-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.9.5
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.2/25061/Mon Oct 22 23:06:35 2018)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rick reported that the BPF JIT could potentially fill the entire module
space with BPF programs from unprivileged users which would prevent later
attempts to load normal kernel modules or privileged BPF programs, for
example. If JIT was enabled but unsuccessful to generate the image, then
before commit 290af86629b2 ("bpf: introduce BPF_JIT_ALWAYS_ON config")
we would always fall back to the BPF interpreter. Nowadays in the case
where the CONFIG_BPF_JIT_ALWAYS_ON could be set, then the load will abort
with a failure since the BPF interpreter was compiled out.

Add a global limit and enforce it for unprivileged users such that in case
of BPF interpreter compiled out we fail once the limit has been reached
or we fall back to BPF interpreter earlier w/o using module mem if latter
was compiled in. In a next step, fair share among unprivileged users can
be resolved in particular for the case where we would fail hard once limit
is reached.

Fixes: 290af86629b2 ("bpf: introduce BPF_JIT_ALWAYS_ON config")
Fixes: 0a14842f5a3c ("net: filter: Just In Time compiler for x86-64")
Co-Developed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Alexei Starovoitov <ast@kernel.org>
Cc: Eric Dumazet <eric.dumazet@gmail.com>
Cc: Jann Horn <jannh@google.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: LKML <linux-kernel@vger.kernel.org>
---
 Hi Rick, I've reworked the original patch into something much simpler
 which is only focussing on the actual main issue we want to resolve right
 now as a first step to make some forward progress, that is, limiting usage
 on the JIT for unprivileged users. Tested the below on x86 and arm64.
 (Trimmed down massive Cc list as well a bit and Cc'ed people related to
 commits referenced and netdev where BPF patches are usually discussed.)
 Thanks a lot!

 Documentation/sysctl/net.txt |  8 ++++++++
 include/linux/filter.h       |  1 +
 kernel/bpf/core.c            | 49 +++++++++++++++++++++++++++++++++++++++++---
 net/core/sysctl_net_core.c   | 10 +++++++--
 4 files changed, 63 insertions(+), 5 deletions(-)

diff --git a/Documentation/sysctl/net.txt b/Documentation/sysctl/net.txt
index 9ecde51..2793d4e 100644
--- a/Documentation/sysctl/net.txt
+++ b/Documentation/sysctl/net.txt
@@ -92,6 +92,14 @@ Values :
 	0 - disable JIT kallsyms export (default value)
 	1 - enable JIT kallsyms export for privileged users only
 
+bpf_jit_limit
+-------------
+
+This enforces a global limit for memory allocations to the BPF JIT
+compiler in order to reject unprivileged JIT requests once it has
+been surpassed. bpf_jit_limit contains the value of the global limit
+in bytes.
+
 dev_weight
 --------------
 
diff --git a/include/linux/filter.h b/include/linux/filter.h
index 91b4c93..de629b7 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -854,6 +854,7 @@ bpf_run_sk_reuseport(struct sock_reuseport *reuse, struct sock *sk,
 extern int bpf_jit_enable;
 extern int bpf_jit_harden;
 extern int bpf_jit_kallsyms;
+extern int bpf_jit_limit;
 
 typedef void (*bpf_jit_fill_hole_t)(void *area, unsigned int size);
 
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 7c7eeea..6377225 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -365,10 +365,13 @@ void bpf_prog_kallsyms_del_all(struct bpf_prog *fp)
 }
 
 #ifdef CONFIG_BPF_JIT
+# define BPF_JIT_LIMIT_DEFAULT	(PAGE_SIZE * 40000)
+
 /* All BPF JIT sysctl knobs here. */
 int bpf_jit_enable   __read_mostly = IS_BUILTIN(CONFIG_BPF_JIT_ALWAYS_ON);
 int bpf_jit_harden   __read_mostly;
 int bpf_jit_kallsyms __read_mostly;
+int bpf_jit_limit    __read_mostly = BPF_JIT_LIMIT_DEFAULT;
 
 static __always_inline void
 bpf_get_prog_addr_region(const struct bpf_prog *prog,
@@ -577,27 +580,64 @@ int bpf_get_kallsym(unsigned int symnum, unsigned long *value, char *type,
 	return ret;
 }
 
+static atomic_long_t bpf_jit_current;
+
+#if defined(MODULES_VADDR)
+static int __init bpf_jit_charge_init(void)
+{
+	/* Only used as heuristic here to derive limit. */
+	bpf_jit_limit = min_t(u64, round_up((MODULES_END - MODULES_VADDR) >> 2,
+					    PAGE_SIZE), INT_MAX);
+	return 0;
+}
+pure_initcall(bpf_jit_charge_init);
+#endif
+
+static int bpf_jit_charge_modmem(u32 pages)
+{
+	if (atomic_long_add_return(pages, &bpf_jit_current) >
+	    (bpf_jit_limit >> PAGE_SHIFT)) {
+		if (!capable(CAP_SYS_ADMIN)) {
+			atomic_long_sub(pages, &bpf_jit_current);
+			return -EPERM;
+		}
+	}
+
+	return 0;
+}
+
+static void bpf_jit_uncharge_modmem(u32 pages)
+{
+	atomic_long_sub(pages, &bpf_jit_current);
+}
+
 struct bpf_binary_header *
 bpf_jit_binary_alloc(unsigned int proglen, u8 **image_ptr,
 		     unsigned int alignment,
 		     bpf_jit_fill_hole_t bpf_fill_ill_insns)
 {
 	struct bpf_binary_header *hdr;
-	unsigned int size, hole, start;
+	u32 size, hole, start, pages;
 
 	/* Most of BPF filters are really small, but if some of them
 	 * fill a page, allow at least 128 extra bytes to insert a
 	 * random section of illegal instructions.
 	 */
 	size = round_up(proglen + sizeof(*hdr) + 128, PAGE_SIZE);
+	pages = size / PAGE_SIZE;
+
+	if (bpf_jit_charge_modmem(pages))
+		return NULL;
 	hdr = module_alloc(size);
-	if (hdr == NULL)
+	if (!hdr) {
+		bpf_jit_uncharge_modmem(pages);
 		return NULL;
+	}
 
 	/* Fill space with illegal/arch-dep instructions. */
 	bpf_fill_ill_insns(hdr, size);
 
-	hdr->pages = size / PAGE_SIZE;
+	hdr->pages = pages;
 	hole = min_t(unsigned int, size - (proglen + sizeof(*hdr)),
 		     PAGE_SIZE - sizeof(*hdr));
 	start = (get_random_int() % hole) & ~(alignment - 1);
@@ -610,7 +650,10 @@ bpf_jit_binary_alloc(unsigned int proglen, u8 **image_ptr,
 
 void bpf_jit_binary_free(struct bpf_binary_header *hdr)
 {
+	u32 pages = hdr->pages;
+
 	module_memfree(hdr);
+	bpf_jit_uncharge_modmem(pages);
 }
 
 /* This symbol is only overridden by archs that have different
diff --git a/net/core/sysctl_net_core.c b/net/core/sysctl_net_core.c
index b1a2c5e..37b4667 100644
--- a/net/core/sysctl_net_core.c
+++ b/net/core/sysctl_net_core.c
@@ -279,7 +279,6 @@ static int proc_dointvec_minmax_bpf_enable(struct ctl_table *table, int write,
 	return ret;
 }
 
-# ifdef CONFIG_HAVE_EBPF_JIT
 static int
 proc_dointvec_minmax_bpf_restricted(struct ctl_table *table, int write,
 				    void __user *buffer, size_t *lenp,
@@ -290,7 +289,6 @@ proc_dointvec_minmax_bpf_restricted(struct ctl_table *table, int write,
 
 	return proc_dointvec_minmax(table, write, buffer, lenp, ppos);
 }
-# endif
 #endif
 
 static struct ctl_table net_core_table[] = {
@@ -397,6 +395,14 @@ static struct ctl_table net_core_table[] = {
 		.extra2		= &one,
 	},
 # endif
+	{
+		.procname	= "bpf_jit_limit",
+		.data		= &bpf_jit_limit,
+		.maxlen		= sizeof(int),
+		.mode		= 0600,
+		.proc_handler	= proc_dointvec_minmax_bpf_restricted,
+		.extra1		= &one,
+	},
 #endif
 	{
 		.procname	= "netdev_tstamp_prequeue",
-- 
2.9.5

