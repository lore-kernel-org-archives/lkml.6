Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1715849-1520641633-2-7283355353811532842
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520641632; b=MeGvcQ8AL0WiFypNoq2zhTZcnsA3k6b2WbFb/bJhgFDBsLM
    uCBqLydb0viN6ow3pDSOnX8AA4rnmo505Pe8WPo1URhA7vHnay1Ujj+yLos1wSni
    gCl8KOmju7Mz/CkXb/tiJg0MFxBo1Enb0Y5c+UK2fZ1f/YTAfgwT+El+qTyq0NPq
    TutHhOvlwFJXfYq5wsvrHghUORTmh7tZrb1WimOKOtGAociUXu+V1qTQ0m13Rgvl
    AVegX/Py80rdIiEmFVAIt/PS8qRvVcTI5gsSU+PBIl5TXvPTQfQoSyvw54gfpIIw
    W3Z8B8nSbn2du1et5jaJGfHUNzV7ikUFE2JAdyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1520641632; bh=DOjDQYBo6dLIVFOXu8SkG9cCyy
    MHyIBjtTR1Hi+YEnY=; b=fCDeR+PDcwALoRIj08WfIpDZ5cdirS+SdVc3Rrt04B
    g//EHBix+cQuWWlWBA4UwnuxXo73ci+1Rgp0GuGVdaagG1K3QSYjOknuwWwH+lS0
    CFKgPHz6lzELN3x7wdUbJdXfvtloDdF3MLL/eg3sHgQbiVhVfR2jhzbZMo4P4P4T
    OzFwqutpgjRgIuTmUvch+GlLrNsoC3mIeGV5Z3/qBIKuuUQR2yV4TNZVf35kF9mK
    hQQYZHfgIsMu7I2KWx6GAF9h851egVlliB9UXqvjPY6l/pYyipqi1ht8e3egfOdu
    LWjZaU6pps0HfK/NrK6V6hwiEfenh+msHxK/75EpvPjA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
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
        id S1751822AbeCJA0z (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Mar 2018 19:26:55 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:40480 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934082AbeCJAXX (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 9 Mar 2018 19:23:23 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH 4.14 5/9] bpf, arm64: fix out of bounds access in tail call
Date: Fri,  9 Mar 2018 16:19:10 -0800
Message-Id: <20180310001828.895928557@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180310001828.476933393@linuxfoundation.org>
References: <20180310001828.476933393@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniel Borkmann <daniel@iogearbox.net>

[ upstream commit 16338a9b3ac30740d49f5dfed81bac0ffa53b9c7 ]

I recently noticed a crash on arm64 when feeding a bogus index
into BPF tail call helper. The crash would not occur when the
interpreter is used, but only in case of JIT. Output looks as
follows:

  [  347.007486] Unable to handle kernel paging request at virtual address fffb850e96492510
  [...]
  [  347.043065] [fffb850e96492510] address between user and kernel address ranges
  [  347.050205] Internal error: Oops: 96000004 [#1] SMP
  [...]
  [  347.190829] x13: 0000000000000000 x12: 0000000000000000
  [  347.196128] x11: fffc047ebe782800 x10: ffff808fd7d0fd10
  [  347.201427] x9 : 0000000000000000 x8 : 0000000000000000
  [  347.206726] x7 : 0000000000000000 x6 : 001c991738000000
  [  347.212025] x5 : 0000000000000018 x4 : 000000000000ba5a
  [  347.217325] x3 : 00000000000329c4 x2 : ffff808fd7cf0500
  [  347.222625] x1 : ffff808fd7d0fc00 x0 : ffff808fd7cf0500
  [  347.227926] Process test_verifier (pid: 4548, stack limit = 0x000000007467fa61)
  [  347.235221] Call trace:
  [  347.237656]  0xffff000002f3a4fc
  [  347.240784]  bpf_test_run+0x78/0xf8
  [  347.244260]  bpf_prog_test_run_skb+0x148/0x230
  [  347.248694]  SyS_bpf+0x77c/0x1110
  [  347.251999]  el0_svc_naked+0x30/0x34
  [  347.255564] Code: 9100075a d280220a 8b0a002a d37df04b (f86b694b)
  [...]

In this case the index used in BPF r3 is the same as in r1
at the time of the call, meaning we fed a pointer as index;
here, it had the value 0xffff808fd7cf0500 which sits in x2.

While I found tail calls to be working in general (also for
hitting the error cases), I noticed the following in the code
emission:

  # bpftool p d j i 988
  [...]
  38:   ldr     w10, [x1,x10]
  3c:   cmp     w2, w10
  40:   b.ge    0x000000000000007c              <-- signed cmp
  44:   mov     x10, #0x20                      // #32
  48:   cmp     x26, x10
  4c:   b.gt    0x000000000000007c
  50:   add     x26, x26, #0x1
  54:   mov     x10, #0x110                     // #272
  58:   add     x10, x1, x10
  5c:   lsl     x11, x2, #3
  60:   ldr     x11, [x10,x11]                  <-- faulting insn (f86b694b)
  64:   cbz     x11, 0x000000000000007c
  [...]

Meaning, the tests passed because commit ddb55992b04d ("arm64:
bpf: implement bpf_tail_call() helper") was using signed compares
instead of unsigned which as a result had the test wrongly passing.

Change this but also the tail call count test both into unsigned
and cap the index as u32. Latter we did as well in 90caccdd8cc0
("bpf: fix bpf_tail_call() x64 JIT") and is needed in addition here,
too. Tested on HiSilicon Hi1616.

Result after patch:

  # bpftool p d j i 268
  [...]
  38:	ldr	w10, [x1,x10]
  3c:	add	w2, w2, #0x0
  40:	cmp	w2, w10
  44:	b.cs	0x0000000000000080
  48:	mov	x10, #0x20                  	// #32
  4c:	cmp	x26, x10
  50:	b.hi	0x0000000000000080
  54:	add	x26, x26, #0x1
  58:	mov	x10, #0x110                 	// #272
  5c:	add	x10, x1, x10
  60:	lsl	x11, x2, #3
  64:	ldr	x11, [x10,x11]
  68:	cbz	x11, 0x0000000000000080
  [...]

Fixes: ddb55992b04d ("arm64: bpf: implement bpf_tail_call() helper")
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/net/bpf_jit_comp.c               |    5 +++--
 tools/testing/selftests/bpf/test_verifier.c |   26 ++++++++++++++++++++++++++
 2 files changed, 29 insertions(+), 2 deletions(-)

--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -238,8 +238,9 @@ static int emit_bpf_tail_call(struct jit
 	off = offsetof(struct bpf_array, map.max_entries);
 	emit_a64_mov_i64(tmp, off, ctx);
 	emit(A64_LDR32(tmp, r2, tmp), ctx);
+	emit(A64_MOV(0, r3, r3), ctx);
 	emit(A64_CMP(0, r3, tmp), ctx);
-	emit(A64_B_(A64_COND_GE, jmp_offset), ctx);
+	emit(A64_B_(A64_COND_CS, jmp_offset), ctx);
 
 	/* if (tail_call_cnt > MAX_TAIL_CALL_CNT)
 	 *     goto out;
@@ -247,7 +248,7 @@ static int emit_bpf_tail_call(struct jit
 	 */
 	emit_a64_mov_i64(tmp, MAX_TAIL_CALL_CNT, ctx);
 	emit(A64_CMP(1, tcc, tmp), ctx);
-	emit(A64_B_(A64_COND_GT, jmp_offset), ctx);
+	emit(A64_B_(A64_COND_HI, jmp_offset), ctx);
 	emit(A64_ADD_I(1, tcc, tcc, 1), ctx);
 
 	/* prog = array->ptrs[index];
--- a/tools/testing/selftests/bpf/test_verifier.c
+++ b/tools/testing/selftests/bpf/test_verifier.c
@@ -2258,6 +2258,32 @@ static struct bpf_test tests[] = {
 		.result = ACCEPT,
 	},
 	{
+		"runtime/jit: pass negative index to tail_call",
+		.insns = {
+			BPF_MOV64_IMM(BPF_REG_3, -1),
+			BPF_LD_MAP_FD(BPF_REG_2, 0),
+			BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
+				     BPF_FUNC_tail_call),
+			BPF_MOV64_IMM(BPF_REG_0, 0),
+			BPF_EXIT_INSN(),
+		},
+		.fixup_prog = { 1 },
+		.result = ACCEPT,
+	},
+	{
+		"runtime/jit: pass > 32bit index to tail_call",
+		.insns = {
+			BPF_LD_IMM64(BPF_REG_3, 0x100000000ULL),
+			BPF_LD_MAP_FD(BPF_REG_2, 0),
+			BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
+				     BPF_FUNC_tail_call),
+			BPF_MOV64_IMM(BPF_REG_0, 0),
+			BPF_EXIT_INSN(),
+		},
+		.fixup_prog = { 2 },
+		.result = ACCEPT,
+	},
+	{
 		"stack pointer arithmetic",
 		.insns = {
 			BPF_MOV64_IMM(BPF_REG_1, 4),
