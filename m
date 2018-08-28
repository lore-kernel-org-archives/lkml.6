Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFA57C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 07:41:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB412208E1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 07:41:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB412208E1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727360AbeH1LbB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 07:31:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:45324 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727203AbeH1LbA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 07:31:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2D3B0AF7A;
        Tue, 28 Aug 2018 07:40:38 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        x86@kernel.org, virtualization@lists.linux-foundation.org
Cc:     akataria@vmware.com, rusty@rustcorp.com.au,
        boris.ostrovsky@oracle.com, hpa@zytor.com, tglx@linutronix.de,
        mingo@redhat.com, Juergen Gross <jgross@suse.com>
Subject: [PATCH v3 05/15] x86/paravirt: make paravirt_patch_call() and paravirt_patch_jmp() static
Date:   Tue, 28 Aug 2018 09:40:16 +0200
Message-Id: <20180828074026.820-6-jgross@suse.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180828074026.820-1-jgross@suse.com>
References: <20180828074026.820-1-jgross@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

paravirt_patch_call() and paravirt_patch_jmp() are used in paravirt.c
only. Convert them to static.

Signed-off-by: Juergen Gross <jgross@suse.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/paravirt_types.h |  6 ------
 arch/x86/kernel/paravirt.c            | 12 ++++++------
 2 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index 4b75acc23b30..7d13197d760b 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -373,12 +373,6 @@ extern struct pv_lock_ops pv_lock_ops;
 
 unsigned paravirt_patch_ident_32(void *insnbuf, unsigned len);
 unsigned paravirt_patch_ident_64(void *insnbuf, unsigned len);
-unsigned paravirt_patch_call(void *insnbuf,
-			     const void *target, u16 tgt_clobbers,
-			     unsigned long addr, u16 site_clobbers,
-			     unsigned len);
-unsigned paravirt_patch_jmp(void *insnbuf, const void *target,
-			    unsigned long addr, unsigned len);
 unsigned paravirt_patch_default(u8 type, u16 clobbers, void *insnbuf,
 				unsigned long addr, unsigned len);
 
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index afdb303285f8..1abdbde35049 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -81,10 +81,10 @@ struct branch {
 	u32 delta;
 } __attribute__((packed));
 
-unsigned paravirt_patch_call(void *insnbuf,
-			     const void *target, u16 tgt_clobbers,
-			     unsigned long addr, u16 site_clobbers,
-			     unsigned len)
+static unsigned paravirt_patch_call(void *insnbuf,
+				    const void *target, u16 tgt_clobbers,
+				    unsigned long addr, u16 site_clobbers,
+				    unsigned len)
 {
 	struct branch *b = insnbuf;
 	unsigned long delta = (unsigned long)target - (addr+5);
@@ -103,8 +103,8 @@ unsigned paravirt_patch_call(void *insnbuf,
 	return 5;
 }
 
-unsigned paravirt_patch_jmp(void *insnbuf, const void *target,
-			    unsigned long addr, unsigned len)
+static unsigned paravirt_patch_jmp(void *insnbuf, const void *target,
+				   unsigned long addr, unsigned len)
 {
 	struct branch *b = insnbuf;
 	unsigned long delta = (unsigned long)target - (addr+5);
-- 
2.16.4

