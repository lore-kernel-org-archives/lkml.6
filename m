Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2241641-1518720498-2-11342175421168276214
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
    t=1518720498; b=WiqUBHVDeck1XZtIzhTE27Q9DrQcPrqh5fYw1jrAGyN6uAO
    7guXIDRHdNOgdGh+xRWJh70ywE9vR6KKnpdcd0QG1v3nQeAYktCaXubCByeCJR1C
    wU/cWom/I/+rflyurUm6O/BkcGausutN+kpNgYG7ATmBqYhJ9jBWLvKPrnNGBcbr
    QU9aRRnFtgk6YsRt+Jdkm24vClUui3Zw1a/0bKz/y6zMy/Ke+KuJOhZuFa1MOoLw
    9Zt7bHvZTnvV49oRF0XlQ45Cu6KGFDHvAnzJlPGyjjmpBuBGiW5X/8mdmkdvGnf3
    y5qmNX4IzyNsfF8Z9C7qWzAcxbuMseu36r/YpAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518720498; bh=CjAuNo8pHmUMa3buOnrD02IWtM
    qgzfC8PuGFF1Q2E/A=; b=Pe872zy25h5zvnaBlgt3xY6n/n977+Ml3J0JUyWvGR
    /E7sMJb/amYyNLGTCiLenjU5wSS3TJn4ywgQfXnjmZnN8HBEFZqcdKX5/uj1NiIn
    EZV+jtP/mNBKcojVR2pSrci2vcpk3mlqcnNpVmMzBz/sTByRz2aZKkj3J0vgUdFF
    gO7u+wQ5JZS25+1PF/21XjW/5tuRlmOOBIS54IQMQhFIfHx/kBV2tFsR83BwkuHP
    e/lhGNddj8xXm5uwGXfcE1PB5/Kl4hKbuxZFT1Vr2A8r2336Qbsqw4R5Cgo70vgF
    Uv5tH/r0JMZ2AUQqKBb6zcSILd+R9xR6jsg+bgbQhdDA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162307AbeBOPWL (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 10:22:11 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:49368 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162270AbeBOPWE (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:22:04 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rolf Neugebauer <rolf.neugebauer@docker.com>
Subject: [PATCH 4.4 037/108] x86/microcode/AMD: Do not load when running on a hypervisor
Date: Thu, 15 Feb 2018 16:16:34 +0100
Message-Id: <20180215151227.581698482@linuxfoundation.org>
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

From: Borislav Petkov <bp@suse.de>

commit a15a753539eca8ba243d576f02e7ca9c4b7d7042 upstream with minor
adjustments.

Doing so is completely void of sense for multiple reasons so prevent
it. Set dis_ucode_ldr to true and thus disable the microcode loader by
default to address xen pv guests which execute the AP path but not the
BSP path.

By having it turned off by default, the APs won't run into the loader
either.

Also, check CPUID(1).ECX[31] which hypervisors set. Well almost, not the
xen pv one. That one gets the aforementioned "fix".

Also, improve the detection method by caching the final decision whether
to continue loading in dis_ucode_ldr and do it once on the BSP. The APs
then simply test that value.

Signed-off-by: Borislav Petkov <bp@suse.de>
Tested-by: Juergen Gross <jgross@suse.com>
Tested-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Acked-by: Juergen Gross <jgross@suse.com>
Link: http://lkml.kernel.org/r/20161218164414.9649-4-bp@alien8.de
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Rolf Neugebauer <rolf.neugebauer@docker.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/cpu/microcode/core.c |   28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -44,7 +44,7 @@
 
 static struct microcode_ops	*microcode_ops;
 
-static bool dis_ucode_ldr;
+static bool dis_ucode_ldr = true;
 
 static int __init disable_loader(char *str)
 {
@@ -81,6 +81,7 @@ struct cpu_info_ctx {
 
 static bool __init check_loader_disabled_bsp(void)
 {
+	u32 a, b, c, d;
 #ifdef CONFIG_X86_32
 	const char *cmdline = (const char *)__pa_nodebug(boot_command_line);
 	const char *opt	    = "dis_ucode_ldr";
@@ -93,8 +94,23 @@ static bool __init check_loader_disabled
 	bool *res = &dis_ucode_ldr;
 #endif
 
-	if (cmdline_find_option_bool(cmdline, option))
-		*res = true;
+	if (!have_cpuid_p())
+		return *res;
+
+	a = 1;
+	c = 0;
+	native_cpuid(&a, &b, &c, &d);
+
+	/*
+	 * CPUID(1).ECX[31]: reserved for hypervisor use. This is still not
+	 * completely accurate as xen pv guests don't see that CPUID bit set but
+	 * that's good enough as they don't land on the BSP path anyway.
+	 */
+	if (c & BIT(31))
+		return *res;
+
+	if (cmdline_find_option_bool(cmdline, option) <= 0)
+		*res = false;
 
 	return *res;
 }
@@ -126,9 +142,6 @@ void __init load_ucode_bsp(void)
 	if (check_loader_disabled_bsp())
 		return;
 
-	if (!have_cpuid_p())
-		return;
-
 	vendor = x86_vendor();
 	family = x86_family();
 
@@ -162,9 +175,6 @@ void load_ucode_ap(void)
 	if (check_loader_disabled_ap())
 		return;
 
-	if (!have_cpuid_p())
-		return;
-
 	vendor = x86_vendor();
 	family = x86_family();
 
