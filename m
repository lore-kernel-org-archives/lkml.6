Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D3B6C65BAF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:09:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D2CC20661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:09:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D2CC20661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbeLIWJL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:09:11 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:37396 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726641AbeLIWJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 17:09:09 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW73C-0002if-9n; Sun, 09 Dec 2018 21:55:46 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72d-0003PD-SB; Sun, 09 Dec 2018 21:55:11 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Will Deacon" <will.deacon@arm.com>,
        "Greg Hackmann" <ghackmann@google.com>,
        "Greg Hackmann" <ghackmann@android.com>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.521891577@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 147/328] arm64: mm: check for upper PAGE_SHIFT bits
 in pfn_valid()
In-Reply-To: <lsq.1544392232.713909046@decadent.org.uk>
X-SA-Exim-Connect-IP: 81.174.156.145
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.62-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Greg Hackmann <ghackmann@android.com>

commit 5ad356eabc47d26a92140a0c4b20eba471c10de3 upstream.

ARM64's pfn_valid() shifts away the upper PAGE_SHIFT bits of the input
before seeing if the PFN is valid.  This leads to false positives when
some of the upper bits are set, but the lower bits match a valid PFN.

For example, the following userspace code looks up a bogus entry in
/proc/kpageflags:

    int pagemap = open("/proc/self/pagemap", O_RDONLY);
    int pageflags = open("/proc/kpageflags", O_RDONLY);
    uint64_t pfn, val;

    lseek64(pagemap, [...], SEEK_SET);
    read(pagemap, &pfn, sizeof(pfn));
    if (pfn & (1UL << 63)) {        /* valid PFN */
        pfn &= ((1UL << 55) - 1);   /* clear flag bits */
        pfn |= (1UL << 55);
        lseek64(pageflags, pfn * sizeof(uint64_t), SEEK_SET);
        read(pageflags, &val, sizeof(val));
    }

On ARM64 this causes the userspace process to crash with SIGSEGV rather
than reading (1 << KPF_NOPAGE).  kpageflags_read() treats the offset as
valid, and stable_page_flags() will try to access an address between the
user and kernel address ranges.

Fixes: c1cc1552616d ("arm64: MMU initialisation")
Signed-off-by: Greg Hackmann <ghackmann@google.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
[bwh: Backported to 3.16: Keep using memblock_is_memory()]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/arm64/mm/init.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -113,7 +113,11 @@ static void __init zone_sizes_init(unsig
 #ifdef CONFIG_HAVE_ARCH_PFN_VALID
 int pfn_valid(unsigned long pfn)
 {
-	return memblock_is_memory(pfn << PAGE_SHIFT);
+	phys_addr_t addr = pfn << PAGE_SHIFT;
+
+	if ((addr >> PAGE_SHIFT) != pfn)
+		return 0;
+	return memblock_is_memory(addr);
 }
 EXPORT_SYMBOL(pfn_valid);
 #endif

