Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751737AbeBTL0o (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 06:26:44 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49746 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751516AbeBTL0m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 06:26:42 -0500
Subject: Re: [PATCH v3 2/4] x86/speculation: Support "Enhanced IBRS" on future
 CPUs
To: David Woodhouse <dwmw@amazon.co.uk>, tglx@linutronix.de,
        karahmed@amazon.de, x86@kernel.org, kvm@vger.kernel.org,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        bp@alien8.de, peterz@infradead.org, jmattson@google.com,
        rkrcmar@redhat.com, arjan.van.de.ven@intel.com, dave.hansen@intel.com,
        mingo@kernel.org
References: <1519037457-7643-1-git-send-email-dwmw@amazon.co.uk>
 <1519037457-7643-3-git-send-email-dwmw@amazon.co.uk>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <79c73482-9509-e67a-da8f-43ba0cb6d0fa@redhat.com>
Date: Tue, 20 Feb 2018 12:26:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1519037457-7643-3-git-send-email-dwmw@amazon.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/02/2018 11:50, David Woodhouse wrote:
> Cope with this by trapping and emulating *all* access to SPEC_CTRL from
> KVM guests when the IBRS_ALL feature is present, so it can never be
> turned off. Guests who see IBRS_ALL should never do anything except
> turn it on at boot anyway. And if they didn't know about IBRS_ALL and
> they keep frobbing IBRS on every kernel entry/exit... well the vmexit
> for a no-op is probably going to be faster than they were expecting
> anyway, so they'll live.

The problem is, it isn't.  On a Haswell (which has fairly slow
SPEC_CTRL) toggling IBRS is 200 cycles.  This gives a context switch
time of around 2000 clock cycles with PTI enabled.

This is fairly awful, but with a vmexit cost of ~1100 cycles that goes
up to 2000+(1100-200)*2 = 3800.  That's more or less doubling the cost
of a system call.

With newer machines SPEC_CTRL cost goes down but vmexit cost doesn't, so
it's only worse.

For now, we really should do something like

	if (vmx->spec_ctrl != host_spec_ctrl)
		wrmsrl(MSR_IA32_SPEC_CTRL, host_spec_ctrl);
	else
		lfence();

which later can become

	if (vmx->spec_ctrl != host_spec_ctrl)
		wrmsrl(MSR_IA32_SPEC_CTRL, host_spec_ctrl);
	else {
		/* lfence not needed if host_spec_ctrl == 0 */
		if (static_cpu_has(BUG_REALLY_WANTS_IBRS))
			nospec_barrier();
	}

Paolo
