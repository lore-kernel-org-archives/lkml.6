Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751824AbeC0K7T (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 06:59:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37062 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751030AbeC0K7R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 06:59:17 -0400
Date: Tue, 27 Mar 2018 12:59:11 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, borntraeger@de.ibm.com,
        kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com,
        alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com,
        alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com,
        jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com,
        berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com
Subject: Re: [PATCH v3 03/14] KVM: s390: CPU model support for AP
 virtualization
Message-ID: <20180327125911.5c7ecf34.cohuck@redhat.com>
In-Reply-To: <1521051954-25715-4-git-send-email-akrowiak@linux.vnet.ibm.com>
References: <1521051954-25715-1-git-send-email-akrowiak@linux.vnet.ibm.com>
        <1521051954-25715-4-git-send-email-akrowiak@linux.vnet.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Mar 2018 14:25:43 -0400
Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:

> Introduces a new CPU model feature and two CPU model
> facilities to support AP virtualization for KVM guests.
> 
> CPU model feature:
> 
> The KVM_S390_VM_CPU_FEAT_AP feature indicates that
> AP instructions are available on the guest. This
> feature will be enabled by the kernel only if the AP
> instructions are installed on the linux host. This feature
> must be specifically turned on for the KVM guest from
> userspace to use the VFIO AP device driver for guest
> access to AP devices.
> 
> CPU model facilities:
> 
> 1. AP Query Configuration Information (QCI) facility is installed.
> 
>    This is indicated by setting facilities bit 12 for
>    the guest. The kernel will not enable this facility
>    for the guest if it is not set on the host. This facility
>    must not be set by userspace if the KVM_S390_VM_CPU_FEAT_AP
>    feature is not installed.
> 
> 2. AP Facilities Test facility (APFT) is installed.
> 
>    This is indicated by setting facilities bit 15 for
>    the guest. The kernel will not enable this facility for
>    the guest if it is not set on the host. This facility
>    must not be set by userspace if the KVM_S390_VM_CPU_FEAT_AP
>    feature is not installed.
> 
> Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Reviewed-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
> ---
>  arch/s390/include/asm/kvm_host.h |    1 +
>  arch/s390/include/uapi/asm/kvm.h |    1 +
>  arch/s390/kvm/kvm-s390.c         |    4 ++++
>  arch/s390/tools/gen_facilities.c |    2 ++
>  4 files changed, 8 insertions(+), 0 deletions(-)
> 

> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index c47731d..a60c45b 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -350,6 +350,10 @@ static void kvm_s390_cpu_feat_init(void)
>  
>  	if (MACHINE_HAS_ESOP)
>  		allow_cpu_feat(KVM_S390_VM_CPU_FEAT_ESOP);
> +
> +	if (ap_instructions_installed()) /* AP instructions installed on host */
> +		allow_cpu_feat(KVM_S390_VM_CPU_FEAT_AP);

That's another dependency of the base kvm-s390 module on zcrypt, which
I don't like at all.

There are two possibilities here:
- Exposing the features makes sense even if no zcrypt driver is active
  in the host. Then, ap_instructions_installed() needs to be moved into
  always-built code (see my comments for the interface in patch 1).
- Exposing the features makes sense only if we actually want to make
  vfio-ap available. Then we should provide the proper check in the
  vfio-ap parts (which depends on zcrypt) and stub it out if vfio-ap is
  not configured.

> +
>  	/*
>  	 * We need SIE support, ESOP (PROT_READ protection for gmap_shadow),
>  	 * 64bit SCAO (SCA passthrough) and IDTE (for gmap_shadow unshadowing).
