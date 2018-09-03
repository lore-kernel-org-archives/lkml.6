Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48ADFC433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 15:02:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F060820843
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 15:02:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F060820843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727756AbeICTX3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 15:23:29 -0400
Received: from terminus.zytor.com ([198.137.202.136]:32997 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726108AbeICTX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 15:23:29 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w83F2nEC3340856
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 3 Sep 2018 08:02:49 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w83F2nmA3340853;
        Mon, 3 Sep 2018 08:02:49 -0700
Date:   Mon, 3 Sep 2018 08:02:49 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Juergen Gross <tipbot@zytor.com>
Message-ID: <tip-495310e4f2dd857c4d5a62806a04cb8ba53855c1@git.kernel.org>
Cc:     jgross@suse.com, tglx@linutronix.de, hpa@zytor.com,
        mingo@kernel.org, linux-kernel@vger.kernel.org
Reply-To: tglx@linutronix.de, jgross@suse.com,
          linux-kernel@vger.kernel.org, mingo@kernel.org, hpa@zytor.com
In-Reply-To: <20180828074026.820-16-jgross@suse.com>
References: <20180828074026.820-16-jgross@suse.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/paravirt] x86/paravirt: Remove unneeded mmu related
 paravirt ops bits
Git-Commit-ID: 495310e4f2dd857c4d5a62806a04cb8ba53855c1
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

Commit-ID:  495310e4f2dd857c4d5a62806a04cb8ba53855c1
Gitweb:     https://git.kernel.org/tip/495310e4f2dd857c4d5a62806a04cb8ba53855c1
Author:     Juergen Gross <jgross@suse.com>
AuthorDate: Tue, 28 Aug 2018 09:40:26 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Mon, 3 Sep 2018 16:50:37 +0200

x86/paravirt: Remove unneeded mmu related paravirt ops bits

There is no need to have 32-bit code for CONFIG_PGTABLE_LEVELS >= 4.
Remove it.

Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: xen-devel@lists.xenproject.org
Cc: virtualization@lists.linux-foundation.org
Cc: akataria@vmware.com
Cc: rusty@rustcorp.com.au
Cc: boris.ostrovsky@oracle.com
Cc: hpa@zytor.com
Link: https://lkml.kernel.org/r/20180828074026.820-16-jgross@suse.com

---
 arch/x86/include/asm/paravirt.h | 20 +++-----------------
 1 file changed, 3 insertions(+), 17 deletions(-)

diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index 63ab58dc5b73..969343c72a9b 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -506,25 +506,14 @@ static inline pud_t __pud(pudval_t val)
 {
 	pudval_t ret;
 
-	if (sizeof(pudval_t) > sizeof(long))
-		ret = PVOP_CALLEE2(pudval_t, mmu.make_pud, val, (u64)val >> 32);
-	else
-		ret = PVOP_CALLEE1(pudval_t, mmu.make_pud, val);
+	ret = PVOP_CALLEE1(pudval_t, mmu.make_pud, val);
 
 	return (pud_t) { ret };
 }
 
 static inline pudval_t pud_val(pud_t pud)
 {
-	pudval_t ret;
-
-	if (sizeof(pudval_t) > sizeof(long))
-		ret =  PVOP_CALLEE2(pudval_t, mmu.pud_val,
-				    pud.pud, (u64)pud.pud >> 32);
-	else
-		ret =  PVOP_CALLEE1(pudval_t, mmu.pud_val, pud.pud);
-
-	return ret;
+	return PVOP_CALLEE1(pudval_t, mmu.pud_val, pud.pud);
 }
 
 static inline void pud_clear(pud_t *pudp)
@@ -536,10 +525,7 @@ static inline void set_p4d(p4d_t *p4dp, p4d_t p4d)
 {
 	p4dval_t val = native_p4d_val(p4d);
 
-	if (sizeof(p4dval_t) > sizeof(long))
-		PVOP_VCALL3(mmu.set_p4d, p4dp, val, (u64)val >> 32);
-	else
-		PVOP_VCALL2(mmu.set_p4d, p4dp, val);
+	PVOP_VCALL2(mmu.set_p4d, p4dp, val);
 }
 
 #if CONFIG_PGTABLE_LEVELS >= 5
