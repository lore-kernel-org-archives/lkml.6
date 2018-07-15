Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69AACECDFB0
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 09:43:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4550B208DB
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 09:43:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4550B208DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726198AbeGOKFx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 06:05:53 -0400
Received: from terminus.zytor.com ([198.137.202.136]:51067 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbeGOKFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 06:05:53 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6F9h2AU729841
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 15 Jul 2018 02:43:02 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6F9gxM6729838;
        Sun, 15 Jul 2018 02:42:59 -0700
Date:   Sun, 15 Jul 2018 02:42:59 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Hugh Dickins <tipbot@zytor.com>
Message-ID: <tip-2c991e408df6a407476dbc453d725e1e975479e7@git.kernel.org>
Cc:     mingo@kernel.org, hpa@zytor.com, markus.t.metzger@intel.com,
        dave.hansen@intel.com, linux-kernel@vger.kernel.org,
        acme@kernel.org, eranian@google.com, alexander.shishkin@intel.com,
        andi.kleen@intel.com, hughd@google.com, tglx@linutronix.de,
        peterz@infradead.org
Reply-To: tglx@linutronix.de, andi.kleen@intel.com, hughd@google.com,
          peterz@infradead.org, eranian@google.com,
          alexander.shishkin@intel.com, markus.t.metzger@intel.com,
          acme@kernel.org, linux-kernel@vger.kernel.org,
          dave.hansen@intel.com, hpa@zytor.com, mingo@kernel.org
In-Reply-To: <alpine.LSU.2.11.1807141248290.1614@eggly.anvils>
References: <alpine.LSU.2.11.1807141248290.1614@eggly.anvils>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/events/intel/ds: Fix bts_interrupt_threshold
 alignment
Git-Commit-ID: 2c991e408df6a407476dbc453d725e1e975479e7
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

Commit-ID:  2c991e408df6a407476dbc453d725e1e975479e7
Gitweb:     https://git.kernel.org/tip/2c991e408df6a407476dbc453d725e1e975479e7
Author:     Hugh Dickins <hughd@google.com>
AuthorDate: Sat, 14 Jul 2018 12:58:07 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sun, 15 Jul 2018 11:38:44 +0200

x86/events/intel/ds: Fix bts_interrupt_threshold alignment

Markus reported that BTS is sporadically missing the tail of the trace
in the perf_event data buffer: [decode error (1): instruction overflow]
shown in GDB; and bisected it to the conversion of debug_store to PTI.

A little "optimization" crept into alloc_bts_buffer(), which mistakenly
placed bts_interrupt_threshold away from the 24-byte record boundary.
Intel SDM Vol 3B 17.4.9 says "This address must point to an offset from
the BTS buffer base that is a multiple of the BTS record size."

Revert "max" from a byte count to a record count, to calculate the
bts_interrupt_threshold correctly: which turns out to fix problem seen.

Fixes: c1961a4631da ("x86/events/intel/ds: Map debug buffers in cpu_entry_area")
Reported-and-tested-by: Markus T Metzger <markus.t.metzger@intel.com>
Signed-off-by: Hugh Dickins <hughd@google.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@intel.com>
Cc: Andi Kleen <andi.kleen@intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: stable@vger.kernel.org # v4.14+
Link: https://lkml.kernel.org/r/alpine.LSU.2.11.1807141248290.1614@eggly.anvils

---
 arch/x86/events/intel/ds.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 8a10a045b57b..8cf03f101938 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -408,9 +408,11 @@ static int alloc_bts_buffer(int cpu)
 	ds->bts_buffer_base = (unsigned long) cea;
 	ds_update_cea(cea, buffer, BTS_BUFFER_SIZE, PAGE_KERNEL);
 	ds->bts_index = ds->bts_buffer_base;
-	max = BTS_RECORD_SIZE * (BTS_BUFFER_SIZE / BTS_RECORD_SIZE);
-	ds->bts_absolute_maximum = ds->bts_buffer_base + max;
-	ds->bts_interrupt_threshold = ds->bts_absolute_maximum - (max / 16);
+	max = BTS_BUFFER_SIZE / BTS_RECORD_SIZE;
+	ds->bts_absolute_maximum = ds->bts_buffer_base +
+					max * BTS_RECORD_SIZE;
+	ds->bts_interrupt_threshold = ds->bts_absolute_maximum -
+					(max / 16) * BTS_RECORD_SIZE;
 	return 0;
 }
 
