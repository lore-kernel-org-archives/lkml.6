Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D8DBECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 13:52:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 235C82146F
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 13:52:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 235C82146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731813AbeGQOZO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 10:25:14 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:33873 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731429AbeGQOZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 10:25:12 -0400
Received: from wuerfel.lan ([46.223.138.35]) by mrelayeu.kundenserver.de
 (mreue103 [212.227.15.145]) with ESMTPA (Nemesis) id
 0MLRLO-1ffycT0ujy-000fPL; Tue, 17 Jul 2018 15:51:39 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     akpm@linux-foundation.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH]  psi-pressure-stall-information-for-cpu-memory-and-io-fix-fix-fix
Date:   Tue, 17 Jul 2018 15:51:24 +0200
Message-Id: <20180717135133.3627980-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:jj1uu/rTj+NwAbNdTvS4L+gxg869CVzAXc8wFPQYRW2UTmWxYbq
 UTGrPu0of13zLoTo9V8jLT0x0F8bh1Y5shasNd5RLRNT5BzELTDYaMU1Y0NNb1qZKrNWh9N
 IBvSOV7NAnWVsNJhCX9mFbjQi+DdEJCpDNMJcy/A46HhhECos6Dfmlpl8KdP57djPE1bBF/
 me1bI4bIwr9UTRm9NNHSw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:kKa+3XTbCyM=:ErTvi28O1uT3sv7yYU2uGT
 ZMtHcKVT0ULbr4upvczbTemltSY6Mi62j3w7U4x4YzGdQEpgHoLjzBcQvJbaCqOkZRuhTVZ3x
 rXD4XMVrh1fah2/I5moVVpHJEsVmgjm1cieunPTJFyaCvWNza7kYmFw5qzFu7UhrwDe3B9aRW
 1bh2GbbVZMrzndC9oH+9LyKmq0FaBi0gMV4L44O1Bd96eefJTwggGNWxXQPdzpHPSpK0eAFLe
 jT0zPD3SEHqIErzqTWIU5Yl65klf2ZeHdE/57bsENSVtNo32Gwv/S/YWl7a1r57rNVcWiAWbW
 WW3ZoOwN7TBGOSh79jqWKMIoVUWXNlqRGWSnZknq4Gjy4Jad2RI+kFsGGJjF84htEBNkPo0OU
 cARBkifb5IyEc5SDK8SaKg5QPAnSmGObn4/QmjJwmC91abGJlvfL5DVz/I809bknQvykat1cb
 r2kqGDwX/gDKckFM4JVMcRwLxlWj48dJ5CdxPP9Z6yErkfTv88rEqLaZQ4YDuRms8LvfLh6oN
 l2RQ98PozZodGOZ9SlaktXj893PYO4QAxgu7mLGsve9KAD4kbUftVj52EC1rGDXpJAjozgEKY
 EQOetpINZ6QII6tRyzY0ddL2FnFEJmeCBv35Rm6L/nDLAv5p4zRx6Xe8yDkFweIzF77ebQKcq
 txv0hovJJ9iII70nsnWY9P76GrwWSxok2A3H5oOVcDLYp/pw3NR4/C1NhH+2Q4hpUJ6U=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The addition of do_div() did not do the right thing, as it assigned the
result of the multiplication to an 'unsigned long', which truncates
it before the division. GCC warns in various ways about this depending
on the architecuture, e.g.

arch/arm/include/asm/div64.h:33:45: note: expected 'uint64_t *' {aka 'long long unsigned int *'} but argument is of type 'long unsigned int *'

This uses div_u64() instead. This is probably still a bad idea since
we should avoid 64-bit division altogether in the scheduler, but at
least it does the correct calculation.

Fixes: 13a67bcb35f5 ("psi-pressure-stall-information-for-cpu-memory-and-io-fix-fix")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
Please fold into the fix
---
 kernel/sched/psi.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index eefe988ea7ce..9c3255ff50df 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -173,11 +173,10 @@ void __init psi_init(void)
 
 static void calc_avgs(unsigned long avg[3], u64 time, int missed_periods)
 {
-	unsigned long pct;
+	u64 pct;
 
 	/* Sample the most recent active period */
-	pct = time * 100;
-	do_div(pct, psi_period);
+	pct = div_u64(time * 100, psi_period);
 	pct *= FIXED_1;
 	avg[0] = calc_load(avg[0], EXP_10s, pct);
 	avg[1] = calc_load(avg[1], EXP_60s, pct);
-- 
2.9.0

