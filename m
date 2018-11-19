Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40581C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 08:09:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE9DD20823
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 08:09:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE9DD20823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbeKSScP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 13:32:15 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:37602 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726348AbeKSScP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 13:32:15 -0500
Received: from p4fea46ac.dip0.t-ipconnect.de ([79.234.70.172] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gOecO-0001Pu-Tu; Mon, 19 Nov 2018 09:09:17 +0100
Date:   Mon, 19 Nov 2018 09:09:16 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Qian Cai <cai@gmx.us>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Waiman Long <longman@redhat.com>,
        Yang Shi <yang.shi@linux.alibaba.com>, arnd@arndb.de,
        linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] debugobjects: add a new Kconfig for POOL_SIZE
In-Reply-To: <5939F7F3-E332-4112-861E-C6C0DF86717E@gmx.us>
Message-ID: <alpine.DEB.2.21.1811190904450.9459@nanos.tec.linutronix.de>
References: <20181118082255.1275-1-cai@gmx.us> <alpine.DEB.2.21.1811181919170.9459@nanos.tec.linutronix.de> <5939F7F3-E332-4112-861E-C6C0DF86717E@gmx.us>
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

Qian,

On Sun, 18 Nov 2018, Qian Cai wrote:
> > On Nov 18, 2018, at 1:21 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> > On Sun, 18 Nov 2018, Qian Cai wrote:
> >> As the results, systems have 60+ CPUs with both timer and workqueue
> >> objects enabled could trigger "ODEBUG: Out of memory. ODEBUG disabled".
> >> 
> >> Hence, add a new Kconfig option so users could adjust ODEBUG_POOL_SIZE
> >> accordingly if either timer or workqueue objects are selected.
> > 
> > why do we need a config option, when the required number can be deduced
> > already from the active CONFIG_DEBUG_OBJECTS_* and NR_CPUS?
> > 
> It because I am worry about the coupling between the implementation details of
> timers and workqueue objects, and the computation in the code you mentioned
> here. For example, people could change workqueue.c to have different number
> of worekqueues initialized during the early boot in the future which is going to
> affect the required pool size, and I am not sure if people are going to adjust the
> code in debugobjects.c here as well when they made changes like that.
> 
> Also, the computation could become so complex depends on lots of config
> options like perf, hrtimer, and combinations that I have not tested so far which is
> difficult to exhausted all the possibilities.
> 
> Hence, I feel like the Kconfig option is more flexible and less error-prone.

Quite the contrary. Config options are a pain and truly error-prone if you
want to compile general purpose kernels as distributions do.

Its not really a problem to have a larger initial static pool which gets
freed after init anyway. So we can size it generously depending on the
config options and be done with it.

Thanks,

	tglx

