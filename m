Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3328118-1521214945-2-10714938986660791649
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521214943; b=aEfHYSP1KE/AsTUbJDiUYi7FzpxslGZZHUVKY1kF87EMKku
    qSxEGhuB2ZoRyvsCK8umOkIWOV8Ix8vBtoMKU20HodopfP2FDowOFKepx5RApmxg
    kJqCCqC/2/FTnuX5qiPO12pmSJh4kV1EdjtJ2t+GS1V2oEt1628gsslZsthPM9Wf
    f87YDQkJRaEfZDs2FYRNoU02Bzkgh4Jim2J/rxsrQ8IQnPep+m7GRazkLkhCjN9C
    BTt9kx0pDOe85cb96nTBYFPqOcH0bwHOUwCKsDj0Z+EVxAr3nK7oafxmhAObgFK0
    J5voo2XIqs8F3hyMiU23s02gxVVzB/kowdQGiHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521214943; bh=E4WtrVqh9br/TJ1Y/xoVKIuaOh
    b+6lQYpXWMlJG3Lz4=; b=HPDAaeb/czBuSvpLCVKmibnOdIa6xwzEIhvSLJL+CB
    7n8FxOOG2UIa7HbNmYyN5ZxzUjCglAPUmZm6ZbU6o12aUnQ4AI0dV3wSFde6O9hh
    SBLyghA956p2UJojo8mhTRxmjYa1p0KjqPalIiIUQgtolWO6uFl7J0itXJXpiGNm
    0Wf13M6srIbnk7TO/3y+SPLGlQQMKpaWjtXnJW1dY8jYFELPUnQtkSEgLPgQMYWk
    EdQqOhZZMbtuHrmL1WxeCOpELlCP1qGSzxigQ770v6hkeoB9B6/KUiVeJDJUooWU
    FmYlFpOIHdD5ugD7yqx66nXD5hFeVmt7kIKEOpKi8w5w==
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
        id S1754855AbeCPPmR (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Mar 2018 11:42:17 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:44380 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754849AbeCPPmM (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 16 Mar 2018 11:42:12 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 067/128] bpf: fix stack state printing in verifier log
Date: Fri, 16 Mar 2018 16:23:28 +0100
Message-Id: <20180316152340.081730873@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152336.199007505@linuxfoundation.org>
References: <20180316152336.199007505@linuxfoundation.org>
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

From: Alexei Starovoitov <ast@fb.com>


[ Upstream commit 12a3cc8424fe1237aaeb982dec4f0914ddd22f3e ]

fix incorrect stack state prints in print_verifier_state()

Fixes: 638f5b90d460 ("bpf: reduce verifier memory consumption")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Acked-by: John Fastabend <john.fastabend@gmail.com>
Acked-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/bpf/verifier.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -279,7 +279,7 @@ static void print_verifier_state(struct
 	for (i = 0; i < state->allocated_stack / BPF_REG_SIZE; i++) {
 		if (state->stack[i].slot_type[0] == STACK_SPILL)
 			verbose(env, " fp%d=%s",
-				-MAX_BPF_STACK + i * BPF_REG_SIZE,
+				(-i - 1) * BPF_REG_SIZE,
 				reg_type_str[state->stack[i].spilled_ptr.type]);
 	}
 	verbose(env, "\n");
