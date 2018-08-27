Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8145FC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 08:34:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FC89208CA
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 08:34:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FC89208CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727130AbeH0MT6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 08:19:58 -0400
Received: from terminus.zytor.com ([198.137.202.136]:39459 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbeH0MT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 08:19:58 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w7R8YBbG510985
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 27 Aug 2018 01:34:11 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w7R8YBBB510982;
        Mon, 27 Aug 2018 01:34:11 -0700
Date:   Mon, 27 Aug 2018 01:34:11 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andi Kleen <tipbot@zytor.com>
Message-ID: <tip-1ab534e85c93945f7862378d8c8adcf408205b19@git.kernel.org>
Cc:     mingo@kernel.org, tglx@linutronix.de, hpa@zytor.com,
        linux-kernel@vger.kernel.org, ak@linux.intel.com
Reply-To: tglx@linutronix.de, mingo@kernel.org, hpa@zytor.com,
          linux-kernel@vger.kernel.org, ak@linux.intel.com
In-Reply-To: <20180824170351.34874-2-andi@firstfloor.org>
References: <20180824170351.34874-2-andi@firstfloor.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/spectre: Add missing family 6 check to
 microcode check
Git-Commit-ID: 1ab534e85c93945f7862378d8c8adcf408205b19
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

Commit-ID:  1ab534e85c93945f7862378d8c8adcf408205b19
Gitweb:     https://git.kernel.org/tip/1ab534e85c93945f7862378d8c8adcf408205b19
Author:     Andi Kleen <ak@linux.intel.com>
AuthorDate: Fri, 24 Aug 2018 10:03:51 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Mon, 27 Aug 2018 10:29:14 +0200

x86/spectre: Add missing family 6 check to microcode check

The check for Spectre microcodes does not check for family 6, only the
model numbers.

Add a family 6 check to avoid ambiguity with other families.

Fixes: a5b296636453 ("x86/cpufeature: Blacklist SPEC_CTRL/PRED_CMD on early Spectre v2 microcodes")
Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20180824170351.34874-2-andi@firstfloor.org

---
 arch/x86/kernel/cpu/intel.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 401e8c133108..fc3c07fe7df5 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -150,6 +150,9 @@ static bool bad_spectre_microcode(struct cpuinfo_x86 *c)
 	if (cpu_has(c, X86_FEATURE_HYPERVISOR))
 		return false;
 
+	if (c->x86 != 6)
+		return false;
+
 	for (i = 0; i < ARRAY_SIZE(spectre_bad_microcodes); i++) {
 		if (c->x86_model == spectre_bad_microcodes[i].model &&
 		    c->x86_stepping == spectre_bad_microcodes[i].stepping)
