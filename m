Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A9F9C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 09:46:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02887218A4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 09:46:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728742AbeLSJqN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 04:46:13 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:58153 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726537AbeLSJqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 04:46:13 -0500
Received: from p4fea4820.dip0.t-ipconnect.de ([79.234.72.32] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gZYQH-0000SR-D0; Wed, 19 Dec 2018 10:45:49 +0100
Date:   Wed, 19 Dec 2018 10:45:48 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Li, Aubrey" <aubrey.li@linux.intel.com>
cc:     Andi Kleen <ak@linux.intel.com>, Aubrey Li <aubrey.li@intel.com>,
        mingo@redhat.com, peterz@infradead.org, hpa@zytor.com,
        tim.c.chen@linux.intel.com, dave.hansen@intel.com,
        arjan@linux.intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/3] x86/fpu: track AVX-512 usage of tasks
In-Reply-To: <6695cf98-17e8-df5f-4dac-264435e2aea5@linux.intel.com>
Message-ID: <alpine.DEB.2.21.1812190951190.1651@nanos.tec.linutronix.de>
References: <20181218042218.8653-1-aubrey.li@intel.com> <alpine.DEB.2.21.1812181448170.12686@nanos.tec.linutronix.de> <62997df2-0817-b54d-b11e-00a567f1d67c@linux.intel.com> <alpine.DEB.2.21.1812181630530.14031@nanos.tec.linutronix.de>
 <b14a9c82-3336-0f13-1a27-fba929e6b4fb@linux.intel.com> <20181218213826.GI25620@tassilo.jf.intel.com> <6695cf98-17e8-df5f-4dac-264435e2aea5@linux.intel.com>
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

On Wed, 19 Dec 2018, Li, Aubrey wrote:
> On 2018/12/19 5:38, Andi Kleen wrote:
> >> I misunderstood, you mean 32bit kernel, not 32bit machine. Theoretically 32bit
> >> kernel can use AVX512, but not sure if anyone use it like this. get_jiffies_64()
> >> includes jiffies_lock ops so not good in context switch. So I want to use raw
> >> jiffies_64 here. jiffies is a good candidate but it has wraparound overflow issue.
> >> Other time source are expensive here.
> >>
> >> Should I limit the code only running on 64bit kernel? 
> > 
> > Yes making it 64bit only should be fine.
> > 
> > Other alternative would be to use 32bit jiffies on 32bit. I assume
> > wrapping is not that big a problem here.
> > 
> Thomas, is this acceptable?

Just do the math. jiffies on 32bit wrap around depending on HZ:

 HZ=100	    248 days
 HZ=1000     24 days

So, yes it takes quite some time, but from then on the information is
bogus. Whether that matters or not is a different question. At least it
needs proper documentation.

Thanks,

	tglx


