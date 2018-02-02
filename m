Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2879036-1517590825-2-18421289725314164450
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517590824; b=fWbGYw1O13cfLUZIwm41FLg8LbDeUpHoyN/3a0Tht9HF/rx
    Qc+g2zrRCBtTI3jSgMhNzqcmfD6dAq1nVGDXwjhnLAm/7osFkBkh9ylEbEK4104o
    9Gk2Z7LA5L9jlgeehN7h1yIbp6uZZk/fK0DSUbzU0fuoC0eFY2Wb4tLmGqAak6lS
    zHQm+XthcWl/AFBE2VuD5QF/HFr28xwI670Ev30kcqxD2Cz17O09gzuGE7SBZVzQ
    U17+VRk5AQ6RaGNimYpcf+pAuybKRRBTk1cQWTggf1iTR8ESxMzy3WrE1AxZgP5M
    zNw7+HQfjqHOWcOnFfjwWHUZjUCIFQmag8Ig5yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1517590824; bh=jaeK6BraVGvVaVzTOWLz0cQLn4
    WXcQ/PydAUZtj0NVg=; b=rO6p6n3XzJxpy6V6tmOWVbfMjgps7WKxmNuy9q2iNC
    8X1e8HpRzD4atDF/HHnSIXZ5Ij95wWE+b2XT/2zxcRsHX/oGTcUYhDlMpdtEyq09
    FIvFG9+/Vcm528Ey+TWE+k2lwkEKvdNCHYf4cKjxBIzmtbQ07P9WIdRUjDmaliML
    vjq9GLe8VMdDOO6X8G0+uTrkFtFTA6NQcKgj8PlBO3DbWt2LYTO7N534c0g3E5dl
    AyIsBU3zfMKkVFXMmloX0O6yhn2Gx2FfXdU09VNhLnE5thF2lNCcrD2/k719hXWO
    aV/LCESSZRtb+NUVpKRNYS2Oub8SLi+jh/cZbMFlshsQ==
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
        id S1752588AbeBBRAW (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Feb 2018 12:00:22 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:34722 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752578AbeBBRAU (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Feb 2018 12:00:20 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 03/67] x86: bpf_jit: small optimization in emit_bpf_tail_call()
Date: Fri,  2 Feb 2018 17:57:32 +0100
Message-Id: <20180202140815.552235573@linuxfoundation.org>
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

From: Eric Dumazet <edumazet@google.com>

[ upstream commit 84ccac6e7854ebbfb56d2fc6d5bef9be49bb304c ]

Saves 4 bytes replacing following instructions :

lea rax, [rsi + rdx * 8 + offsetof(...)]
mov rax, qword ptr [rax]
cmp rax, 0

by :

mov rax, [rsi + rdx * 8 + offsetof(...)]
test rax, rax

Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/net/bpf_jit_comp.c |    9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -269,7 +269,7 @@ static void emit_bpf_tail_call(u8 **ppro
 	EMIT4(0x48, 0x8B, 0x46,                   /* mov rax, qword ptr [rsi + 16] */
 	      offsetof(struct bpf_array, map.max_entries));
 	EMIT3(0x48, 0x39, 0xD0);                  /* cmp rax, rdx */
-#define OFFSET1 47 /* number of bytes to jump */
+#define OFFSET1 43 /* number of bytes to jump */
 	EMIT2(X86_JBE, OFFSET1);                  /* jbe out */
 	label1 = cnt;
 
@@ -278,21 +278,20 @@ static void emit_bpf_tail_call(u8 **ppro
 	 */
 	EMIT2_off32(0x8B, 0x85, -STACKSIZE + 36); /* mov eax, dword ptr [rbp - 516] */
 	EMIT3(0x83, 0xF8, MAX_TAIL_CALL_CNT);     /* cmp eax, MAX_TAIL_CALL_CNT */
-#define OFFSET2 36
+#define OFFSET2 32
 	EMIT2(X86_JA, OFFSET2);                   /* ja out */
 	label2 = cnt;
 	EMIT3(0x83, 0xC0, 0x01);                  /* add eax, 1 */
 	EMIT2_off32(0x89, 0x85, -STACKSIZE + 36); /* mov dword ptr [rbp - 516], eax */
 
 	/* prog = array->ptrs[index]; */
-	EMIT4_off32(0x48, 0x8D, 0x84, 0xD6,       /* lea rax, [rsi + rdx * 8 + offsetof(...)] */
+	EMIT4_off32(0x48, 0x8B, 0x84, 0xD6,       /* mov rax, [rsi + rdx * 8 + offsetof(...)] */
 		    offsetof(struct bpf_array, ptrs));
-	EMIT3(0x48, 0x8B, 0x00);                  /* mov rax, qword ptr [rax] */
 
 	/* if (prog == NULL)
 	 *   goto out;
 	 */
-	EMIT4(0x48, 0x83, 0xF8, 0x00);            /* cmp rax, 0 */
+	EMIT3(0x48, 0x85, 0xC0);		  /* test rax,rax */
 #define OFFSET3 10
 	EMIT2(X86_JE, OFFSET3);                   /* je out */
 	label3 = cnt;
