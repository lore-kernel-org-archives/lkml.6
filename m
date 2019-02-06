Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB99AC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 16:34:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7261B2186A
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 16:34:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TIxnOEO1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731056AbfBFQer (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 11:34:47 -0500
Received: from merlin.infradead.org ([205.233.59.134]:57604 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730520AbfBFQeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 11:34:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=yaqrHMtkzU0QfS0XgeidGPWlqi4N+n6MDShva+367LA=; b=TIxnOEO1Xs8s96dWklBgmEcOd
        G722pzE2uOrLogJBUCSYeZi7ZdL682QVAYxFRB9BB7brmIq+OYRzNFYWDpg1B3Pe4WLMVpGHpzbUI
        dPYE5p/X7WYKhWg6pdAmNGV/Hwh5A5ag64BADhof0WweGrTv65PFTOq8eLHZdHV1fS4JPXoD+RDmY
        GHYp6t2P9eibkf72gK3LlbM+2SxRuH4q63/h5Bq7HfY7Hb4EGb7kWd5ukB55RZUYd2WhSx2QbK2Wq
        fnH0tv1HPPahErKkrPAipv6p4+Lm9Zku3k8y0Zj2IHzoewl4EhnLVtj4j4byuNQ3Ipgw/0eo9gRN3
        d3kkatEyw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1grQ9Z-0003uP-4e; Wed, 06 Feb 2019 16:34:25 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 977382029F1D4; Wed,  6 Feb 2019 17:34:23 +0100 (CET)
Date:   Wed, 6 Feb 2019 17:34:23 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Luwei Kang <luwei.kang@intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org, songliubraving@fb.com,
        rkrcmar@redhat.com, zsm@chromium.org,
        alexander.shishkin@linux.intel.com, konrad.wilk@oracle.com,
        ak@linux.intel.com
Subject: Re: [PATCH 2/3] perf/x86/intel/pt: Inject PMI for KVM guest
Message-ID: <20190206163423.GI17564@hirez.programming.kicks-ass.net>
References: <1547928284-2915-1-git-send-email-luwei.kang@intel.com>
 <1547928284-2915-3-git-send-email-luwei.kang@intel.com>
 <94fdce1b-9c42-e551-3099-ef7c4071a6ba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94fdce1b-9c42-e551-3099-ef7c4071a6ba@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 06:02:27PM +0100, Paolo Bonzini wrote:
> On 19/01/19 21:04, Luwei Kang wrote:
> >  static struct pt_pmu pt_pmu;
> >  
> > @@ -1260,6 +1262,14 @@ void intel_pt_interrupt(void)
> >  	struct pt_buffer *buf;
> >  	struct perf_event *event = pt->handle.event;
> >  
> > +	if (pt->vcpu) {
> > +		/* Inject PMI to Guest */
> > +		kvm_make_request(KVM_REQ_PMI, pt->vcpu);
> > +		__set_bit(MSR_CORE_PERF_GLOBAL_OVF_CTRL_TRACE_TOPA_PMI_BIT,
> > +			(unsigned long *)&pt->vcpu->arch.pmu.global_status);
> > +		return;
> > +	}
> > +
> 
> There is no need to touch struct pt and to know details of KVM in
> arch/x86/events.  Please add a function pointer
> 
> 	void (*kvm_handle_pt_interrupt)(void);
> 
> to some header, and in handle_pmi_common do
> 
> 	if (unlikely(kvm_handle_intel_pt_interrupt))
> 		kvm_handle_intel_pt_interrupt();
> 	else
> 		intel_pt_interrupt();
> 
> The function pointer can be assigned in
> kvm_before_interrupt/kvm_after_interrupt just like you do now.
> 
> This should be a simpler patch too.

I know we do this in other places too; but it really is a very bad
pattern.

Exported function pointers are a fscking disaster waiting to happen.
There is nothing that limits access to kvm.o, any random module can try
and poke at it.

How about we extend perf_guest_info_callback with an arch section and
add:

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 5aeb4c74fb99..76ce804e72c1 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5835,6 +5835,9 @@ struct perf_guest_info_callbacks *perf_guest_cbs;
 
 int perf_register_guest_info_callbacks(struct perf_guest_info_callbacks *cbs)
 {
+	if (WARN_ON_ONCE(perf_guest_cbs))
+		return -EBUSY;
+
 	perf_guest_cbs = cbs;
 	return 0;
 }
@@ -5842,6 +5845,9 @@ EXPORT_SYMBOL_GPL(perf_register_guest_info_callbacks);
 
 int perf_unregister_guest_info_callbacks(struct perf_guest_info_callbacks *cbs)
 {
+	if (WARN_ON_ONCE(perf_guest_cbs != cbs))
+		return -EINVAL;
+
 	perf_guest_cbs = NULL;
 	return 0;
 }
