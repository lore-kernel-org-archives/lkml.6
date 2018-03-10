Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsTfZnAueLtXXNc9SkmJkuA6vOKxf3UufXadRljsB96eFCCW6mAZuVi7jmSpv/ltKubWuAs
ARC-Seal: i=1; a=rsa-sha256; t=1520641384; cv=none;
        d=google.com; s=arc-20160816;
        b=XkL+xry/kBWG+sWpMBPJgtEcSV6LF6USpX3854e6cCG4ND0VK/66ephi3zZr2uuPjL
         fee2NZIYYZUyBMXXoI6jkEK5EOaENWpMzecT7l9lAnfRzmW665RoKltwhpEbooVgq8Sc
         mL0wegHfNk+Dg8vGuvXhnw7iTUupFivV8x/WjEJHeas1flQBf5ke1HXnDJdlohl+PFN9
         pBC3kif/AAxo8exR0iRsZoEd/h+JXJd0vLb3JhEnyKqRjtxULJ8C3LphpVB6/8hjqof8
         LQoi0MX8PQdIecK6xBRmptq6fsHjDvziu6ZAnGzve82h/ObSkSjG9pa54yEljxeFIMiC
         pwoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=6gi97wqf9jL0kzUZzFsDMgLRwV/sF0ABzgVWmSZ1LW8=;
        b=VFKesXz5DuJtO0BNoeYxTZgp//YeEVb5BMxXhe+Tt4n633A65bpXMamb8X3oVav6fQ
         5d22BsAs272DlwTPTW/gBdKtM2R4Zisjq3hTHXlCQMGgSvRsh8gFFsaToPPnyKipv+ve
         71UWLHbKIASbbEsHQZtc2Rv48yLVuap45Lgjt6iADN3Z8faAIC7iktxbR/leR8dAf/LY
         zV9I3E8woL58pz1vsYPQxDB11LNX8PcWNPraVgFEgGEloZbgBUZNTpLQ93CnKeL9u9aU
         NrEZeor13ChRx0bLEErtRm9TedKo5Pw1mKmLbNvYkc3vQRpc9i3xngJHOz3xB9LQcdR4
         RGeQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH 4.9 61/65] bpf, x64: implement retpoline for tail call
Date: Fri,  9 Mar 2018 16:19:01 -0800
Message-Id: <20180310001830.195082624@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180310001824.927996722@linuxfoundation.org>
References: <20180310001824.927996722@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594507903420975418?=
X-GMAIL-MSGID: =?utf-8?q?1594508060337234044?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniel Borkmann <daniel@iogearbox.net>

[ upstream commit a493a87f38cfa48caaa95c9347be2d914c6fdf29 ]

Implement a retpoline [0] for the BPF tail call JIT'ing that converts
the indirect jump via jmp %rax that is used to make the long jump into
another JITed BPF image. Since this is subject to speculative execution,
we need to control the transient instruction sequence here as well
when CONFIG_RETPOLINE is set, and direct it into a pause + lfence loop.
The latter aligns also with what gcc / clang emits (e.g. [1]).

JIT dump after patch:

  # bpftool p d x i 1
   0: (18) r2 = map[id:1]
   2: (b7) r3 = 0
   3: (85) call bpf_tail_call#12
   4: (b7) r0 = 2
   5: (95) exit

With CONFIG_RETPOLINE:

  # bpftool p d j i 1
  [...]
  33:	cmp    %edx,0x24(%rsi)
  36:	jbe    0x0000000000000072  |*
  38:	mov    0x24(%rbp),%eax
  3e:	cmp    $0x20,%eax
  41:	ja     0x0000000000000072  |
  43:	add    $0x1,%eax
  46:	mov    %eax,0x24(%rbp)
  4c:	mov    0x90(%rsi,%rdx,8),%rax
  54:	test   %rax,%rax
  57:	je     0x0000000000000072  |
  59:	mov    0x28(%rax),%rax
  5d:	add    $0x25,%rax
  61:	callq  0x000000000000006d  |+
  66:	pause                      |
  68:	lfence                     |
  6b:	jmp    0x0000000000000066  |
  6d:	mov    %rax,(%rsp)         |
  71:	retq                       |
  72:	mov    $0x2,%eax
  [...]

  * relative fall-through jumps in error case
  + retpoline for indirect jump

Without CONFIG_RETPOLINE:

  # bpftool p d j i 1
  [...]
  33:	cmp    %edx,0x24(%rsi)
  36:	jbe    0x0000000000000063  |*
  38:	mov    0x24(%rbp),%eax
  3e:	cmp    $0x20,%eax
  41:	ja     0x0000000000000063  |
  43:	add    $0x1,%eax
  46:	mov    %eax,0x24(%rbp)
  4c:	mov    0x90(%rsi,%rdx,8),%rax
  54:	test   %rax,%rax
  57:	je     0x0000000000000063  |
  59:	mov    0x28(%rax),%rax
  5d:	add    $0x25,%rax
  61:	jmpq   *%rax               |-
  63:	mov    $0x2,%eax
  [...]

  * relative fall-through jumps in error case
  - plain indirect jump as before

  [0] https://support.google.com/faqs/answer/7625886
  [1] https://github.com/gcc-mirror/gcc/commit/a31e654fa107be968b802786d747e962c2fcdb2b

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/nospec-branch.h |   37 +++++++++++++++++++++++++++++++++++
 arch/x86/net/bpf_jit_comp.c          |    9 ++++----
 2 files changed, 42 insertions(+), 4 deletions(-)

--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -177,4 +177,41 @@ static inline void indirect_branch_predi
 }
 
 #endif /* __ASSEMBLY__ */
+
+/*
+ * Below is used in the eBPF JIT compiler and emits the byte sequence
+ * for the following assembly:
+ *
+ * With retpolines configured:
+ *
+ *    callq do_rop
+ *  spec_trap:
+ *    pause
+ *    lfence
+ *    jmp spec_trap
+ *  do_rop:
+ *    mov %rax,(%rsp)
+ *    retq
+ *
+ * Without retpolines configured:
+ *
+ *    jmp *%rax
+ */
+#ifdef CONFIG_RETPOLINE
+# define RETPOLINE_RAX_BPF_JIT_SIZE	17
+# define RETPOLINE_RAX_BPF_JIT()				\
+	EMIT1_off32(0xE8, 7);	 /* callq do_rop */		\
+	/* spec_trap: */					\
+	EMIT2(0xF3, 0x90);       /* pause */			\
+	EMIT3(0x0F, 0xAE, 0xE8); /* lfence */			\
+	EMIT2(0xEB, 0xF9);       /* jmp spec_trap */		\
+	/* do_rop: */						\
+	EMIT4(0x48, 0x89, 0x04, 0x24); /* mov %rax,(%rsp) */	\
+	EMIT1(0xC3);             /* retq */
+#else
+# define RETPOLINE_RAX_BPF_JIT_SIZE	2
+# define RETPOLINE_RAX_BPF_JIT()				\
+	EMIT2(0xFF, 0xE0);	 /* jmp *%rax */
+#endif
+
 #endif /* _ASM_X86_NOSPEC_BRANCH_H_ */
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -12,6 +12,7 @@
 #include <linux/filter.h>
 #include <linux/if_vlan.h>
 #include <asm/cacheflush.h>
+#include <asm/nospec-branch.h>
 #include <linux/bpf.h>
 
 int bpf_jit_enable __read_mostly;
@@ -281,7 +282,7 @@ static void emit_bpf_tail_call(u8 **ppro
 	EMIT2(0x89, 0xD2);                        /* mov edx, edx */
 	EMIT3(0x39, 0x56,                         /* cmp dword ptr [rsi + 16], edx */
 	      offsetof(struct bpf_array, map.max_entries));
-#define OFFSET1 43 /* number of bytes to jump */
+#define OFFSET1 (41 + RETPOLINE_RAX_BPF_JIT_SIZE) /* number of bytes to jump */
 	EMIT2(X86_JBE, OFFSET1);                  /* jbe out */
 	label1 = cnt;
 
@@ -290,7 +291,7 @@ static void emit_bpf_tail_call(u8 **ppro
 	 */
 	EMIT2_off32(0x8B, 0x85, -STACKSIZE + 36); /* mov eax, dword ptr [rbp - 516] */
 	EMIT3(0x83, 0xF8, MAX_TAIL_CALL_CNT);     /* cmp eax, MAX_TAIL_CALL_CNT */
-#define OFFSET2 32
+#define OFFSET2 (30 + RETPOLINE_RAX_BPF_JIT_SIZE)
 	EMIT2(X86_JA, OFFSET2);                   /* ja out */
 	label2 = cnt;
 	EMIT3(0x83, 0xC0, 0x01);                  /* add eax, 1 */
@@ -304,7 +305,7 @@ static void emit_bpf_tail_call(u8 **ppro
 	 *   goto out;
 	 */
 	EMIT3(0x48, 0x85, 0xC0);		  /* test rax,rax */
-#define OFFSET3 10
+#define OFFSET3 (8 + RETPOLINE_RAX_BPF_JIT_SIZE)
 	EMIT2(X86_JE, OFFSET3);                   /* je out */
 	label3 = cnt;
 
@@ -317,7 +318,7 @@ static void emit_bpf_tail_call(u8 **ppro
 	 * rdi == ctx (1st arg)
 	 * rax == prog->bpf_func + prologue_size
 	 */
-	EMIT2(0xFF, 0xE0);                        /* jmp rax */
+	RETPOLINE_RAX_BPF_JIT();
 
 	/* out: */
 	BUILD_BUG_ON(cnt - label1 != OFFSET1);
