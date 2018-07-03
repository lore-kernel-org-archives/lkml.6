Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60313C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 14:19:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FD8D22427
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 14:19:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FD8D22427
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753586AbeGCOTo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 10:19:44 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:44204 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753067AbeGCOTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 10:19:43 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1faM9Z-0002Z0-9s; Tue, 03 Jul 2018 16:19:37 +0200
Date:   Tue, 3 Jul 2018 16:19:36 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Bernhard Rosenkraenzer <bero@lindev.ch>
cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Gabriel C <nix.or.die@gmail.com>,
        Benjamin Gilbert <bgilbert@redhat.com>,
        linux-x86_64@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>
Subject: Re: 4.17.x won't boot due to "x86/boot/compressed/64: Handle 5-level
 paging boot if kernel is above 4G"
In-Reply-To: <54cf-5b3b8300-1-6d99ad80@111178718>
Message-ID: <alpine.DEB.2.21.1807031609550.1601@nanos.tec.linutronix.de>
References: <54cf-5b3b8300-1-6d99ad80@111178718>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Jul 2018, Bernhard Rosenkraenzer wrote:
> On Tuesday, July 03, 2018 16:02 CEST, Thomas Gleixner <tglx@linutronix.de> wrote:
> > On Tue, 3 Jul 2018, Kirill A. Shutemov wrote:
> > > On Tue, Jul 03, 2018 at 01:24:49PM +0200, Gabriel C wrote:
> > > > 2018-07-01 23:32 GMT+02:00 Benjamin Gilbert <bgilbert@redhat.com>:
> > > > > On Sun, Jul 01, 2018 at 05:15:59PM -0400, Benjamin Gilbert wrote:
> > > > >> 4.17 kernels built with the CoreOS Container Linux toolchain and kconfig,
> > > > >> up to and including 4.17.3, fail to boot on AMD64 running in (at least)
> > > > >> QEMU/KVM.  No messages are shown post-GRUB; the VM instantly reboots.
> > > > >> Reverting commit 194a9749c73d ("x86/boot/compressed/64: Handle 5-level
> > > > >> paging boot if kernel is above 4G") fixes it.  I've attached our kernel
> > > > >> config for reference, and am happy to test patches, provide sample QCOW
> > > > >> images, etc.
> > > > >
> > > >
> > > > Also see https://bugzilla.kernel.org/show_bug.cgi?id=200385 ,
> > > >
> > > > 0a1756bd2897951c03c1cb671bdfd40729ac2177 is acting up
> > > > too with the same symptoms
> > >
> > > I tracked it down to -flto in LDFLAGS. I'll look more into this.
> >
> > And what sets -flto in LDFLAGS? I can't find anything in the kernel
> > build/Makefiles.
> 
> The kernel doesn't use -flto by default. Some people (and distros) set
> -flto in CFLAGS and LDFLAGS manually hoping to get a few extra
> optimizations.  This never caused any problems before 0a1756bd - would be
> nice to keep it working.

Maybe it never caused any obvious problems, but there is a reason why LTO
is not supported by the kernel, GCC and its LTO history being one of them.

Thanks,

	tglx
