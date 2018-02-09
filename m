Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751099AbeBIP0E (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 10:26:04 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:53646 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751024AbeBIP0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 10:26:02 -0500
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] KVM: lapic: stop advertising DIRECTED_EOI when in-kernel
 IOAPIC is in use
From: Nikita Leshenko <nikita.leshchenko@oracle.com>
In-Reply-To: <20180209130133.28387-1-vkuznets@redhat.com>
Date: Fri, 9 Feb 2018 17:20:48 +0200
Cc: kvm <kvm@vger.kernel.org>, linux-kernel@vger.kernel.org,
        x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        =?utf-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Peter Xu <peterx@redhat.com>
Message-Id: <292414F1-6978-497E-9CE2-3847E171150B@oracle.com>
References: <20180209130133.28387-1-vkuznets@redhat.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>
X-Mailer: Apple Mail (2.3273)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8799 signatures=668665
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802090195
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w19FQ9wB019579

The patch looks correct, however I’m confused about why you consider
this to be a bug in the guest rather than a bug in KVM.

The spec for x2APIC states:
"The support for Directed EOI capability can be detected by means of
bit 24 in the Local APIC Version Register” (Intel’s x2APIC spec, 2.5.1
Directed EOI)
It seems to me that Windows did the right thing by testing for the
presence of directed EOI feature rather than implying it exists by
testing a version number. KVM did the wrong thing by advertising a
feature it doesn’t support.

Therefore I think that you should change the comment to something like
“KVM’s in-kernel IOAPIC doesn’t support Directed EOI register, so don’t
advertise this capability in the LAPIC Version Register.” instead of
talking about buggy guests, as it may confuse future readers of this
code.

Thanks,
Nikita
> On 9 Feb 2018, at 15:01, Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
> 
> Devices which use level-triggered interrupts under Windows 2016 with
> Hyper-V role enabled don't work: Windows disables EOI broadcast in SPIV
> unconditionally. Our in-kernel IOAPIC implementation emulates an old IOAPIC
> version which has no EOI register so EOI never happens.
> 
> The issue was discovered and discussed a while ago:
> https://urldefense.proofpoint.com/v2/url?u=https-3A__www.spinics.net_lists_kvm_msg148098.html&d=DwIBAg&c=RoP1YumCXCgaWHvlZYR8PZh8Bv7qIrMUB65eapI_JnE&r=JD7W0KpKqI3xo5AglC-aIVDRz_ysy5CrQRnZ9Jb7je0&m=GWIw1X7PvyWESZaIau591RwjCXYZTi6THVNSOEcdaxU&s=5QUI6ED5i6frC8BzcF_e7hp6Kd_OqAxkg0z73R-UIDI&e=
> 
> While this is a guest OS bug (it should check that IOAPIC has the required
> capabilities before disabling EOI broadcast) we can workaround it in KVM:
> advertising DIRECTED_EOI with in-kernel IOAPIC makes little sense anyway.
> 
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
> - Radim's suggestion was to disable DIRECTED_EOI unconditionally but I'm not
>  that radical :-) In theory, we may have multiple IOAPICs in userspace in
>  future and DIRECTED_EOI can be leveraged.
> ---
> arch/x86/kvm/lapic.c | 10 +++++++++-
> 1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
> index 924ac8ce9d50..5339287fee63 100644
> --- a/arch/x86/kvm/lapic.c
> +++ b/arch/x86/kvm/lapic.c
> @@ -321,8 +321,16 @@ void kvm_apic_set_version(struct kvm_vcpu *vcpu)
> 	if (!lapic_in_kernel(vcpu))
> 		return;
> 
> +	/*
> +	 * KVM emulates 82093AA datasheet (with in-kernel IOAPIC implementation)
> +	 * which doesn't have EOI register; Some buggy OSes (e.g. Windows with
> +	 * Hyper-V role) disable EOI broadcast in lapic not checking for IOAPIC
> +	 * version first and level-triggered interrupts never get EOIed in
> +	 * IOAPIC.
> +	 */
> 	feat = kvm_find_cpuid_entry(apic->vcpu, 0x1, 0);
> -	if (feat && (feat->ecx & (1 << (X86_FEATURE_X2APIC & 31))))
> +	if (feat && (feat->ecx & (1 << (X86_FEATURE_X2APIC & 31))) &&
> +	    !ioapic_in_kernel(vcpu->kvm))
> 		v |= APIC_LVR_DIRECTED_EOI;
> 	kvm_lapic_set_reg(apic, APIC_LVR, v);
> }
> -- 
> 2.14.3
> 
