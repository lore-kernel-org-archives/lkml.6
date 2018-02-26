Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753974AbeBZOqW (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 09:46:22 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38528 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753418AbeBZOqS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 09:46:18 -0500
Subject: Re: [PATCH] KVM: X86: Allow userspace to define the microcode version
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Borislav Petkov <bp@alien8.de>, Wanpeng Li <kernellwp@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
References: <CANRm+Cxw2-8Cf+6cg_yZC+SD66uNA5RO+ZaoHHmkpHLzjCih=A@mail.gmail.com>
 <20180226113000.GC4377@pd.tnic>
 <CANRm+CzwY2yzKFXF7r=vfqDaHHoHxC221TSBtSHC2XtvkrQxHA@mail.gmail.com>
 <20180226114409.GD4377@pd.tnic>
 <46cecef2-b0fb-b0c2-bbf3-983328d52763@redhat.com>
 <20180226121509.GE4377@pd.tnic>
 <24cd527d-5287-f0be-ffe8-eab341bf1d94@redhat.com>
 <3866d359-0ef8-6a99-6254-84890be62b93@redhat.com>
 <20180226122205.GG4377@pd.tnic>
 <fb705c01-9bdd-9924-00c6-70d8ee940fb4@redhat.com>
 <20180226143912.GC22024@char.us.oracle.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9c58dff5-7fed-3fef-d996-56e9460e39b8@redhat.com>
Date: Mon, 26 Feb 2018 15:46:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180226143912.GC22024@char.us.oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/02/2018 15:39, Konrad Rzeszutek Wilk wrote:
> Perhaps both ideas should be done? The one Boris suggested (See below, not
> compile tested yet), and also this one? Keep in mind that other hypervisor
> offerings (say Xen, VMWare, etc) may have provided the correct microcode
> or not and it would be good for the OS to be comfortable running under them.

Yes, the patch below is definitely a good idea.  Can you send it to
Thomas and Ingo?

Thanks,

Paolo

> From 36ea81363c38942057b006ccaf2ef26708a894bb Mon Sep 17 00:00:00 2001
> From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> Date: Mon, 26 Feb 2018 09:35:01 -0500
> Subject: [PATCH] x86/spectre_v2: Don't check bad microcode versions when
>  running under hypervisors.
> 
> As:
>  1) We know they lie about the env anyhow (host mismatch)
>  2) Even if the hypervisor (Xen, KVM, VMWare, etc) provided
>     a valid "correct" value, it all gets to be very murky
>     when migration happens (do you provide the "new"
>     microcode of the machine?).
> 
> And in reality the cloud vendors are the ones that should make
> sure that the microcode that is running is correct and we should
> just sing lalalala and believe them.

More "trust" (as the comment says in the code below) than believe.

And perhaps the code would be more accurate if it said "hope" instead of
"trust". :)

Paolo

> 
> Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> ---
>  arch/x86/kernel/cpu/intel.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
> index d19e903214b4..87d044ce837f 100644
> --- a/arch/x86/kernel/cpu/intel.c
> +++ b/arch/x86/kernel/cpu/intel.c
> @@ -144,6 +144,13 @@ static bool bad_spectre_microcode(struct cpuinfo_x86 *c)
>  {
>  	int i;
>  
> +	/*
> +	 * We know that the hypervisor lie to us on the microcode version so
> +	 * we may as well trust that it is running the correct version.
> +	 */
> +	if (boot_cpu_has(X86_FEATURE_HYPERVISOR))
> +		return false;
> +
>  	for (i = 0; i < ARRAY_SIZE(spectre_bad_microcodes); i++) {
>  		if (c->x86_model == spectre_bad_microcodes[i].model &&
>  		    c->x86_stepping == spectre_bad_microcodes[i].stepping)
> 
