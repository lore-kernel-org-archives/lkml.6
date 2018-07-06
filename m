Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E67AC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 16:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1642722549
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 16:55:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1642722549
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933616AbeGFQzo (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 12:55:44 -0400
Received: from terminus.zytor.com ([198.137.202.136]:38725 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933157AbeGFQzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 12:55:43 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w66GsuNa1575778
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 6 Jul 2018 09:54:56 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w66Gss9m1575765;
        Fri, 6 Jul 2018 09:54:54 -0700
Date:   Fri, 6 Jul 2018 09:54:54 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Dan Williams <tipbot@zytor.com>
Message-ID: <tip-3b6c62f363a19ce82bf378187ab97c9dc01e3927@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@kernel.org,
        dan.j.williams@intel.com, richard.weiyang@gmail.com,
        peterz@infradead.org, torvalds@linux-foundation.org,
        rientjes@google.com, hpa@zytor.com
Reply-To: dan.j.williams@intel.com, mingo@kernel.org, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
          hpa@zytor.com, rientjes@google.com, peterz@infradead.org,
          richard.weiyang@gmail.com
In-Reply-To: <153089328103.27680.14778434392225818887.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <153089328103.27680.14778434392225818887.stgit@dwillia2-desk3.amr.corp.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cpu] x86/numa_emulation: Fix emulated-to-physical node
 mapping
Git-Commit-ID: 3b6c62f363a19ce82bf378187ab97c9dc01e3927
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

Commit-ID:  3b6c62f363a19ce82bf378187ab97c9dc01e3927
Gitweb:     https://git.kernel.org/tip/3b6c62f363a19ce82bf378187ab97c9dc01e3927
Author:     Dan Williams <dan.j.williams@intel.com>
AuthorDate: Fri, 6 Jul 2018 09:08:01 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 6 Jul 2018 18:48:58 +0200

x86/numa_emulation: Fix emulated-to-physical node mapping

Without this change the distance table calculation for emulated nodes
may use the wrong numa node and report an incorrect distance.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Cc: David Rientjes <rientjes@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Wei Yang <richard.weiyang@gmail.com>
Cc: linux-mm@kvack.org
Link: http://lkml.kernel.org/r/153089328103.27680.14778434392225818887.stgit@dwillia2-desk3.amr.corp.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/mm/numa_emulation.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/mm/numa_emulation.c b/arch/x86/mm/numa_emulation.c
index 34a2a3bfde9c..22cbad56acab 100644
--- a/arch/x86/mm/numa_emulation.c
+++ b/arch/x86/mm/numa_emulation.c
@@ -61,7 +61,7 @@ static int __init emu_setup_memblk(struct numa_meminfo *ei,
 	eb->nid = nid;
 
 	if (emu_nid_to_phys[nid] == NUMA_NO_NODE)
-		emu_nid_to_phys[nid] = nid;
+		emu_nid_to_phys[nid] = pb->nid;
 
 	pb->start += size;
 	if (pb->start >= pb->end) {
