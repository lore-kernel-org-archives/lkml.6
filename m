Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA3D9C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 16:20:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83DA620661
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 16:20:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83DA620661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732091AbeGSREQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 13:04:16 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:33623 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731888AbeGSREQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 13:04:16 -0400
Received: from p4fea5a5a.dip0.t-ipconnect.de ([79.234.90.90] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fgBeQ-00032V-2N; Thu, 19 Jul 2018 18:19:34 +0200
Date:   Thu, 19 Jul 2018 18:19:33 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Pavel Tatashin <pasha.tatashin@oracle.com>
cc:     Peter Zijlstra <peterz@infradead.org>, steven.sistare@oracle.com,
        daniel.m.jordan@oracle.com, linux@armlinux.org.uk,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        john.stultz@linaro.org, sboyd@codeaurora.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com, hpa@zytor.com,
        douly.fnst@cn.fujitsu.com, prarit@redhat.com, feng.tang@intel.com,
        pmladek@suse.com, gnomes@lxorguk.ukuu.org.uk,
        linux-s390@vger.kernel.org, boris.ostrovsky@oracle.com,
        jgross@suse.com, pbonzini@redhat.com
Subject: Re: [PATCH v14 20/25] x86/tsc: calibrate tsc only once
In-Reply-To: <4295075b-8a0f-1723-2e80-1bbd2f038846@oracle.com>
Message-ID: <alpine.DEB.2.21.1807191817080.1693@nanos.tec.linutronix.de>
References: <20180718022211.6259-1-pasha.tatashin@oracle.com> <20180718022211.6259-21-pasha.tatashin@oracle.com> <20180719103340.GA2494@hirez.programming.kicks-ass.net> <alpine.DEB.2.21.1807191300150.1602@nanos.tec.linutronix.de>
 <4295075b-8a0f-1723-2e80-1bbd2f038846@oracle.com>
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
> On 07/19/2018 07:01 AM, Thomas Gleixner wrote:
> 
> And hpet_pmtime_calibrate_cpu() contains all the hpet/pmtime stuff.
> 
> However, when cpu_khz = x86_platform.calibrate_cpu() is called the first
> time, we still call hpet_pmtime_calibrate_cpu() from
> native_calibrate_cpu(). We cannot simply split native_calibrate_cpu()
> into two independent functions because it is also called from
> recalibrate_cpu_khz().

> So, the question is how to enforce that the first time we do not call hpet/pmtime?
> 
> 1. Use a new global variable? Kind of ugly.
> 2. Use system_state == SYSTEM_BOOTING ? Ugly, and probably not very safe.

Both are horrible.

So create two functions. native_...early..() and native....(). The early
one does not contain the hpet/pmtimer stuff and it replaces the ops.pointer
with the late one which contains all of it.

Hmm?

Thanks,

	tglx
