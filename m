Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32510ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:44:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF1CD20685
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:44:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF1CD20685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388540AbeGWNpZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 09:45:25 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:48280 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388546AbeGWNob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 09:44:31 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C3E60C7D;
        Mon, 23 Jul 2018 12:43:27 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alexey Brodkin <abrodkin@synopsys.com>,
        Vineet Gupta <vgupta@synopsys.com>
Subject: [PATCH 4.4 005/107] ARC: Fix CONFIG_SWAP
Date:   Mon, 23 Jul 2018 14:40:59 +0200
Message-Id: <20180723122413.201588043@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180723122413.003644357@linuxfoundation.org>
References: <20180723122413.003644357@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexey Brodkin <abrodkin@synopsys.com>

commit 6e3761145a9ba3ce267c330b6bff51cf6a057b06 upstream.

swap was broken on ARC due to silly copy-paste issue.

We encode offset from swapcache page in __swp_entry() as (off << 13) but
were not decoding back in __swp_offset() as (off >> 13) - it was still
(off << 13).

This finally fixes swap usage on ARC.

| # mkswap /dev/sda2
|
| # swapon -a -e /dev/sda2
| Adding 500728k swap on /dev/sda2.  Priority:-2 extents:1 across:500728k
|
| # free
|              total       used       free     shared    buffers     cached
| Mem:        765104      13456     751648       4736          8       4736
| -/+ buffers/cache:       8712     756392
| Swap:       500728          0     500728

Cc: stable@vger.kernel.org
Signed-off-by: Alexey Brodkin <abrodkin@synopsys.com>
Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arc/include/asm/pgtable.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arc/include/asm/pgtable.h
+++ b/arch/arc/include/asm/pgtable.h
@@ -372,7 +372,7 @@ void update_mmu_cache(struct vm_area_str
 
 /* Decode a PTE containing swap "identifier "into constituents */
 #define __swp_type(pte_lookalike)	(((pte_lookalike).val) & 0x1f)
-#define __swp_offset(pte_lookalike)	((pte_lookalike).val << 13)
+#define __swp_offset(pte_lookalike)	((pte_lookalike).val >> 13)
 
 /* NOPs, to keep generic kernel happy */
 #define __pte_to_swp_entry(pte)	((swp_entry_t) { pte_val(pte) })


