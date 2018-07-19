Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DACBECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 11:04:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A369220693
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 11:04:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A369220693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731120AbeGSLrN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 07:47:13 -0400
Received: from smtp.nue.novell.com ([195.135.221.5]:47035 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727242AbeGSLrM (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Thu, 19 Jul 2018 07:47:12 -0400
Received: from emea4-mta.ukb.novell.com ([10.120.13.87])
        by smtp.nue.novell.com with ESMTP (TLS encrypted); Thu, 19 Jul 2018 13:04:29 +0200
Received: from suselix (nwb-a10-snat.microfocus.com [10.120.13.202])
        by emea4-mta.ukb.novell.com with ESMTP (TLS encrypted); Thu, 19 Jul 2018 12:04:21 +0100
Date:   Thu, 19 Jul 2018 13:04:18 +0200
From:   Andreas Herrmann <aherrmann@suse.com>
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Commit 554c8aa8ecad causing severe performance degression with
 pcc-cpufreq
Message-ID: <20180719110418.beofpa5iaulicfw7@suselix>
References: <20180717065048.74mmgk4t5utjaa6a@suselix>
 <20180718152556.5rydmdt7wlgpr5uk@suselix>
 <20180718153104.agcsgaoc6lhihuvo@suselix>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180718153104.agcsgaoc6lhihuvo@suselix>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the sake of completeness following are given the remaining sets of
kernbench results related to this thread.

Setup for kernbench test is as described in previous mails but now all
120 logical CPUs were online in all tests. Test runs were still pinned
to node 0.

Common legend for below tables is:

   OSCM: "OS Control Mode"
   DPSM: "Dynamic Power Savings Mode"
idle_rb: partial rollback of 554c8aa8ecad ("sched: idle: Select idle
         state before stopping the tick") as described in initial mail
         of this thread

(A) intel_pstate (in powersave mode) performance wrt effect of commit
    554c8aa8ecad and wrt to potential interference from platform code

 Kernel v4.18-rc5-36-g30b06abfb92b + patch for intel_pstate to load it
 instead of pcc-cpufreq when system is in DPSM.

 Detailed results for each number of compile jobs:
 (OSCM is baseline, values in parenthesis show comparison to baseline)

                    OSCM                OSCM                DPSM                DPSM
                                     idle_rb                                 idle_rb
 Amean  user-2    600.58   596.38 (   0.70%)   685.94 ( -14.21%)   688.78 ( -14.69%)
 Amean  user-4    583.90   586.34 (  -0.42%)   626.37 (  -7.27%)   622.17 (  -6.55%)
 Amean  user-8    584.78   581.52 (   0.56%)   600.89 (  -2.75%)   595.53 (  -1.84%)
 Amean  user-16   705.07   688.62 (   2.33%)   705.16 (  -0.01%)   682.44 (   3.21%)
 Amean  user-30  1017.25  1022.39 (  -0.51%)  1025.23 (  -0.78%)  1022.61 (  -0.53%)
 Amean  syst-2    172.17   174.08 (  -1.11%)   184.73 (  -7.30%)   186.13 (  -8.11%)
 Amean  syst-4    183.88   180.44 (   1.87%)   191.70 (  -4.25%)   192.24 (  -4.54%)
 Amean  syst-8    193.40   193.81 (  -0.21%)   198.01 (  -2.38%)   193.96 (  -0.29%)
 Amean  syst-16   183.97   180.40 (   1.94%)   184.00 (  -0.01%)   182.10 (   1.02%)
 Amean  syst-30   122.36   122.08 (   0.23%)   122.53 (  -0.14%)   122.17 (   0.15%)
 Amean  elsp-2    610.90   634.64 (  -3.89%)   667.67 (  -9.29%)   661.81 (  -8.33%)
 Amean  elsp-4    413.54   488.02 ( -18.01%)   433.79 (  -4.90%)   407.30 (   1.51%)
 Amean  elsp-8    261.85   218.25 (  16.65%)   246.62 (   5.82%)   219.55 (  16.15%)
 Amean  elsp-16    89.27    99.36 ( -11.30%)    92.74 (  -3.89%)   102.74 ( -15.09%)
 Amean  elsp-30    47.07    47.04 (   0.08%)    48.82 (  -3.72%)    48.28 (  -2.57%)
 Stddev user-2      6.06     7.53 ( -24.21%)    31.88 (-425.98%)    25.79 (-325.57%)
 Stddev user-4      7.05    14.48 (-105.40%)    11.82 ( -67.63%)    12.14 ( -72.22%)
 Stddev user-8      5.69     1.18 (  79.28%)    18.75 (-229.45%)     7.03 ( -23.51%)
 Stddev user-16     6.41    15.74 (-145.55%)    12.87 (-100.75%)    10.59 ( -65.19%)
 Stddev user-30     2.62     2.80 (  -6.56%)     2.92 ( -11.31%)     2.45 (   6.52%)
 Stddev syst-2      3.48     2.81 (  19.28%)     2.27 (  34.73%)     1.47 (  57.83%)
 Stddev syst-4      4.04     4.69 ( -16.03%)     2.16 (  46.42%)     0.84 (  79.32%)
 Stddev syst-8      3.96     1.42 (  64.11%)     2.34 (  40.98%)     1.93 (  51.24%)
 Stddev syst-16     2.01     2.33 ( -15.76%)     1.33 (  33.89%)     1.94 (   3.74%)
 Stddev syst-30     0.76     0.38 (  50.10%)     0.91 ( -19.48%)     0.17 (  77.86%)
 Stddev elsp-2     44.55    58.37 ( -31.01%)   110.11 (-147.15%)    82.81 ( -85.88%)
 Stddev elsp-4     62.39   109.75 ( -75.90%)    48.32 (  22.56%)    47.10 (  24.52%)
 Stddev elsp-8     59.01    25.95 (  56.02%)    71.44 ( -21.07%)    37.83 (  35.89%)
 Stddev elsp-16    10.47    23.88 (-128.08%)    11.98 ( -14.41%)    15.42 ( -47.32%)
 Stddev elsp-30     0.26     0.64 (-142.06%)     0.39 ( -46.53%)     0.44 ( -66.71%)

 Overall test time:

               OSCM     OSCM     DPSM     DPSM
                     idle_rb           idle_rb
 User      18681.59 18599.99 19450.38 19289.33
 System     4487.76  4458.55  4620.80  4595.13
 Elapsed    7407.07  7725.86  7765.91  7502.72

 Overall test run-time is comparable. Commit 554c8aa8ecad does not
 seem to have a significant impact on performance (I don't have
 numbers for power consumption). Comparing OSCM vs. DPSM: it seems
 that its better to switch system into OSCM.


(B) performance of intel_pstate (in powersave mode and system in DPSM)
    vs. pcc-cpufreq (with ondemand governor)

 Results for pcc-cpufreq were obtained with v4.17.5+misc modifications.

 intel_pstate results were obtained with v4.18-rc5-36-g30b06abfb92b +
 patch for intel_pstate to load it instead of pcc-cpufreq when system
 is in DPSM.

 So strictly speaking this is no correct comparison but at least it
 gives an idea where the limits are with pcc-cpufreq and why its
 better to just switch to intel_pstate.
 
 pcc-cpufreq driver modifications were

 freqtable: pcc-cpufreq modified to use fixed table of 4 frequencies
  deadband: pcc-cpufreq modified to re-introduce so called deadband
            effect which keeps CPU at minimum frequency if target
            frequency would be in the calculated deadband

           intel_pstate        pcc-cpufreq        pcc-cpufreq        pcc-cpufreq
                   DPSM            idle_rb  idle_rb+freqtable   idle_rb+deadband
 Amean  user-2   685.94  834.15 ( -21.61%)  648.68 (   5.43%)  636.63 (   7.19%)
 Amean  user-4   626.37  902.09 ( -44.02%)  657.43 (  -4.96%)  615.49 (   1.74%)
 Amean  user-8   600.89 1078.37 ( -79.46%)  723.05 ( -20.33%)  646.23 (  -7.55%)
 Amean  user-16  705.16 1640.89 (-132.70%) 1096.61 ( -55.51%)  904.17 ( -28.22%)
 Amean  user-30 1025.23 1463.90 ( -42.79%) 1156.17 ( -12.77%) 1151.40 ( -12.31%)
 Amean  syst-2   184.73  232.17 ( -25.68%)  178.24 (   3.51%)  172.09 (   6.84%)
 Amean  syst-4   191.70  257.22 ( -34.18%)  194.16 (  -1.29%)  188.10 (   1.88%)
 Amean  syst-8   198.01  313.67 ( -58.41%)  228.34 ( -15.31%)  206.99 (  -4.53%)
 Amean  syst-16  184.00  393.92 (-114.09%)  279.89 ( -52.12%)  241.83 ( -31.43%)
 Amean  syst-30  122.53  185.98 ( -51.79%)  143.28 ( -16.94%)  140.45 ( -14.62%)
 Amean  elsp-2   667.67  769.28 ( -15.22%)  635.68 (   4.79%)  651.51 (   2.42%)
 Amean  elsp-4   433.79  614.27 ( -41.60%)  440.45 (  -1.53%)  392.80 (   9.45%)
 Amean  elsp-8   246.62  397.54 ( -61.19%)  252.27 (  -2.29%)  239.21 (   3.01%)
 Amean  elsp-16   92.74  207.43 (-123.68%)  138.00 ( -48.81%)  119.98 ( -29.37%)
 Amean  elsp-30   48.82   72.66 ( -48.83%)   55.95 ( -14.60%)   54.32 ( -11.27%)
 Stddev user-2    31.88   15.22 (  52.26%)    7.77 (  75.63%)    6.63 (  79.21%)
 Stddev user-4    11.82   32.20 (-172.49%)    3.37 (  71.44%)    6.44 (  45.49%)
 Stddev user-8    18.75   33.99 ( -81.29%)    6.96 (  62.86%)    5.82 (  68.97%)
 Stddev user-16   12.87   70.72 (-449.46%)   31.19 (-142.30%)   28.88 (-124.40%)
 Stddev user-30    2.92   26.08 (-792.64%)    6.16 (-110.99%)   10.90 (-273.16%)
 Stddev syst-2     2.27    4.44 ( -95.54%)    4.15 ( -82.48%)    2.09 (   8.11%)
 Stddev syst-4     2.16    8.46 (-290.74%)    3.71 ( -71.58%)    2.45 ( -12.99%)
 Stddev syst-8     2.34   10.73 (-359.70%)    3.98 ( -70.62%)    4.39 ( -87.80%)
 Stddev syst-16    1.33   11.44 (-759.46%)    2.14 ( -60.49%)    2.93 (-120.24%)
 Stddev syst-30    0.91    4.88 (-436.79%)    1.37 ( -50.11%)    2.36 (-159.71%)
 Stddev elsp-2   110.11   85.53 (  22.32%)   87.11 (  20.89%)   37.33 (  66.10%)
 Stddev elsp-4    48.32  130.17 (-169.39%)   59.81 ( -23.79%)   26.15 (  45.88%)
 Stddev elsp-8    71.44   86.47 ( -21.03%)   12.87 (  81.98%)   43.88 (  38.58%)
 Stddev elsp-16   11.98   13.63 ( -13.82%)    8.94 (  25.35%)    5.97 (  50.15%)
 Stddev elsp-30    0.39    2.64 (-582.23%)    0.62 ( -58.97%)    0.95 (-144.47%)

         intel_pstate pcc-cpufreq pcc-cpufreq pcc-cpufreq
                 DPSM     idle_rb    idle_rb+    idle_rb+
                                    freqtable    deadband
 User        19450.38    31273.96    22689.14    21050.35
 System       4620.80     7327.67     5364.63     4984.36
 Elapsed      7765.91    10997.49     7935.53     7593.74

 Again I have no numbers for power consumption.

 Note that I've stopped an attempt to collect results for pcc-cpufreq
 with unmodififed v4.17.5 (ie. w/o idle_rb) after the first iteration
 (compiling kernel with 2 jobs) took several hours.


Andreas
