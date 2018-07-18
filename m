Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B8F2ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 15:26:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3DA820850
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 15:26:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3DA820850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731104AbeGRQEd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 12:04:33 -0400
Received: from smtp.nue.novell.com ([195.135.221.5]:41950 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730684AbeGRQEd (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Wed, 18 Jul 2018 12:04:33 -0400
Received: from emea4-mta.ukb.novell.com ([10.120.13.87])
        by smtp.nue.novell.com with ESMTP (TLS encrypted); Wed, 18 Jul 2018 17:26:05 +0200
Received: from suselix (nwb-a10-snat.microfocus.com [10.120.13.201])
        by emea4-mta.ukb.novell.com with ESMTP (TLS encrypted); Wed, 18 Jul 2018 16:25:58 +0100
Date:   Wed, 18 Jul 2018 17:25:56 +0200
From:   Andreas Herrmann <aherrmann@suse.com>
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Commit 554c8aa8ecad causing severe performance degression with
 pcc-cpufreq
Message-ID: <20180718152556.5rydmdt7wlgpr5uk@suselix>
References: <20180717065048.74mmgk4t5utjaa6a@suselix>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180717065048.74mmgk4t5utjaa6a@suselix>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I think I still owe some performance numbers to show what is wrong
with systems using pcc-cpufreq with Linux after commit 554c8aa8ecad.

Following are results for kernbench tests (from MMTests test suite).
That's just a kernel compile with different number of compile jobs.
As result the time is measured, 5 runs are done for each configuration and
average values calculated.

I've restricted maximum number of jobs to 30. That means that tests
were done for 2, 4, 8, 16, and 30 compile jobs. I had bound all tests
to node 0. (I've used something like "numactl -N 0 ./run-mmtests.sh
--run-monitor <test_name>" to start those tests.)

Tests were done with kernel 4.18.0-rc3 on an HP DL580 Gen8 with Intel
Xeon CPU E7-4890 with latest BIOS installed. System had 4 nodes, 15
CPUs per node (30 logical CPUs with HT enabled). pcc-cpufreq was
active and ondemand governor in use.

I've tested with different number of online CPUs which better
illustrates how idle online CPUs interfere with compile load on node 0
(due to the jitter caused by pcc-cpufreq and its locking).

Average mean for user/system/elapsed time and standard deviation for each
subtest (=number of compile jobs) are as follows:

(Nodes)                      N0                N01                   N0                  N01                 N0123
 (CPUs)                  15CPUs             30CPUs               30CPUs               60CPUs               120CPUs
Amean   user-2   640.82 (0.00%)  675.90   (-5.47%)   789.03   (-23.13%)  1448.58  (-126.05%)  3575.79   (-458.01%)
Amean   user-4   652.18 (0.00%)  689.12   (-5.67%)   868.19   (-33.12%)  1846.66  (-183.15%)  5437.37   (-733.73%)
Amean   user-8   695.00 (0.00%)  732.22   (-5.35%)  1138.30   (-63.78%)  2598.74  (-273.92%)  7413.43   (-966.67%)
Amean   user-16  653.94 (0.00%)  772.48  (-18.13%)  1734.80  (-165.29%)  2699.65  (-312.83%)  9224.47  (-1310.61%)
Amean   user-30  634.91 (0.00%)  701.11  (-10.43%)  1197.37   (-88.59%)  1360.02  (-114.21%)  3732.34   (-487.85%)
Amean   syst-2   235.45 (0.00%)  235.68   (-0.10%)   321.99   (-36.76%)   574.44  (-143.98%)   869.35   (-269.23%)
Amean   syst-4   239.34 (0.00%)  243.09   (-1.57%)   345.07   (-44.18%)   621.00  (-159.47%)  1145.13   (-378.46%)
Amean   syst-8   246.51 (0.00%)  254.83   (-3.37%)   387.49   (-57.19%)   786.63  (-219.10%)  1406.17   (-470.42%)
Amean   syst-16  110.85 (0.00%)  122.21  (-10.25%)   408.25  (-268.31%)   644.41  (-481.36%)  1513.04  (-1264.99%)
Amean   syst-30   82.74 (0.00%)   94.07  (-13.69%)   155.38   (-87.80%)   207.03  (-150.22%)   547.73   (-562.01%)
Amean   elsp-2   625.33 (0.00%)  724.51  (-15.86%)   792.47   (-26.73%)  1537.44  (-145.86%)  3510.22   (-461.34%)
Amean   elsp-4   482.02 (0.00%)  568.26  (-17.89%)   670.26   (-39.05%)  1257.34  (-160.85%)  3120.89   (-547.46%)
Amean   elsp-8   267.75 (0.00%)  337.88  (-26.19%)   430.56   (-60.80%)   978.47  (-265.44%)  2321.91   (-767.18%)
Amean   elsp-16   63.55 (0.00%)   71.79  (-12.97%)   224.83  (-253.79%)   403.94  (-535.65%)  1121.04  (-1664.09%)
Amean   elsp-30   56.76 (0.00%)   62.82  (-10.69%)    66.50   (-17.16%)   124.20  (-118.84%)   303.47   (-434.70%)
Stddev  user-2     1.36 (0.00%)    1.94  (-42.57%)    16.17 (-1090.46%)   119.09 (-8669.75%)   382.74 (-28085.60%)
Stddev  user-4     2.81 (0.00%)    5.08  (-80.78%)     4.88   (-73.66%)   252.56 (-8881.80%)  1133.02 (-40193.16%)
Stddev  user-8     2.30 (0.00%)   15.58 (-578.28%)    30.60 (-1232.63%)   279.35 (-12064.01%) 1050.00 (-45621.61%)
Stddev  user-16    6.76 (0.00%)   25.52 (-277.80%)    78.44 (-1060.97%)   118.29 (-1650.94%)   724.11 (-10617.95%)
Stddev  user-30    0.51 (0.00%)    1.80 (-249.13%)    12.63 (-2354.11%)    25.82 (-4915.43%)  1098.82 (-213365.28%)
Stddev  syst-2     1.52 (0.00%)    2.76  (-81.04%)     3.98  (-161.58%)    36.35 (-2287.16%)    59.09  (-3781.09%)
Stddev  syst-4     2.39 (0.00%)    1.55   (35.25%)     3.24  ( -35.92%)    51.51 (-2057.65%)   175.75  (-7262.43%)
Stddev  syst-8     1.08 (0.00%)    3.70 (-241.40%)     6.83  (-531.33%)    65.80 (-5977.97%)   151.17 (-13864.10%)
Stddev  syst-16    3.78 (0.00%)    5.58  (-47.53%)     4.63  ( -22.44%)    47.90 (-1167.18%)    99.94  (-2543.88%)
Stddev  syst-30    0.31 (0.00%)    0.38  (-22.41%)     3.01  (-862.79%)    27.45 (-8688.85%)   137.94 (-44072.77%)
Stddev  elsp-2    55.14 (0.00%)   55.04    (0.18%)    95.33  ( -72.90%)   103.91   (-88.45%)   302.31   (-448.29%)
Stddev  elsp-4    60.90 (0.00%)   84.42  (-38.62%)    18.92  (  68.94%)   197.60  (-224.46%)   323.53   (-431.24%)
Stddev  elsp-8    16.77 (0.00%)   30.77  (-83.47%)    49.57  (-195.57%)    79.02  (-371.16%)   261.85  (-1461.28%)
Stddev  elsp-16    1.99 (0.00%)    2.88  (-44.60%)    28.11 (-1311.79%)   101.81 (-5012.88%)    62.29  (-3028.36%)
Stddev  elsp-30    0.65 (0.00%)    1.04  (-59.06%)     1.64  (-151.81%)    41.84 (-6308.81%)    75.37 (-11445.61%)

Overall test time for each mmtests invocation was as follows (this is
also given for number-of-cpu configs for which I did not provide
details above).

               N0      N01       N0     N012    N0123      N01    N0123    N0123     N012    N0123     N0123
           15CPUs   30CPUs   30CPUs   45CPUs   60CPUs   60CPUs   75CPUs   90CPUs   90CPUs  105CPUs   120CPUs
User     17196.67 18714.36 30105.65 19239.27 19505.35 53089.39 22690.33 26731.06 38131.74 47627.61 153424.99
System    4807.98  4970.89  8533.95  5136.97  5184.24 16351.67  6135.29  7152.66 10920.76 12362.39  32129.74
Elapsed   7796.46  9166.55 11518.51  9274.77  9030.39 25465.38  9361.60 10677.63 15633.49 18900.46  60908.28

The results given for 120 online CPUs on nodes 0-3 indicate what I
meant with the "system being almost unusable". When trying to gather
results with kernel 4.17.5 and 120 CPUs, one iteration of kernbench (1
kernel compile) with 2 jobs even took about 6 hours. Maybe it was an
extreme outlier but I dismissed to further use that kernel (w/o
modifications) for further tests.


Andreas
