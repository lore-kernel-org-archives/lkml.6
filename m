Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B28A3C46465
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 01:04:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78D672086B
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 01:04:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RT3QNZsr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78D672086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388978AbeKGKcS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 05:32:18 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45751 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387697AbeKGKcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 05:32:17 -0500
Received: by mail-pl1-f194.google.com with SMTP id o19-v6so7033781pll.12
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 17:04:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WQM7chB0oDewwNnyIx9CKfvrFsyvLv4TlbWwfrMWGXo=;
        b=RT3QNZsrexQ10U8eGOLxbLruMSjgUhr+TLEqjuVkJ6d4zm8lcdVeR50NiGKuvKknaj
         ZOR3qV8Gex62a4pp1H5inI9eY1ma9POzAJiY8m70fNXeI2uw4geFVV3+QGyAaGne97Ml
         axhvODRUoJMdUqfy8ysGZLOwh0Bws0qhqXdi8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WQM7chB0oDewwNnyIx9CKfvrFsyvLv4TlbWwfrMWGXo=;
        b=S/5JlImBFUPEhAVzJbwknHPvvDMB0cCtsSJ3y9voQbgCc8xB74HSzQNZ4d+hCHsNId
         cleItfnvcyC8LdRIEhdB/Wq69ZisupCMhcJbdTcpZEWcqHbHDj31W1UBHHGqcE03x/X9
         NAIlhaRwzb0VJVFS7/PVB90MLspiidJWS4xVB/Eu1KWWsqzWK7fsBpdO/lOUp83jFe4A
         MacKHPfZi8ndY2+Os6AaavTR4dBgdyg4eNOpImtzoTEvE8JkyPsk+HxThaIDh3h3Gvn2
         zJ3UtTUZvShha0FM0dhzm9Uji+PM0TR+u16KvHyLr3SEfcfEPIu+c8loybM3JnzgZlEA
         +qmw==
X-Gm-Message-State: AGRZ1gJLOSTtWDd5P5Aev6IJ7ydYxstNUHH729C6PtXJxQYmfmePV33Q
        T4a2h9sPIKao0JlAYM5dpqas7g==
X-Google-Smtp-Source: AJdET5dbQyY9HQLt4CjVjduEuH6F7Uo/Wi0xqO2etcTnRWyUqpNM4eK1L8QIwPxuEvweU53Or24F8w==
X-Received: by 2002:a17:902:b612:: with SMTP id b18-v6mr29215604pls.205.1541552656499;
        Tue, 06 Nov 2018 17:04:16 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:c8e0:70d7:4be7:a36])
        by smtp.gmail.com with ESMTPSA id v37sm30134695pgn.5.2018.11.06.17.04.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Nov 2018 17:04:15 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>
Cc:     kgdb-bugreport@lists.sourceforge.net,
        Peter Zijlstra <peterz@infradead.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/4] kgdb: Don't round up a CPU that failed rounding up before
Date:   Tue,  6 Nov 2018 17:00:27 -0800
Message-Id: <20181107010028.184543-4-dianders@chromium.org>
X-Mailer: git-send-email 2.19.1.930.g4563a0d9d0-goog
In-Reply-To: <20181107010028.184543-1-dianders@chromium.org>
References: <20181107010028.184543-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we're using the default implementation of kgdb_roundup_cpus() that
uses smp_call_function_single_async() we can end up hanging
kgdb_roundup_cpus() if we try to round up a CPU that failed to round
up before.

Specifically smp_call_function_single_async() will try to wait on the
csd lock for the CPU that we're trying to round up.  If the previous
round up never finished then that lock could still be held and we'll
just sit there hanging.

There's not a lot of use trying to round up a CPU that failed to round
up before.  Let's keep a flag that indicates whether the CPU started
but didn't finish to round up before.  If we see that flag set then
we'll skip the next round up.

In general we have a few goals here:
- We never want to end up calling smp_call_function_single_async()
  when the csd is still locked.  This is accomplished because
  flush_smp_call_function_queue() unlocks the csd _before_ invoking
  the callback.  That means that when kgdb_nmicallback() runs we know
  for sure the the csd is no longer locked.  Thus when we set
  "rounding_up = false" we know for sure that the csd is unlocked.
- If there are no timeouts rounding up we should never skip a round
  up.

NOTE #1: In general trying to continue running after failing to round
up CPUs doesn't appear to be supported in the debugger.  When I
simulate this I find that kdb reports "Catastrophic error detected"
when I try to continue.  I can overrule and continue anyway, but it
should be noted that we may be entering the land of dragons here.

NOTE #2: I did a bit of testing before and after this change.  I
introduced a 10 second hang in the kernel while holding a spinlock
that I could invoke on a certain CPU with 'taskset -c 3 cat /sys/...".

Before this change if I did:
- Invoke hang
- Enter debugger
- g (which warns about Catastrophic error, g again to go anyway)
- g
- Enter debugger

...I'd hang the rest of the 10 seconds without getting a debugger
prompt.  After this change I end up in the debugger the 2nd time after
only 1 second with the standard warning about 'Timed out waiting for
secondary CPUs.'

I'll also note that once the CPU finished waiting I could actually
debug it (aka "btc" worked)

I won't promise that everything works perfectly if the errant CPU
comes back at just the wrong time (like as we're entering or exiting
the debugger) but it certainly seems like an improvement.

NOTE #3: setting 'kgdb_info[cpu].rounding_up = false' is in
kgdb_nmicallback() instead of kgdb_call_nmi_hook() because some
implementations override kgdb_call_nmi_hook().  It shouldn't hurt to
have it in kgdb_nmicallback() in any case.

NOTE #4: this logic is really only needed because there is no API call
like "smp_try_call_function_single_async()" or "smp_csd_is_locked()".
If such an API existed then we'd use it instead, but it seemed a bit
much to add an API like this just for kgdb.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v3:
- New for v3.

Changes in v2: None

 kernel/debug/debug_core.c | 17 +++++++++++++++++
 kernel/debug/debug_core.h |  1 +
 2 files changed, 18 insertions(+)

diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
index 23f2b5613afa..324cba8917f1 100644
--- a/kernel/debug/debug_core.c
+++ b/kernel/debug/debug_core.c
@@ -246,6 +246,20 @@ void __weak kgdb_roundup_cpus(void)
 			continue;
 
 		csd = &per_cpu(kgdb_roundup_csd, cpu);
+
+		/*
+		 * If it didn't round up last time, don't try again
+		 * since smp_call_function_single_async() will block.
+		 *
+		 * If rounding_up is false then we know that the
+		 * previous call must have at least started and that
+		 * means smp_call_function_single_async() won't block.
+		 */
+		smp_mb();
+		if (kgdb_info[cpu].rounding_up)
+			continue;
+		kgdb_info[cpu].rounding_up = true;
+
 		csd->func = kgdb_call_nmi_hook;
 		smp_call_function_single_async(cpu, csd);
 	}
@@ -782,6 +796,9 @@ int kgdb_nmicallback(int cpu, void *regs)
 	struct kgdb_state kgdb_var;
 	struct kgdb_state *ks = &kgdb_var;
 
+	kgdb_info[cpu].rounding_up = false;
+	smp_mb();
+
 	memset(ks, 0, sizeof(struct kgdb_state));
 	ks->cpu			= cpu;
 	ks->linux_regs		= regs;
diff --git a/kernel/debug/debug_core.h b/kernel/debug/debug_core.h
index 127d9bc49fb4..b4a7c326d546 100644
--- a/kernel/debug/debug_core.h
+++ b/kernel/debug/debug_core.h
@@ -42,6 +42,7 @@ struct debuggerinfo_struct {
 	int			ret_state;
 	int			irq_depth;
 	int			enter_kgdb;
+	bool			rounding_up;
 };
 
 extern struct debuggerinfo_struct kgdb_info[];
-- 
2.19.1.930.g4563a0d9d0-goog

