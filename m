Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07748C282CA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 13:51:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C88BA2080A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 13:51:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729982AbfBLNvJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 08:51:09 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:43404 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729889AbfBLNvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 08:51:08 -0500
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gtYSj-0004A7-29; Tue, 12 Feb 2019 14:51:01 +0100
Date:   Tue, 12 Feb 2019 14:51:00 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        H Peter Anvin <hpa@zytor.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Michael Chan <michael.chan@broadcom.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [PATCH v3 08/10] x86/setcpuid: Add kernel option setcpuid
In-Reply-To: <20190212133750.GJ32494@hirez.programming.kicks-ass.net>
Message-ID: <alpine.DEB.2.21.1902121444250.3710@nanos.tec.linutronix.de>
References: <1549084491-57808-9-git-send-email-fenghua.yu@intel.com> <alpine.DEB.2.21.1902041745370.3006@nanos.tec.linutronix.de> <9fa7406b-113f-fe0a-9fc7-ef00b3a6b620@intel.com> <20190204195704.GJ29639@zn.tnic> <5c2f0af3-1740-f16b-6ff6-6bec6a325034@intel.com>
 <20190205084857.GK17528@hirez.programming.kicks-ass.net> <ec193a66-b395-ed1a-e39c-40fa1ece3f56@intel.com> <20190205170415.GG17550@hirez.programming.kicks-ass.net> <alpine.DEB.2.21.1902102012520.8784@nanos.tec.linutronix.de> <20190211191643.GB103371@romley-ivt3.sc.intel.com>
 <20190212133750.GJ32494@hirez.programming.kicks-ass.net>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Feb 2019, Peter Zijlstra wrote:

> On Mon, Feb 11, 2019 at 11:16:43AM -0800, Fenghua Yu wrote:
> > 4. The feature can be disabled by kernel option
> > "clearcpuid=split_lock_detection" during early boot time.
> 
> IFF clearcpuid lives, it should also employ CPUID faulting and clear it
> for userspace too.

We have it already, and aside of clearcpuid there are enough things which
the kernel disables in the kernel view of CPUID, but user space still can
see them. That's inconsistent, so we really should use CPUID faulting when
its available.

That won't solve the problem of user space ignoring CPUID alltogether and
just probing crap, but you can't prevent that at all.

For that we'd need a CPUID mask facility in the hardware, which would
default to 0xFFFFFFFFFF and the kernel could clear bits in the mask to turn
of both the CPUID bit _AND_ the connected functionality. IOW, if you mask a
bit and user space probes the functionality brute force, it'll #GP and we
can just kill it.

Thanks,

	tglx
