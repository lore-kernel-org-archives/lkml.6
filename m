Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 825FCC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 14:27:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B2B8218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 14:27:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387527AbfAaO1A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 09:27:00 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:49544 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726775AbfAaO1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 09:27:00 -0500
Received: from p5492e0d8.dip0.t-ipconnect.de ([84.146.224.216] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gpDIv-000701-Ca; Thu, 31 Jan 2019 15:26:57 +0100
Date:   Thu, 31 Jan 2019 15:26:56 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Zhenzhong Duan <zhenzhong.duan@oracle.com>
cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Waiman Long <longman@redhat.com>,
        Srinivas Eeda <srinivas.eeda@oracle.com>
Subject: Re: [PATCH] acpi_pm: Reduce PMTMR counter read contention
In-Reply-To: <019e583c-7bcb-c234-200c-fcdb6c49fbb0@oracle.com>
Message-ID: <alpine.DEB.2.21.1901311525360.8200@nanos.tec.linutronix.de>
References: <1548141807-25825-1-git-send-email-zhenzhong.duan@oracle.com> <alpine.DEB.2.21.1901300903350.1950@nanos.tec.linutronix.de> <019e583c-7bcb-c234-200c-fcdb6c49fbb0@oracle.com>
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

On Thu, 31 Jan 2019, Zhenzhong Duan wrote:

> On 2019/1/30 16:06, Thomas Gleixner wrote:
> > On Tue, 22 Jan 2019, Zhenzhong Duan wrote:
> > 
> > > On a large system with many CPUs, using PMTMR as the clock source can
> > > have a significant impact on the overall system performance because
> > > of the following reasons:
> > >   1) There is a single PMTMR counter shared by all the CPUs.
> > >   2) PMTMR counter reading is a very slow operation.
> > > 
> > > Using PMTMR as the default clock source may happen when, for example,
> > > the TSC clock calibration exceeds the allowable tolerance and HPET
> > > disabled by nohpet on kernel command line. Sometimes the performance
> > 
> > The question is why would anyone disable HPET on a larger machine when the
> > TSC is wreckaged?
> 
> There may be broken hardware where TSC is wreckaged.

I know that.

> > I'm not against the change per se, but I really want to understand why we
> > need all the complexity for something which should never be used in a real
> > world deployment.
> 
> Hmm, it's a strong word of "never be used". Customers may happen to use
> nohpet(sanity test?) and report bug to us. Sometimes they does report a bug
> that reproduce with their customed config. There may also be BIOS setting HPET
> disabled.

And because the customer MAY do completely nonsensical things (and there
are a lot more than the HPET) the kernel has to handle all of them?

Thanks,

	tglx
