Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1715849-1520641525-2-9032916060842120042
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520641524; b=DFGnvHuR5E5cknm7TqL5cybCZP554O84EaWQqfWTk1M3gUU
    6ozgHl39L7I4pAUH5erKxRrJC+M4WNXXrrAyfupP8ytdCZqJSs9wAWDc+jZqwHgV
    8jhSOq/oESlnt7t8LrXBgXxvXsi+REOGpKKiu+ABS0QNNsnzXrF6ZED6p0DOQNd2
    bxNX+SX25u4CsLcb1mu6VkdGcYtckx6cSo4CBX9VmPaYM2+NimtFlQ44Cxly2CH7
    qit5RSuhqpBKJ+oGogse6U7Ltubx7Z1nWMH4to6tB6SHMP31en3S7S2qxBtmryCi
    GF68IBW+JuymqSLagJ+tCb2B6DIIdqxdcxc8LLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1520641524; bh=mccJlMSIYqFNcJBRN6jIda7iBf
    XKZfWa49g5wlnIKfI=; b=lPC6t1gd+BygNH1+dA1vpm6d8QIgtyt9TnqZrxRpvn
    Ysk6cooxTlDIT1WjVFvEgb07pkKPM6tixUDT82lo0WPp0W96L/yu6p7/W1LamzKP
    a3u8I4L993oqner4klHwMhCITw3Y+Kdm0moFf05g/OJ+/DeRT3CRl08AkQMeddGn
    Yc9R+SkhZF90yL09Q2bxOkAyp/2GpHww6iM2PHqXp9w2bg7FutzB6Q148EgJisXK
    /gn6/8mTukFdM8cA6RNSHFG0GQYn7HQ8QjA4WqXVNoUDUTpmBdrZbaPWcvFuBNfT
    swuRYmWPa9S8F95eQDPW/tLvPo9JcWZkpVSRQi4qD1xg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934160AbeCJAXr (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Mar 2018 19:23:47 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:41164 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933088AbeCJAXq (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 9 Mar 2018 19:23:46 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH 4.15 04/11] bpf, x64: implement retpoline for tail call
Date: Fri,  9 Mar 2018 16:19:18 -0800
Message-Id: <20180310001834.776719451@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180310001834.560857664@linuxfoundation.org>
References: <20180310001834.560857664@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -13,6 +13,7 @@
 #include <linux/if_vlan.h>
 #include <asm/cacheflush.h>
 #include <asm/set_memory.h>
+#include <asm/nospec-branch.h>
 #include <linux/bpf.h>
 
 int bpf_jit_enable __read_mostly;
@@ -287,7 +288,7 @@ static void emit_bpf_tail_call(u8 **ppro
 	EMIT2(0x89, 0xD2);                        /* mov edx, edx */
 	EMIT3(0x39, 0x56,                         /* cmp dword ptr [rsi + 16], edx */
 	      offsetof(struct bpf_array, map.max_entries));
-#define OFFSET1 43 /* number of bytes to jump */
+#define OFFSET1 (41 + RETPOLINE_RAX_BPF_JIT_SIZE) /* number of bytes to jump */
 	EMIT2(X86_JBE, OFFSET1);                  /* jbe out */
 	label1 = cnt;
 
@@ -296,7 +297,7 @@ static void emit_bpf_tail_call(u8 **ppro
 	 */
 	EMIT2_off32(0x8B, 0x85, 36);              /* mov eax, dword ptr [rbp + 36] */
 	EMIT3(0x83, 0xF8, MAX_TAIL_CALL_CNT);     /* cmp eax, MAX_TAIL_CALL_CNT */
-#define OFFSET2 32
+#define OFFSET2 (30 + RETPOLINE_RAX_BPF_JIT_SIZE)
 	EMIT2(X86_JA, OFFSET2);                   /* ja out */
 	label2 = cnt;
 	EMIT3(0x83, 0xC0, 0x01);                  /* add eax, 1 */
@@ -310,7 +311,7 @@ static void emit_bpf_tail_call(u8 **ppro
 	 *   goto out;
 	 */
 	EMIT3(0x48, 0x85, 0xC0);		  /* test rax,rax */
-#define OFFSET3 10
+#define OFFSET3 (8 + RETPOLINE_RAX_BPF_JIT_SIZE)
 	EMIT2(X86_JE, OFFSET3);                   /* je out */
 	label3 = cnt;
 
@@ -323,7 +324,7 @@ static void emit_bpf_tail_call(u8 **ppro
 	 * rdi == ctx (1st arg)
 	 * rax == prog->bpf_func + prologue_size
 	 */
-	EMIT2(0xFF, 0xE0);                        /* jmp rax */
+	RETPOLINE_RAX_BPF_JIT();
 
 	/* out: */
 	BUILD_BUG_ON(cnt - label1 != OFFSET1);
