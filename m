Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10A90C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 09:28:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B37C62077C
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 09:28:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B37C62077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbeIBNnx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 09:43:53 -0400
Received: from terminus.zytor.com ([198.137.202.136]:53219 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbeIBNnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 09:43:53 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w829Rxjt2869038
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 2 Sep 2018 02:27:59 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w829RudT2869030;
        Sun, 2 Sep 2018 02:27:56 -0700
Date:   Sun, 2 Sep 2018 02:27:56 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Randy Dunlap <tipbot@zytor.com>
Message-ID: <tip-ff924c5a1ec7548825cc2d07980b03be4224ffac@git.kernel.org>
Cc:     hpa@zytor.com, lkp@intel.com, rdunlap@infradead.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org, mingo@kernel.org,
        luto@kernel.org
Reply-To: luto@kernel.org, mingo@kernel.org, linux-kernel@vger.kernel.org,
          hpa@zytor.com, tglx@linutronix.de, rdunlap@infradead.org,
          lkp@intel.com
In-Reply-To: <43a6d6a3-d69d-5eda-da09-0b1c88215a2a@infradead.org>
References: <43a6d6a3-d69d-5eda-da09-0b1c88215a2a@infradead.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/pti: Fix section mismatch warning/error
Git-Commit-ID: ff924c5a1ec7548825cc2d07980b03be4224ffac
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

Commit-ID:  ff924c5a1ec7548825cc2d07980b03be4224ffac
Gitweb:     https://git.kernel.org/tip/ff924c5a1ec7548825cc2d07980b03be4224ffac
Author:     Randy Dunlap <rdunlap@infradead.org>
AuthorDate: Sat, 1 Sep 2018 21:01:28 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sun, 2 Sep 2018 11:24:41 +0200

x86/pti: Fix section mismatch warning/error

Fix the section mismatch warning in arch/x86/mm/pti.c:

WARNING: vmlinux.o(.text+0x6972a): Section mismatch in reference from the function pti_clone_pgtable() to the function .init.text:pti_user_pagetable_walk_pte()
The function pti_clone_pgtable() references
the function __init pti_user_pagetable_walk_pte().
This is often because pti_clone_pgtable lacks a __init
annotation or the annotation of pti_user_pagetable_walk_pte is wrong.
FATAL: modpost: Section mismatches detected.

Fixes: 85900ea51577 ("x86/pti: Map the vsyscall page if needed")
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>
Link: https://lkml.kernel.org/r/43a6d6a3-d69d-5eda-da09-0b1c88215a2a@infradead.org


---
 arch/x86/mm/pti.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/mm/pti.c b/arch/x86/mm/pti.c
index 31341ae7309f..c1fc1ae6b429 100644
--- a/arch/x86/mm/pti.c
+++ b/arch/x86/mm/pti.c
@@ -248,7 +248,7 @@ static pmd_t *pti_user_pagetable_walk_pmd(unsigned long address)
  *
  * Returns a pointer to a PTE on success, or NULL on failure.
  */
-static __init pte_t *pti_user_pagetable_walk_pte(unsigned long address)
+static pte_t *pti_user_pagetable_walk_pte(unsigned long address)
 {
 	gfp_t gfp = (GFP_KERNEL | __GFP_NOTRACK | __GFP_ZERO);
 	pmd_t *pmd;
