Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F2B6C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 13:54:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4981D206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 13:54:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4981D206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387414AbeKMXxM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 18:53:12 -0500
Received: from mga01.intel.com ([192.55.52.88]:31500 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732913AbeKMXxM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 18:53:12 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Nov 2018 05:54:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,499,1534834800"; 
   d="scan'208";a="103991208"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
  by fmsmga002.fm.intel.com with SMTP; 13 Nov 2018 05:54:53 -0800
Received: by stinkbox (sSMTP sendmail emulation); Tue, 13 Nov 2018 15:54:53 +0200
Date:   Tue, 13 Nov 2018 15:54:53 +0200
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc:     linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [REGRESSION 4.20-rc1] 45975c7d21a1 ("rcu: Define RCU-sched API in
 terms of RCU for Tree RCU PREEMPT builds")
Message-ID: <20181113135453.GW9144@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

After 4.20-rc1 some of my 32bit UP machines no longer reboot/shutdown.
I bisected this down to commit 45975c7d21a1 ("rcu: Define RCU-sched
API in terms of RCU for Tree RCU PREEMPT builds").

I traced the hang into
-> cpufreq_suspend()
 -> cpufreq_stop_governor()
  -> cpufreq_dbs_governor_stop()
   -> gov_clear_update_util()
    -> synchronize_sched()
     -> synchronize_rcu()

Only PREEMPT=y is affected for obvious reasons, but that couldn't
explain why the same UP kernel booted on an SMP machine worked fine.
Eventually I realized that the difference between working and
non-working machine was IOAPIC vs. PIC. With initcall_debug I saw
that we mask everything in the PIC before cpufreq is shut down,
and came up with the following fix:

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 7aa3dcad2175..f88bf3c77fc0 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2605,4 +2605,4 @@ static int __init cpufreq_core_init(void)
        return 0;
 }
 module_param(off, int, 0444);
-core_initcall(cpufreq_core_init);
+late_initcall(cpufreq_core_init);

Here's the resulting change in inutcall_debug:
  pci 0000:00:00.1: shutdown
  hub 4-0:1.0: hub_ext_port_status failed (err = -110)
  agpgart-intel 0000:00:00.0: shutdown
+ PM: Calling cpufreq_suspend+0x0/0x100
  PM: Calling mce_syscore_shutdown+0x0/0x10
  PM: Calling i8259A_shutdown+0x0/0x10
- PM: Calling cpufreq_suspend+0x0/0x100
+ reboot: Restarting system
+ reboot: machine restart

I didn't really look into what other ramifications the cpufreq
initcall change might have. cpufreq_global_kobject worries
me a bit. Maybe that one has to remain in core_initcall() and
we could just move the suspend to late_initcall()? Anyways,
I figured I'd leave this for someone more familiar with the
code to figure out ;) 

-- 
Ville Syrjälä
Intel
