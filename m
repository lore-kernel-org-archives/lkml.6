Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1325E13F6DFF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 13:35:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1E9D20870
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 13:35:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1E9D20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731980AbeG3PKK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 11:10:10 -0400
Received: from mout.gmx.net ([212.227.15.19]:57453 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726760AbeG3PKJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 11:10:09 -0400
Received: from homer.simpson.net ([185.191.218.229]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MFMEG-1fnSEB3RzQ-00EL04; Mon, 30
 Jul 2018 15:34:43 +0200
Message-ID: <1532957682.30205.42.camel@gmx.de>
Subject: Re: [rt-patch 3/3] arm, KVM: convert vgic_irq.irq_lock to
 raw_spinlock_t
From:   Mike Galbraith <efault@gmx.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Date:   Mon, 30 Jul 2018 15:34:42 +0200
In-Reply-To: <20180730092728.GE2494@hirez.programming.kicks-ass.net>
References: <20180727215710.zq6gkoqzlb4ca7qv@linutronix.de>
         <1532764179.9882.14.camel@gmx.de> <1532768853.9882.73.camel@gmx.de>
         <20180730092728.GE2494@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:OeBJw6ZtxnbG5epXzsmxoLOsLxc38mENCI1K3wwp8L7NcJa4Vcq
 0oMlcwmYGq/uOE+PBomwJSgwBZM8RtXQchx/Z2nURakwyO5pL+2+E+2R6tPK7rgakebPlyB
 01YL8x7zg5loLGZSet7Y9Df4ecyiqR3jEwLTPoy9cZ/Zcq8319V8zmzmvVyyiXzka7oG4Hi
 v75f/LvkDgHBIlADgm0HQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:CefTGgtF8mc=:HBP1SCJ7dF6RGe6ga9ZE3m
 oTl6AVXViKW16rNUO+IE3A+YwpXzBBfUL99A9FTmGZTRPctj3pLgav4pYDTmeL5+Sc8WrkAAU
 jgeUuI3GBs3Uizl1HHH6B6WV4/hR/I9KLIg5+ojXKerOKzB8ZyHlbDbujm/34Zxw2HEpp9Egx
 H/Z9t5gSc5L1vkh7fBy9eR9XyNITm13ySjpc3WD0LDHfrdYUShJCbddu3aEPRfbPYWIymMZmi
 Qg2/l25MKe0Imf1jHB/xAnkfxthesAUiegRZ9FDMRM1JWVrbaSVFDW3IZKfTcrH/I1LD8ituh
 7TLnaMdsqq+fFT/K9C9ollikMhxw0VLmcaJycOTFiA0+27cf9gnKS8bOi8F1hw9QbUKZx6zPA
 HsUeBlpgyyNvgZ/r1wrxPbawiAClLqyLyV22DnFZJ/kz+y3XwtiPddx70hOQRzx8gxhd/APKJ
 muR7wQk7DypcHrvjeVhS2RIw8nMlWGYibNu2kFQ6w7QWOgSpRHgehy5ADbeOlgicNe1Z8m2Ab
 4e3n/sPDV9qIZKg2SAcrTeh/WHdwyjwCwURBqpBGwQopAo5ep69J6rE9LD1CtkBR9FuAxLZzg
 Z+DC9NuT96Yh3koZsj/9M0UQl1PGFwInSHkMasS2u1gXyxB4zD5ayUyV6vTA9YN0v/usUQcW0
 BPmeGh0OgQFdPMlWBY1otN5LC5ZBTY2vYcgqo7MrfPC+TPk6UW1ppm4EBuLAT2i9rUT0V+sg1
 f/tpv7fr9ZggVNQz66FkKPXa+CKmqjRNCZt5Afw55HUQxsEQd4IjjjKDItAEbj4QVPwxf6MAX
 J4hIjks
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-07-30 at 11:27 +0200, Peter Zijlstra wrote:
> 
> The thing missing from the Changelog is the analysis that all the work
> done under these locks is indeed properly bounded and cannot cause
> excessive latencies.

True, I have no idea what worst case hold times are.  Nothing poked me
dead in the eye when looking around in completely alien code, nor did
cyclictest inspire concern running on box with no base of comparison.

I do know that latency is now < infinity, a modest improvement ;-)

	-Mike
