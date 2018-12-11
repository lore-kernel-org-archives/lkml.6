Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F24C2C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 13:59:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD0EB208E7
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 13:59:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD0EB208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbeLKN7I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 08:59:08 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:47876 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726286AbeLKN7H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 08:59:07 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 072651596;
        Tue, 11 Dec 2018 05:59:07 -0800 (PST)
Received: from localhost (unknown [10.37.6.11])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3F8CD3F59C;
        Tue, 11 Dec 2018 05:59:06 -0800 (PST)
Date:   Tue, 11 Dec 2018 13:59:03 +0000
From:   Andrew Murray <andrew.murray@arm.com>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        linux-alpha@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Joerg Roedel <joro@8bytes.org>,
        "paulus@samba.org" <paulus@samba.org>, Christoffer.Dall@arm.com
Subject: Re: [PATCH 10/10] perf/doc: update design.txt for
 exclude_{host|guest} flags
Message-ID: <20181211135903.GG13393@e119886-lin.cambridge.arm.com>
References: <1542363853-13849-1-git-send-email-andrew.murray@arm.com>
 <1542363853-13849-11-git-send-email-andrew.murray@arm.com>
 <87pnv00yuf.fsf@concordia.ellerman.id.au>
 <20181120133202.GH35798@e119886-lin.cambridge.arm.com>
 <87bm5sxqya.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bm5sxqya.fsf@concordia.ellerman.id.au>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 10:06:53PM +1100, Michael Ellerman wrote:
> [ Reviving old thread. ]
> 
> Andrew Murray <andrew.murray@arm.com> writes:
> > On Tue, Nov 20, 2018 at 10:31:36PM +1100, Michael Ellerman wrote:
> >> Andrew Murray <andrew.murray@arm.com> writes:
> >> 
> >> > Update design.txt to reflect the presence of the exclude_host
> >> > and exclude_guest perf flags.
> >> >
> >> > Signed-off-by: Andrew Murray <andrew.murray@arm.com>
> >> > ---
> >> >  tools/perf/design.txt | 4 ++++
> >> >  1 file changed, 4 insertions(+)
> >> >
> >> > diff --git a/tools/perf/design.txt b/tools/perf/design.txt
> >> > index a28dca2..7de7d83 100644
> >> > --- a/tools/perf/design.txt
> >> > +++ b/tools/perf/design.txt
> >> > @@ -222,6 +222,10 @@ The 'exclude_user', 'exclude_kernel' and 'exclude_hv' bits provide a
> >> >  way to request that counting of events be restricted to times when the
> >> >  CPU is in user, kernel and/or hypervisor mode.
> >> >  
> >> > +Furthermore the 'exclude_host' and 'exclude_guest' bits provide a way
> >> > +to request counting of events restricted to guest and host contexts when
> >> > +using virtualisation.
> >> 
> >> How does exclude_host differ from exclude_hv ?
> >
> > I believe exclude_host / exclude_guest are intented to distinguish
> > between host and guest in the hosted hypervisor context (KVM).
> 
> OK yeah, from the perf-list man page:
> 
>            u - user-space counting
>            k - kernel counting
>            h - hypervisor counting
>            I - non idle counting
>            G - guest counting (in KVM guests)
>            H - host counting (not in KVM guests)
> 
> > Whereas exclude_hv allows to distinguish between guest and
> > hypervisor in the bare-metal type hypervisors.
> 
> Except that's exactly not how we use them on powerpc :)
> 
> We use exclude_hv to exclude "the hypervisor", regardless of whether
> it's KVM or PowerVM (which is a bare-metal hypervisor).
> 
> We don't use exclude_host / exclude_guest at all, which I guess is a
> bug, except I didn't know they existed until this thread.
> 
> eg, in a KVM guest:
> 
>   $ perf record -e cycles:G /bin/bash -c "for i in {0..100000}; do :;done"
>   $ perf report -D | grep -Fc "dso: [hypervisor]"
>   16
> 
> 
> > In the case of arm64 - if VHE extensions are present then the host
> > kernel will run at a higher privilege to the guest kernel, in which
> > case there is no distinction between hypervisor and host so we ignore
> > exclude_hv. But where VHE extensions are not present then the host
> > kernel runs at the same privilege level as the guest and we use a
> > higher privilege level to switch between them - in this case we can
> > use exclude_hv to discount that hypervisor role of switching between
> > guests.
> 
> I couldn't find any arm64 perf code using exclude_host/guest at all?

Correct - but this is in flight as I am currently adding support for this
see [1].

> 
> And I don't see any x86 code using exclude_hv.

I can't find any either.

> 
> But maybe that's OK, I just worry this is confusing for users.

There is some extra context regarding this where exclude_guest/exclude_host
was added, see [2] and where exclude_hv was added, see [3]

Generally it seems that exclude_guest/exclude_host relies upon switching
counters off/on on guest/host switch code (which works well in the nested
virt case). Whereas exclude_hv tends to rely solely on hardware capability
based on privilege level (which works well in the bare metal case where
the guest doesn't run at same privilege as the host).

I think from the user perspective exclude_hv allows you to see your overhead
if you are a guest (i.e. work done by bare metal hypervisor associated with
you as the guest). Whereas exclude_guest/exclude_host doesn't allow you to
see events above you (i.e. the kernel hypervisor) if you are the guest...

At least that's how I read this, I've copied in others that may provide
more authoritative feedback.

[1] https://lists.cs.columbia.edu/pipermail/kvmarm/2018-December/033698.html
[2] https://www.spinics.net/lists/kvm/msg53996.html
[3] https://lore.kernel.org/patchwork/patch/143918/

Thanks,

Andrew Murray

> 
> cheers
