Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA02EC43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 07:30:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91BFF24240
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 07:30:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91BFF24240
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933502AbeF2Hau (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 03:30:50 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:57836 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753259AbeF2Has (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 03:30:48 -0400
Received: from hsi-kbw-5-158-153-55.hsi19.kabel-badenwuerttemberg.de ([5.158.153.55] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fYnrD-0002HP-VV; Fri, 29 Jun 2018 09:30:16 +0200
Date:   Fri, 29 Jun 2018 09:30:10 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Pavel Tatashin <pasha.tatashin@oracle.com>
cc:     Steven Sistare <steven.sistare@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        linux@armlinux.org.uk, Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        John Stultz <john.stultz@linaro.org>, sboyd@codeaurora.org,
        x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        mingo@redhat.com, "H. Peter Anvin" <hpa@zytor.com>,
        douly.fnst@cn.fujitsu.com, Peter Zijlstra <peterz@infradead.org>,
        Prarit Bhargava <prarit@redhat.com>, feng.tang@intel.com,
        Petr Mladek <pmladek@suse.com>, gnomes@lxorguk.ukuu.org.uk,
        linux-s390@vger.kernel.org, andriy.shevchenko@linux.intel.com,
        boris.ostrovsky@oracle.com, pbonzini@redhat.com
Subject: Re: [PATCH v12 09/11] x86/tsc: prepare for early sched_clock
In-Reply-To: <CAGM2read-NcUjssuUPHaf=qhdidT8f7cRNOs_GjdPnuOVvi-Lw@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1806290925340.1578@nanos.tec.linutronix.de>
References: <20180621212518.19914-1-pasha.tatashin@oracle.com> <20180621212518.19914-10-pasha.tatashin@oracle.com> <alpine.DEB.2.21.1806231815060.8650@nanos.tec.linutronix.de> <alpine.DEB.2.21.1806232210110.8650@nanos.tec.linutronix.de>
 <CAGM2reYQx769omkWVweEcTMy8WNrKOiuUVo4OFWNh4zW-rc4pg@mail.gmail.com> <alpine.DEB.2.21.1806232347540.8650@nanos.tec.linutronix.de> <alpine.DEB.2.21.1806261725510.1587@nanos.tec.linutronix.de> <CAGM2reYQ23XhQHAOO0Oo8MGvgrjpNZPZkwp+wwsU8Fb+jfANyA@mail.gmail.com>
 <alpine.DEB.2.21.1806270947410.1587@nanos.tec.linutronix.de> <alpine.DEB.2.21.1806281159590.1778@nanos.tec.linutronix.de> <CAGM2read-NcUjssuUPHaf=qhdidT8f7cRNOs_GjdPnuOVvi-Lw@mail.gmail.com>
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

On Thu, 28 Jun 2018, Pavel Tatashin wrote:
> On Thu, Jun 28, 2018 at 11:23 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> Hi Thomas,
> 
> In addition to above, we have xen hvm:
> 
> setup_arch()
>     ...
>     init_hypervisor_platform();
>         x86_init.hyper.init_platform();
>             xen_hvm_guest_init()
>                 xen_hvm_init_time_ops();

Duh. Missed that completely.

>     ...
>     tsc_early_delay_calibrate();
>         tsc_khz = x86_platform.calibrate_tsc(); == xen_tsc_khz()
>     ...
> 
> Which works early.
> 
> So, what should we do with xen, which seems to be the only platform
> that would provide different tsc frequency early and late, because of
> different calibration method?

Fix it? I have no idea why XEN has two variants of the scheme and I neither
have a clue why the KVM clock stuff is late.

Thanks,

	tglx

