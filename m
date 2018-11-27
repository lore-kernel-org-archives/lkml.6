Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F831C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 03:52:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4801720989
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 03:52:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dXs0TANb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4801720989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728523AbeK0Os3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 09:48:29 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43241 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728334AbeK0OsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 09:48:19 -0500
Received: by mail-pf1-f193.google.com with SMTP id w73so7658868pfk.10
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 19:51:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=txlFVks4et+bbgNmcRi9RcRaSRarquSDT3787o71SRM=;
        b=dXs0TANbgV15czj2bamR2bDs1V5boQm2igSHEZWXzYJ1WQ/YlV75KgKF4K71v3+u4P
         cToow+cOubxUOrvJKm+2JLtEVaM0eE+Nc/JwQo+zyqV9OeLGA8wHxUk8AncowxJwhhYx
         e3+hLax5ezo7rEgv5ZFN2Ds0o4R13iHkS0fxQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=txlFVks4et+bbgNmcRi9RcRaSRarquSDT3787o71SRM=;
        b=toEqnF1+Rksdc2/gPcV52c+MWkp6COuR9tHraE7Dc53srMHuHv2qoTdGv7jhQYKYqG
         NvhgYNuHFkoquO0fpkY/mzbr4bH+ZCeqTrfwP4ZzmPE1z2ZVxaFqQ/3cadPJCIV+kqZf
         7sSCo2fiOikOaJyeSLFhW+K70kEaSDGb4ciSoci5uf/9NGb4kb4cDOKseq/IqpVEUgTg
         oeea8sIFL7URVgh3+8yCIgj9hFJHDTZdn202WNQAMrb73uwhpHTk14OmzwL8QH+MHNb3
         2LDgsFX+j57Nt9a/kECVPD4SkRaU6tmqeq+jqt0Ay4VmC41mv0aAxx3MKT0gLCnvMJzE
         9WZw==
X-Gm-Message-State: AA+aEWbjtQ3TKiZ3WxCP/hOww+USIBZdkY4ttSfJBXc1O3xgxjGTzSUg
        2I6Yvuoo3R3gU/M3p/UShQHQqw==
X-Google-Smtp-Source: AFSGD/XGRoLCxqbdIKgXQUi/n3aRf4RDcyAjpmoOIf67IcUIGpN5qXzXLJ6KSoLO/HfuCerwSbqI6g==
X-Received: by 2002:a63:224f:: with SMTP id t15mr27546243pgm.69.1543290710003;
        Mon, 26 Nov 2018 19:51:50 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:c8e0:70d7:4be7:a36])
        by smtp.gmail.com with ESMTPSA id i4sm2690112pfj.82.2018.11.26.19.51.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Nov 2018 19:51:49 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Will Deacon <will.deacon@arm.com>,
        kgdb-bugreport@lists.sourceforge.net,
        Peter Zijlstra <peterz@infradead.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 3/4] kgdb: Don't round up a CPU that failed rounding up before
Date:   Mon, 26 Nov 2018 19:51:32 -0800
Message-Id: <20181127035133.225592-4-dianders@chromium.org>
X-Mailer: git-send-email 2.20.0.rc0.387.gc7a69e6b6c-goog
In-Reply-To: <20181127035133.225592-1-dianders@chromium.org>
References: <20181127035133.225592-1-dianders@chromium.org>
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

Changes in v5: None
Changes in v4:
- Removed smp_mb() calls.

Changes in v3:
- Don't round up a CPU that failed rounding up before new for v3.

Changes in v2: None

 kernel/debug/debug_core.c | 15 +++++++++++++++
 kernel/debug/debug_core.h |  1 +
 2 files changed, 16 insertions(+)

diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
index d7444e6ead99..1fb8b239e567 100644
--- a/kernel/debug/debug_core.c
+++ b/kernel/debug/debug_core.c
@@ -255,6 +255,19 @@ void __weak kgdb_roundup_cpus(void)
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
 		ret = smp_call_function_single_async(cpu, csd);
 		if (ret)
@@ -791,6 +804,8 @@ int kgdb_nmicallback(int cpu, void *regs)
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
2.20.0.rc0.387.gc7a69e6b6c-goog

