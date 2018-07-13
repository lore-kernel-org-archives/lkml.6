Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38FA3ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 12:01:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7E60208E2
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 12:01:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7E60208E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729785AbeGMMQQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 08:16:16 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:47088 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727608AbeGMMQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 08:16:16 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=[10.100.61.71])
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <anna-maria@linutronix.de>)
        id 1fdwle-00036d-02; Fri, 13 Jul 2018 14:01:46 +0200
Date:   Fri, 13 Jul 2018 14:01:45 +0200 (CEST)
From:   Anna-Maria Gleixner <anna-maria@linutronix.de>
To:     Haris Okanovic <haris.okanovic@ni.com>
cc:     linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        harisokn@gmail.com, bigeasy@linutronix.de, tglx@linutronix.de,
        julia.cartwright@ni.com, gratian.crisan@ni.com, daniel@bristot.me,
        efault@gmx.de
Subject: Re: [PATCH v5 1/2] timers: Don't wake ktimersoftd on every tick
In-Reply-To: <20180628164036.27378-1-haris.okanovic@ni.com>
Message-ID: <alpine.DEB.2.21.1807131354560.2242@somnus>
References: <7d21ff63-3dce-b8ea-a0f1-81d53617747d@ni.com> <20180628164036.27378-1-haris.okanovic@ni.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Haris,

On Thu, 28 Jun 2018, Haris Okanovic wrote:

> Collect expired timers in interrupt context to avoid overhead of waking
> ktimersoftd on every scheduler tick.
> 
> This is implemented by storing lists of expired timers in the timer_base
> struct, which is updated by the interrupt routing on each tick in
> run_local_timers(). TIMER softirq (ktimersoftd) is then raised only when
> one or more expired timers are collected.
> 
> Performance impact on a 2core Intel Atom E3825 system:
>  * reduction in small latency spikes measured by cyclictest
>  * ~30% fewer context-switches measured by perf
>  * run_local_timers() execution time increases by 0.2 measured by TSC
> 

I'm also working on timer improvements at the moment. When I fixed all
my bugs in my implementation (there is a last horrible one), I'm very
interested in integrating your patches into my testing to be able to
give you a tested-by.

Thanks,

	Anna-Maria
