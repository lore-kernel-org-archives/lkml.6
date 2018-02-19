Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3989416-1519035351-2-1327908984866184752
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519035350; b=pUAtMU9xI8cXxQbSCsSY7pjJgikb9tO6uUv8CHZQYzf0Wiu
    1tcuX7M5h/npcphkucHfUmxkgvxZ36TsD/RLtmzMJUSBvLBchM6I5fnkJshZFsDP
    TKEZ2Ca6hoPF1U0Z60eqyw0fjDaSG1F/64H+1u7VvI6uYjoXvlABJ/t74GDr6tqP
    MnyJ4+8DpGRYpbC20Vhu/THhTGI967eYbhaGxlb9f3zrAqAkkAEQQ4cK3+t62Cg6
    EkeJWtbdtUtZTW3JbRORgmohwrT3lPny3v6zh3RScyej/tL2WvEC7Tfy8S5YLdgC
    Y4aC03ioM4NKqRcSdklNJBGnR4xZlDQUPuWJsRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1519035350;
    bh=P/UfdSvPZ03bihsTdWgl5txTAPLLqklPc+B5niuZn0A=; b=a7UTUYC+ZAXO
    N8Ejkpeo1X5sqLxmaYl5MDVydU2KRGHKRT/90fjWTxSngb9nhgEjDXLyGCraHtY2
    YRlSpiqFdpuprGraeI9hz0CXsfVgP8iCStJQgnNWL0glrOJ8v+IgP4j5JhfkrpKE
    pnQ47p2pTMCloj0Z4ZG2PXGgmJA7ZQLvwZ4MsyGOmpBw8RF3xw6wvUHo2d4J3WKH
    yeFWUvmo6D/pODq/vufwLaPtLiyUv8BDUV7p1pLOW3qz/Ah5EVDOv3hMYvc5b0IQ
    ksajUHL09l2+k5WV3VHWUcGqmPd2Y5JQGLo2LTVgVw7ummcTIDLXonnpzvMbhApl
    BY5uC43ClQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752454AbeBSKPd (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Feb 2018 05:15:33 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:57593 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752244AbeBSKPa (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Feb 2018 05:15:30 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: stable@vger.kernel.org
Cc: Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [4.9-stable 7/9] arm64: fix warning about swapper_pg_dir overflow
Date: Mon, 19 Feb 2018 11:13:26 +0100
Message-Id: <20180219101343.2922561-8-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180219101343.2922561-1-arnd@arndb.de>
References: <20180219101343.2922561-1-arnd@arndb.de>
X-Provags-ID: V03:K0:SAhe7T3IVieToXWBJGmlA4s3NSyYXUetj5yu1WjtIftver4eToN
 Gpk0Wl36N54ZJK797nhfl6b+k561922877V+bWEitopve3yGKBuJoc/M4vU/zKe0g4hn20I
 P8AGWyOYgKlOZa1eJeUsEMFrQJtLAMzR0p30f4nMxZTgp7d0PWqEEX8DwncqguNCJAHpy51
 GJGOMvysaYv93OAHlgPOg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:HtneMOQWNCg=:3SwsiIrMSosazfd1sRbn1x
 4+yqk6PI0GC0ueWnH1K0caqiukjBy5nk1ljaPYa9W2vPF8Wf3O95PGMOiHKOHnL5Bf2PmGUF2
 WoKjfPZ4G9U9JPUZT/V3a9HuWI/fgqsTe2feEAz+pLq0/dRxgWyWPdV3cdpXBJLMRziMDxpYm
 7luVv1KBfpHPU53R0LjOFHE7bw4e66KP5YcdXlNYm+QwHKOJ8aEodumtYLrIdY3tM1WuoktAm
 MLJG6UK5PtcwwgcfH0WT8zqZDwmKwChrjrxDG+YR2OW1r8w1vhEL10GKRszw1KOrbHqGMtK/S
 CzpGxPv/ZAh/7kYokaNzF/ej+g3nrNCSfZTGnmw4RTA51bOHY8PvPMzpyWd/LU+XqdH8CEsPf
 1Uvu78uNcWTeG42d1vqus7SrzK9+ZpE9wVcpq9/Ytel6HfaVXdT8wKt4+v3tmwtGRkbqEP/n3
 GLprks9WKqS5/4Ml11g7z1RcSfovW5ydrQi1uscIRi4PGOXZZU2gc6P+MBbfnc9N0+wxOKCyn
 /q3gKwwDC1M3O1X65P09zfyyEFzGcgeFpzKS+HsZG1FuYBhTdDXcDJH5LVo/IN/skBvQl55Cn
 MxU29RpJcMp5QOJQLatnIGrdDeGCjPluPqm9iZSHAM10tXCmj+NgiL+ckVr2aPyg3xES9dBUp
 gtDWwJvUjFK1p1I4XkjRutMbVxR7t4Te1CgtOQ1oozOOEyHHhBz7rceO6aY5lnSGdCXS/Y+e9
 ILX5myZpi8BVD3OoAxeP3SrlGwzH0pwN7BdrAQ==
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

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
---
 arch/arm64/mm/mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 05615a3fdc6f..d5cc6d73c2c4 100644
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
-- 
2.9.0
