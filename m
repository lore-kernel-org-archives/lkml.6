Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1841884-1518709278-2-5388651343862600014
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
    t=1518709277; b=dzRtE/VfWfwwNfvUpPPWphgWyBBXU3iVlaSg3cpPgkHiSDV
    2dLm8KZ9sifRgx/IMkGh58wxm4vZ6cKg8GuN4AIUPNs+BaZgOasizixQ+pRRcD7Q
    /7Dx6XF9Ro05aUCdULAk+XhO7A321lqLjG9QoeivruUEqWnE67kLmmCoAp/gJ7x4
    F/d9PmWJE/y6XmtCD1oLxjSqxi/WiJ94jg6bLhKfKXcDuof/wSjwj0Md0txtjRbQ
    66vDI48YZZ/dtv7gMM9UPYkKikqsSZuk549aA/iGCPAjG4u5ZVWG7IlLH3mWHNkT
    h83e2c/NW/aaKQlqrIqYS8XWPDW2TqxREEqTRWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518709277; bh=lvW4o0UOYDqD+vn616zwcR8QP1
    OyP3aQ5xfRsFuoAa4=; b=R9P3X8vNABG/IAu5Yie6M4QfRGHyArsoRzc7aER4r9
    3CeHc2IEmlrRYd0t7fu7/o9pVY9KeJQzb+6brzczbwGSA4NZfvIXxgOreJTHzPJx
    TaxpfVMHbdxrtLBecjhBJhxeDpRiR0sFvrpICJNVNwRWcpmDxrfiRSoQEmWKWWJ2
    yYT5g1mTKrhH3NIZnrPrSI1eg4M30RAXwvmPqS38JkuU7feRCgRoeTZBfG7YD7dP
    QZj5EjAHukcx9AhU2jvWdUeONSDj/69LCavsJjZFBUrZBMhwhNYMHojV/dD/NlCg
    BJPjgJAvuHsXByEZxuw5uQ0ccgA1pyZ7t5Yz3GXRhznQ==
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
        id S1423878AbeBOPlN (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 10:41:13 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:60332 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1423873AbeBOPlL (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:41:11 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Dave Martin <dave.martin@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 4.15 059/202] [Variant 2/Spectre-v2] arm64: Run enable method for errata work arounds on late CPUs
Date: Thu, 15 Feb 2018 16:15:59 +0100
Message-Id: <20180215151716.386570101@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151712.768794354@linuxfoundation.org>
References: <20180215151712.768794354@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Suzuki K Poulose <suzuki.poulose@arm.com>


Commit 55b35d070c25 upstream.

When a CPU is brought up after we have finalised the system
wide capabilities (i.e, features and errata), we make sure the
new CPU doesn't need a new errata work around which has not been
detected already. However we don't run enable() method on the new
CPU for the errata work arounds already detected. This could
cause the new CPU running without potential work arounds.
It is upto the "enable()" method to decide if this CPU should
do something about the errata.

Fixes: commit 6a6efbb45b7d95c84 ("arm64: Verify CPU errata work arounds on hotplugged CPU")
Cc: Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Andre Przywara <andre.przywara@arm.com>
Cc: Dave Martin <dave.martin@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/kernel/cpu_errata.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -221,15 +221,18 @@ void verify_local_cpu_errata_workarounds
 {
 	const struct arm64_cpu_capabilities *caps = arm64_errata;
 
-	for (; caps->matches; caps++)
-		if (!cpus_have_cap(caps->capability) &&
-			caps->matches(caps, SCOPE_LOCAL_CPU)) {
+	for (; caps->matches; caps++) {
+		if (cpus_have_cap(caps->capability)) {
+			if (caps->enable)
+				caps->enable((void *)caps);
+		} else if (caps->matches(caps, SCOPE_LOCAL_CPU)) {
 			pr_crit("CPU%d: Requires work around for %s, not detected"
 					" at boot time\n",
 				smp_processor_id(),
 				caps->desc ? : "an erratum");
 			cpu_die_early();
 		}
+	}
 }
 
 void update_cpu_errata_workarounds(void)
