Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0E95ECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 06:57:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CEBC2145D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 06:57:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CEBC2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=chris-wilson.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727583AbeJRO5I convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 10:57:08 -0400
Received: from mail.fireflyinternet.com ([109.228.58.192]:52848 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727337AbeJRO5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 10:57:08 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 14143354-1500050 
        for multiple; Thu, 18 Oct 2018 07:56:48 +0100
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     Kuo-Hsin Yang <vovoy@chromium.org>,
        Michal Hocko <mhocko@kernel.org>
From:   Chris Wilson <chris@chris-wilson.co.uk>
In-Reply-To: <153971466599.22931.16793398326492316920@skylake-alporthouse-com>
Cc:     linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        peterz@infradead.org, dave.hansen@intel.com, corbet@lwn.net,
        hughd@google.com, joonas.lahtinen@linux.intel.com,
        marcheu@chromium.org, hoegsberg@chromium.org
References: <20181016174300.197906-1-vovoy@chromium.org>
 <20181016174300.197906-3-vovoy@chromium.org>
 <20181016182155.GW18839@dhcp22.suse.cz>
 <153971466599.22931.16793398326492316920@skylake-alporthouse-com>
Message-ID: <153984580501.19935.11456945882099910977@skylake-alporthouse-com>
User-Agent: alot/0.6
Subject: Re: [PATCH 2/2] drm/i915: Mark pinned shmemfs pages as unevictable
Date:   Thu, 18 Oct 2018 07:56:45 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Chris Wilson (2018-10-16 19:31:06)
> Fwiw, the shmem_unlock_mapping() call feels quite expensive, almost
> nullifying the advantage gained from not walking the lists in reclaim.
> I'll have better numbers in a couple of days.

Using a test ("igt/benchmarks/gem_syslatency -t 120 -b -m" on kbl)
consisting of cycletest with a background load of trying to allocate +
populate 2MiB (to hit thp) while catting all files to /dev/null, the
result of using mapping_set_unevictable is mixed.

Each test run consists of running cycletest for 120s measuring the mean
and maximum wakeup latency and then repeating that 120 times.

x baseline-mean.txt # no i915 activity
+ tip-mean.txt # current stock i915 with a continuous load
+------------------------------------------------------------------------+
| x      +                                                               |
| x      +                                                               |
|xx      +                                                               |
|xx      +                                                               |
|xx      +                                                               |
|xx     ++                                                               |
|xx    +++                                                               |
|xx    +++                                                               |
|xx    +++                                                               |
|xx    +++                                                               |
|xx    +++                                                               |
|xx    ++++                                                              |
|xx   +++++                                                              |
|xx  ++++++                                                              |
|xx  ++++++                                                              |
|xx  ++++++                                                              |
|xx  ++++++                                                              |
|xx  ++++++                                                              |
|xx  +++++++ +                                                           |
|xx ++++++++ +                                                           |
|xx ++++++++++                                                           |
|xx+++++++++++ +     +                                                   |
|xx+++++++++++ +     +  +          +      +       ++                    +|
| A                                                                      |
||______M_A_________|                                                    |
+------------------------------------------------------------------------+
    N           Min           Max        Median           Avg        Stddev
x 120       359.153       876.915       863.548     778.80319     186.15875
+ 120      2475.318     73172.303      7666.812     9579.4671      9552.865

Our target then is 863us, but currently i915 adds 7ms of uninterruptable
delay on hitting the shrinker.

x baseline-mean.txt
+ mapping-mean.txt # applying the mapping_set_evictable patch
* tip-mean.txt
+------------------------------------------------------------------------+
| x      *         +                                                     |
| x      *         +                                                     |
|xx      *         +                                                     |
|xx      *         +                                                     |
|xx      *         +                                                     |
|xx     **         +                                                     |
|xx    ***         ++                                                    |
|xx    ***         ++                                                    |
|xx    ***         ++                                                    |
|xx    ***         ++                                                    |
|xx    ***         ++                                                    |
|xx    ****  +     ++                                                    |
|xx   *****+ ++    ++                                                    |
|xx  ******+ ++    ++                                                    |
|xx  ******+ ++  + ++                                                    |
|xx  ******+ ++  + ++                                                    |
|xx  ******+ ++  ++++                                                    |
|xx  ******+ ++  ++++                                                    |
|xx  ******* *+  ++++                                                    |
|xx ******** *+ +++++                                                    |
|xx **********+ +++++                                                    |
|xx***********+*+++++*                                                   |
|xx***********+*+++++*  *  +       *      *       **                    *|
| A                                                                      |
|          |___AM___|                                                    |
||______M_A_________|                                                    |
+------------------------------------------------------------------------+
    N           Min           Max        Median           Avg        Stddev
x 120       359.153       876.915       863.548     778.80319     186.15875
+ 120      3291.633     26644.894     15829.186     14654.781     4466.6997
* 120      2475.318     73172.303      7666.812     9579.4671      9552.865

Shows that if we use the mapping_set_evictable() +
shmem_unlock_mapping() we add a further 8ms uninterruptable delay to the
system... That's the opposite of our goal! ;)

x baseline-mean.txt
+ lock_vma-mean.txt # the old approach of pinning each page
* tip-mean.txt
+------------------------------------------------------------------------+
| *+     *                                                               |
| *+   * *                                                               |
| *+   * *                                                               |
| *+   * *                                                               |
| *+   ***                                                               |
| *+   ***                                                               |
| *+   ***                                                               |
| *+   ***                                                               |
| *+   ***                                                               |
| *+   ***                                                               |
| *+   ***                                                               |
| *+   ****                                                              |
| *+  *****                                                              |
| *+  ******                                                             |
| *+  ****** *                                                           |
| *+  ****** *                                                           |
| *+ ******* *                                                           |
| *+******** *                                                           |
| *+******** *                                                           |
| *+******** *                                                           |
| *+******** * *     *                                                   |
| *+******** * *   + *  *          *      *       * *                   *|
| A                                                                      |
||MA|                                                                    |
||_______M_A________|                                                    |
+------------------------------------------------------------------------+
    N           Min           Max        Median           Avg        Stddev
x 120       359.153       876.915       863.548     778.80319     186.15875
+ 120       511.415     18757.367      1276.302     1416.0016     1679.3965
* 120      2475.318     73172.303      7666.812     9579.4671      9552.865

By contrast, the previous approach of using mlock_page_vma() does
dramatically reduce the uninterruptable delay -- which suggests that the
mapping_set_evictable() isn't keeping our unshrinkable pages off the
shrinker lru.

However, if instead of looking at the average uninterruptable delay
during the 120s of cycletest, but look at the worst case, things get a
little more interesting. Currently i915 is terrible.

x baseline-max.txt
+ tip-max.txt
+------------------------------------------------------------------------+
|      *                                                                 |
[snip 100 lines]
|      *                                                                 |
|      *                                                                 |
|      *                                                                 |
|      *                                                                 |
|      *                                                                 |
|      *                                                                 |
|      *                                                                 |
|      *                                                                 |
|      * +++      ++ +           +  +      +                            +|
|      A                                                                 |
||_____M_A_______|                                                       |
+------------------------------------------------------------------------+
    N           Min           Max        Median           Avg        Stddev
x 120          7391         58543         51953     51564.033     5044.6375
+ 120       2284928  6.752085e+08       3385097      20825362      80352645

Worst case with no i915 is 52ms, but as soon as we load up i915 with
some work, the worst case uninterruptable delay is on average 20s!!! As
suggested by the median, the data is severely skewed by a few outliers.
(Worst worst case is so bad khungtaskd often makes an appearance.)

x baseline-max.txt
+ mapping-max.txt
* tip-max.txt
+------------------------------------------------------------------------+
|      *                                                                 |
[snip 100 lines]
|      *                                                                 |
|      *                                                                 |
|      *                                                                 |
|      *                                                                 |
|      *                                                                 |
|      *                                                                 |
|      *                                                                 |
|      *+                                                                |
|      *+***      ** *           * +*      *                            *|
|      A                                                                 |
|    |_A__|                                                              |
||_____M_A_______|                                                       |
+------------------------------------------------------------------------+
    N           Min           Max        Median           Avg        Stddev
x 120          7391         58543         51953     51564.033     5044.6375
+ 120       3088140 2.9181602e+08       4022581     6528993.3      26278426
* 120       2284928  6.752085e+08       3385097      20825362      80352645

So while the mapping_set_evictable patch did reduce the maximum observed
delay within the 4 hour sample, on average (median, to exclude those worst
worst case outliers) it still fares worse than stock i915. The
mlock_page_vma() has no impact on worst case wrt stock.

My conclusion is that the mapping_set_evictable patch makes both the
average and worst case uninterruptable latency (as observed by other
users of the system) significantly worse. (Although the maximum latency
is not stable enough to draw a real conclusion other than i915 is
shockingly terrible.)
-Chris
