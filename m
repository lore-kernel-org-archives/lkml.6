Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3946214-1519035423-2-15282329461644645026
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enroca,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519035422; b=YywY6EO9Pe3RYuc+wAXoYrdtj36/jC4v0vpbxjXPu5s40De
    mF6eR79hjiNTIwIkDse/Wriq/VVe8mCU8lx4Gf3TdellOzW4mBd929/N8+yJsWlj
    PZcN8D/QtTSboMdgO1jsF6SAUtx0G5daujgu2J3uF9KxcvYH+efrXGYewuqFhSjc
    qE3bfekWLfQhvyulyY9H94PK8XczcN7QBRLYgLHAXoog62zZl+zB8Naz5vyutj8b
    E2pJeV7IKf1TFbl/lm7Ou5rbP9bQ6aTUAEt6/xQ0FwcD+rny50hD7eJdmrPW9vHD
    LfJg6ZbT5gDlrIN2FV50ABYgL67KI6y2H4QIEtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1519035422;
    bh=LXbJQtFJLFIx81LzdjQcK/4AX+vmUwbGmOln7nj7uA0=; b=VPgaBCG7QJpM
    dsvoyJz/ALt+bMKDYRqk4GeCiZUMma47zxSM3ejhUGYak2g/fLvfFXC7IiknENxW
    5qNQMEL8geq7Kc0DM619d92jXJ3cPqVpvm+BKiyaT9Rx7smBUIzi8kTLmMmxAPeJ
    gvv45XSHGCO9fFmB48hO5l39LDpWtvAKqU3UxHWLeBxjbBXzDxReLhbiE/WJ0vnd
    3MrovD2YstafIXfWtgUjOufFx2MtAQONZN2aFFWTcTC3gqMJdb2ZmZN+svVDxSVS
    Cu8fe5ysZiafV0GdsgrfDX7DC1FXex6FWt1bMuvAItnCOF5QyE0lrwarYVeReIt2
    OYwxdOQy0w==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752492AbeBSKQi (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Feb 2018 05:16:38 -0500
Received: from mx2.suse.de ([195.135.220.15]:53123 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752372AbeBSKOj (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Feb 2018 05:14:39 -0500
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-acpi@vger.kernel.org, x86@kernel.org
Cc: rafael.j.wysocki@intel.com, lenb@kernel.org,
        boris.ostrovsky@oracle.com, hpa@zytor.com, tglx@linutronix.de,
        mingo@redhat.com, Juergen Gross <jgross@suse.com>,
        stable@vger.kernel.org
Subject: [PATCH v3 1/3] acpi: introduce acpi_arch_get_root_pointer() for getting rsdp address
Date: Mon, 19 Feb 2018 11:09:04 +0100
Message-Id: <20180219100906.14265-2-jgross@suse.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180219100906.14265-1-jgross@suse.com>
References: <20180219100906.14265-1-jgross@suse.com>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add an architecture specific function to get the address of the RSDP
table. Per default it will just return 0 indicating falling back to
the current mechanism.

Cc: <stable@vger.kernel.org> # 4.11
Signed-off-by: Juergen Gross <jgross@suse.com>
---
 drivers/acpi/osl.c   | 5 ++++-
 include/linux/acpi.h | 7 +++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 3bb46cb24a99..ff812243bac3 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -189,12 +189,15 @@ early_param("acpi_rsdp", setup_acpi_rsdp);
 
 acpi_physical_address __init acpi_os_get_root_pointer(void)
 {
-	acpi_physical_address pa = 0;
+	acpi_physical_address pa;
 
 #ifdef CONFIG_KEXEC
 	if (acpi_rsdp)
 		return acpi_rsdp;
 #endif
+	pa = acpi_arch_get_root_pointer();
+	if (pa)
+		return pa;
 
 	if (efi_enabled(EFI_CONFIG_TABLES)) {
 		if (efi.acpi20 != EFI_INVALID_TABLE_ADDR)
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 968173ec2726..15bfb15c2fa5 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -623,6 +623,13 @@ bool acpi_gtdt_c3stop(int type);
 int acpi_arch_timer_mem_init(struct arch_timer_mem *timer_mem, int *timer_count);
 #endif
 
+#ifndef ACPI_HAVE_ARCH_GET_ROOT_POINTER
+static inline u64 acpi_arch_get_root_pointer(void)
+{
+	return 0;
+}
+#endif
+
 #else	/* !CONFIG_ACPI */
 
 #define acpi_disabled 1
-- 
2.13.6
