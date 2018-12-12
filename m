Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4F84C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 04:48:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96D3D20851
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 04:48:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96D3D20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbeLLEsi convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 23:48:38 -0500
Received: from ozlabs.org ([203.11.71.1]:38011 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726220AbeLLEsh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 23:48:37 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43F4812KnBz9s0n;
        Wed, 12 Dec 2018 15:48:33 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Andrew Murray <andrew.murray@arm.com>
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
        "paulus\@samba.org" <paulus@samba.org>, Christoffer.Dall@arm.com
Subject: Re: [PATCH 10/10] perf/doc: update design.txt for exclude_{host|guest} flags
In-Reply-To: <20181211135903.GG13393@e119886-lin.cambridge.arm.com>
References: <1542363853-13849-1-git-send-email-andrew.murray@arm.com> <1542363853-13849-11-git-send-email-andrew.murray@arm.com> <87pnv00yuf.fsf@concordia.ellerman.id.au> <20181120133202.GH35798@e119886-lin.cambridge.arm.com> <87bm5sxqya.fsf@concordia.ellerman.id.au> <20181211135903.GG13393@e119886-lin.cambridge.arm.com>
Date:   Wed, 12 Dec 2018 15:48:32 +1100
Message-ID: <87sgz3wdsv.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Murray <andrew.murray@arm.com> writes:
> On Tue, Dec 11, 2018 at 10:06:53PM +1100, Michael Ellerman wrote:
>> [ Reviving old thread. ]
>> 
>> Andrew Murray <andrew.murray@arm.com> writes:
>> > On Tue, Nov 20, 2018 at 10:31:36PM +1100, Michael Ellerman wrote:
>> >> Andrew Murray <andrew.murray@arm.com> writes:
>> >> 
>> >> > Update design.txt to reflect the presence of the exclude_host
>> >> > and exclude_guest perf flags.
>> >> >
>> >> > Signed-off-by: Andrew Murray <andrew.murray@arm.com>
>> >> > ---
>> >> >  tools/perf/design.txt | 4 ++++
>> >> >  1 file changed, 4 insertions(+)
>> >> >
>> >> > diff --git a/tools/perf/design.txt b/tools/perf/design.txt
>> >> > index a28dca2..7de7d83 100644
>> >> > --- a/tools/perf/design.txt
>> >> > +++ b/tools/perf/design.txt
>> >> > @@ -222,6 +222,10 @@ The 'exclude_user', 'exclude_kernel' and 'exclude_hv' bits provide a
>> >> >  way to request that counting of events be restricted to times when the
>> >> >  CPU is in user, kernel and/or hypervisor mode.
>> >> >  
>> >> > +Furthermore the 'exclude_host' and 'exclude_guest' bits provide a way
>> >> > +to request counting of events restricted to guest and host contexts when
>> >> > +using virtualisation.
>> >> 
>> >> How does exclude_host differ from exclude_hv ?
>> >
>> > I believe exclude_host / exclude_guest are intented to distinguish
>> > between host and guest in the hosted hypervisor context (KVM).
>> 
>> OK yeah, from the perf-list man page:
>> 
>>            u - user-space counting
>>            k - kernel counting
>>            h - hypervisor counting
>>            I - non idle counting
>>            G - guest counting (in KVM guests)
>>            H - host counting (not in KVM guests)
>> 
>> > Whereas exclude_hv allows to distinguish between guest and
>> > hypervisor in the bare-metal type hypervisors.
>> 
>> Except that's exactly not how we use them on powerpc :)
>> 
>> We use exclude_hv to exclude "the hypervisor", regardless of whether
>> it's KVM or PowerVM (which is a bare-metal hypervisor).
>> 
>> We don't use exclude_host / exclude_guest at all, which I guess is a
>> bug, except I didn't know they existed until this thread.
>> 
>> eg, in a KVM guest:
>> 
>>   $ perf record -e cycles:G /bin/bash -c "for i in {0..100000}; do :;done"
>>   $ perf report -D | grep -Fc "dso: [hypervisor]"
>>   16
>> 
>> 
>> > In the case of arm64 - if VHE extensions are present then the host
>> > kernel will run at a higher privilege to the guest kernel, in which
>> > case there is no distinction between hypervisor and host so we ignore
>> > exclude_hv. But where VHE extensions are not present then the host
>> > kernel runs at the same privilege level as the guest and we use a
>> > higher privilege level to switch between them - in this case we can
>> > use exclude_hv to discount that hypervisor role of switching between
>> > guests.
>> 
>> I couldn't find any arm64 perf code using exclude_host/guest at all?
>
> Correct - but this is in flight as I am currently adding support for this
> see [1].

OK, so at least that will be consistent across arm64 & x86.

>> And I don't see any x86 code using exclude_hv.
>
> I can't find any either.

I think that's because they don't need it, because they don't let guests
program the PMU directly. It's all handled by the host and the host
doesn't let the guest count host cycles anyway. But I could be wrong I'm
no x86 expert.

>> But maybe that's OK, I just worry this is confusing for users.
>
> There is some extra context regarding this where exclude_guest/exclude_host
> was added, see [2]

Good find. I had looked at that commit, but the thread on the list is
more informative.

In fact there was even a man page update! Never occurred to me look
there :P

http://man7.org/linux/man-pages/man2/perf_event_open.2.html

       exclude_host (since Linux 3.2)
              When conducting measurements that include processes running VM
              instances (i.e., have executed a KVM_RUN ioctl(2)), only mea‐
              sure events happening inside a guest instance.  This is only
              meaningful outside the guests; this setting does not change
              counts gathered inside of a guest.  Currently, this function‐
              ality is x86 only.

       exclude_guest (since Linux 3.2)
              When conducting measurements that include processes running VM
              instances (i.e., have executed a KVM_RUN ioctl(2)), do not
              measure events happening inside guest instances.  This is only
              meaningful outside the guests; this setting does not change
              counts gathered inside of a guest.  Currently, this function‐
              ality is x86 only.


Which makes things much clearer.

Perhaps you want to add a reference to the man page in your text,
something like?

  Furthermore the 'exclude_host' and 'exclude_guest' bits provide a way
  to request counting of events restricted to guest and host contexts when
  using virtualisation. See the perf_event_open(2) man page for more
  detail.


cheers
