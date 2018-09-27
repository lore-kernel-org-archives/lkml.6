Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EE9AC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 18:49:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2064021710
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 18:49:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2064021710
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728619AbeI1BJ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 21:09:29 -0400
Received: from terminus.zytor.com ([198.137.202.136]:56797 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727995AbeI1BJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 21:09:28 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w8RIn7Hs129692
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 27 Sep 2018 11:49:07 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w8RIn7GS129689;
        Thu, 27 Sep 2018 11:49:07 -0700
Date:   Thu, 27 Sep 2018 11:49:07 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-69c31e69df3d2efc4ad7f53d500fdd920d3865a4@git.kernel.org>
Cc:     tglx@linutronix.de, hpa@zytor.com, linux-kernel@vger.kernel.org,
        dave.hansen@intel.com, mingo@kernel.org, bin.yang@intel.com,
        mark.gross@intel.com, peterz@infradead.org
Reply-To: dave.hansen@intel.com, hpa@zytor.com,
          linux-kernel@vger.kernel.org, mingo@kernel.org,
          tglx@linutronix.de, bin.yang@intel.com, mark.gross@intel.com,
          peterz@infradead.org
In-Reply-To: <20180917143546.245849757@linutronix.de>
References: <20180917143546.245849757@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] x86/mm/cpa: Avoid static protection checks on unmap
Git-Commit-ID: 69c31e69df3d2efc4ad7f53d500fdd920d3865a4
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

Commit-ID:  69c31e69df3d2efc4ad7f53d500fdd920d3865a4
Gitweb:     https://git.kernel.org/tip/69c31e69df3d2efc4ad7f53d500fdd920d3865a4
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Mon, 17 Sep 2018 16:29:13 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 27 Sep 2018 20:39:38 +0200

x86/mm/cpa: Avoid static protection checks on unmap

If the new pgprot has the PRESENT bit cleared, then conflicts vs. RW/NX are
completely irrelevant.

Before:

 1G pages checked:                    2
 1G pages sameprot:                   0
 1G pages preserved:                  0
 2M pages checked:                  540
 2M pages sameprot:                 466
 2M pages preserved:                 47
 4K pages checked:               800770
 4K pages set-checked:             7668

After:

 1G pages checked:                    2
 1G pages sameprot:                   0
 1G pages preserved:                  0
 2M pages checked:                  540
 2M pages sameprot:                 466
 2M pages preserved:                 47
 4K pages checked:               800709
 4K pages set-checked:             7668

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Dave Hansen <dave.hansen@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Bin Yang <bin.yang@intel.com>
Cc: Mark Gross <mark.gross@intel.com>
Link: https://lkml.kernel.org/r/20180917143546.245849757@linutronix.de

---
 arch/x86/mm/pageattr.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/mm/pageattr.c b/arch/x86/mm/pageattr.c
index cdf52eb86f3a..8f9083eb21ac 100644
--- a/arch/x86/mm/pageattr.c
+++ b/arch/x86/mm/pageattr.c
@@ -526,6 +526,13 @@ static inline pgprot_t static_protections(pgprot_t prot, unsigned long start,
 	pgprotval_t forbidden, res;
 	unsigned long end;
 
+	/*
+	 * There is no point in checking RW/NX conflicts when the requested
+	 * mapping is setting the page !PRESENT.
+	 */
+	if (!(pgprot_val(prot) & _PAGE_PRESENT))
+		return prot;
+
 	/* Operate on the virtual address */
 	end = start + npg * PAGE_SIZE - 1;
 
