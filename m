Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94D81ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 15:32:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59C5B2088F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 15:32:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59C5B2088F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729214AbeIQVAH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 17:00:07 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:55436 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727063AbeIQVAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 17:00:07 -0400
Received: from hsi-kbw-5-158-153-55.hsi19.kabel-badenwuerttemberg.de ([5.158.153.55] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1g1vVT-0001vG-D5; Mon, 17 Sep 2018 17:32:11 +0200
Date:   Mon, 17 Sep 2018 17:32:05 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Dou Liyang <dou_liyang@163.com>
cc:     linux-kernel@vger.kernel.org, x86@kernel.org, mingo@redhat.com,
        hpa@zytor.com, douly.fnst@cn.fujitsu.com
Subject: Re: [PATCH v3 2/2] irq/matrix: Spread managed interrupts on
 allocation
In-Reply-To: <20180908175838.14450-2-dou_liyang@163.com>
Message-ID: <alpine.DEB.2.21.1809171713270.16580@nanos.tec.linutronix.de>
References: <20180908175838.14450-1-dou_liyang@163.com> <20180908175838.14450-2-dou_liyang@163.com>
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

On Sun, 9 Sep 2018, Dou Liyang wrote:

> From: Dou Liyang <douly.fnst@cn.fujitsu.com>
> 
> Linux has spread out the non managed interrupt across the possible
> target CPUs to avoid vector space exhaustion.
> 
> But, the same situation may happen on the managed interrupts.

Second thougts on this.

Spreading the managed interrupts out at vector allocation time does not
prevent vector exhaustion at all, because contrary to regular interrupts
managed interrupts have a guaranteed allocation. IOW when the managed
interrupt is initialized (that's way before the actual vector allocation
happens) a vector is reserved on each CPU which is in the associated
interrupt mask.

This is an essential property of managed interrupts because the kernel
guarantees that they can be moved to any CPU in the supplied mask during
CPU hot unplug and consequently shut down when the last CPU in the mask
goes offline.

So for that special case of pre/post vectors the supplied mask is all CPUs
and the guaranteed reservation will claim a vector on each CPU. What makes
it look unbalanced is that when the interrupts are actually requested, all
end up on CPU0 as that's the first CPU in the mask.

So doing the spreading does not prevent vector exhaustion it merily spreads
the active interrupts more evenly over the CPUs in the mask.

I think it's still worthwhile to do that, but the changelog needs a major
overhaul as right now it's outright misleading. I'll just amend it with
something along the above lines, unless someone disagrees.

That said, it might also be interesting to allow user space affinity
settings on managed interrupts. Not meant for the pre/post vector case,
which just needs to be made non managed. It's meant for the case where a
device has less queues than CPUs, where changing affinity within the spread
range of CPUs could be allowed. Not sure though. Delegating this to the
folks who actually use that in their drivers.

Thanks,

	tglx
