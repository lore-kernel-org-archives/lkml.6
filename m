Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E332BECE560
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 15:07:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7690D20866
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 15:07:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7690D20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727350AbeIOU0E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 16:26:04 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:51840 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726833AbeIOU0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 16:26:04 -0400
Received: from p4fea45ac.dip0.t-ipconnect.de ([79.234.69.172] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1g1C9i-00011J-VR; Sat, 15 Sep 2018 17:06:43 +0200
Date:   Sat, 15 Sep 2018 17:06:42 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Rick Ratzel <rick.ratzel@ni.com>
cc:     "john.stultz@linaro.org" <john.stultz@linaro.org>,
        "udknight@gmail.com" <udknight@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Julia Cartwright <julia.cartwright@ni.com>
Subject: Re: Ensuring wall_to_monotonic is not positive breaks use case
In-Reply-To: <alpine.DEB.2.21.1809061605570.1570@nanos.tec.linutronix.de>
Message-ID: <alpine.DEB.2.21.1809151651290.1650@nanos.tec.linutronix.de>
References: <CY4PR04MB0296FED0A64321B49AA527C69B020@CY4PR04MB0296.namprd04.prod.outlook.com> <alpine.DEB.2.21.1809061605570.1570@nanos.tec.linutronix.de>
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

On Thu, 6 Sep 2018, Thomas Gleixner wrote:
> On Wed, 5 Sep 2018, Rick Ratzel wrote:
> 
> > We're looking for suggestions on how best to proceed with a new change
> > that ideally both supports the use case described above, as well as
> > addresses the symptoms brought up in the initial commit (negative boot
> > time causes get_expiry() to overflow time_t, and show_stat() uses
> > "unsigned long" to print negative btime).  Any thoughts on this would be
> > greatly appreciated.
> 
> Those symptoms are just the tip of the iceberg. For sure it screws up
> everything around boot time and a lot of things use boottime nowadays.

I had a second look and actually it's not that bad. My brain snapped on
boot time and we actually have two variants of boot time. One is the
monotonic time since boot aka CLOCK_BOOTTIME and the other one is the wall
clock time when the system was booted.

> So reverting this is not really an option.

Maybe we can :)

We have 3 users in tree:

1) /proc/stat btime

   It's trivial enough to clamp that value to 0, though it might be
   surprising for some users as uptime will tell something different.

2) sunrpc

   I think that can be converted to actually use CLOCK_BOOTTIME. This needs
   a bit of trickery to preserve the user space interfaces which are
   CLOCK_REALTIME based, but it should be doable.

3) x86/kvm

   That's actually the trickiest part of all and I haven't yet fully
   analyzed it, whether there is an issue that time can go negative.

   Actually there shouldn't be one as this is about wall time and that
   cannot go before the epoch. Needs some close inspection and while it
   might be trivial to adapt the code in question, it could be tricky or
   even impossible to fix it without breaking existing guests.

Thanks,

	tglx

