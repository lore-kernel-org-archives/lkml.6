Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58053C004D2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 06:15:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2730E20684
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 06:15:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2730E20684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbeJBM5W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 08:57:22 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:58853 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbeJBM5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 08:57:21 -0400
Received: from p5492e4c1.dip0.t-ipconnect.de ([84.146.228.193] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1g7Dxj-0002iL-Pv; Tue, 02 Oct 2018 08:15:15 +0200
Date:   Tue, 2 Oct 2018 08:15:15 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andrey Vagin <avagin@virtuozzo.com>
cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Dmitry Safonov <dima@arista.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Adrian Reber <adrian@lisas.de>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jeff Dike <jdike@addtoit.com>, Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelianov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        "containers@lists.linux-foundation.org" 
        <containers@lists.linux-foundation.org>,
        "criu@openvz.org" <criu@openvz.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: Re: [RFC 00/20] ns: Introduce Time Namespace
In-Reply-To: <20181001232033.GA31324@outlook.office365.com>
Message-ID: <alpine.DEB.2.21.1810020811290.32062@nanos.tec.linutronix.de>
References: <20180919205037.9574-1-dima@arista.com> <874lej6nny.fsf@xmission.com> <20180924205119.GA14833@outlook.office365.com> <874leezh8n.fsf@xmission.com> <20180925014150.GA6302@outlook.office365.com> <87zhw4rwiq.fsf@xmission.com>
 <alpine.DEB.2.21.1809272247270.8118@nanos.tec.linutronix.de> <alpine.DEB.2.21.1809272335430.8118@nanos.tec.linutronix.de> <20181001232033.GA31324@outlook.office365.com>
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

On Mon, 1 Oct 2018, Andrey Vagin wrote:

> On Thu, Sep 27, 2018 at 11:41:49PM +0200, Thomas Gleixner wrote:
> > On Thu, 27 Sep 2018, Thomas Gleixner wrote:
> > > Add time skew via NTP/PTP into the picture and you might have to adjust
> > > timers as well, because you need to guarantee that they are not expiring
> > > early.
> > > 
> > > I haven't looked through Dimitry's patches yet, but I don't see how this
> > > can work at all without introducing subtle issues all over the place.
> > 
> > And just a quick scan tells me that this is broken. Timers will expire
> > early or late. The latter is acceptible to some extent, but larger delays
> > might come with surprise. Expiring early is an absolute nono.
> 
> Do you mean that we have to adjust all timers after changing offset for
> CLOCK_MONOTONIC or CLOCK_BOOTTIME? Our idea is that offsets for
> monotonic and boot times will be set immediately after creating a time
> namespace before using any timers.

I explained that in detail in this thread, but it's not about the initial
setting of clock mono/boot before any timers have been armed.

It's about setting the offset or clock realtime (via settimeofday) when
timers are already armed. Also having a entirely different time domain,
e.g. separate NTP adjustments, makes that necessary.

Thanks,

	tglx
