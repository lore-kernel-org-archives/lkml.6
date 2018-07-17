Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F038ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 20:16:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 041E320693
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 20:16:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 041E320693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730371AbeGQUud (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 16:50:33 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42076 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729760AbeGQUud (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 16:50:33 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6CF5B428053F;
        Tue, 17 Jul 2018 20:16:17 +0000 (UTC)
Received: from llong.com (dhcp-17-175.bos.redhat.com [10.18.17.175])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F23FB2156893;
        Tue, 17 Jul 2018 20:16:16 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Will Deacon <will.deacon@arm.com>,
        Joe Mario <jmario@redhat.com>, Waiman Long <longman@redhat.com>
Subject: [PATCH] x86/pvqspinlock: Use LOCK_PREFIX in __pv_queued_spin_unlock assembly code
Date:   Tue, 17 Jul 2018 16:16:00 -0400
Message-Id: <1531858560-21547-1-git-send-email-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Tue, 17 Jul 2018 20:16:17 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Tue, 17 Jul 2018 20:16:17 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'longman@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The LOCK_PREFIX macro should be used in the assembly
__raw_callee_save___pv_queued_spin_unlock code so that the lock prefix
can be patched out on UP systems.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 arch/x86/include/asm/qspinlock_paravirt.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/qspinlock_paravirt.h b/arch/x86/include/asm/qspinlock_paravirt.h
index 9ef5ee0..159622e 100644
--- a/arch/x86/include/asm/qspinlock_paravirt.h
+++ b/arch/x86/include/asm/qspinlock_paravirt.h
@@ -43,7 +43,7 @@
 	"push  %rdx;"
 	"mov   $0x1,%eax;"
 	"xor   %edx,%edx;"
-	"lock cmpxchg %dl,(%rdi);"
+	LOCK_PREFIX "cmpxchg %dl,(%rdi);"
 	"cmp   $0x1,%al;"
 	"jne   .slowpath;"
 	"pop   %rdx;"
-- 
1.8.3.1

