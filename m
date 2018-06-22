Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 603C9C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 12:41:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2068B241EE
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 12:41:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2068B241EE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751444AbeFVMlC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 08:41:02 -0400
Received: from terminus.zytor.com ([198.137.202.136]:60187 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751284AbeFVMlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 08:41:01 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5MCeiuQ069348
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 22 Jun 2018 05:40:44 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5MCeiGt069345;
        Fri, 22 Jun 2018 05:40:44 -0700
Date:   Fri, 22 Jun 2018 05:40:44 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnd Bergmann <tipbot@zytor.com>
Message-ID: <tip-bc39f010200d09dc6d4d5e613e86dfd0b22c63b3@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        arnd@arndb.de, tony.luck@intel.com, bp@suse.de, mingo@kernel.org,
        hpa@zytor.com, tglx@linutronix.de
Reply-To: mingo@kernel.org, hpa@zytor.com, bp@suse.de, tglx@linutronix.de,
          linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
          tony.luck@intel.com, arnd@arndb.de
In-Reply-To: <20180618100759.1921750-1-arnd@arndb.de>
References: <20180618100759.1921750-1-arnd@arndb.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:ras/core] x86/mce: Always use 64-bit timestamps
Git-Commit-ID: bc39f010200d09dc6d4d5e613e86dfd0b22c63b3
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

Commit-ID:  bc39f010200d09dc6d4d5e613e86dfd0b22c63b3
Gitweb:     https://git.kernel.org/tip/bc39f010200d09dc6d4d5e613e86dfd0b22c63b3
Author:     Arnd Bergmann <arnd@arndb.de>
AuthorDate: Fri, 22 Jun 2018 11:54:22 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 22 Jun 2018 14:37:22 +0200

x86/mce: Always use 64-bit timestamps

The machine check timestamp uses get_seconds(), which returns an
'unsigned long' number that might overflow on 32-bit architectures (in
the distant future) and is therefore deprecated.

The normal replacement would be ktime_get_real_seconds(), but that needs
to use a sequence lock that might cause a deadlock if the MCE happens at
just the wrong moment. The __ktime_get_real_seconds() skips that lock
and is safer here, but has a miniscule risk of returning the wrong time
when we read it on a 32-bit architecture at the same time as updating
the epoch, i.e. from before y2106 overflow time to after, or vice versa.

This seems to be an acceptable risk in this particular case, and is the
same thing we do in kdb.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Tony Luck <tony.luck@intel.com>
Cc: linux-edac <linux-edac@vger.kernel.org>
Cc: y2038@lists.linaro.org
Link: http://lkml.kernel.org/r/20180618100759.1921750-1-arnd@arndb.de

---
 arch/x86/kernel/cpu/mcheck/mce.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/mcheck/mce.c b/arch/x86/kernel/cpu/mcheck/mce.c
index e93670d736a6..d62201e40027 100644
--- a/arch/x86/kernel/cpu/mcheck/mce.c
+++ b/arch/x86/kernel/cpu/mcheck/mce.c
@@ -123,8 +123,8 @@ void mce_setup(struct mce *m)
 {
 	memset(m, 0, sizeof(struct mce));
 	m->cpu = m->extcpu = smp_processor_id();
-	/* We hope get_seconds stays lockless */
-	m->time = get_seconds();
+	/* need the internal __ version to avoid deadlocks */
+	m->time = __ktime_get_real_seconds();
 	m->cpuvendor = boot_cpu_data.x86_vendor;
 	m->cpuid = cpuid_eax(1);
 	m->socketid = cpu_data(m->extcpu).phys_proc_id;
