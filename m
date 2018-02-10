Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751343AbeBJCQ6 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 21:16:58 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:36658 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751122AbeBJCQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 21:16:57 -0500
MIME-Version: 1.0
Message-ID: <3b565dd4-0b90-4301-b918-aba529d54a81@default>
Date: Fri, 9 Feb 2018 18:16:39 -0800 (PST)
From: Liran Alon <liran.alon@oracle.com>
To: <pbonzini@redhat.com>
Cc: <mingo@redhat.com>, <chao.gao@intel.com>, <x86@kernel.org>,
        <tglx@linutronix.de>, <rkrcmar@redhat.com>,
        <linux-kernel@vger.kernel.org>, <hpa@zytor.com>, <kvm@vger.kernel.org>
Subject: Re: [PATCH] x86/kvm/vmx: Don't halt vcpu when L1 is injecting events
 to L2
X-Mailer: Zimbra on Oracle Beehive
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8800 signatures=668666
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802100026
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w1A2H3QI016879


----- pbonzini@redhat.com wrote:

> On 08/02/2018 13:09, Liran Alon wrote:
> > ----- pbonzini@redhat.com wrote:
> >> On 08/02/2018 06:13, Chao Gao wrote:
> > 
> > A possible patch to fix this is to change vmx_hwapic_irr_update()
> such that
> > if is_guest_mode(vcpu)==true, we should return max(max_irr, rvi) and
> return
> > that value into apic_has_interrupt_for_ppr().
> > Need to verify that it doesn't break other flows but I think it
> makes sense.
> > What do you think?
> 
> Yeah, I think it makes sense though I'd need to look a lot more at
> arch/x86/kvm/lapic.c and arch/x86/kvm/vmx.c to turn that into a
> patch!
> 
> Paolo

After thinking about this a bit more, I don't like my previous suggestion.
As we don't semantically want to change the value returned from kvm_apic_has_interrupt().
Instead, it makes more sense to change kvm_cpu_has_interrupt() to check for RVI>PPR
in case is_guest_mode(vcpu)==true.

Something like (partial theoretical patch):

@@ -97,6 +97,14 @@ int kvm_cpu_has_interrupt(struct kvm_vcpu *v)
        if (kvm_cpu_has_extint(v))
                return 1;
 
+       /*
+        * When running L2, L1 controls vmcs02 RVI via vmcs12.
+        * Therefore, it is possible RVI indicates pending interrupt
+        * for vCPU while LAPIC IRR is empty.
+        */
+       if (is_guest_mode(v) &&
+           (kvm_x86_ops->hwapic_has_interrupt(v) != -1))
+               return 1;
+
        return kvm_apic_has_interrupt(v) != -1; /* LAPIC */
 }

Where:

+static int vmx_get_rvi(void)
+{
+       return ((u8)vmcs_read16(GUEST_INTR_STATUS) & 0xff);
+}

+static int vmx_hwapic_has_interrupt(struct kvm_vcpu *vcpu)
+{
+       int vector = vmx_get_rvi(vcpu);
+       return kvm_apic_has_interrupt_for_vector(vector);
+}

+int kvm_apic_has_interrupt_for_vector(struct kvm_vcpu *vcpu, int vector)
+{
+       struct kvm_lapic *apic = vcpu->arch.apic;
+       u32 ppr;
+
+       if (!apic_enabled(apic))
+               return -1;
+
+       __apic_update_ppr(apic, &ppr);
+       return (((vector & 0xF0) > ppr) ? (vector) : (-1));
+}
+EXPORT_SYMBOL_GPL(kvm_apic_has_interrupt_for_vector);

Regards,
-Liran
