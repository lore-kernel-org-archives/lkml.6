Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E8F1ECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 10:06:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF13020861
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 10:06:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF13020861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbeINPUb convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 11:20:31 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:39381 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726868AbeINPUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 11:20:31 -0400
Received: by mail-ot1-f66.google.com with SMTP id c12-v6so4037395otl.6;
        Fri, 14 Sep 2018 03:06:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LhJ7VGsjU15WgOrkRMuAvoAlQWwnmBzU5YvauPjraxQ=;
        b=pDpsVw+VVb9f7lsL5DIFcnZBTAdPAOv6Miw59r3XCwxcj4noug5+H5VG/2+ybJzsoS
         l0kg1ye7bKj5D6KvPIGJWp3W9BFg9bXwfgaV7IRBIjtHmN77pKfgp5PyDF05wQ48wnJo
         q9ZOU6QrHxX47YRFKSJ8FnG9CW24swEcGTJkEgX2mo5OWW4omJd3svWKERTYPwJSb+bn
         mc5uaZXXt/2HgvBujpbgtHu7TCUU+4FSQ7c0ZwA+E+Xp2uxg1bzLVessaO4PAIwOnqx7
         HgIl8aVTWHEICImGuR+CkrR/21jY68CJG8vsHzTMH9wqueKqRHAUO2neE7ITkWr4RJTo
         enEQ==
X-Gm-Message-State: APzg51CT2Fbv/bLWFHtGYllCFyLSwd7hcMWnEN6PbWZ7NMeGSdscKdET
        fGeFCrHrY1DhOuCqx3N5n/mcJexmY5SJAGeK8vM=
X-Google-Smtp-Source: ANB0VdbqfOgaeouCbHAD2gvZM6F28TsnmagX4CeSaVFv1Qc9ALlnodUrWoL4IuoErIBNqlV5WqqGOVFR9RZeGppa/OI=
X-Received: by 2002:a9d:2645:: with SMTP id a63-v6mr3754304otb.270.1536919603377;
 Fri, 14 Sep 2018 03:06:43 -0700 (PDT)
MIME-Version: 1.0
References: <9611469.2z7W9akjOQ@aspire.rjw.lan> <767e9ec4-cc35-9255-360a-4d12736aa4de@nextfour.com>
 <1831106.CYv9dyYV15@aspire.rjw.lan> <e028742e-cd42-24a7-0da1-4fa12d8c9d7c@nextfour.com>
In-Reply-To: <e028742e-cd42-24a7-0da1-4fa12d8c9d7c@nextfour.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 14 Sep 2018 12:06:31 +0200
Message-ID: <CAJZ5v0gRjfGDSyZXRwGgF9dOBR9OJbfYE8Dbpqdx6oCMN1XUVA@mail.gmail.com>
Subject: Re: [PATCH] PM / suspend: Count suspend-to-idle loop as sleep time
To:     mika.penttila@nextfour.com
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 14, 2018 at 11:53 AM Mika Penttilä
<mika.penttila@nextfour.com> wrote:
>
> On 09/14/2018 11:46 AM, Rafael J. Wysocki wrote:
> > On Friday, September 14, 2018 10:28:44 AM CEST Mika Penttilä wrote:
> >> Hi!
> >>
> >>
> >> On 09/14/2018 09:59 AM, Rafael J. Wysocki wrote:
> >>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>>
> >>> There is a difference in behavior between suspend-to-idle and
> >>> suspend-to-RAM in the timekeeping handling that leads to functional
> >>> issues.  Namely, every iteration of the loop in s2idle_loop()
> >>> increases the monotinic clock somewhat, even if timekeeping_suspend()
> >>> and timekeeping_resume() are invoked from s2idle_enter(), and if
> >>> many of them are carried out in a row, the monotonic clock can grow
> >>> significantly while the system is regarded as suspended, which
> >>> doesn't happen during suspend-to-RAM and so it is unexpected and
> >>> leads to confusion and misbehavior in user space (similar to what
> >>> ensued when we tried to combine the boottime and monotonic clocks).
> >>>
> >>> To avoid that, count all iterations of the loop in s2idle_loop()
> >>> as "sleep time" and adjust the clock for that on exit from
> >>> suspend-to-idle.
> >>>
> >>> [That also covers systems on which timekeeping is not suspended
> >>>  by by s2idle_enter().]
> >>>
> >>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>> ---
> >>>
> >>> This is a replacement for https://patchwork.kernel.org/patch/10599209/
> >>>
> >>> I decided to count the entire loop in s2idle_loop() as "sleep time" as the
> >>> patch is then simpler and it also covers systems where timekeeping is not
> >>> suspended in the final step of suspend-to-idle.
> >>>
> >>> I dropped the "Fixes:" tag, because the monotonic clock delta problem
> >>> has been present on the latter since the very introduction of "freeze"
> >>> (as suspend-to-idle was referred to previously) and so this doesn't fix
> >>> any particular later commits.
> >>>
> >>> ---
> >>>  kernel/power/suspend.c |   18 ++++++++++++++++++
> >>>  1 file changed, 18 insertions(+)
> >>>
> >>> Index: linux-pm/kernel/power/suspend.c
> >>> ===================================================================
> >>> --- linux-pm.orig/kernel/power/suspend.c
> >>> +++ linux-pm/kernel/power/suspend.c
> >>> @@ -109,8 +109,12 @@ static void s2idle_enter(void)
> >>>
> >>>  static void s2idle_loop(void)
> >>>  {
> >>> +   ktime_t start, delta;
> >>> +
> >>>     pm_pr_dbg("suspend-to-idle\n");
> >>>
> >>> +   start = ktime_get();
> >>> +
> >>>     for (;;) {
> >>>             int error;
> >>>
> >>> @@ -150,6 +154,20 @@ static void s2idle_loop(void)
> >>>             pm_wakeup_clear(false);
> >>>     }
> >>>
> >>> +   /*
> >>> +    * If the monotonic clock difference between the start of the loop and
> >>> +    * this point is too large, user space may get confused about whether or
> >>> +    * not the system has been suspended and tasks may get killed by
> >>> +    * watchdogs etc., so count the loop as "sleep time" to compensate for
> >>> +    * that.
> >>> +    */
> >>> +   delta = ktime_sub(ktime_get(), start);
> >>> +   if (ktime_to_ns(delta) > 0) {
> >>> +           struct timespec64 timespec64_delta = ktime_to_timespec64(delta);
> >>> +
> >>> +           timekeeping_inject_sleeptime64(&timespec64_delta);
> >>> +   }
> >>
> >> But doesn't injecting sleep time here make monotonic clock too large by the amount of sleeptime?
> >> tick_freeze() / tick_unfreeze() already injects the sleeptime (otherwise delta would be 0).
> >
> > No, it doesn't.
> >
> > The delta here is the extra time taken by the loop which hasn't been counted
> > as sleep time yet.
>
> I said incorrectly monotonic clock, but timekeeping_inject_sleeptime64() forwards the wall time, by the amount of delta.
> Why wouldn't some other cpu update xtime when one cpu is in the loop? And if all cpus enter s2idle, tick_unfreeze()
> injects sleeptime. My point is that this extra injection makes wall time wrong, no?

OK, you're right.  I got that the other way around.

So, the patch is withdrawn.
