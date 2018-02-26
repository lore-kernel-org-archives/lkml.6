Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751823AbeBZWYH (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 17:24:07 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:47686 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751784AbeBZWYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 17:24:04 -0500
Date: Mon, 26 Feb 2018 17:23:55 -0500
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: Paolo Bonzini <pbonzini@redhat.com>, g@char.us.oracle.com
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        David Woodhouse <dwmw@amazon.co.uk>,
        KarimAllah Ahmed <karahmed@amazon.de>
Subject: Re: [PATCH] KVM: VMX: expose the host's ARCH_CAPABILITIES MSR to
 userspace
Message-ID: <20180226222355.GL22024@char.us.oracle.com>
References: <1519433546-33879-1-git-send-email-pbonzini@redhat.com>
 <20180226221300.GK22024@char.us.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180226221300.GK22024@char.us.oracle.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8816 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802260281
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 26, 2018 at 05:13:00PM -0500, Konrad Rzeszutek Wilk wrote:
> On Sat, Feb 24, 2018 at 01:52:26AM +0100, Paolo Bonzini wrote:
> > Use the new MSR feature framework to expose the ARCH_CAPABILITIES MSR to
> > userspace.  This way, userspace can access the capabilities even if it
> > does not have the permissions to read MSRs.
> 
> ... That is good but could you expand a bit of why it would want this?
> 
> I am 99% sure it is due to the lovely spectre_v2 mitigation but
> could you include that in the commit message so that in say a year
> folks would know what this is?
> 
> Also what branch is this based on? I am not seeing this vmx_get_msr_feature
> in kvm/master or kvm/linux-next ?

Ah I see you posted them! Sorry for that particular noise.
> > 
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > ---
> >  arch/x86/kvm/vmx.c | 12 +++++++++++-
> >  arch/x86/kvm/x86.c |  1 +
> >  2 files changed, 12 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
> > index 130fca0ea1bf..99689061e11e 100644
> > --- a/arch/x86/kvm/vmx.c
> > +++ b/arch/x86/kvm/vmx.c
> > @@ -3228,7 +3228,17 @@ static inline bool vmx_feature_control_msr_valid(struct kvm_vcpu *vcpu,
> >  
> >  static int vmx_get_msr_feature(struct kvm_msr_entry *msr)
> >  {
> > -	return 1;
> > +	switch (msr->index) {
> > +	case MSR_IA32_ARCH_CAPABILITIES:
> > +		if (!boot_cpu_has(X86_FEATURE_ARCH_CAPABILITIES))
> > +			return 1;
> > +		rdmsrl(msr->index, msr->data);
> > +		break;
> > +	default:
> > +		return 1;
> > +	}
> > +
> > +	return 0;
> >  }
> >  
> >  /*
> > diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> > index 54b4ed55945b..e9a8cc9e3b2b 100644
> > --- a/arch/x86/kvm/x86.c
> > +++ b/arch/x86/kvm/x86.c
> > @@ -1054,6 +1054,7 @@ bool kvm_rdpmc(struct kvm_vcpu *vcpu)
> >   * can be used by a hypervisor to validate requested CPU features.
> >   */
> >  static u32 msr_based_features[] = {
> > +	MSR_IA32_ARCH_CAPABILITIES,
> >  	MSR_F10H_DECFG,
> >  };
> >  
> > -- 
> > 1.8.3.1
> > 
