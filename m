Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D183ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 20:45:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 122AC20684
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 20:45:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 122AC20684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729914AbeGSV3y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 17:29:54 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:34106 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727461AbeGSV3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 17:29:54 -0400
Received: from p4fea5a5a.dip0.t-ipconnect.de ([79.234.90.90] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fgFmY-00065d-3c; Thu, 19 Jul 2018 22:44:14 +0200
Date:   Thu, 19 Jul 2018 22:44:13 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Pavel Tatashin <pasha.tatashin@oracle.com>
cc:     peterz@infradead.org, Steven Sistare <steven.sistare@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        linux@armlinux.org.uk, schwidefsky@de.ibm.com,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        John Stultz <john.stultz@linaro.org>, sboyd@codeaurora.org,
        x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        mingo@redhat.com, hpa@zytor.com, douly.fnst@cn.fujitsu.com,
        prarit@redhat.com, feng.tang@intel.com,
        Petr Mladek <pmladek@suse.com>, gnomes@lxorguk.ukuu.org.uk,
        linux-s390@vger.kernel.org, boris.ostrovsky@oracle.com,
        jgross@suse.com, pbonzini@redhat.com
Subject: Re: [PATCH v14 20/25] x86/tsc: calibrate tsc only once
In-Reply-To: <CAGM2rebBN0v0epfTssM=ShiWZ4GTDaN_cgGWdKE4+k+jV6CxyA@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1807192240260.1693@nanos.tec.linutronix.de>
References: <20180718022211.6259-1-pasha.tatashin@oracle.com> <20180718022211.6259-21-pasha.tatashin@oracle.com> <20180719103340.GA2494@hirez.programming.kicks-ass.net> <alpine.DEB.2.21.1807191300150.1602@nanos.tec.linutronix.de> <4295075b-8a0f-1723-2e80-1bbd2f038846@oracle.com>
 <alpine.DEB.2.21.1807191817080.1693@nanos.tec.linutronix.de> <CAGM2reYpApca9v-2qpVbTGXGVWiEEL5mkEWzTAvXFiztmtkh1Q@mail.gmail.com> <CAGM2rebBN0v0epfTssM=ShiWZ4GTDaN_cgGWdKE4+k+jV6CxyA@mail.gmail.com>
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

On Thu, 19 Jul 2018, Pavel Tatashin wrote:

> On Thu, Jul 19, 2018 at 12:49 PM Pavel Tatashin
> <pasha.tatashin@oracle.com> wrote:
> >
> > > So create two functions. native_...early..() and native....(). The early
> > > one does not contain the hpet/pmtimer stuff and it replaces the ops.pointer
> > > with the late one which contains all of it.
> >
> > Good idea. Actually, the late one will contain only hpet/pmtimer and I
> > will set it only if tsc frequency was not determined only.
> 
> If we determined tsc early in boot using one of the quick methods:
> from cpuid/msr/quick_pit, can we assume that frequencies of all other
> CPUs will be determined the same way? Or do we still have to fallback
> to PIT/HPET/PMTIMER? I wondering if we support heterogeneous
> multi-socket platforms with different CPUs, because that the only
> platforms where I see such scenario is possible.

The frequency for secondary CPUs is usually taken from the boot CPU and the
only reason why recalibration can happen is when the CPU does not have a
constant frequency TSC.

For that case the quick PIT + hpet/pmtimer calibration bundle is
required. So yes, the early calibration might work with quick PIT (those
CPUs definitely do not have MSR/CPUID based calibration), but the
recalibration might fail the quick PIT calibration for various reasons.

Thanks,

	tglx
