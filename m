Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1465196-1518185633-2-15709212496336895571
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
    t=1518185632; b=JStiQOvQeWBtumVwL2iGvX747zpQVVMdodTcBeJMOaNsL3Z
    HXj8OKzopWK2kdABbjGcFZxYb1n/XdgAodkkVbb7vB02Pvbbn8xzyTFUx+j5dPhp
    ciLbkv6cXANQRCPXJ9Xwuq9BrIfr7XmwefjFmrFjSuznHbWr3JNX1Dn5E0rzr+bb
    K5yZPO8Sw8yXa6jqT6Pd/tOQNWJMEXF8QkWk0qUwNEcrI0AO7NlgSUYshj9EfFmh
    jFTICdnJM45zj5ss4nMiprPIxJMvbiFG0SrzOxp+P5vsbtQW4pvxuwkLWLvktekh
    jgwO24UgzPnNHqDaYCnXnW3VUGrzJxlMlGKL6Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518185632; bh=CzTqvnA/JP8TFn819sXsxS4TVh
    apN240AbPzR2lS+O0=; b=Gpt9SLhgcc1e9KVC0/SvSZAhbyRuJMMmHoYLIcVZYs
    +4dMOPjEHrqwUVCAMwUYGjuvDlwL3Dp0lB4XjaP8/vYkCa+rZxBI27+n6GibOr9t
    LDSWMUbeRQvkuDMDbXNGuxlDTbC+vAjuEfpfRhEsU1eV9BKcQAs0s/fOVigmaNZF
    h6ZnPxe9/W+1is5z8wnYt7UhRuKCnzGye3Z8B/9zlccJdNtyFZQpUDYqS8EAhn9W
    EPTKdf3ZdM0/ibDz4EkcJCCpQd2uJ3Glrn1515UjEvCwRunAsZ1QKg2DM7AwXVv2
    RzHUlG6QG43AJK1Gyrh5BwTmL8QtQs/+36BMFoz+SbGg==
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
        id S1752651AbeBINlo (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Feb 2018 08:41:44 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:49202 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752647AbeBINlj (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 9 Feb 2018 08:41:39 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rolf Neugebauer <rolf.neugebauer@docker.com>
Subject: [PATCH 4.9 31/92] x86/microcode/AMD: Do not load when running on a hypervisor
Date: Fri,  9 Feb 2018 14:39:00 +0100
Message-Id: <20180209133933.427851594@linuxfoundation.org>
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

From: Borislav Petkov <bp@suse.de>

commit a15a753539eca8ba243d576f02e7ca9c4b7d7042 upstream.

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
Cc: Rolf Neugebauer <rolf.neugebauer@docker.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/cpu/microcode/core.c |   28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -43,7 +43,7 @@
 #define MICROCODE_VERSION	"2.01"
 
 static struct microcode_ops	*microcode_ops;
-static bool dis_ucode_ldr;
+static bool dis_ucode_ldr = true;
 
 /*
  * Synchronization.
@@ -73,6 +73,7 @@ struct cpu_info_ctx {
 static bool __init check_loader_disabled_bsp(void)
 {
 	static const char *__dis_opt_str = "dis_ucode_ldr";
+	u32 a, b, c, d;
 
 #ifdef CONFIG_X86_32
 	const char *cmdline = (const char *)__pa_nodebug(boot_command_line);
@@ -85,8 +86,23 @@ static bool __init check_loader_disabled
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
@@ -118,9 +134,6 @@ void __init load_ucode_bsp(void)
 	if (check_loader_disabled_bsp())
 		return;
 
-	if (!have_cpuid_p())
-		return;
-
 	vendor = x86_cpuid_vendor();
 	family = x86_cpuid_family();
 
@@ -154,9 +167,6 @@ void load_ucode_ap(void)
 	if (check_loader_disabled_ap())
 		return;
 
-	if (!have_cpuid_p())
-		return;
-
 	vendor = x86_cpuid_vendor();
 	family = x86_cpuid_family();
 
