Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD70AC00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 05:26:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7A41206B2
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 05:26:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7A41206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbeJCMNB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 08:13:01 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:33026 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbeJCMNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 08:13:00 -0400
Received: from p5492e4c1.dip0.t-ipconnect.de ([84.146.228.193] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1g7ZfE-0006tq-6X; Wed, 03 Oct 2018 07:25:36 +0200
Date:   Wed, 3 Oct 2018 07:25:35 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
cc:     Arnd Bergmann <arnd@arndb.de>, avagin@virtuozzo.com,
        dima@arista.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        0x7f454c46@gmail.com, adrian@lisas.de,
        Andy Lutomirski <luto@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        gorcunov@openvz.org, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>, Jeff Dike <jdike@addtoit.com>,
        Oleg Nesterov <oleg@redhat.com>, xemul@virtuozzo.com,
        Shuah Khan <shuah@kernel.org>,
        containers@lists.linux-foundation.org, criu@openvz.org,
        Linux API <linux-api@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        linux-kselftest@vger.kernel.org
Subject: Re: Setting monotonic time?
In-Reply-To: <87in2jskew.fsf@xmission.com>
Message-ID: <alpine.DEB.2.21.1810030711520.1435@nanos.tec.linutronix.de>
References: <20180919205037.9574-1-dima@arista.com> <874lej6nny.fsf@xmission.com> <20180924205119.GA14833@outlook.office365.com> <874leezh8n.fsf@xmission.com> <20180925014150.GA6302@outlook.office365.com> <87zhw4rwiq.fsf@xmission.com>
 <alpine.DEB.2.21.1809272247270.8118@nanos.tec.linutronix.de> <87mus1ftb9.fsf@xmission.com> <alpine.DEB.2.21.1809282023350.1432@nanos.tec.linutronix.de> <877ej2xc23.fsf_-_@xmission.com> <alpine.DEB.2.21.1810012047520.32062@nanos.tec.linutronix.de>
 <CAK8P3a2zTqrCGURE3XVpn3_w6C4R5O+cq8TdtbyKCMGyRk9_jw@mail.gmail.com> <alpine.DEB.2.21.1810022205080.1435@nanos.tec.linutronix.de> <87in2jskew.fsf@xmission.com>
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

On Wed, 3 Oct 2018, Eric W. Biederman wrote:
> Direct access to hardware/drivers and not through an abstraction like
> the vfs (an abstraction over block devices) can legitimately be handled
> by hotplug events.  I unplug one keyboard I plug in another.
> 
> I don't know if the input layer is more of a general abstraction
> or more of a hardware device.  I have not dug into it but my guess
> is abstraction from what I have heard.
> 
> The scary difficulty here is if after restart input is reporting times
> in CLOCK_MONOTONIC and the applications in the namespace are talking
> about times in CLOCK_MONOTONIC_SYNC.  Then there is an issue.  As even
> with a fixed offset the times don't match up.
> 
> So a time namespace absolutely needs to do is figure out how to deal
> with all of the kernel interfaces reporting times and figure out how to
> report them in the current time namespace.

So you want to talk to Arnd who is leading the y2038 effort. He knowns how
many and which interfaces are involved aside of the obvious core timer
ones. It's quite an amount and the problem is that you really need to do
that at the interface level, because many of those time stamps are taken in
contexts which are completely oblivious of name spaces. Ditto for timeouts
and similar things which are handed in through these interfaces.

Thanks,

	tglx



