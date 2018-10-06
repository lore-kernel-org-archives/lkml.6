Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF984C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:19:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 851E42086D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:19:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 851E42086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbeJHWcB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 18:32:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58114 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726291AbeJHWcA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 18:32:00 -0400
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.25])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 24BEF3097030;
        Mon,  8 Oct 2018 15:19:47 +0000 (UTC)
Received: from amt.cnet (ovpn-112-5.gru2.redhat.com [10.97.112.5])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 135532016BE3;
        Mon,  8 Oct 2018 15:19:46 +0000 (UTC)
Received: from amt.cnet (localhost [127.0.0.1])
        by amt.cnet (Postfix) with ESMTP id C9EF0105144;
        Sat,  6 Oct 2018 17:49:55 -0300 (BRT)
Received: (from marcelo@localhost)
        by amt.cnet (8.14.7/8.14.7/Submit) id w96Knd2T029932;
        Sat, 6 Oct 2018 17:49:39 -0300
Date:   Sat, 6 Oct 2018 17:49:34 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim Krcmar <rkrcmar@redhat.com>,
        Wanpeng Li <kernellwp@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Matt Rickard <matt@softrans.com.au>,
        Stephen Boyd <sboyd@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Florian Weimer <fweimer@redhat.com>,
        KY Srinivasan <kys@microsoft.com>,
        devel@linuxdriverproject.org,
        Linux Virtualization <virtualization@lists.linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Juergen Gross <jgross@suse.com>
Subject: Re: [patch 00/11] x86/vdso: Cleanups, simmplifications and CLOCK_TAI
 support
Message-ID: <20181006204932.GA27822@amt.cnet>
References: <20180914125006.349747096@linutronix.de>
 <CALCETrU+jP2hPLoJWTYJKTvr7-=YLwtk1=cZ_uizHYQZ1z4P-w@mail.gmail.com>
 <87sh1ne64t.fsf@vitty.brq.redhat.com>
 <20181003190617.GC21381@amt.cnet>
 <87k1mycfju.fsf@vitty.brq.redhat.com>
 <20181004081100.GI19272@hirez.programming.kicks-ass.net>
 <B8C05946-43BB-40A4-A564-53904FAF8CC0@amacapital.net>
 <20181004193150.GQ19272@hirez.programming.kicks-ass.net>
 <499807AB-E779-40C3-AA3F-E8C77A7770EC@amacapital.net>
 <CALCETrXNKCNZzUXj=2sp1vBd_o7HHzfW6RwyY5v3-wMfbVaZnQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrXNKCNZzUXj=2sp1vBd_o7HHzfW6RwyY5v3-wMfbVaZnQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.25
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Mon, 08 Oct 2018 15:19:47 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 04, 2018 at 03:15:32PM -0700, Andy Lutomirski wrote:
> For better or for worse, I'm trying to understand this code.  So far,
> I've come up with this patch:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/luto/linux.git/commit/?h=x86/vdso-tglx&id=14fd71e12b1c4492a06f368f75041f263e6862bf
> 
> Is it correct, or am I missing some subtlety?

"In the non-fallback case, a bunch of gnarly arithmetic is done: a
hopefully matched pair of (TSC, boot time) is read, then all locks
are dropped, then the TSC frequency is read, a branch new multiplier
and shift is read, and the result is turned into a time.

This seems quite racy to me.  Because locks are not held, I don't
see what keeps TSC frequency used in sync with the master clock
data."

If tsc_khz changes, the host TSC clocksource will not be used, which 
disables masterclock:

if ((val == CPUFREQ_PRECHANGE  && freq->old < freq->new) ||
                        (val == CPUFREQ_POSTCHANGE && freq->old >
freq->new)) {
                *lpj = cpufreq_scale(loops_per_jiffy_ref, ref_freq,
freq->new);

                tsc_khz = cpufreq_scale(tsc_khz_ref, ref_freq,
freq->new);
                if (!(freq->flags & CPUFREQ_CONST_LOOPS))
                        mark_tsc_unstable("cpufreq changes");

In which case it ends up in:

-	spin_lock(&ka->pvclock_gtod_sync_lock);
-	if (!ka->use_master_clock) {
-		spin_unlock(&ka->pvclock_gtod_sync_lock);
-		return ktime_get_boot_ns() + ka->kvmclock_offset;
-	}

masterclock -> non masterclock transition sets
a REQUEST bit on each vCPU, so as to invalidate any previous
clock reads.

static void kvm_gen_update_masterclock(struct kvm *kvm)
{
#ifdef CONFIG_X86_64
        int i;
        struct kvm_vcpu *vcpu;
        struct kvm_arch *ka = &kvm->arch;

        spin_lock(&ka->pvclock_gtod_sync_lock);
        kvm_make_mclock_inprogress_request(kvm);
        /* no guest entries from this point */
        pvclock_update_vm_gtod_copy(kvm);

        kvm_for_each_vcpu(i, vcpu, kvm)
                kvm_make_request(KVM_REQ_CLOCK_UPDATE, vcpu);

        /* guest entries allowed */
        kvm_for_each_vcpu(i, vcpu, kvm)
                kvm_clear_request(KVM_REQ_MCLOCK_INPROGRESS, vcpu);

        spin_unlock(&ka->pvclock_gtod_sync_lock);
#endif



        /*
         * If the host uses TSC clock, then passthrough TSC as stable
         * to the guest.
         */
        host_tsc_clocksource = kvm_get_time_and_clockread(
                                        &ka->master_kernel_ns,
                                        &ka->master_cycle_now);

        ka->use_master_clock = host_tsc_clocksource && vcpus_matched
                                && !ka->backwards_tsc_observed
                                && !ka->boot_vcpu_runs_old_kvmclock;




