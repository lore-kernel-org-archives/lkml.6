Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B831CC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 14:32:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F8E22086B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 14:32:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F8E22086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728590AbeK2Ben (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 20:34:43 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:59889 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727872AbeK2Ben (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 20:34:43 -0500
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gS0tS-0007UT-DA; Wed, 28 Nov 2018 15:32:46 +0100
Date:   Wed, 28 Nov 2018 15:32:45 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Heiko Carstens <heiko.carstens@de.ibm.com>
cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: WARN_ON_ONCE(!new_owner) within wake_futex_pi() triggered
In-Reply-To: <20181127081115.GB3625@osiris>
Message-ID: <alpine.DEB.2.21.1811281526430.1532@nanos.tec.linutronix.de>
References: <20181127081115.GB3625@osiris>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Heiko,

On Tue, 27 Nov 2018, Heiko Carstens wrote:

> with the glibc self-tests I was able to trigger the "this should not
> happen" warning ;) below on s390 (with panic_on_warn=1 set). It looks
> like it is hardly reproducible.

Any idea which self-test triggered that?

> This one happened with commit d146194f31c9 for compiling the kernel.
> Config can be re-created with "make ARCH=s390 performance_defconfig".

Which is not really helpful for people who do not own a s390. And no, I
don't want one unless IBM pays the power bill as well :)

> [  649.596938] WARNING: CPU: 0 PID: 58886 at kernel/futex.c:1418 do_futex+0xa9a/0xc50
> [  649.596946] Kernel panic - not syncing: panic_on_warn set ...
> [  649.596951] CPU: 0 PID: 58886 Comm: ld64.so.1 Not tainted 4.20.0-20181125.rc3.git0.d146194f31c9.300.fc29.s390x+git #1

That's ld64.so.1. Weird, but what do I know about glibc self tests.

I still fail to see how that can happen, but I usually page out the futex
horrors immediately. I'll keep staring at the code...

Thanks,

	tglx


