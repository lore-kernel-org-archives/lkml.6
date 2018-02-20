Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3849073-1519160383-3-5694973106884052516
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519160382; b=Q+SaY3aiTc2Flg9qWy8ZsOfK4kjsNwX2kvykg6YsRmLJdZ6
    GEvv78UxtKXUAp1a/vUUgLz6oRMcLqyGfoeGBYGc+J9A6Ob8qcZzDg45/gLw8exh
    +/klPcPjPVKwa4RomSiwXpdlSZSyqIrtLud+Nq0SPmpNfNPHn+vK/gjydui7m91k
    Qy7q4qyq/+Nt9urYn1I84p7z9k9yvdespz6m8IrWcq8HZ9yNi2ufJi5NCbpafJx9
    ux78D3zMFto4VTWD1NxlIXkIn2owGmQAyGl42PMD3fpxnMh8zqlqe2w9rqWpSPXJ
    ZLEcguCxKVkNtR2zRuWIRhtt0rTIYML/fHM3qfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=arctest; t=1519160382; bh=I18Y2wIneEcAy0iIrEMeoqpevc
    bpjfAMxM0ryG25aw4=; b=INeMTMuDY0XGxkFn+kPuw4vG0cTzl7ZSlb2CIqgFCp
    ANcdGfKm5gOehT1nW0XTDjdulD7/HCY7fqGQm6b6po/NOIvSoXJZsljR6B3hXVzg
    Ap/vPlM/BmRpPyaehz2LgIzalPw0BiYqVn0+u/02tFBmwIs8LiXxs1BUls7iebxq
    gApn1FBsPbyd43+9gJRYNzDFq8P5izJQpg1hnK1uoLFYud7xJl+afHygWmZiDz/o
    LsTUKXWVAMcI5+04ToDJUhSxasj5XcU2igHiNMFk2n9rNE8NhXxSbwID5S1PvQE8
    bIMST8TAYtoabT2ec/JM1Gi1DqtC1IBu+ycg9uSHGEdw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750829AbeBTU7k (ORCPT <rfc822;greg@kroah.com>);
        Tue, 20 Feb 2018 15:59:40 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:37311 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750799AbeBTU7j (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 20 Feb 2018 15:59:39 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Robert Richter <rric@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Martin Sebor <msebor@gcc.gnu.org>,
        stable@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Kees Cook <keescook@chromium.org>,
        Jessica Yu <jeyu@kernel.org>, oprofile-list@lists.sf.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH] x86: oprofile: nmi_int: fix bogus gcc-8 warning
Date: Tue, 20 Feb 2018 21:58:21 +0100
Message-Id: <20180220205826.2008875-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K0:60/+K93AohkaXPCtCjzEuVmkDxlGn4HOWmVgcqrhY3Ue5rxR2wP
 a2VN8XpIPn9v1KBJmaWj+lmoICEBfrfDLsIsfHhR2IoEc86+lZBxcu8jVv7OQkFg4fkD2yh
 NyQV0PLK/E0tVMKzn9K3z4iI1Nu9skqqxT3VigZ8rIsliGm0Z4rB5AaqSwga4cfzZBoiebo
 j/SYmyEjkPsjZHsVqEpLQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:5DmU568mD+A=:6PMtccOFEhmLLRp07jCati
 HSler0LkTj5yGsommVlhtAZDqGtsDPSB+HLnPa5jDUQW/Vu29ewx3Lz6ehM8C84m2WHMjPAAX
 iBVL5tuEFGtxDKgXDeLfoLzNeOO/d0doaQCvUOHePles8zt45yYwZgeKU/ldH8pyfnaYwVP9k
 QbhL4TklZa1IjYGeiJp7BJWeyJB3RU8t+3xO35r+zhowiffLoMhNBLPYpaACNI91Q0o0YN2gK
 ovOPP0TM7IA0q2fAnNBvGm3xiEtHBNpr9TF++zCh6dNYg3fJflZMUVuMcIdcko8IliT0mnDnS
 kkvwbV6pLiWOwZ0Q+0cbzmLphybKSsmi6WY7mBy6Xu0znlYziMYuFhxiQtR5MEGunI64ccLyq
 0503t2Vsm75RHP+N8bKU+MaaVkrgqzUGJ2+9yIwK98GIKzfZxOyMbCoeDKWQxf+u3RS5gVZSl
 OYR8uxKU/1/1mdu2p/jpfZ0FfbRjzsEJJR7crE0C6Cet8HS55/lv8bRJs5FzSDhJcAMz2v47K
 PiS/EvT7MsI3Xz4pSnmM2toNWTwPpEfvCY5q5rkFTDHaSuaQ5FAMOpkjXsBaUCw81JA3rybiD
 EZU8pz4LTQl4jLnXWMXrodOVL81/g4ZPUL3cjlZNuyIBmiEo1a3iSiGak1tUfXlAJd8PH6xi+
 yFDInVk/6uRU56eVYcqlvn/x6w7pce6PVUf3ssU5WsFYI5WCUqk2zC0ZNH2kXudIDoQY+bFht
 bj3o9FmNhaTnlmRUXlPm60p/6gZu15iqRM2ohA==
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

gcc-8 shows a warning for the x86 oprofile code that copies per-cpu
data from CPU 0 to all other CPUs, which when building a non-SMP
kernel turns into a memcpy() with identical source and destination
pointers:

arch/x86/oprofile/nmi_int.c: In function 'mux_clone':
arch/x86/oprofile/nmi_int.c:285:2: error: 'memcpy' source argument is the same as destination [-Werror=restrict]
  memcpy(per_cpu(cpu_msrs, cpu).multiplex,
  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         per_cpu(cpu_msrs, 0).multiplex,
         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         sizeof(struct op_msr) * model->num_virt_counters);
         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
arch/x86/oprofile/nmi_int.c: In function 'nmi_setup':
arch/x86/oprofile/nmi_int.c:466:3: error: 'memcpy' source argument is the same as destination [-Werror=restrict]
arch/x86/oprofile/nmi_int.c:470:3: error: 'memcpy' source argument is the same as destination [-Werror=restrict]

I have analyzed a number of such warnings now: some are valid and the
gcc warning is welcome. Others turned out to be false-positives, and
gcc was changed to not warn about those any more. This is a corner case
that is a false-positive but the gcc developers feel it's better to keep
warning about it.

In this case, it seems best to work around it by telling gcc
a little more clearly that this code path is never hit with
an IS_ENABLED() configuration check. Cc:stable as we also want
old kernels to build cleanly with gcc-8.

Cc: Martin Sebor <msebor@gcc.gnu.org>
Cc: stable@vger.kernel.org
Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=84095
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/x86/oprofile/nmi_int.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/oprofile/nmi_int.c b/arch/x86/oprofile/nmi_int.c
index 174c59774cc9..1d6d14db96c0 100644
--- a/arch/x86/oprofile/nmi_int.c
+++ b/arch/x86/oprofile/nmi_int.c
@@ -460,7 +460,7 @@ static int nmi_setup(void)
 		goto fail;
 
 	for_each_possible_cpu(cpu) {
-		if (!cpu)
+		if (!IS_ENABLED(CONFIG_SMP) || !cpu)
 			continue;
 
 		memcpy(per_cpu(cpu_msrs, cpu).counters,
@@ -470,7 +470,6 @@ static int nmi_setup(void)
 		memcpy(per_cpu(cpu_msrs, cpu).controls,
 		       per_cpu(cpu_msrs, 0).controls,
 		       sizeof(struct op_msr) * model->num_controls);
-
 		mux_clone(cpu);
 	}
 
-- 
2.9.0
