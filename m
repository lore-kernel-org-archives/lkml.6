Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47B7FC468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 11:01:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0734B20671
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 11:01:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0734B20671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731215AbeGSLoa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 07:44:30 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:60978 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726930AbeGSLoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 07:44:30 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fg6gU-00068M-NV; Thu, 19 Jul 2018 13:01:22 +0200
Date:   Thu, 19 Jul 2018 13:01:22 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
cc:     Pavel Tatashin <pasha.tatashin@oracle.com>,
        steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux@armlinux.org.uk, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, john.stultz@linaro.org,
        sboyd@codeaurora.org, x86@kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, hpa@zytor.com, douly.fnst@cn.fujitsu.com,
        prarit@redhat.com, feng.tang@intel.com, pmladek@suse.com,
        gnomes@lxorguk.ukuu.org.uk, linux-s390@vger.kernel.org,
        boris.ostrovsky@oracle.com, jgross@suse.com, pbonzini@redhat.com
Subject: Re: [PATCH v14 20/25] x86/tsc: calibrate tsc only once
In-Reply-To: <20180719103340.GA2494@hirez.programming.kicks-ass.net>
Message-ID: <alpine.DEB.2.21.1807191300150.1602@nanos.tec.linutronix.de>
References: <20180718022211.6259-1-pasha.tatashin@oracle.com> <20180718022211.6259-21-pasha.tatashin@oracle.com> <20180719103340.GA2494@hirez.programming.kicks-ass.net>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Jul 2018, Peter Zijlstra wrote:
> On Tue, Jul 17, 2018 at 10:22:06PM -0400, Pavel Tatashin wrote:
> > During boot tsc is calibrated twice: once in tsc_early_delay_calibrate(),
> > and the second time in tsc_init().
> > 
> > Rename tsc_early_delay_calibrate() to tsc_early_init(), and rework it so
> > the calibration is done only early, and make tsc_init() to use the values
> > already determined in tsc_early_init().
> > 
> > Sometimes it is not possible to determine tsc early, as the subsystem that
> > is required is not yet initialized, in such case try again later in
> > tsc_init().
> 
> It might be nice to preserve some of the information tglx dug out during
> review of all this. Like the various methods of calibrate_*() and their
> dependencies.
> 
> And I note that this patch relies on the magic of native_calibrate_cpu()
> working really early and not exploding in the quick calibration run.
> This either wants fixing or documenting.
> 
> I think the initial idea was to only do the fast_calibrate (cpuid, msr
> and possibly the quick_pit) things early and delay the HPET/PMTIMER
> magic until later.

Yes. I really would prefer to have this as an explicit expressed mechanism
rather than relying on magic variables not being initialized.

Thanks

	tglx

