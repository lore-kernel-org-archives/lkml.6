Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18E03C070C3
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 19:23:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1F6220880
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 19:23:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1F6220880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728336AbeIMA3C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 20:29:02 -0400
Received: from terminus.zytor.com ([198.137.202.136]:51189 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728121AbeIMA3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 20:29:02 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w8CJMj2C2744437
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 12 Sep 2018 12:22:45 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w8CJMi8t2744434;
        Wed, 12 Sep 2018 12:22:44 -0700
Date:   Wed, 12 Sep 2018 12:22:44 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Juergen Gross <tipbot@zytor.com>
Message-ID: <tip-999696752db1099aba595aac4f8d881f8c7cf4e6@git.kernel.org>
Cc:     torvalds@linux-foundation.org, hpa@zytor.com, tglx@linutronix.de,
        jgross@suse.com, peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Reply-To: hpa@zytor.com, torvalds@linux-foundation.org, tglx@linutronix.de,
          jgross@suse.com, linux-kernel@vger.kernel.org, mingo@kernel.org,
          peterz@infradead.org
In-Reply-To: <20180912174122.24282-1-jgross@suse.com>
References: <20180912174122.24282-1-jgross@suse.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/xen: Disable CPU0 hotplug for Xen PV
Git-Commit-ID: 999696752db1099aba595aac4f8d881f8c7cf4e6
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

Commit-ID:  999696752db1099aba595aac4f8d881f8c7cf4e6
Gitweb:     https://git.kernel.org/tip/999696752db1099aba595aac4f8d881f8c7cf4e6
Author:     Juergen Gross <jgross@suse.com>
AuthorDate: Wed, 12 Sep 2018 19:41:22 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 12 Sep 2018 21:15:02 +0200

x86/xen: Disable CPU0 hotplug for Xen PV

Xen PV guests don't allow CPU0 hotplug, so disable it.

Signed-off-by: Juergen Gross <jgross@suse.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: boris.ostrovsky@oracle.com
Cc: xen-devel@lists.xenproject.org
Link: http://lkml.kernel.org/r/20180912174122.24282-1-jgross@suse.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/kernel/topology.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/topology.c b/arch/x86/kernel/topology.c
index 12cbe2b88c0f..738bf42b0218 100644
--- a/arch/x86/kernel/topology.c
+++ b/arch/x86/kernel/topology.c
@@ -111,8 +111,10 @@ int arch_register_cpu(int num)
 	/*
 	 * Currently CPU0 is only hotpluggable on Intel platforms. Other
 	 * vendors can add hotplug support later.
+	 * Xen PV guests don't support CPU0 hotplug at all.
 	 */
-	if (c->x86_vendor != X86_VENDOR_INTEL)
+	if (c->x86_vendor != X86_VENDOR_INTEL ||
+	    boot_cpu_has(X86_FEATURE_XENPV))
 		cpu0_hotpluggable = 0;
 
 	/*
