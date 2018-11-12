Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79B53C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 18:27:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B1532245E
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 18:27:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hRMRhXcV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B1532245E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730328AbeKMEVq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 23:21:46 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40850 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727354AbeKMEVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 23:21:45 -0500
Received: by mail-pf1-f196.google.com with SMTP id x2-v6so4704674pfm.7
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 10:27:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gIC8YvIzJSpzRaEWbDUMtgPUQN1L7oxCLhTdrA/N/SM=;
        b=hRMRhXcVkiEBv7HgJtyLDXwNwfuYFyGEWi6Bkihmd5pbCBwNrpHZFm6y+IaPIh4LNp
         tfia1Q10O1b+a8BjJiQr609Eh5kqGMLH186EovOiQhzcG2qVETnkZJywbjqSsnHgYmmZ
         Qc8Nz0rdE4GDiUpLyWfh1PnTV5IMQ0iC6Xbz4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gIC8YvIzJSpzRaEWbDUMtgPUQN1L7oxCLhTdrA/N/SM=;
        b=f044ZVpor6oEB0435/BB7YrenZ1TxCCHSduNkrC/FZt4dQujAhoOJ6BlGgm1p971kj
         hIHV20ZDk227rUkQWoQihMHGqHGgvnv4lEODNaaMxGpOhHiW7Y0Tc/EvGnWqDQ7mw5a4
         Yl1Gpe1v76NCGfjxNk1p/UPhlXLneMcdsHiL/ckMGoVTGHBZwv43lgrvKB2ENR5B8DCP
         /wE0TI7zOwuNOeLSrj6JHarhy7sHoTjvp18y0ukiejHUMtT3NrY5KyOIEMcjJDpA67h7
         xmQA4GBxXAEuAuGScBCutMSNg6sXoHFC27eKAfc4Li0Tzt1s5pO3XfSDSzk0SSJGvRfP
         hMTA==
X-Gm-Message-State: AGRZ1gI9PwozFLDKhNMDwu+3+E6qCYynl0B9sUWB5sti8BlrnwwbP+SD
        8VTosa1znsgMvw1ST6Vj8Nvepg==
X-Google-Smtp-Source: AJdET5e90NOAHUQA14AOEWTf5cmBYro4c8csNw6m1nj2wmrNUyWFIOS6WXSWS0l3oLvumSGyNUskJw==
X-Received: by 2002:a63:2f86:: with SMTP id v128mr1675599pgv.407.1542047240719;
        Mon, 12 Nov 2018 10:27:20 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:c8e0:70d7:4be7:a36])
        by smtp.gmail.com with ESMTPSA id o86-v6sm18813100pfk.8.2018.11.12.10.27.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 10:27:20 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>
Cc:     kgdb-bugreport@lists.sourceforge.net,
        Peter Zijlstra <peterz@infradead.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/4] kgdb: Don't round up a CPU that failed rounding up before
Date:   Mon, 12 Nov 2018 10:26:57 -0800
Message-Id: <20181112182659.245726-4-dianders@chromium.org>
X-Mailer: git-send-email 2.19.1.930.g4563a0d9d0-goog
In-Reply-To: <20181112182659.245726-1-dianders@chromium.org>
References: <20181112182659.245726-1-dianders@chromium.org>
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
Possibly the "Catastrophic error detected" was added _because_ of the
future failure to round up, but even so this is an area of the code
that hasn't been strongly tested.

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

Changes in v4:
- Removed smp_mb() calls.

Changes in v3:
- Don't round up a CPU that failed rounding up before new for v3.

Changes in v2: None

 kernel/debug/debug_core.c | 15 +++++++++++++++
 kernel/debug/debug_core.h |  1 +
 2 files changed, 16 insertions(+)

diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
index 23f2b5613afa..7e2f312fb41f 100644
--- a/kernel/debug/debug_core.c
+++ b/kernel/debug/debug_core.c
@@ -246,6 +246,19 @@ void __weak kgdb_roundup_cpus(void)
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
+		if (kgdb_info[cpu].rounding_up)
+			continue;
+		kgdb_info[cpu].rounding_up = true;
+
 		csd->func = kgdb_call_nmi_hook;
 		smp_call_function_single_async(cpu, csd);
 	}
@@ -782,6 +795,8 @@ int kgdb_nmicallback(int cpu, void *regs)
 	struct kgdb_state kgdb_var;
 	struct kgdb_state *ks = &kgdb_var;
 
+	kgdb_info[cpu].rounding_up = false;
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

