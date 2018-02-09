Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1465196-1518185824-2-10605214347172678848
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
    t=1518185823; b=cRincSqvoMHYqETbYoxJoV1RH3+jr0O6NU/En3hHT1vk6uM
    /b6PW7G1FTrKDvoEsRJEo6+j+mCemK5SLCu6IL6l4hxe2I1CQR1lMwFFG1kJ0B6u
    V2JJbrjMd+NHmoIdxTcha7iNoVO9NhzHpIAKHIadrLXGh+T9MwhARup7EGiOiDg/
    8QhDEfT5bc5aN7XPIyYQkPe8e2elpHtw3hZCRLyEA9yGUjsPF2+A5tlb6XStm7HQ
    W4S2AY4rax9neMuqfM8+nNlXPoJlYeOBCBsn+l2gdR1aXXzFj8VGM8FrBanrbfI2
    eTceVseMPMf3lqPNW4MVO5GPM/To4Ts6yQos/yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518185823; bh=dgOcxZ/xF0932qN/9a7bsIrZ0I
    uFwdZEO6jRpU3vxQg=; b=QqpHHknaxBWkJa5CdFPvpw2/ckpmqDweX7sE2+Okx4
    H3qrxYB0l1tssDEyZH++JJxl++ydnTH2vm1y934P5hSnolGxgEWcjO4AdN2lH96h
    FXQv2eOgGaEw5iTOEmrP0vCsO+EbdCTngTSKi1hgZaI52xpOXuAAaY7eHrgpUmrY
    Qz4bNGzs1tIyTCs9rvNHDqZukBXZiwn/87dcCwobiynsmYm7D0m+6noauVgSClug
    11MVY24kEjQlDr4T53kfyoNQFWMcZTFbKe5wFEBKQGoXQh/ITeTNYunn5e10KqNc
    tZe4bfzK5X/aky2qOyTLSr8g1uUUQMuXAeltpzJsGWcg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752633AbeBIOQ2 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Feb 2018 09:16:28 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:48298 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752275AbeBINkv (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 9 Feb 2018 08:40:51 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.9 07/92] powerpc/64s: Support disabling RFI flush with no_rfi_flush and nopti
Date: Fri,  9 Feb 2018 14:38:36 +0100
Message-Id: <20180209133931.821957082@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180209133931.211869118@linuxfoundation.org>
References: <20180209133931.211869118@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Ellerman <mpe@ellerman.id.au>

commit bc9c9304a45480797e13a8e1df96ffcf44fb62fe upstream.

Because there may be some performance overhead of the RFI flush, add
kernel command line options to disable it.

We add a sensibly named 'no_rfi_flush' option, but we also hijack the
x86 option 'nopti'. The RFI flush is not the same as KPTI, but if we
see 'nopti' we can guess that the user is trying to avoid any overhead
of Meltdown mitigations, and it means we don't have to educate every
one about a different command line option.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/kernel/setup_64.c |   24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -682,8 +682,29 @@ early_initcall(disable_hardlockup_detect
 #ifdef CONFIG_PPC_BOOK3S_64
 static enum l1d_flush_type enabled_flush_types;
 static void *l1d_flush_fallback_area;
+static bool no_rfi_flush;
 bool rfi_flush;
 
+static int __init handle_no_rfi_flush(char *p)
+{
+	pr_info("rfi-flush: disabled on command line.");
+	no_rfi_flush = true;
+	return 0;
+}
+early_param("no_rfi_flush", handle_no_rfi_flush);
+
+/*
+ * The RFI flush is not KPTI, but because users will see doco that says to use
+ * nopti we hijack that option here to also disable the RFI flush.
+ */
+static int __init handle_no_pti(char *p)
+{
+	pr_info("rfi-flush: disabling due to 'nopti' on command line.\n");
+	handle_no_rfi_flush(NULL);
+	return 0;
+}
+early_param("nopti", handle_no_pti);
+
 static void do_nothing(void *unused)
 {
 	/*
@@ -754,7 +775,8 @@ void __init setup_rfi_flush(enum l1d_flu
 
 	enabled_flush_types = types;
 
-	rfi_flush_enable(enable);
+	if (!no_rfi_flush)
+		rfi_flush_enable(enable);
 }
 #endif /* CONFIG_PPC_BOOK3S_64 */
 #endif
