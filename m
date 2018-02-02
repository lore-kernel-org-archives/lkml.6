Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2848808-1517590830-2-1049108930972682560
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517590829; b=saDNXxPW+OoDlXVRwP17T5pdWXw9/zt1HNWBLWT5cBx2Wvo
    0tESLQfWrjAqp7f8SziX64k7Gj3u1EyhIM7Gx19O56hATLDzpiSUFiYiScaDWyph
    L/pR1C3mUEJuVB3W5phaAQSveamG11WFWQ+ifTM6GRembOr/A5j6kpxU93MBkjZy
    rMlAlFuo/CrrMlyF0xqibO1fY8Tdd3MhoSGmQ7R+jbY3eYaI6QJ1kaqCrNUkYzO1
    t2N4GStbLIR4bleRbLqBCCoKgo86BzTQnCIbbpqWpzM6PFERHUBldi6iAvxnzWTu
    KYXBlo/CTSO4JGO9ftLToeJINV7PlITjzdPKAvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1517590829; bh=2+UPYoNLVKkHHcKNrk6iyl6rKs
    P0JMGyRA/93ZGXFjE=; b=wKTKlMFbrNHrTd71MC/rr/T1guecSj8wEWqb8Zt+Ie
    1mD6hx7wo8pmZ4pfN/MmYbLrUseuWsegYeBbpq6upG8fS0k0PADOZNI11Wv9speK
    ohaL3hawIbYju4FXRT0uhLidhdPo0om8rZlfz0mCr6PICaHo58xeWGvjTHTA7vhZ
    JGdEz33AQVfLC/ze9Aj9K7olJ/hnWKhoL2r9LVX8cx0zmftTEKj756+Edj8Faq3X
    7bjR0UIKuadYOCoR8nPvQ3ycL7poYf57CBXPA+0S40f4YfwclOH7YU3j7GL/JlbX
    YJwFN1Y0n//cWfOp9AZvdy36B39QvI4gOxxiFu1EjihA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752359AbeBBRA1 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Feb 2018 12:00:27 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:34738 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752593AbeBBRAX (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Feb 2018 12:00:23 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 04/67] bpf: fix bpf_tail_call() x64 JIT
Date: Fri,  2 Feb 2018 17:57:33 +0100
Message-Id: <20180202140815.700661977@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140815.091718203@linuxfoundation.org>
References: <20180202140815.091718203@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexei Starovoitov <ast@fb.com>

[ upstream commit 90caccdd8cc0215705f18b92771b449b01e2474a ]

- bpf prog_array just like all other types of bpf array accepts 32-bit index.
  Clarify that in the comment.
- fix x64 JIT of bpf_tail_call which was incorrectly loading 8 instead of 4 bytes
- tighten corresponding check in the interpreter to stay consistent

The JIT bug can be triggered after introduction of BPF_F_NUMA_NODE flag
in commit 96eabe7a40aa in 4.14. Before that the map_flags would stay zero and
though JIT code is wrong it will check bounds correctly.
Hence two fixes tags. All other JITs don't have this problem.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Fixes: 96eabe7a40aa ("bpf: Allow selecting numa node during map creation")
Fixes: b52f00e6a715 ("x86: bpf_jit: implement bpf_tail_call() helper")
Acked-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Martin KaFai Lau <kafai@fb.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/net/bpf_jit_comp.c |    4 ++--
 kernel/bpf/core.c           |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -266,9 +266,9 @@ static void emit_bpf_tail_call(u8 **ppro
 	/* if (index >= array->map.max_entries)
 	 *   goto out;
 	 */
-	EMIT4(0x48, 0x8B, 0x46,                   /* mov rax, qword ptr [rsi + 16] */
+	EMIT2(0x89, 0xD2);                        /* mov edx, edx */
+	EMIT3(0x39, 0x56,                         /* cmp dword ptr [rsi + 16], edx */
 	      offsetof(struct bpf_array, map.max_entries));
-	EMIT3(0x48, 0x39, 0xD0);                  /* cmp rax, rdx */
 #define OFFSET1 43 /* number of bytes to jump */
 	EMIT2(X86_JBE, OFFSET1);                  /* jbe out */
 	label1 = cnt;
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -517,7 +517,7 @@ select_insn:
 		struct bpf_map *map = (struct bpf_map *) (unsigned long) BPF_R2;
 		struct bpf_array *array = container_of(map, struct bpf_array, map);
 		struct bpf_prog *prog;
-		u64 index = BPF_R3;
+		u32 index = BPF_R3;
 
 		if (unlikely(index >= array->map.max_entries))
 			goto out;
