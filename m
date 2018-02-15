Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1825685-1518708751-5-1741898673270490228
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
    t=1518708751; b=wD5L4596yZEtuHnC8mmdUcjmoYsHdpa+BwD6I54nYnfBvyE
    lOK7xlw1XS1Xa5Sd3uJbj0+4Oum+uZS046BRfzWIFcRrj0Me8SY38sbzYEytdZUE
    JwrfoDx6JKiQANycsAgcPGOxAHQ6DI81nHVOQ1LcUd1XStD5IHa0JmNkAYXY950v
    joTXS0unwtd+Ec4JIKJ7209p6NhC/FjM+5s6MsTCAyraeeMp2e3c+OYlstYffErv
    iUdaeaSy75H992WRME9aj/wiyI1seiXjnUjLAaYQ4kV5HM+p4Dd61VcGrrWCAJ/L
    691EeDS1DZp7m3sGduT0YHuVGmtaGoybzkqn9sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518708751; bh=bpbWYwVbcKCpmRtvZmqT+5bpwA
    yzc97PMvRX1XPJ2zE=; b=uZ/dKZu7FQPTPlDhCYCj74xJI3KVfEBHzWnA7n4AQp
    meThupASyYBYsrWhjW0vy9QB1IGzRHggcVKG9azNYtoQIfiXUtiVa95ZXg3XYRWH
    gN2CsAQ5WqyZgFia5vGIMNiQCfzRj2wOu4JQfJQ4+2ePzSavkwqlZKBNAVbGg9IM
    0YFIc9M5EwQPitkssgNs2WQYzLu9uqN6eWe2L6ivmGiDy/60QHD3du94iRZljYqX
    hY0GM+7qG2Okbc+RReB52NUX01452iqPUCAj5NUe5thX/MnlKh14NQMywQRcx+OB
    mpMERUeUihhg6qJEc4609mg0D+5+huBHh74OJJkRcH8g==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1164614AbeBOPc2 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 10:32:28 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:56406 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1163857AbeBOPc0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:32:26 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Dave Martin <dave.martin@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH 4.14 066/195] [Variant 2/Spectre-v2] arm64: Run enable method for errata work arounds on late CPUs
Date: Thu, 15 Feb 2018 16:15:57 +0100
Message-Id: <20180215151709.006581977@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151705.738773577@linuxfoundation.org>
References: <20180215151705.738773577@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
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
