Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A8EBC43142
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 20:16:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0612F24CE7
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 20:16:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0612F24CE7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751961AbeFWUQX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jun 2018 16:16:23 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:43909 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751791AbeFWUQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jun 2018 16:16:22 -0400
Received: from p4fea482e.dip0.t-ipconnect.de ([79.234.72.46] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fWoxE-000807-V5; Sat, 23 Jun 2018 22:16:17 +0200
Date:   Sat, 23 Jun 2018 22:16:16 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
cc:     joelaf@google.com, John Stultz <john.stultz@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Accuracy bounds of ktime_get_boot_fast_ns
In-Reply-To: <CAHmME9oc=HD=AWxS9dqtnKYxeGuAkJabDTuBe66fRWV3HBXWiA@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1806232212180.8650@nanos.tec.linutronix.de>
References: <CAHmME9oc=HD=AWxS9dqtnKYxeGuAkJabDTuBe66fRWV3HBXWiA@mail.gmail.com>
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

On Sat, 23 Jun 2018, Jason A. Donenfeld wrote:
> void foobar_create(struct foobar *f)
> {
>     f->birthdate = ktime_get_boot_fast_ns();
> }
> bool foobar_has_expired(struct foobar *f)
> {
>     return f->birthdate + DEATH_AGE_SEC * NSEC_PER_SEC <=
>                 ktime_get_boot_fast_ns();
> }
> 
> I'm wondering if I can actually get away with this last iteration.
> I've read the comments around the various _fast_ns functions, and they
> all indicate that it might not be totally monotonic with respect to
> all cpus. But I wonder if that actually matters for my use case. For
> example, is it still correct within a 10th or so of a second? Or will
> it occasionally be wrong by massive multi-second leaps, which would
> make it unsuitable for my usage? In other words, I'm wondering if
> there's still a level of accuracy for a certain low degree of
> precision?

The step backwards would be in the low nanoseconds range, so nothing to
worry about. The slope is not adjusted by large jumps, it's a very smooth
adoption through NTP/PTP.

Thanks,

	tglx

