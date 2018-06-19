Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F0E0C1B0F1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 22:31:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BCC620661
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 22:31:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BCC620661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joshtriplett.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753931AbeFSWbm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 18:31:42 -0400
Received: from mslow2.mail.gandi.net ([217.70.178.242]:54262 "EHLO
        slow1-d.mail.gandi.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751032AbeFSWbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 18:31:39 -0400
Received: from relay11.mail.gandi.net (unknown [217.70.178.231])
        by slow1-d.mail.gandi.net (Postfix) with ESMTP id 4BC1A3A4F73;
        Tue, 19 Jun 2018 23:49:06 +0200 (CEST)
Received: from localhost (jfdmzpr03-ext.jf.intel.com [134.134.139.72])
        (Authenticated sender: josh@joshtriplett.org)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 335AA10000F;
        Tue, 19 Jun 2018 21:48:44 +0000 (UTC)
Date:   Tue, 19 Jun 2018 14:48:33 -0700
From:   Josh Triplett <josh@joshtriplett.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, x86@kernel.org,
        platform-driver-x86@vger.kernel.org, dave.hansen@intel.com,
        sean.j.christopherson@intel.com, nhorman@redhat.com,
        npmccallum@redhat.com, Alexei Starovoitov <ast@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        "David S. Miller" <davem@davemloft.net>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>,
        "open list:INTEL SGX" <intel-sgx-kernel-dev@lists.01.org>,
        Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        "open list:KERNEL VIRTUAL MACHINE FOR X86 (KVM/x86)" 
        <kvm@vger.kernel.org>, Len Brown <len.brown@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:CRYPTO API" <linux-crypto@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:SPARSE CHECKER" <linux-sparse@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Vikas Shivappa <vikas.shivappa@linux.intel.com>
Subject: Re: [PATCH v11 00/13] Intel SGX1 support
Message-ID: <20180619214833.GA5873@localhost>
References: <20180608171216.26521-1-jarkko.sakkinen@linux.intel.com>
 <20180612105011.GA26931@amd>
 <20180619145943.GC8034@linux.intel.com>
 <20180619200414.GA3143@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180619200414.GA3143@amd>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 10:04:15PM +0200, Pavel Machek wrote:
> On Tue 2018-06-19 17:59:43, Jarkko Sakkinen wrote:
> > On Tue, Jun 12, 2018 at 12:50:12PM +0200, Pavel Machek wrote:
> > > On Fri 2018-06-08 19:09:35, Jarkko Sakkinen wrote:
> > > > Intel(R) SGX is a set of CPU instructions that can be used by applications
> > > > to set aside private regions of code and data. The code outside the enclave
> > > > is disallowed to access the memory inside the enclave by the CPU access
> > > > control.  In a way you can think that SGX provides inverted sandbox. It
> > > > protects the application from a malicious host.
> > > 
> > > Do you intend to allow non-root applications to use SGX?
> > > 
> > > What are non-evil uses for SGX?
> > > 
> > > ...because it is quite useful for some kinds of evil:
> > 
> > The default permissions for the device are 600.
> 
> Good. This does not belong to non-root.

There are entirely legitimate use cases for using this as an
unprivileged user. However, that'll be up to system and distribution
policy, which can evolve over time, and it makes sense for the *initial*
kernel permission to start out root-only and then adjust permissions via
udev.

> What are some non-evil uses for SGX?

Building a software certificate store. Hardening key-agent software like
ssh-agent or gpg-agent. Building a challenge-response authentication
system. Providing more assurance that your server infrastructure is
uncompromised. Offloading computation to a system without having to
fully trust that system.

As one of many possibilities, imagine a distcc that didn't have to trust
the compile nodes. The compile nodes could fail to return results at
all, but they couldn't alter the results.
