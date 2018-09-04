Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02780C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 17:50:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4CBD206BA
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 17:50:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4CBD206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727744AbeIDWQ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 18:16:58 -0400
Received: from mga01.intel.com ([192.55.52.88]:33428 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726304AbeIDWQ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 18:16:58 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Sep 2018 10:50:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,329,1531810800"; 
   d="scan'208";a="87110178"
Received: from spandruv-desk.jf.intel.com ([10.54.75.31])
  by fmsmga001.fm.intel.com with ESMTP; 04 Sep 2018 10:50:08 -0700
Message-ID: <b48340f59011bc3d7402b6a811bce4fa861fab7b.camel@linux.intel.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: Optimize IO boost in non HWP mode
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Francisco Jerez <currojerez@riseup.net>,
        Eero Tamminen <eero.t.tamminen@intel.com>, lenb@kernel.org,
        rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc:     mgorman@techsingularity.net, ggherdovich@suse.cz,
        peterz@infradead.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 04 Sep 2018 10:50:08 -0700
In-Reply-To: <8736upda8s.fsf@riseup.net>
References: <20180831172851.79812-1-srinivas.pandruvada@linux.intel.com>
         <1244c5d6-460e-0e0b-b7bf-a46e73327383@intel.com>
         <8736upda8s.fsf@riseup.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.2 (3.28.2-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-09-03 at 23:53 -0700, Francisco Jerez wrote:
> Eero Tamminen <eero.t.tamminen@intel.com> writes:
> 
> > Hi,
> > 
> > On 31.08.2018 20:28, Srinivas Pandruvada wrote:
> > ...
> > > As per testing Eero Tamminen, the results are comparable to the
> > > patchset
> > > https://patchwork.kernel.org/patch/10312259/
> > > But he has to watch results for several days to check trend.
> > 
> > It's close, but there is some gap compared to Francisco's version.
> > 
> > (Because of the large variance on TDP limited devices, and factors 
> > causing extra perf differences e.g. between boots, it's hard to
> > give 
> > exact number without having trends from several days / weeks.  I
> > would 
> > also need new version of Fransisco's patch set that applies to
> > latest 
> > kernel like yours does.)
> > 
> > 
> > > Since here boost is getting limited to turbo and non turbo, we
> > > need some
> > > ways to adjust the fractions corresponding to max non turbo as
> > > well. It
> > > is much easier to use the actual P-state limits for boost instead
> > > of
> > > fractions. So here P-state io boost limit is applied on top of
> > > the
> > > P-state limit calculated via current algorithm by removing
> > > current
> > > io_wait boost calculation using fractions.
> > > 
> > > Since we prefer to use common algorithm for all processor
> > > platforms, this
> > > change was tested on other client and sever platforms as well.
> > > All results
> > > were within the margin of errors. Results:
> > > https://bugzilla.kernel.org/attachment.cgi?id=278149
> > 
> > Good.
> > 
> > Francisco, how well the listed PTS tests cover latency bound cases
> > you 
> > were concerned about?  [1]
> > 
> > 
> > 	- Eero
> > 
> > [1] Fransisco was concerned that the patch:
> > * trade-off might regress latency bound cases (which I haven't
> > tested, I 
> > tested only 3D throughput), and
> > * that it addressed only other of the sources of energy
> > inefficiencies 
> > he had identified (which could explain slightly better 3D results
> > from 
> > his more complex patch set).
> 
> This patch causes a number of statistically significant regressions
> (with significance of 1%) on the two systems I've tested it on.  On
> my
Sure. These patches are targeted to Atom clients where some of these
server like workload may have some minor regression on few watts TDP
parts. But weighing against reduced TURBO usage (which is enough
trigger) and improvement in tests done by Eero (which was primary
complaint to us).

It is trivial patch. Yes, the patch is not perfect and doesn't close
doors for any improvements.

I see your idea, but how to implement in acceptable way is a challenge.
So ultimately we will get there, but will require some time compared
with other high priority items.


Thanks
Srinivas

> CHV N3050:
> 
> > phoronix/fs-
> > mark/test=0:                                                       
> > XXX ±7.25% x34 -> XXX ±7.00% x39  d=-36.85% ±5.91%  p=0.00%
> > phoronix/sqlite:                                                   
> >             XXX ±1.86% x34 -> XXX ±1.88% x39  d=-21.73%
> > ±1.66%  p=0.00%
> > warsow/benchsow:                                                   
> >             XXX ±1.25% x34 -> XXX ±1.95% x39  d=-10.83%
> > ±1.53%  p=0.00%
> > phoronix/iozone/record-size=4Kb/file-size=2GB/test=Read
> > Performance:           XXX ±1.70% x31 -> XXX ±1.02% x34  d=-7.39%
> > ±1.36%   p=0.00%
> > phoronix/gtkperf/gtk-
> > test=GtkComboBox:                                         XXX
> > ±1.15% x13 -> XXX ±1.59% x14   d=-5.37% ±1.35%  p=0.00%
> > lightsmark:                                                        
> >             XXX ±1.45% x34 -> XXX ±0.97% x41   d=-4.66%
> > ±1.19%  p=0.00%
> > jxrendermark/rendering-test=Transformed Blit Bilinear/rendering-
> > size=128x128:  XXX ±1.04% x31 -> XXX ±1.04% x39   d=-4.58%
> > ±1.01%  p=0.00%
> > jxrendermark/rendering-test=Linear Gradient Blend/rendering-
> > size=128x128:      XXX ±0.12% x31 -> XXX ±0.19% x39   d=-3.60%
> > ±0.16%  p=0.00%
> > dbench/client-
> > count=1:                                                         XX
> > X ±0.50% x34 -> XXX ±0.50% x39   d=-2.51% ±0.49%  p=0.00%
> 
> On my BXT J3455:
> 
> > fs-
> > mark/test=0:                                                       
> >          XXX ±3.04% x6 ->   XXX ±3.05% x9  d=-15.96%
> > ±2.76%  p=0.00%
> > sqlite:                                                            
> >             XXX ±2.54% x6 ->   XXX ±2.72% x9  d=-12.42%
> > ±2.44%  p=0.00%
> > dbench/client-
> > count=1:                                                         XX
> > X ±0.42% x6 ->   XXX ±0.36% x9   d=-6.52% ±0.37%  p=0.00%
> > dbench/client-
> > count=2:                                                         XX
> > X ±0.26% x6 ->   XXX ±0.33% x9   d=-5.22% ±0.29%  p=0.00%
> > dbench/client-
> > count=3:                                                         XX
> > X ±0.34% x6 ->   XXX ±0.53% x9   d=-2.92% ±0.45%  p=0.00%
> > x11perf/test=500px Compositing From Pixmap To
> > Window:                          XXX ±2.29% x16 ->  XXX ±2.11%
> > x19  d=-2.69% ±2.16%  p=0.09%
> > lightsmark:                                                        
> >             XXX ±0.44% x6 ->   XXX ±0.33% x9   d=-1.76%
> > ±0.37%  p=0.00%
> > j2dbench/rendering-test=Vector Graphics
> > Rendering:                             XXX ±1.18% x16 ->  XXX
> > ±1.82% x19  d=-1.71% ±1.54%  p=0.26%
> > gtkperf/gtk-
> > test=GtkComboBox:                                                  
> > XXX ±0.37% x6 ->   XXX ±0.45% x9   d=-0.95% ±0.42%  p=0.08%
> > jxrendermark/rendering-test=Transformed Blit Bilinear/rendering-
> > size=128x128:  XXX ±0.21% x3 ->   XXX ±0.23% x6   d=-0.87%
> > ±0.22%  p=0.08%
> 
> This is not surprising given that the patch is making a hard trade-
> off
> between latency and energy efficiency without considering whether the
> workload is IO- or latency-bound, which is the reason why the series
> I
> submitted earlier [1] to address this problem implemented an IO
> utilization statistic in order to determine whether the workload is
> IO-bound, in which case the latency trade-off wouldn't impact
> performance negatively.
> 
> Aside from that the improvement in graphics throughput seems like a
> small fraction of the series [1] while TDP-bound.  E.g. with this
> patch
> on my BXT J3455:
> 
> > unigine/heaven:           XXX ±0.21% x3 -> XXX ±0.19% x6  d=1.18%
> > ±0.19%  p=0.01%
> > unigine/valley:           XXX ±0.52% x3 -> XXX ±0.28% x6  d=1.56%
> > ±0.37%  p=0.06%
> > gfxbench/gl_manhattan31:  XXX ±0.12% x3 -> XXX ±0.21% x6  d=1.64%
> > ±0.19%  p=0.00%
> > gfxbench/gl_trex:         XXX ±0.56% x3 -> XXX ±0.36% x6  d=7.07%
> > ±0.44%  p=0.00%
> 
> vs. my series on the same system:
> 
> > gfxbench/gl_manhattan31:  XXX ±0.37% x3 -> XXX ±0.08% x3  d=7.30%
> > ±0.27%  p=0.00%
> > unigine/heaven:           XXX ±0.47% x3 -> XXX ±0.40% x3  d=7.99%
> > ±0.45%  p=0.00%
> > unigine/valley:           XXX ±0.35% x3 -> XXX ±0.50% x3  d=8.24%
> > ±0.45%  p=0.00%
> > gfxbench/gl_trex:         XXX ±0.15% x3 -> XXX ±0.26% x3  d=9.12%
> > ±0.23%  p=0.00%
> 
> That's not surprising either considering that this patch is only
> addressing one of the two reasons the current non-HWP intel_pstate
> governor behaves inefficiently (see [1] for more details on the other
> reason).  And even that is only partially addressed since the
> heuristic
> implemented in this patch in order to decide the degree of IOWAIT
> boosting to apply can and will frequently trigger in heavily GPU-
> bound
> cases, which will cause the task to IOWAIT on the GPU frequently,
> causing the P-state controller to waste shared TDP for no benefit.
> 
> [1] https://lists.freedesktop.org/archives/intel-gfx/2018-March/16053
> 2.html
