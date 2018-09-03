Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5875C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 16:51:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 874CB20779
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 16:51:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 874CB20779
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728315AbeICVMl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:12:41 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36380 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727740AbeICVMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:12:40 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D69A6CF3;
        Mon,  3 Sep 2018 16:51:43 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Greg Hackmann <ghackmann@google.com>,
        Will Deacon <will.deacon@arm.com>
Subject: [PATCH 3.18 39/56] arm64: mm: check for upper PAGE_SHIFT bits in pfn_valid()
Date:   Mon,  3 Sep 2018 18:49:29 +0200
Message-Id: <20180903164926.005307025@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180903164924.078355019@linuxfoundation.org>
References: <20180903164924.078355019@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

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
Cc: stable@vger.kernel.org
Signed-off-by: Greg Hackmann <ghackmann@google.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/mm/init.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -116,7 +116,11 @@ static void __init zone_sizes_init(unsig
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


