Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6D2DC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 17:38:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9432820817
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 17:38:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WZ6awFen"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9432820817
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731985AbeK1Ehe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 23:37:34 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34601 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731930AbeK1Ehd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 23:37:33 -0500
Received: by mail-pf1-f196.google.com with SMTP id h3so8749199pfg.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 09:38:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ao1Uz+phHUdzfJadAcXIQZSiHrjNveQnzAB3LdzHWmM=;
        b=WZ6awFenx+3PYYe/6SmZZOUD9tFYTu303l9DVFUgcR+XV5SKgCQavQVxHO1YrQbPAi
         z1+RDFHqVnTbhtzHwrueFxFF/3JTynZ2wo47bvAEZjKhH23UJm8qCAPgOJs2QVSaVSqL
         LwRz3Ypwj4fRVaKsBhHbVL/BLEHWoh5zNAzdw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ao1Uz+phHUdzfJadAcXIQZSiHrjNveQnzAB3LdzHWmM=;
        b=a1ycB6kiXm8+IAXSqqHggeLFCeTy1BwZrid94cmVg+OqE8dk7mr0Rc5XobmeC6On4Y
         hy5oPAhIHJP4LaQmkZku1Ocd6BMOP0CnCYdQT2vZBbhqHDacpusHPpl7F9GalW7txKes
         AmCqcQlcckbm3hq3gk3w/lTkqBdboV2LEYpRbtVGZhzGUyM3wnkrkaWroSC+fMBNZ+sg
         wQv45OeBv5RdCoIEEe+DLtHt0H80TQKBN0H0WQZMf/df/ee9UWodQHDom3jKKNKlp7uP
         i+NNef9unzAEzpecQ2e9Z8Wue+ZoGD7MyCIhwpDrcrGkgmzaB2tKm5SmM5UD3i+ymYFT
         gBJw==
X-Gm-Message-State: AGRZ1gLWciHOc4PyCZVB/Vuryrk7g9uCyqciq6qdhJxAKlSimQ0QhpDD
        Ce0FwbpjYpqYzlj2yWPbtPX3NQ==
X-Google-Smtp-Source: AJdET5fmhlby04WHGEBz54bPAf9xUpUZC7UVqrFQAyEfVx623IWaljSJS5+eCaUH3iOQ5hSH/CNnPg==
X-Received: by 2002:aa7:8354:: with SMTP id z20mr33279489pfm.81.1543340334476;
        Tue, 27 Nov 2018 09:38:54 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:c8e0:70d7:4be7:a36])
        by smtp.gmail.com with ESMTPSA id b185sm4577547pga.85.2018.11.27.09.38.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Nov 2018 09:38:53 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Will Deacon <will.deacon@arm.com>,
        kgdb-bugreport@lists.sourceforge.net,
        Peter Zijlstra <peterz@infradead.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 3/4] kgdb: Don't round up a CPU that failed rounding up before
Date:   Tue, 27 Nov 2018 09:38:38 -0800
Message-Id: <20181127173839.34328-4-dianders@chromium.org>
X-Mailer: git-send-email 2.20.0.rc0.387.gc7a69e6b6c-goog
In-Reply-To: <20181127173839.34328-1-dianders@chromium.org>
References: <20181127173839.34328-1-dianders@chromium.org>
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

Changes in v6:
- Moved smp_call_function_single_async() error check to patch 3.

Changes in v5: None
Changes in v4:
- Removed smp_mb() calls.

Changes in v3:
- Don't round up a CPU that failed rounding up before new for v3.

Changes in v2: None

 kernel/debug/debug_core.c | 20 +++++++++++++++++++-
 kernel/debug/debug_core.h |  1 +
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
index 10db2833a423..1fb8b239e567 100644
--- a/kernel/debug/debug_core.c
+++ b/kernel/debug/debug_core.c
@@ -247,6 +247,7 @@ void __weak kgdb_roundup_cpus(void)
 	call_single_data_t *csd;
 	int this_cpu = raw_smp_processor_id();
 	int cpu;
+	int ret;
 
 	for_each_online_cpu(cpu) {
 		/* No need to roundup ourselves */
@@ -254,8 +255,23 @@ void __weak kgdb_roundup_cpus(void)
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
-		smp_call_function_single_async(cpu, csd);
+		ret = smp_call_function_single_async(cpu, csd);
+		if (ret)
+			kgdb_info[cpu].rounding_up = false;
 	}
 }
 
@@ -788,6 +804,8 @@ int kgdb_nmicallback(int cpu, void *regs)
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

