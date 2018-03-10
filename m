Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvdoYHrWPgDxr5E4E19iXH17Kwej9kSgQvah5XiPfM9w0oSCIzPvDMgmAqadvPhfqQDkGNm
ARC-Seal: i=1; a=rsa-sha256; t=1520641386; cv=none;
        d=google.com; s=arc-20160816;
        b=VizziHmETEylibaVDC7nuVO6bYCy2fKp8k8TnF2rLj5MwAqMVUiKYa8AmkreaX4rVj
         hRS3WYN+dhz7OD776B37Gvl93zcIuOnYgndVrIFwmUbNb8JubtjI3ulgAY7Hi4yJKQ46
         2SNgK0e/jL7mK1or0iMAN4uEujrhEOaSpmaMdkUC1B7yLKfGJxLSmQQwucoX5QTydJjy
         fTYdoiQzbEWa04Me8G+W+pKYYwy2BZguOGvKMkMo/viuHgTKM+hoeXjvuaYDbrWrskZU
         rqS+GDIAaRT9kXvgjTY6ETMNeFGpuFiw39R7KzTb8j1VUCyjLxWMX8ExruFqWDldviwH
         nkaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=7V49E1U33Qxcl0LeHgsCGXDiW9P+0FQnPE78w4ni+OQ=;
        b=yxIwNd1nv59J4Ath+KgwDLyGkrDoVRfAorjAxRqVC87aB71fv1ecpmIdBjnV8O36iN
         kh3bm3kS2vaT3B8gOJwt/4ST9/XewG6CsA7dSBNR9cXdQeTlsaildIUUrlpXfeuSfuin
         r2/1LKvEKlN3pISfocSITpqh+QfXnZy5H3Dd+0y+8+OyQ49G+Nj+5hcqeA806o8lzZyc
         AWlfZOtmPxA3By4QI6jIzu+5QB0mTs2uh3ymjN3XOZ8z0Gc1ipPacBWokO+4Y5M/ihxu
         rbpB+MjcVaj6SdJxz0NrAWhETGiul5avV5Jr3PJ0D3O8+rHhOnOxaqnog5CqEVyqsl3u
         kaHA==
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
Subject: [PATCH 4.9 62/65] bpf, arm64: fix out of bounds access in tail call
Date: Fri,  9 Mar 2018 16:19:02 -0800
Message-Id: <20180310001830.271405889@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180310001824.927996722@linuxfoundation.org>
References: <20180310001824.927996722@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594508062378391968?=
X-GMAIL-MSGID: =?utf-8?q?1594508062378391968?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
 arch/arm64/net/bpf_jit_comp.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -234,8 +234,9 @@ static int emit_bpf_tail_call(struct jit
 	off = offsetof(struct bpf_array, map.max_entries);
 	emit_a64_mov_i64(tmp, off, ctx);
 	emit(A64_LDR32(tmp, r2, tmp), ctx);
+	emit(A64_MOV(0, r3, r3), ctx);
 	emit(A64_CMP(0, r3, tmp), ctx);
-	emit(A64_B_(A64_COND_GE, jmp_offset), ctx);
+	emit(A64_B_(A64_COND_CS, jmp_offset), ctx);
 
 	/* if (tail_call_cnt > MAX_TAIL_CALL_CNT)
 	 *     goto out;
@@ -243,7 +244,7 @@ static int emit_bpf_tail_call(struct jit
 	 */
 	emit_a64_mov_i64(tmp, MAX_TAIL_CALL_CNT, ctx);
 	emit(A64_CMP(1, tcc, tmp), ctx);
-	emit(A64_B_(A64_COND_GT, jmp_offset), ctx);
+	emit(A64_B_(A64_COND_HI, jmp_offset), ctx);
 	emit(A64_ADD_I(1, tcc, tcc, 1), ctx);
 
 	/* prog = array->ptrs[index];
