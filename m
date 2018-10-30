Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D84DC6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 10:01:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C849720823
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 10:01:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C849720823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbeJ3Sxw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 14:53:52 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:53533 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbeJ3Sxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 14:53:52 -0400
Received: from tmo-115-37.customers.d1-online.com ([80.187.115.37] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gHQp7-0003og-LD; Tue, 30 Oct 2018 11:00:33 +0100
Date:   Tue, 30 Oct 2018 11:00:31 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Paolo Bonzini <pbonzini@redhat.com>
cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Luwei Kang <luwei.kang@intel.com>, kvm@vger.kernel.org,
        x86@kernel.org, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        rkrcmar@redhat.com, joro@8bytes.org, songliubraving@fb.com,
        peterz@infradead.org, kstewart@linuxfoundation.org,
        gregkh@linuxfoundation.org, thomas.lendacky@amd.com,
        konrad.wilk@oracle.com, mattst88@gmail.com,
        Janakarajan.Natarajan@amd.com, dwmw@amazon.co.uk,
        jpoimboe@redhat.com, marcorr@google.com, ubizjak@gmail.com,
        sean.j.christopherson@intel.com, jmattson@google.com,
        linux-kernel@vger.kernel.org,
        Chao Peng <chao.p.peng@linux.intel.com>
Subject: Re: [PATCH v13 08/12] KVM: x86: Add Intel PT context switch for each
 vcpu
In-Reply-To: <bc192976-2c56-3cfc-a697-cf941a92ad0a@redhat.com>
Message-ID: <alpine.DEB.2.21.1810301058060.5984@nanos.tec.linutronix.de>
References: <1540368316-12998-1-git-send-email-luwei.kang@intel.com> <1540368316-12998-9-git-send-email-luwei.kang@intel.com> <87a7n37iuf.fsf@ashishki-desk.ger.corp.intel.com> <bc192976-2c56-3cfc-a697-cf941a92ad0a@redhat.com>
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

On Mon, 29 Oct 2018, Paolo Bonzini wrote:
> On 24/10/2018 12:13, Alexander Shishkin wrote:
> > Luwei Kang <luwei.kang@intel.com> writes:
> >> +	/*
> >> +	 * Set guest state of MSR_IA32_RTIT_CTL MSR (PT will be disabled
> >> +	 * on VM entry when it has been disabled in guest before).
> >> +	 */
> >> +	vmcs_write64(GUEST_IA32_RTIT_CTL, vmx->pt_desc.guest.ctl);
> >> +
> >> +	if (vmx->pt_desc.guest.ctl & RTIT_CTL_TRACEEN) {
> >> +		wrmsrl(MSR_IA32_RTIT_CTL, 0);
> >> +		pt_save_msr(&vmx->pt_desc.host, vmx->pt_desc.addr_range);
> >> +		pt_load_msr(&vmx->pt_desc.guest, vmx->pt_desc.addr_range);
> >> +	}
> >> +}
> > 
> > From my side this is still a NAK, because [1].
> > 
> > [1] https://marc.info/?l=kvm&m=153847567226248&w=2
> 
> Then you should have replied to
> https://marc.info/?l=kvm&m=153865386015249&w=2 instead of having Luwei
> do the work for nothing.
> 
> Quoting from there:
> 
> >> One shouldn't have to enable or disable anything in KVM to stop it from
> >> breaking one's existing workflow. That makes no sense.
> > 
> > If you "have to enable or disable anything" it means you have to
> > override the default.  But the default in this patches is "no change
> > compared to before the patches", leaving tracing of both host and guest
> > entirely to the host, so I don't understand your remark.  What workflow
> > is broken?
> > 
> >> There already are controls in perf that enable/disable guest tracing.
> > 
> > You are confusing "tracing guest from the host" and "the guest can trace
> > itself".  This patchset is adding support for the latter, and that
> > affects directly whether the tracing CPUID leaf can be added to the
> > guest.  Therefore it's not perf that can decide whether to turn it on;
> > KVM must know it when /dev/kvm is opened, which is why it is a module
> > parameter.
> 
> I'd be happier if we found an agreement, but without discussion that
> just won't happen.

So at least we need a way for perf on the host to programmatically detect,
that 'guest traces itself' is enabled, so it can inject that information
into the host data and post processing can tell that. W/o something like
that it's going to be a FAQ.

Thanks,

	tglx


