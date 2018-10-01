Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 283ABC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 18:53:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E045D2089A
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 18:53:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E045D2089A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbeJBBc0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 21:32:26 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:58349 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbeJBBcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 21:32:25 -0400
Received: from p5492e4c1.dip0.t-ipconnect.de ([84.146.228.193] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1g73JB-0002bV-Sa; Mon, 01 Oct 2018 20:52:42 +0200
Date:   Mon, 1 Oct 2018 20:52:41 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
cc:     Andrey Vagin <avagin@virtuozzo.com>,
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
Subject: Re: Setting monotonic time?
In-Reply-To: <877ej2xc23.fsf_-_@xmission.com>
Message-ID: <alpine.DEB.2.21.1810012047520.32062@nanos.tec.linutronix.de>
References: <20180919205037.9574-1-dima@arista.com>        <874lej6nny.fsf@xmission.com>        <20180924205119.GA14833@outlook.office365.com>        <874leezh8n.fsf@xmission.com>        <20180925014150.GA6302@outlook.office365.com>        <87zhw4rwiq.fsf@xmission.com>
        <alpine.DEB.2.21.1809272247270.8118@nanos.tec.linutronix.de>        <87mus1ftb9.fsf@xmission.com>        <alpine.DEB.2.21.1809282023350.1432@nanos.tec.linutronix.de> <877ej2xc23.fsf_-_@xmission.com>
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

On Mon, 1 Oct 2018, Eric W. Biederman wrote:
> In the context of process migration there is a simpler subproblem that I
> think it is worth exploring if we can do something about.
> 
> For a cluster of machines all running with synchronized
> clocks. CLOCK_REALTIME matches. CLOCK_MONOTNIC does not match between
> machines.   Not having a matching CLOCK_MONOTONIC prevents successful
> process migration between nodes in that cluster.
> 
> Would it be possible to allow setting CLOCK_MONOTONIC at the very
> beginning of time?  So that all of the nodes in a cluster can be in
> sync?
> 
> No change in skew just in offset for CLOCK_MONOTONIC.
> 
> There are also dragons involved in coordinating things so that
> CLOCK_MONOTONIC gets set before CLOCK_MONOTONIC gets used.  So I don't
> know if allowing CLOCK_MONOTONIC to be set would be practical but it
> seems work exploring all on it's own.

It's used very early on in the kernel, so that would be a major surprise
for many things including user space which has expectations on clock
monotonic.

It would be reasonably easy to add CLOCK_MONONOTIC_SYNC which can be set in
the way you described and then in name spaces make it possible to magically
map CLOCK_MONOTONIC to CLOCK_MONOTONIC_SYNC.

It still wouldn't allow to have different NTP/PTP time domains, but might
be a good start to address the main migration headaches.

Thanks,

	tglx
