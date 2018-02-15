Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2241641-1518720520-2-2425093939810400269
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
    t=1518720519; b=UBGLGF/W6zTZruDjN9VYWeMBwBMNISc4h+WjiWYzlqxOhqz
    I08McBmM8a4+7QVMQ7lujod7kFMoPNN7h8eICKmhNWRV4z8JMOhNPw4RHqSdhlaV
    AZxWktl76FkAYuv/zjCYJW8jvThBiyEWAm93TYKeZBVpNCItK89EA6AAick+/xyJ
    2uVvqyPAA3R1Scqrn0IV96YHUrKqUcz1OE6zK7252J+VaBTrTOtw22sqt+6IQIa2
    08elUEvf0ixHDhsND5oEmJzNgi+oSDe6UGc1eR0uBpz9tQ+OjIx/yrTtD0vN0OUi
    BCJu8tQ0Z1P2oWpU/9PDmxiHX4VGcTzkcePalBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518720519; bh=/yp2oFhd71JzvkIPU7m4KO0qnr
    9+zXOaryvggGRsKEo=; b=e6wUBjU6WyI0baYB17yJCNzb0vzrvGL0m8Zp5HUfRv
    AkGSdbcvXoBD4v7jLnnjt9zIxlwNtFSfmNvjBHGdWfhuSQKYy5fWoSTZEQ8Bgl5C
    VMsu0eH1E1NVZ9N5Tj5gif0aRBMOJb46IS9r30+bvi6rnGR1FOmvDNOlYF+lyU1Y
    kV3x2IKcx2CYnx74GBTrpOXSD5cgJAhUR2D0Vg6qOClZIj7G0wC15unhWcSIJcBW
    Ll+UXvhw1AmCu/TlcGiN2kVW8K28P95pp/SafZA7D24nlrjzO32Nlk8F1MCBbxbk
    gIPbIaoOkHDmzWpPJ26ZRab9+DZlGLC7HvGWzdwPq4jA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162505AbeBOSsX (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 13:48:23 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:49406 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162294AbeBOPWK (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:22:10 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.4 012/108] powerpc/64s: Support disabling RFI flush with no_rfi_flush and nopti
Date: Thu, 15 Feb 2018 16:16:09 +0100
Message-Id: <20180215151224.118610505@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151222.267507937@linuxfoundation.org>
References: <20180215151222.267507937@linuxfoundation.org>
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
@@ -838,8 +838,29 @@ early_initcall(disable_hardlockup_detect
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
@@ -910,7 +931,8 @@ void __init setup_rfi_flush(enum l1d_flu
 
 	enabled_flush_types = types;
 
-	rfi_flush_enable(enable);
+	if (!no_rfi_flush)
+		rfi_flush_enable(enable);
 }
 #endif /* CONFIG_PPC_BOOK3S_64 */
 #endif
