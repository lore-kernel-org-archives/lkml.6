Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225o7SGp3Nk4sNQ+UfTOp2213+vw70yRlk14Zjlx6wlknAwgYnGCSJiIWrrSsoWPYQn7LWeR
ARC-Seal: i=1; a=rsa-sha256; t=1517590826; cv=none;
        d=google.com; s=arc-20160816;
        b=bF3wD5jdatmoBqmXCL6p+PkMretD4gKnXpn1mg3QWDsOBbg+WqQPen5wMFI33uUkXD
         dcSn2QRHOmyc0AnzILMAhsPYHUSZmrJaH3b+RVmAkFJMzWIfX97tS7t6Nr0s0LJ//v7c
         N8iuVlOjJSECBTy+ch9MzBpdiZUNnfa+xf1j39BAWn/5jRrPPMckEaxa8XZtDcjLPJEZ
         1CR1auoRwQXPpbYkmQoKYbAcc9Aa+KQFrjFzw+9EgvaxWOTqaHxsfBELxN3pC0UWlFoj
         4oAKfJD5bJGBZnnG7zTT31YJehnnkqrmAWUFidptKj4QpHyyufSO3IlE1QG2QD4CLgtJ
         vnKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=aXALvLAh3TMgzCXqSHTEwEgnNotgyFTtZg3AAuHuQEg=;
        b=Ie/Hjv6IH30IoVpWIpJ92Mg4FuGwC/wxpXl99fGSjATUf3rQFZd8U9DZdFDGYJ3ZXg
         LqoQaFWDRLdYuLqPfs6RhDVIqpct7EYf0U7/e+0GsCIG+2t62N37OPUc8Ia4CCm87njc
         VSqtnZG5TutJDWCTYNyn602T40HlcTA8ryLDwo1pzh5uCIS0RIsnPX2rJLyjilzzkucj
         r8Ir7jAfv8cHbozoLphj+XtiZFXNaLm1d2lPcaHfGhqST646r+m24MwWlmt/d3UDdae2
         fVMqW+oHbK1S6L0NXs6x7pCC17iEYrj/WknV2Dq7DJTe57WuwS1XDjwunESRbVZaWZLm
         wiKQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH 4.4 05/67] bpf: introduce BPF_JIT_ALWAYS_ON config
Date: Fri,  2 Feb 2018 17:57:34 +0100
Message-Id: <20180202140815.846106508@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140815.091718203@linuxfoundation.org>
References: <20180202140815.091718203@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309318945296656?=
X-GMAIL-MSGID: =?utf-8?q?1591309318945296656?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexei Starovoitov <ast@kernel.org>

[ upstream commit 290af86629b25ffd1ed6232c4e9107da031705cb ]

The BPF interpreter has been used as part of the spectre 2 attack CVE-2017-5715.

A quote from goolge project zero blog:
"At this point, it would normally be necessary to locate gadgets in
the host kernel code that can be used to actually leak data by reading
from an attacker-controlled location, shifting and masking the result
appropriately and then using the result of that as offset to an
attacker-controlled address for a load. But piecing gadgets together
and figuring out which ones work in a speculation context seems annoying.
So instead, we decided to use the eBPF interpreter, which is built into
the host kernel - while there is no legitimate way to invoke it from inside
a VM, the presence of the code in the host kernel's text section is sufficient
to make it usable for the attack, just like with ordinary ROP gadgets."

To make attacker job harder introduce BPF_JIT_ALWAYS_ON config
option that removes interpreter from the kernel in favor of JIT-only mode.
So far eBPF JIT is supported by:
x64, arm64, arm32, sparc64, s390, powerpc64, mips64

The start of JITed program is randomized and code page is marked as read-only.
In addition "constant blinding" can be turned on with net.core.bpf_jit_harden

v2->v3:
- move __bpf_prog_ret0 under ifdef (Daniel)

v1->v2:
- fix init order, test_bpf and cBPF (Daniel's feedback)
- fix offloaded bpf (Jakub's feedback)
- add 'return 0' dummy in case something can invoke prog->bpf_func
- retarget bpf tree. For bpf-next the patch would need one extra hunk.
  It will be sent when the trees are merged back to net-next

Considered doing:
  int bpf_jit_enable __read_mostly = BPF_EBPF_JIT_DEFAULT;
but it seems better to land the patch as-is and in bpf-next remove
bpf_jit_enable global variable from all JITs, consolidate in one place
and remove this jit_init() function.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/Kconfig         |    1 +
 arch/s390/Kconfig          |    1 +
 arch/x86/Kconfig           |    1 +
 init/Kconfig               |    7 +++++++
 kernel/bpf/core.c          |   24 +++++++++++++++++++++++-
 lib/test_bpf.c             |   13 ++++++++-----
 net/Kconfig                |    3 +++
 net/core/filter.c          |    4 +++-
 net/core/sysctl_net_core.c |    6 ++++++
 net/socket.c               |    9 +++++++++
 10 files changed, 62 insertions(+), 7 deletions(-)

--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -54,6 +54,7 @@ config ARM64
 	select HAVE_ARCH_SECCOMP_FILTER
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_BPF_JIT
+	select HAVE_EBPF_JIT
 	select HAVE_C_RECORDMCOUNT
 	select HAVE_CC_STACKPROTECTOR
 	select HAVE_CMPXCHG_DOUBLE
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -123,6 +123,7 @@ config S390
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_ARCH_TRANSPARENT_HUGEPAGE
 	select HAVE_BPF_JIT if PACK_STACK && HAVE_MARCH_Z196_FEATURES
+	select HAVE_EBPF_JIT if PACK_STACK && HAVE_MARCH_Z196_FEATURES
 	select HAVE_CMPXCHG_DOUBLE
 	select HAVE_CMPXCHG_LOCAL
 	select HAVE_DEBUG_KMEMLEAK
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -88,6 +88,7 @@ config X86
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_ARCH_TRANSPARENT_HUGEPAGE
 	select HAVE_BPF_JIT			if X86_64
+	select HAVE_EBPF_JIT			if X86_64
 	select HAVE_CC_STACKPROTECTOR
 	select HAVE_CMPXCHG_DOUBLE
 	select HAVE_CMPXCHG_LOCAL
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1556,6 +1556,13 @@ config BPF_SYSCALL
 	  Enable the bpf() system call that allows to manipulate eBPF
 	  programs and maps via file descriptors.
 
+config BPF_JIT_ALWAYS_ON
+	bool "Permanently enable BPF JIT and remove BPF interpreter"
+	depends on BPF_SYSCALL && HAVE_EBPF_JIT && BPF_JIT
+	help
+	  Enables BPF JIT and removes BPF interpreter to avoid
+	  speculative execution of BPF instructions by the interpreter
+
 config SHMEM
 	bool "Use full shmem filesystem" if EXPERT
 	default y
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -256,6 +256,7 @@ noinline u64 __bpf_call_base(u64 r1, u64
 }
 EXPORT_SYMBOL_GPL(__bpf_call_base);
 
+#ifndef CONFIG_BPF_JIT_ALWAYS_ON
 /**
  *	__bpf_prog_run - run eBPF program on a given context
  *	@ctx: is the data we are operating on
@@ -725,6 +726,13 @@ load_byte:
 		return 0;
 }
 
+#else
+static unsigned int __bpf_prog_ret0(void *ctx, const struct bpf_insn *insn)
+{
+	return 0;
+}
+#endif
+
 bool bpf_prog_array_compatible(struct bpf_array *array,
 			       const struct bpf_prog *fp)
 {
@@ -771,9 +779,23 @@ static int bpf_check_tail_call(const str
  */
 int bpf_prog_select_runtime(struct bpf_prog *fp)
 {
+#ifndef CONFIG_BPF_JIT_ALWAYS_ON
 	fp->bpf_func = (void *) __bpf_prog_run;
-
+#else
+	fp->bpf_func = (void *) __bpf_prog_ret0;
+#endif
+
+	/* eBPF JITs can rewrite the program in case constant
+	 * blinding is active. However, in case of error during
+	 * blinding, bpf_int_jit_compile() must always return a
+	 * valid program, which in this case would simply not
+	 * be JITed, but falls back to the interpreter.
+	 */
 	bpf_int_jit_compile(fp);
+#ifdef CONFIG_BPF_JIT_ALWAYS_ON
+	if (!fp->jited)
+		return -ENOTSUPP;
+#endif
 	bpf_prog_lock_ro(fp);
 
 	/* The tail call compatibility check can only be done at
--- a/lib/test_bpf.c
+++ b/lib/test_bpf.c
@@ -5304,9 +5304,8 @@ static struct bpf_prog *generate_filter(
 				return NULL;
 			}
 		}
-		/* We don't expect to fail. */
 		if (*err) {
-			pr_cont("FAIL to attach err=%d len=%d\n",
+			pr_cont("FAIL to prog_create err=%d len=%d\n",
 				*err, fprog.len);
 			return NULL;
 		}
@@ -5325,7 +5324,11 @@ static struct bpf_prog *generate_filter(
 		fp->type = BPF_PROG_TYPE_SOCKET_FILTER;
 		memcpy(fp->insnsi, fptr, fp->len * sizeof(struct bpf_insn));
 
-		bpf_prog_select_runtime(fp);
+		*err = bpf_prog_select_runtime(fp);
+		if (*err) {
+			pr_cont("FAIL to select_runtime err=%d\n", *err);
+			return NULL;
+		}
 		break;
 	}
 
@@ -5511,8 +5514,8 @@ static __init int test_bpf(void)
 				pass_cnt++;
 				continue;
 			}
-
-			return err;
+			err_cnt++;
+			continue;
 		}
 
 		pr_cont("jited:%u ", fp->jited);
--- a/net/Kconfig
+++ b/net/Kconfig
@@ -388,3 +388,6 @@ endif   # if NET
 # Used by archs to tell that they support BPF_JIT
 config HAVE_BPF_JIT
 	bool
+
+config HAVE_EBPF_JIT
+	bool
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -984,7 +984,9 @@ static struct bpf_prog *bpf_migrate_filt
 		 */
 		goto out_err_free;
 
-	bpf_prog_select_runtime(fp);
+	err = bpf_prog_select_runtime(fp);
+	if (err)
+		goto out_err_free;
 
 	kfree(old_prog);
 	return fp;
--- a/net/core/sysctl_net_core.c
+++ b/net/core/sysctl_net_core.c
@@ -292,7 +292,13 @@ static struct ctl_table net_core_table[]
 		.data		= &bpf_jit_enable,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
+#ifndef CONFIG_BPF_JIT_ALWAYS_ON
 		.proc_handler	= proc_dointvec
+#else
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= &one,
+		.extra2		= &one,
+#endif
 	},
 #endif
 	{
--- a/net/socket.c
+++ b/net/socket.c
@@ -2534,6 +2534,15 @@ out_fs:
 
 core_initcall(sock_init);	/* early initcall */
 
+static int __init jit_init(void)
+{
+#ifdef CONFIG_BPF_JIT_ALWAYS_ON
+	bpf_jit_enable = 1;
+#endif
+	return 0;
+}
+pure_initcall(jit_init);
+
 #ifdef CONFIG_PROC_FS
 void socket_seq_show(struct seq_file *seq)
 {
