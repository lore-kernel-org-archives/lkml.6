Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6559C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 13:04:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DAC5222E3
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 13:04:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727943AbfBPMz4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Feb 2019 07:55:56 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:54426 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbfBPMz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Feb 2019 07:55:56 -0500
Received: from p5492e0d8.dip0.t-ipconnect.de ([84.146.224.216] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1guzVN-0004yB-J7; Sat, 16 Feb 2019 13:55:41 +0100
Date:   Sat, 16 Feb 2019 13:55:41 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Li, Aubrey" <aubrey.li@linux.intel.com>
cc:     mingo@redhat.com, peterz@infradead.org, hpa@zytor.com,
        ak@linux.intel.com, tim.c.chen@linux.intel.com,
        dave.hansen@intel.com, arjan@linux.intel.com, aubrey.li@intel.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 2/3] x86,/proc/pid/status: Add AVX-512 usage elapsed
 time
In-Reply-To: <85b22e16-fffc-7ebe-2ab1-3b6fe7e036ab@linux.intel.com>
Message-ID: <alpine.DEB.2.21.1902161340320.1683@nanos.tec.linutronix.de>
References: <20190213023748.6614-1-aubrey.li@linux.intel.com> <20190213023748.6614-2-aubrey.li@linux.intel.com> <alpine.DEB.2.21.1902141212400.1561@nanos.tec.linutronix.de> <85b22e16-fffc-7ebe-2ab1-3b6fe7e036ab@linux.intel.com>
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

On Fri, 15 Feb 2019, Li, Aubrey wrote:
> On 2019/2/14 19:29, Thomas Gleixner wrote:
> Under this scenario, the elapsed time becomes longer than normal indeed, see below:
> 
> $ while [ 1 ]; do cat /proc/6985/status | grep AVX; sleep 1; done
> AVX512_elapsed_ms:	3432
> AVX512_elapsed_ms:	440
> AVX512_elapsed_ms:	1444
> AVX512_elapsed_ms:	2448
> AVX512_elapsed_ms:	3456
> AVX512_elapsed_ms:	460
> AVX512_elapsed_ms:	1464
> AVX512_elapsed_ms:	2468
> 
> But AFAIK, google's Heracles do a 15s polling, so this worst case is still acceptable.?

I have no idea what Google's thingy does and you surely have to ask those
people who want to use this whether they are OK with that. I personally
think the numbers are largely useless, but I don't know the use case.

> >IOW, this needs crystal ball magic to decode because
> > there is no correlation between that elapsed time and the time when the
> > last context switch happened simply because that time is not available in
> > /proc/$PID/status. Sure you can oracle it out from /proc/$PID/stat with
> > even more crystal ball magic, but there is no explanation at all.
> > 
> > There may be use case scenarios where this crystal ball prediction is
> > actually useful, but the inaccuracy of that information and the possible
> > pitfalls for any user space application which uses it need to be documented
> > in detail. Without that, this is going to cause more trouble and confusion
> > than benefit.
> > 
> Not sure if the above experiment addressed your concern, please correct me if
> I totally misunderstood.

The above experiment just confirms what I said: The numbers are inaccurate
and potentially misleading to a large extent when the AVX using task is not
scheduled out for a longer time.

So what I'm asking for is proper documentation which explains how this
'hint' is generated in the kernel and why it can be completely inaccurate
and misleading. We don't want to end up in a situation where people start
to rely on this information and then have to go and read kernel code to
understand why the numbers do not make sense.

I'm not convinced that this interface in the current form is actually
useful. Even if you ignore the single task example, then on a loaded
machine where tasks are scheduled in and out by time slices, then the
calculation is:

	    delta = (long)(jiffies - timestamp);

delta is what you expose as elapsed_ms. Now assume that the task is seen as
using AVX when being scheduled out. So depending on the time it is
scheduled out, whether it's due lots of other tasks occupying the CPU or
due to a blocking syscall, the result can be completely misleading. The job
scheduler will see for example: 80ms ago was last AVX usage recorded and
decide that this is just an occasional usage and migrate it away. Now the
task gets on the other CPU and starts using AVX again, which makes the
scheduler see a short delta and decide to move it back.

So interpreting the value is voodoo which becomes even harder when there is
no documentation.

Thanks,

	tglx
