Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0142C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 19:25:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 996DD247CF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 19:25:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 996DD247CF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934373AbeFVTZC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 15:25:02 -0400
Received: from terminus.zytor.com ([198.137.202.136]:34917 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933382AbeFVTZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 15:25:01 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5MJOqSq184188
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 22 Jun 2018 12:24:52 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5MJOpEb184185;
        Fri, 22 Jun 2018 12:24:51 -0700
Date:   Fri, 22 Jun 2018 12:24:51 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Suravee Suthikulpanit <tipbot@zytor.com>
Message-ID: <tip-964d978433a4b9aa1368ff71227ca0027dd1e32f@git.kernel.org>
Cc:     suravee.suthikulpanit@amd.com, tglx@linutronix.de, bp@suse.de,
        mingo@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org
Reply-To: bp@suse.de, hpa@zytor.com, mingo@kernel.org,
          linux-kernel@vger.kernel.org, suravee.suthikulpanit@amd.com,
          tglx@linutronix.de
In-Reply-To: <1528915390-30533-1-git-send-email-suravee.suthikulpanit@amd.com>
References: <1528915390-30533-1-git-send-email-suravee.suthikulpanit@amd.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/CPU/AMD: Fix LLC ID bit-shift calculation
Git-Commit-ID: 964d978433a4b9aa1368ff71227ca0027dd1e32f
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  964d978433a4b9aa1368ff71227ca0027dd1e32f
Gitweb:     https://git.kernel.org/tip/964d978433a4b9aa1368ff71227ca0027dd1e32f
Author:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
AuthorDate: Wed, 13 Jun 2018 13:43:10 -0500
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 22 Jun 2018 21:21:49 +0200

x86/CPU/AMD: Fix LLC ID bit-shift calculation

The current logic incorrectly calculates the LLC ID from the APIC ID.

Unless specified otherwise, the LLC ID should be calculated by removing
the Core and Thread ID bits from the least significant end of the APIC
ID. For more info, see "ApicId Enumeration Requirements" in any Fam17h
PPR document.

[ bp: Improve commit message. ]

Fixes: 68091ee7ac3c ("Calculate last level cache ID from number of sharing threads")
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/1528915390-30533-1-git-send-email-suravee.suthikulpanit@amd.com
---
 arch/x86/kernel/cpu/cacheinfo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index 38354c66df81..0c5fcbd998cf 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -671,7 +671,7 @@ void cacheinfo_amd_init_llc_id(struct cpuinfo_x86 *c, int cpu, u8 node_id)
 			num_sharing_cache = ((eax >> 14) & 0xfff) + 1;
 
 		if (num_sharing_cache) {
-			int bits = get_count_order(num_sharing_cache) - 1;
+			int bits = get_count_order(num_sharing_cache);
 
 			per_cpu(cpu_llc_id, cpu) = c->apicid >> bits;
 		}
