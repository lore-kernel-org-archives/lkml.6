Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07903C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 18:20:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC6DA206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 18:20:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC6DA206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbeI2Ape (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 20:45:34 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:54973 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbeI2Apd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 20:45:33 -0400
Received: from p5492e4c1.dip0.t-ipconnect.de ([84.146.228.193] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1g5xNN-0003pi-Im; Fri, 28 Sep 2018 20:20:29 +0200
Date:   Fri, 28 Sep 2018 20:20:28 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
cc:     Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>,
        Tvrtko Ursulin <tursulin@ursulin.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [RFC 0/5] perf: Per PMU access controls (paranoid setting)
In-Reply-To: <0feb9867-0040-0306-a95b-4b6df1818312@linux.intel.com>
Message-ID: <alpine.DEB.2.21.1809281932040.1432@nanos.tec.linutronix.de>
References: <20180919122751.12439-1-tvrtko.ursulin@linux.intel.com> <alpine.DEB.2.21.1809281151190.2004@nanos.tec.linutronix.de> <e89ec139-1a97-803e-343c-76eedf244d65@linux.intel.com> <alpine.DEB.2.21.1809281542180.2004@nanos.tec.linutronix.de>
 <0feb9867-0040-0306-a95b-4b6df1818312@linux.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alexey,

On Fri, 28 Sep 2018, Alexey Budankov wrote:
> On 28.09.2018 17:02, Thomas Gleixner wrote:
> > But this does also require a proper analysis and documentation why it is
> > not a security risk to expose the i915 PMU or what potential security
> > issues this can create, so that the competent sysadmin can make a
> > judgement.
> > 
> > And the same is required for all other PMUs which can be enabled in the
> > same way for unprivileged access. And we might as well come to the
> > conclusion via analysis that for some PMUs unpriviledged access is just not
> > a good idea and exclude them. I surely know a few which qualify for
> > exclusion, so the right approach is to provide this knob only when the risk
> > is analyzed and documented and the PMU has been flagged as candidate for
> > unpriviledged exposure. I.e. opt in and not opt out.
> 
> If you ask me then, IMHO, unprivileged access to CBOX pmu looks unsafe 
> and is now governed by traditional *core* perf_event_paranoid setting.
> 
> But *core* paranoid >= 1 (per-process mode) prevents simultaneous perf 
> record sampling and perf stat -I reading from IMC, UPI, PCIe and other 
> uncore counters.
> 
> This kind of monitoring could make process performance observability 
> thru Perf subsystem more flexible and better tailored for cloud and 
> cluster environments. However it requires fine-tuning control 
> capabilities in order to still keep system as secure as possible.
> 
> Could i915, IMC, UPI, PCIe pmus be safe enough to be governed by 
> a separate perf_event_paranoid settings?

Just to make it clear. I'm not against separate settings at all. But I'm
against adding knobs for every PMU the kernel supports wholesale without
analysis and documentation just because we can and somebody wants it.

Right now we have a single knob, which is poorly documented and that should
be fixed first. But some googling gives you the information that allowing
unprivilegded access is a security risk. So the security focussed sysadmin
will deny access to the PMUs no matter what.

Now we add more knobs without documentation what the exposure and risk of
each PMU is. The proposed patch set does this wholesale for every PMU
supported by the kernel. So the GPU user will ask the sysadmin to allow him
access. How can he make an informed decision? If he grants it then the next
user comes around and wants it for something else arguing that the other
got it for the GPU already. How can he make an informed decision about
that one?

We provide the knobs, so it's also our responsibility towards our users to
give them the information about their usage and scope. And every single PMU
knob has a different scope.

The documentation of the gazillion of knobs in /proc and /sysfs is not
really brilliant, but we should really not continue this bad practice
especially not when these knobs have potentially security relevant
implcations. Yes, I know, writing documentation is work, but it's valuable
and is appreciated by our users.

To make this doable and not blocked by requiring every PMU to be analyzed
and documented at once, I suggested to make this opt-in. Do analysis for a
given PMU, decide whether it should be exposed at all. If so, document it
proper and flip the bit. That way this can be done gradually as the need
arises and we can exclude the riskier ones completely.

I don't think this is an unreasonable request as it does not require the
i915 folks to look at PMUs they are not familiar with and does not get
blocked by waiting on every PMU wizard on the planet to have time.

Start with something like Documentation/admin-guide/perf-security.rst or
whatever name fits better and add a proper documentation for the existing
knob. With the infrastructure for fine grained access control add the
general explanation for fine grained access control. With each PMU which
opt's in for the knob, add a section with guidance about scope and risk for
this particular one.

Thanks,

	tglx


