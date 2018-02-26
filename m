Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3776141-1519677581-2-15218963687103524016
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
    t=1519677581; b=sBuPxBsfrDn5ZYoP5dmJWCpM7/pYMSwt5k1Y5q/pEyVK2t4
    Zr8NAjdaxW5lp2Lfk+KKHwcyJ1J2iEgm7tDg34zBEMLjuQHes643/o5dH/t8aqHT
    577hJ4q4imv0YHMR8mWGgRAjpQ7TLmlyHW6Lz5bR97ZxyzF95YNTbkL5cimMjAeX
    kb4FMTAc6BVXv36QJfMCiPGpDQ7irvtektb060CWJFMGFm8agql71NNVOwonMZTK
    OQfUHJxwJBuT1SkQCscAZ6PqdhsW8EYNRymweHJ9+oI0N7bSQX5Qt5Nwhkl6jXlg
    NyX3ijR+mmu4ydMEsbIUxByXzO8eIzrR+5fwTZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519677581; bh=6lecGp8bsNrIDw8GqDrZWPrGaw
    C5gchv/rKakjQA8AA=; b=TK/gGWouvoQGJl/BjHL+k/DjU/L0EXONUf1qil0b3P
    qR6MKSuHA/lAp8g2Fjj1tReDnlg0qUyHdAAHXAPRf4KKflpbn0f8aNWDxqdzlW3t
    AdnNb5EzwgHX2cda53CAgZRkM1F0x50s4hfn58faUymwXoOOKjvyHIZ19zw2qLJF
    gZJqnYEjuoiPxOLdc7TntdfVmPx9MuhpL1xp0k7nP59XU4uaaQAXRf1F/XUkcelb
    hLe7klqdUpcjZt468cPMTy2XH0Au7IjlI3oits7pBMVM3xJhXhTiRCnsO1kBJ2T3
    cZUhIaStjBae1SeauvkDGSc3YUO2aHGa2/skib6ElXYg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753685AbeBZU1Z (ORCPT <rfc822;greg@kroah.com>);
        Mon, 26 Feb 2018 15:27:25 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:36438 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753656AbeBZU1T (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Feb 2018 15:27:19 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 4.15 05/64] xtensa: fix high memory/reserved memory collision
Date: Mon, 26 Feb 2018 21:21:42 +0100
Message-Id: <20180226202153.666660881@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180226202153.453363333@linuxfoundation.org>
References: <20180226202153.453363333@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Max Filippov <jcmvbkbc@gmail.com>

commit 6ac5a11dc674bc5016ea716e8082fff61f524dc1 upstream.

Xtensa memory initialization code frees high memory pages without
checking whether they are in the reserved memory regions or not. That
results in invalid value of totalram_pages and duplicate page usage by
CMA and highmem. It produces a bunch of BUGs at startup looking like
this:

BUG: Bad page state in process swapper  pfn:70800
page:be60c000 count:0 mapcount:-127 mapping:  (null) index:0x1
flags: 0x80000000()
raw: 80000000 00000000 00000001 ffffff80 00000000 be60c014 be60c014 0000000a
page dumped because: nonzero mapcount
Modules linked in:
CPU: 0 PID: 1 Comm: swapper Tainted: G    B            4.16.0-rc1-00015-g7928b2cbe55b-dirty #23
Stack:
 bd839d33 00000000 00000018 ba97b64c a106578c bd839d70 be60c000 00000000
 a1378054 bd86a000 00000003 ba97b64c a1066166 bd839da0 be60c000 ffe00000
 a1066b58 bd839dc0 be504000 00000000 000002f4 bd838000 00000000 0000001e
Call Trace:
 [<a1065734>] bad_page+0xac/0xd0
 [<a106578c>] free_pages_check_bad+0x34/0x4c
 [<a1066166>] __free_pages_ok+0xae/0x14c
 [<a1066b58>] __free_pages+0x30/0x64
 [<a1365de5>] init_cma_reserved_pageblock+0x35/0x44
 [<a13682dc>] cma_init_reserved_areas+0xf4/0x148
 [<a10034b8>] do_one_initcall+0x80/0xf8
 [<a1361c16>] kernel_init_freeable+0xda/0x13c
 [<a125b59d>] kernel_init+0x9/0xd0
 [<a1004304>] ret_from_kernel_thread+0xc/0x18

Only free high memory pages that are not reserved.

Cc: stable@vger.kernel.org
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/xtensa/mm/init.c |   70 +++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 63 insertions(+), 7 deletions(-)

--- a/arch/xtensa/mm/init.c
+++ b/arch/xtensa/mm/init.c
@@ -79,19 +79,75 @@ void __init zones_init(void)
 	free_area_init_node(0, zones_size, ARCH_PFN_OFFSET, NULL);
 }
 
+#ifdef CONFIG_HIGHMEM
+static void __init free_area_high(unsigned long pfn, unsigned long end)
+{
+	for (; pfn < end; pfn++)
+		free_highmem_page(pfn_to_page(pfn));
+}
+
+static void __init free_highpages(void)
+{
+	unsigned long max_low = max_low_pfn;
+	struct memblock_region *mem, *res;
+
+	reset_all_zones_managed_pages();
+	/* set highmem page free */
+	for_each_memblock(memory, mem) {
+		unsigned long start = memblock_region_memory_base_pfn(mem);
+		unsigned long end = memblock_region_memory_end_pfn(mem);
+
+		/* Ignore complete lowmem entries */
+		if (end <= max_low)
+			continue;
+
+		if (memblock_is_nomap(mem))
+			continue;
+
+		/* Truncate partial highmem entries */
+		if (start < max_low)
+			start = max_low;
+
+		/* Find and exclude any reserved regions */
+		for_each_memblock(reserved, res) {
+			unsigned long res_start, res_end;
+
+			res_start = memblock_region_reserved_base_pfn(res);
+			res_end = memblock_region_reserved_end_pfn(res);
+
+			if (res_end < start)
+				continue;
+			if (res_start < start)
+				res_start = start;
+			if (res_start > end)
+				res_start = end;
+			if (res_end > end)
+				res_end = end;
+			if (res_start != start)
+				free_area_high(start, res_start);
+			start = res_end;
+			if (start == end)
+				break;
+		}
+
+		/* And now free anything which remains */
+		if (start < end)
+			free_area_high(start, end);
+	}
+}
+#else
+static void __init free_highpages(void)
+{
+}
+#endif
+
 /*
  * Initialize memory pages.
  */
 
 void __init mem_init(void)
 {
-#ifdef CONFIG_HIGHMEM
-	unsigned long tmp;
-
-	reset_all_zones_managed_pages();
-	for (tmp = max_low_pfn; tmp < max_pfn; tmp++)
-		free_highmem_page(pfn_to_page(tmp));
-#endif
+	free_highpages();
 
 	max_mapnr = max_pfn - ARCH_PFN_OFFSET;
 	high_memory = (void *)__va(max_low_pfn << PAGE_SHIFT);
