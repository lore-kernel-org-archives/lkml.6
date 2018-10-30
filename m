Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AF9CC2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 09:30:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D58520827
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 09:30:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D58520827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbeJ3SXR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 14:23:17 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:53413 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726212AbeJ3SXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 14:23:17 -0400
Received: from tmo-115-37.customers.d1-online.com ([80.187.115.37] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gHQLZ-0003Iy-Rf; Tue, 30 Oct 2018 10:30:02 +0100
Date:   Tue, 30 Oct 2018 10:30:00 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Kang, Luwei" <luwei.kang@intel.com>
cc:     Jim Mattson <jmattson@google.com>, kvm list <kvm@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?ISO-8859-2?Q?Radim_Kr=E8m=E1=F8?= <rkrcmar@redhat.com>,
        Joerg Roedel <joro@8bytes.org>,
        "songliubraving@fb.com" <songliubraving@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        "mattst88@gmail.com" <mattst88@gmail.com>,
        Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Marc Orr <marcorr@google.com>, Uros Bizjak <ubizjak@gmail.com>,
        "Christopherson, Sean J" <sean.j.christopherson@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Chao Peng <chao.p.peng@linux.intel.com>
Subject: RE: [PATCH v13 06/12] KVM: x86: Add Intel PT virtualization work
 mode
In-Reply-To: <82D7661F83C1A047AF7DC287873BF1E172BD64F1@SHSMSX101.ccr.corp.intel.com>
Message-ID: <alpine.DEB.2.21.1810301027480.5984@nanos.tec.linutronix.de>
References: <1540368316-12998-1-git-send-email-luwei.kang@intel.com> <1540368316-12998-7-git-send-email-luwei.kang@intel.com> <CALMp9eSNr_AedOLv+gcqayFQSpwxQnVdsJQSWG1qixwNUmQXzw@mail.gmail.com>
 <82D7661F83C1A047AF7DC287873BF1E172BD64F1@SHSMSX101.ccr.corp.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1282566447-1540891801=:5984"
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1282566447-1540891801=:5984
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

Kang,

On Thu, 25 Oct 2018, Kang, Luwei wrote:
> > > +#define SECONDARY_EXEC_PT_USE_GPA              0x01000000
> > > +#define VM_EXIT_CLEAR_IA32_RTIT_CTL            0x02000000
> > > +#define VM_ENTRY_LOAD_IA32_RTIT_CTL            0x00040000
> > 
> > Where are all of these bits documented? I'm looking at the latest SDM, volume 3 (325384-067US), and none of these bits aredocumented
> > there.
> 
> This part is in the " Intel® Architecture Instruction Set Extensions and Future Features Programming Reference"
> https://software.intel.com/sites/default/files/managed/c5/15/architecture-instruction-set-extensions-programming-reference.pdf
>

Yet another PDF which will change it's location sooner than later. Can you
please stick that into the kernel.org bugzilla and reference the BZ in the
change log, so we have something for posterity?

Thanks,

	tglx
--8323329-1282566447-1540891801=:5984--
