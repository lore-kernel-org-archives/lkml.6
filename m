Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2F9BC4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 16:49:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6467621A32
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 16:49:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6467621A32
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732672AbeHFS7s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 14:59:48 -0400
Received: from mga18.intel.com ([134.134.136.126]:51317 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731993AbeHFS7r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 14:59:47 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Aug 2018 09:49:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,452,1526367600"; 
   d="scan'208";a="62958079"
Received: from spandruv-desk.jf.intel.com ([10.54.75.31])
  by orsmga008.jf.intel.com with ESMTP; 06 Aug 2018 09:49:29 -0700
Message-ID: <cd2287153b369d88cc240068adc7d341ef675acf.camel@linux.intel.com>
Subject: Re: [PATCH] Revert "cpufreq: intel_pstate: Fix ->set_policy()
 interface for no_turbo"
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Gabriele Mazzotta <gabriele.mzt@gmail.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Mon, 06 Aug 2018 09:49:29 -0700
In-Reply-To: <CAJZ5v0iwhVu6PwztsbN8cYmQtnjD2SyFkazkObc1o-1JX6GO5g@mail.gmail.com>
References: <20180804152932.3861-1-gabriele.mzt@gmail.com>
         <ccf46de4-d75e-306b-9554-9d33f68d2379@gmail.com>
         <CAJZ5v0iwhVu6PwztsbN8cYmQtnjD2SyFkazkObc1o-1JX6GO5g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.2 (3.28.2-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-08-06 at 10:30 +0200, Rafael J. Wysocki wrote:
> On Sat, Aug 4, 2018 at 7:31 PM, Gabriele Mazzotta
> <gabriele.mzt@gmail.com> wrote:
> > On 04/08/2018 17:29, Gabriele Mazzotta wrote:
> > > This change does not take into account that some BIOSes change
> > > MSR_IA32_MISC_ENABLE_TURBO_DISABLE depending on the power source.
> > > If the turbo is disabled when the system boots, policy.max_freq
> > > is set to pstate.max_pstate. However, if the BIOS later enables
> > > the turbo, the CPU will never be able to run at
> > > pstate.turbo_pstate.
> > > 
> > > Since now intel_pstate_set_policy() does its calculations using
> > > pstate.max_freq and pstate.turbo_freq, we can always calculate
> > > cpuinfo.max_freq using pstate.turbo_pstate, thus allowing system
> > > with varying MSR_IA32_MISC_ENABLE_TURBO_DISABLE to run at full
> > > speed when the turbo is enabled.
> 
> Well, the problem with this approach is that always using
> pstate.turbo_pstate as the max causes the governor to overestimate
> the
> target frequency when the turbo range is not available (the target
> depends on the width of the entire available P-state range including
> turbo, so if the turbo range is not available, the number take into
> that computation is too large).
> 
> Are we expected to get notified when the BIOS updates
> MSR_IA32_MISC_ENABLE_TURBO_DISABLE?

Let's try this:
- boot with kernel command line 

intel_pstate=support_acpi_ppc dyndbg="file processor_perflib.c +p"
dyndbg="file intel_pstate.c +p"

and send dmesg after you change power sources.

- Also try with
intel_pstate=disable dyndbg="file processor_perflib.c +p"

and send dmesg.

Thanks,
Srinivas


