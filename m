Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97242ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5492520875
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:55:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5492520875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388502AbeGWN4H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 09:56:07 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45076 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388088AbeGWN0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 09:26:35 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 01757BD4;
        Mon, 23 Jul 2018 12:25:38 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hugh Dickins <hughd@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@intel.com>,
        Andi Kleen <andi.kleen@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Stephane Eranian <eranian@google.com>
Subject: [PATCH 4.17 11/63] x86/events/intel/ds: Fix bts_interrupt_threshold alignment
Date:   Mon, 23 Jul 2018 14:24:17 +0200
Message-Id: <20180723122446.802635463@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180723122446.351334162@linuxfoundation.org>
References: <20180723122446.351334162@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hugh Dickins <hughd@google.com>

commit 2c991e408df6a407476dbc453d725e1e975479e7 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/events/intel/ds.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

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
 


