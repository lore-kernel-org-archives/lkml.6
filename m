Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67E6FC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 13:26:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 308B3214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 13:26:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 308B3214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729422AbeKVAAs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 19:00:48 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:44098 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbeKVAAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 19:00:47 -0500
Received: from p4fea46ac.dip0.t-ipconnect.de ([79.234.70.172] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gPSWL-0001kA-L4; Wed, 21 Nov 2018 14:26:21 +0100
Date:   Wed, 21 Nov 2018 14:26:20 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Josh Hunt <johunt@akamai.com>
cc:     saeedm@mellanox.com, linux-kernel@vger.kernel.org,
        "Ozen, Gurhan" <guozen@akamai.com>
Subject: Re: vector space exhaustion on 4.14 LTS kernels
In-Reply-To: <598457c6-4bea-50f5-efe9-6a2af3405ff5@akamai.com>
Message-ID: <alpine.DEB.2.21.1811211419260.1665@nanos.tec.linutronix.de>
References: <598457c6-4bea-50f5-efe9-6a2af3405ff5@akamai.com>
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

Josh,

On Mon, 19 Nov 2018, Josh Hunt wrote:
> We have a class of machines that appear to be exhausting the vector space on
> cpus 0 and 1 which causes some breakage later on when trying to set the
> affinity. The boxes are running the 4.14 LTS kernel.
> 
> [   39.531385] __assign_irq_vector: irq:512 cpu:128 searched:00,00000001
> vector:00,00000000 continue
> [   39.531386] apic_set_affinity: irq:512 mask:00,00000001 err:-28
> 
> The affinity values:
> 
> root@172.25.48.208:/proc/irq/512# grep . *
> affinity_hint:00,00000001
> effective_affinity:00,00000004
> effective_affinity_list:2
> grep: mlx5_comp0@pci:0000:65:00.1: Is a directory
> node:0
> smp_affinity:ff,ffffffff
> smp_affinity_list:0-39
> spurious:count 3
> spurious:unhandled 0
> spurious:last_unhandled 0 ms
> 
> I noticed your change, a0c9259dc4e1 "irq/matrix: Spread interrupts on
> allocation", and this sounds like what we're hitting. Booting 4.19 does not
> have this problem. I haven't booted 4.15 yet, but can do it to confirm the
> above commit is what resolves this.

Might be, but in 4.15 the while vector allocation got rewritten. One of the
reasons was the exhaustion issue. Some of that is caused by massive over
allocation by certain device drivers. The new allocator mechanism handles
that way better.

> Since 4.14 doesn't have the matrix allocator it's not a trivial backport. I
> was wondering a) if you agree with my assessment and b) if there's any plans
> on resolving this on the 4.14 allocator? If not I can attempt to backport the
> idea to 4.14 to spread the interrupts around on allocation.

No plans. Good luck with trying to fix that on the 4.14 code. I'd recommend
to switch to 4.19 LTS :)

Thanks,

	tglx
