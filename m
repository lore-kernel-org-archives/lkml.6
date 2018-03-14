Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752020AbeCNN1E (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 09:27:04 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34952 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751559AbeCNN1C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 09:27:02 -0400
Date: Wed, 14 Mar 2018 14:26:14 +0100
From: Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
To: "Moger, Babu" <Babu.Moger@amd.com>
Cc: "joro@8bytes.org" <joro@8bytes.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC 3/3] arch/x86/kvm: SVM: Introduce pause loop exit logic in
 SVM
Message-ID: <20180314132613.GB28943@flask>
References: <1520007456-85293-1-git-send-email-babu.moger@amd.com>
 <1520007456-85293-4-git-send-email-babu.moger@amd.com>
 <20180309181233.GO12290@flask>
 <CY4PR12MB1768CC12C6685127A947D02795DD0@CY4PR12MB1768.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CY4PR12MB1768CC12C6685127A947D02795DD0@CY4PR12MB1768.namprd12.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-03-10 05:07+0000, Moger, Babu:
> Radim,
>  Thanks for the comments. Taken care of most of the comments.
>  I have few questions/comments. Please see inline.
> 
> > -----Original Message-----
> > From: Radim Krčmář <rkrcmar@redhat.com>
> > Sent: Friday, March 9, 2018 12:13 PM
> > To: Moger, Babu <Babu.Moger@amd.com>
> > Cc: joro@8bytes.org; tglx@linutronix.de; mingo@redhat.com;
> > hpa@zytor.com; x86@kernel.org; pbonzini@redhat.com;
> > kvm@vger.kernel.org; linux-kernel@vger.kernel.org
> > Subject: Re: [RFC 3/3] arch/x86/kvm: SVM: Introduce pause loop exit logic in
> > SVM
> > 
> > 2018-03-02 11:17-0500, Babu Moger:
> > > Bring the PLE(pause loop exit) logic to AMD svm driver.
> > > We have noticed it help in situations where numerous pauses are
> > generated
> > > due to spinlock or other scenarios. Tested it with idle=poll and noticed
> > > pause interceptions go down considerably.
> > >
> > > Signed-off-by: Babu Moger <babu.moger@amd.com>
> > > ---
> > > @@ -1046,6 +1095,58 @@ static int avic_ga_log_notifier(u32 ga_tag)
> > >  	return 0;
> > >  }
> > >
> > > +static void grow_ple_window(struct kvm_vcpu *vcpu)
> > > +{
> > > +	struct vcpu_svm *svm = to_svm(vcpu);
> > > +	struct vmcb_control_area *control = &svm->vmcb->control;
> > > +	int old = control->pause_filter_count;
> > > +
> > > +	control->pause_filter_count = __grow_ple_window(old,
> > > +							pause_filter_count,
> > > +							ple_window_grow,
> > > +
> > 	ple_window_actual_max);
> > > +
> > > +	if (control->pause_filter_count != old)
> > > +		mark_dirty(svm->vmcb, VMCB_INTERCEPTS);
> > > +
> > > +	trace_kvm_ple_window_grow(vcpu->vcpu_id,
> > > +				  control->pause_filter_count, old);
> > 
> > Please move the tracing into __shrink_ple_window to share the code.
> > This probably belongs to patch [2/3].
> 
> I will have to pass vcpu_id, and have to make few changes to display old and new values.
> I am afraid it might add few more extra instructions.

Right, vcpu_id isn't available in that function.
Keeping it like this is ok.

> > 
> > > +/*
> > > + * ple_window_actual_max is computed to be one grow_ple_window()
> > below
> > > + * ple_window_max. (See __grow_ple_window for the reason.)
> > > + * This prevents overflows, because ple_window_max is int.
> > > + * ple_window_max effectively rounded down to a multiple of
> > ple_window_grow in
> > > + * this process.
> > > + * ple_window_max is also prevented from setting control-
> > >pause_filter_count <
> > > + * pause_filter_count.
> > > + */
> > > +static void update_ple_window_actual_max(void)
> > > +{
> > > +	ple_window_actual_max =
> > > +		__shrink_ple_window(max(ple_window_max,
> > pause_filter_count),
> > 
> > (I have no idea what I was thinking when I wrote that for VMX. :[
> >  I'll write a patch to get rid of ple_window_actual_max, because its
> >  benefits are really minuscule and the logic is complicated.)
> 
> If you are thinking of just straight forward removal, I can take care of it.

And tweaking the overflow handling to account for that.  Go ahead if
you'd like to.

> > 
> > > +				    pause_filter_count,
> > > +				    ple_window_grow, SHRT_MIN);
> > > +}
> > >  static __init int svm_hardware_setup(void)
> > >  {
> > >  	int cpu;
> > > @@ -1309,7 +1412,11 @@ static void init_vmcb(struct vcpu_svm *svm)
> > >  	svm->vcpu.arch.hflags = 0;
> > >
> > >  	if (boot_cpu_has(X86_FEATURE_PAUSEFILTER)) {
> > > -		control->pause_filter_count = 3000;
> > > +		control->pause_filter_count = pause_filter_count;
> > > +		if (boot_cpu_has(X86_FEATURE_PFTHRESHOLD))
> > > +			control->pause_filter_thresh = pause_filter_thresh;
> > > +		else
> > > +			pause_filter_thresh = 0;
> > 
> > Please move this to hardware_setup and also clear pause_filter_count if
> 
> Moving this to hardware_setup will be a problem.  We don't have access to svm data structure in hardware_setup.

I mean just the pause_filter_thresh = 0 and pause_filter_count = 0 logic
based on boot_cpu_has (it's weird if the user-visible parameters are
corrected after starting a VM);  VMCB configuration stays,

thanks.
