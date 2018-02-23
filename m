Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3704313-1519414956-2-4918748730060083117
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519414955; b=Z+X4oBtlLMMMsZfr8XhFfQzuy1BdZCzpD7PM3I3gj4XgqEo
    Xh5KFXeomSxaqaPuNJjAiN/eFHSZ8X/o798R4qepqZJ5AimPt1mBFtYkkqlWJViw
    QAQMhHQkHwAgm9FxlXFzctvFcd8lT8k9C8ptQDCA2/pDcY1Zt8m4a5myE7wMCkFs
    ayGqHYwftooAmcRIHA1z1M910hUrG56ekXJ5mQq7rDzcgdbfWa7VI5rQq1GQiAch
    DJVHAij6iikzMGkDhcuWp4HZ05npCnBb7loP0pieD/YIVkA9moBXkIjqXxPB4oiE
    wGaS+t+BMMWvdl8MNY5R/I+JjBwyaggpFMeofmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519414955; bh=RCRA+djcp+TCUoTNte5suF2wPV
    hqaYKS6tvoSWgfV5M=; b=pgRD/Q4RUK7OXTYXFWRtHpuFURHW5lkniM0SSJCXLk
    PQuyrFYYtb2GYW0svd5Oj6Y3COXqSR1HEIpAEMqkTLCWmqsqmNVbYI9iabjeQl5q
    F6sfEjK2CmC8hQTKQ0OZxSMbL5txsP2C0uT+Y5eHPDBOacfYxft44z8QssL0/smJ
    uq3FHpImDxeR1fiF2VPX2gSfzc+VOG5WwOQhsYesSeCEFV6P8Ur2DRxTTKxg2lUi
    7pC/dT8AkAyy0RQ5yWoFd+NTZMBfc76tIxM9ddKosgsgWFCxsOWYOYv8FFXtzT7k
    ghRb0OhEkwTE9mOENalmdwiSjiwRuSZPIxAQLDAbKzsQ==
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
        id S932816AbeBWTmT (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 14:42:19 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:44960 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934411AbeBWSse (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:48:34 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Will Deacon <will.deacon@arm.com>
Subject: [PATCH 4.9 139/145] arm64: fix warning about swapper_pg_dir overflow
Date: Fri, 23 Feb 2018 19:27:25 +0100
Message-Id: <20180223170742.674594702@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170724.669759283@linuxfoundation.org>
References: <20180223170724.669759283@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit 12f043ff2b28fa64c9123b454cbe30a8a9e1967e upstream.

With 4 levels of 16KB pages, we get this warning about the fact that we are
copying a whole page into an array that is declared as having only two pointers
for the top level of the page table:

arch/arm64/mm/mmu.c: In function 'paging_init':
arch/arm64/mm/mmu.c:528:2: error: 'memcpy' writing 16384 bytes into a region of size 16 overflows the destination [-Werror=stringop-overflow=]

This is harmless since we actually reserve a whole page in the definition of the
array that comes from, and just the extern declaration is short. The pgdir
is initialized to zero either way, so copying the actual entries here seems
like the best solution.

Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Will Deacon <will.deacon@arm.com>
[slightly adapted to apply on 4.9]
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/mm/mmu.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -479,7 +479,7 @@ void __init paging_init(void)
 	 * To do this we need to go via a temporary pgd.
 	 */
 	cpu_replace_ttbr1(__va(pgd_phys));
-	memcpy(swapper_pg_dir, pgd, PAGE_SIZE);
+	memcpy(swapper_pg_dir, pgd, PGD_SIZE);
 	cpu_replace_ttbr1(swapper_pg_dir);
 
 	pgd_clear_fixmap();
