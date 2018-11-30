Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32EE3C64EB4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 21:17:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF8E520660
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 21:17:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="fU0mJ4Sg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF8E520660
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=purestorage.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbeLAI23 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 03:28:29 -0500
Received: from mail-yb1-f225.google.com ([209.85.219.225]:41013 "EHLO
        mail-yb1-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725749AbeLAI23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 03:28:29 -0500
Received: by mail-yb1-f225.google.com with SMTP id t13-v6so2798271ybb.8
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 13:17:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TPDqD8xgs+VCmbWVHXJYorz2uK27Phebvx1M40eoRsE=;
        b=fU0mJ4Sg2VVhrUctWgjKchIk0So43xK7W9ZSHpakDWFbkyM/+PolTa2qaPNL3Dnz6q
         XMMq+kAiVN/WeIn9XWGu+5DiNLFx5RXDDPYa4emmxe9ZqSR8UFqgv/mnfsqOrQRMr8tN
         adt58YkG6aBgVuiEK4xYmUZm3YqBSv4tKsZe8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TPDqD8xgs+VCmbWVHXJYorz2uK27Phebvx1M40eoRsE=;
        b=dw1YxOIODbcKPn6TfFSFISnkH2LFdTn9PCbn9oz8j7ANyeyfu7GxNEMLGcdhewkpLI
         0K/GrW97LnO5J7Rr4K0ivBPG9znRz2BghYvuicu5ZJZ5WMH7HrpiPRGZBE3qRer1W7di
         JFsK8dupWUXNf3D2QH6yVWY5qlN1PhT7uxSWhjKcAoasVwpJGQcgMzwWLDX5EVIrsk27
         9PqKsRXIYSR8waoTDniX4SX0NRU2douEqbVKP4i88R+/ao3Cn5n5J45thWYNCbNxuEld
         L4HS5rIUsAly0528HzynB8P60w/YKIt4qbzmH3OiOGie6So/b36FBqdxKtm+/IvXikl8
         ENYw==
X-Gm-Message-State: AA+aEWYPkrRNaOyy1/ABQMBDLXw3FvOwsQ/CKY1CvNzBiLcEzEYH5U9F
        GHi7JT3Z61vU85j2hNkXmaTEC7pOQ6w/Pjn0ewENM6tV8E885+x0t/IgFJCUvz4UrQ==
X-Google-Smtp-Source: AFSGD/VOvHvAUydNdXoRfUBu/AV9QHzLPCzGjcNINGO9cSsMpHi/58P71fBTtQH6QF5CiiTeeRcjTp/Zlvp4
X-Received: by 2002:a25:c342:: with SMTP id t63-v6mr6889649ybf.91.1543612672363;
        Fri, 30 Nov 2018 13:17:52 -0800 (PST)
Received: from c7-smtp.dev.purestorage.com ([2620:125:9007:320:7:32:106:0])
        by smtp-relay.gmail.com with ESMTPS id k84-v6sm544890ywa.10.2018.11.30.13.17.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Nov 2018 13:17:52 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from roland-x1-yoga.digitalvampire.org (roland-x1-yoga.purestorage.com [10.202.102.176])
        by c7-smtp.dev.purestorage.com (Postfix) with ESMTPS id 0E9FB2191E;
        Fri, 30 Nov 2018 14:17:51 -0700 (MST)
From:   Roland Dreier <roland@purestorage.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] clocksource: Add heuristics to avoid switching away from TSC due to timer delay
Date:   Fri, 30 Nov 2018 13:17:50 -0800
Message-Id: <20181130211750.5571-1-roland@purestorage.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On a modern x86 system, the TSC is used as a clocksource, with HPET
used in the clocksource watchdog to make sure that the TSC is stable.

If the clocksource watchdog_timer is delayed for an extremely long
time (for example if softirqs are being serviced in ksoftirqd, and
realtime threads are starving ksoftirqd), then the 32-bit HPET counter
may wrap around.  For example, with an HPET running at 24 MHz, 2^32
cycles is about 179 seconds - a long time for timers to be starved,
but possible with a poorly behaved realtime thread.

If this happens, since the TSC is a 64-bit counter and won't wrap, the
watchdog will detect skew - the TSC interval will be 179 seconds
longer than the HPET interval - and will mark the TSC as unstable.
This causes the system to switch to the HPET as a clocksource, which
has a huge negative performance impact.

In this case, switching to the HPET just makes a bad situation (timers
starved) that the system might recover from turn permanently even
worse (more expensive clock_gettime() calls), due to a spurious false
positive detection of TSC instability.

To improve this, add some heuristics to detect cases where the
watchdog is delayed long enough for the instability detection to be
likely to be wrong:

 - If the clocksource being tested (eg TSC) has counted so many cycles
   that converting to nsecs will overflow multiplication, *AND* the
   watchdog clocksource (eg HPET) shows that the watchdog timer has
   missed its interval by at least a factor of 3, skip marking the
   clocksource as unstable for a timer interation.  This is not
   perfect - for example it is possible for the watchdog clocksource
   to wrap around and show a small interval - but at least in the
   specific x86 it is unlikely, since the watchdog interval is a small
   fraction of the wraparound interval.

 - If there is a skew between the clocksource being tested and the
   watchdog clocksource that is at least as big as the wraparound
   interval for the watchdog clocksource, then don't mark the
   clocksource as unstable.  Again, this might fail to mark a
   clocksource as unstable for one iteration, but it is unlikely that
   the instability is bad enough that we will see a larger skew than
   the wraparound interval for many iterations.

These heuristics are imperfect but are chosen to make false detection
of instability much less likely, while leaving detection of true
instability very likely within a few clocksource watchdog iterations.

Signed-off-by: Roland Dreier <roland@purestorage.com>
---
 kernel/time/clocksource.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index ffe081623aec..f1b3d8ff2437 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -243,12 +243,47 @@ static void clocksource_watchdog(struct timer_list *unused)
 					     watchdog->shift);
 
 		delta = clocksource_delta(csnow, cs->cs_last, cs->mask);
+
+		/* If the cycle delta is beyond what we can safely
+		 * convert to nsecs, and the watchdog clocksource
+		 * suggests that we've overslept, skip checking this
+		 * iteration to avoid marking a clocksource as
+		 * unstable because of a severely delayed timer. */
+		if (delta > cs->max_cycles &&
+		    wd_nsec > 3 * jiffies_to_nsecs(WATCHDOG_INTERVAL)) {
+			pr_warn("timekeeping watchdog: Clocksource '%s' not checked due to apparent long timer delay:\n",
+				cs->name);
+			pr_warn("                      Delta %llx > max_cycles %llx, wd_nsec %lld\n",
+				delta, cs->max_cycles, wd_nsec);
+			continue;
+		}
+
 		cs_nsec = clocksource_cyc2ns(delta, cs->mult, cs->shift);
 		wdlast = cs->wd_last; /* save these in case we print them */
 		cslast = cs->cs_last;
 		cs->cs_last = csnow;
 		cs->wd_last = wdnow;
 
+		/* If the clocksource interval is far off from the
+		 * watchdog clocksource interval but the interval is
+		 * big enough that the watchdog may have wrapped
+		 * around (again due to a severely delayed timer),
+		 * skip this iteration.  For example, this saves us
+		 * from marking the TSC as unstable just because the
+		 * 32-bit HPET wrapped around on x86. */
+		if (abs(cs_nsec - wd_nsec) >
+		    clocksource_cyc2ns(watchdog->max_cycles, watchdog->mult,
+				       watchdog->shift) - WATCHDOG_THRESHOLD) {
+			pr_warn("timekeeping watchdog: Clocksource '%s' not checked due to apparent timer delay:\n",
+				cs->name);
+			pr_warn("                      Skew %lld watchdog wrap %lld\n",
+				abs(cs_nsec - wd_nsec),
+				clocksource_cyc2ns(watchdog->max_cycles,
+						   watchdog->mult,
+						   watchdog->shift));
+			continue;
+		}
+
 		if (atomic_read(&watchdog_reset_pending))
 			continue;
 
-- 
2.19.1

