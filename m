Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A088BC7112A
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 16:01:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C32520645
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 16:01:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C32520645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbeJNXLr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:11:47 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35757 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727180AbeJNXLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:11:45 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLY-0004cY-QF; Sun, 14 Oct 2018 16:30:25 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLV-0000TB-QT; Sun, 14 Oct 2018 16:30:21 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Yazen Ghannam" <yazen.ghannam@amd.com>,
        "Yazen Ghannam" <Yazen.Ghannam@amd.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Borislav Petkov" <bp@suse.de>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.860345871@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 228/366] x86/smpboot: Don't use mwait_play_dead() on
 AMD systems
In-Reply-To: <lsq.1539530740.755408431@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.60-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Yazen Ghannam <yazen.ghannam@amd.com>

commit da6fa7ef67f07108a1b0cb9fd9e7fcaabd39c051 upstream.

Recent AMD systems support using MWAIT for C1 state. However, MWAIT will
not allow deeper cstates than C1 on current systems.

play_dead() expects to use the deepest state available.  The deepest state
available on AMD systems is reached through SystemIO or HALT. If MWAIT is
available, it is preferred over the other methods, so the CPU never reaches
the deepest possible state.

Don't try to use MWAIT to play_dead() on AMD systems. Instead, use CPUIDLE
to enter the deepest state advertised by firmware. If CPUIDLE is not
available then fallback to HALT.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
Cc: Yazen Ghannam <Yazen.Ghannam@amd.com>
Link: https://lkml.kernel.org/r/20180403140228.58540-1-Yazen.Ghannam@amd.com
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/kernel/smpboot.c | 2 ++
 1 file changed, 2 insertions(+)

--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1397,6 +1397,8 @@ static inline void mwait_play_dead(void)
 	void *mwait_ptr;
 	int i;
 
+	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
+		return;
 	if (!this_cpu_has(X86_FEATURE_MWAIT))
 		return;
 	if (!this_cpu_has(X86_FEATURE_CLFLUSH))

