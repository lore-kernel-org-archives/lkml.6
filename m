Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933559AbeCSOP4 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 10:15:56 -0400
Received: from foss.arm.com ([217.140.101.70]:53088 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754380AbeCSOPy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 10:15:54 -0400
Subject: Re: [RFC 02/12] KVM: arm/arm64: Document
 KVM_VGIC_V3_ADDR_TYPE_REDIST_REGION
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, cdall@kernel.org,
        peter.maydell@linaro.org
Cc: andre.przywara@arm.com, drjones@redhat.com, wei@redhat.com
References: <1521451220-27754-1-git-send-email-eric.auger@redhat.com>
 <1521451220-27754-3-git-send-email-eric.auger@redhat.com>
From: Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <f00d314f-7f16-1785-b0e2-6d4d815514dc@arm.com>
Date: Mon, 19 Mar 2018 14:15:51 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1521451220-27754-3-git-send-email-eric.auger@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/03/18 09:20, Eric Auger wrote:
> We introduce a new KVM_VGIC_V3_ADDR_TYPE_REDIST_REGION attribute in
> KVM_DEV_ARM_VGIC_GRP_ADDR group. It allows userspace to provide the
> base address and size of a redistributor region
> 
> Compared to KVM_VGIC_V3_ADDR_TYPE_REDIST, this new attribute allows
> to declare several separate redistributor regions.
> 
> So the whole redist space does not need to be contiguous anymore.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>  Documentation/virtual/kvm/devices/arm-vgic-v3.txt | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/Documentation/virtual/kvm/devices/arm-vgic-v3.txt b/Documentation/virtual/kvm/devices/arm-vgic-v3.txt
> index 9293b45..2c0bedf 100644
> --- a/Documentation/virtual/kvm/devices/arm-vgic-v3.txt
> +++ b/Documentation/virtual/kvm/devices/arm-vgic-v3.txt
> @@ -27,6 +27,18 @@ Groups:
>        VCPU and all of the redistributor pages are contiguous.
>        Only valid for KVM_DEV_TYPE_ARM_VGIC_V3.
>        This address needs to be 64K aligned.
> +
> +    KVM_VGIC_V3_ADDR_TYPE_REDIST_REGION (rw, 64-bit)
> +      The attr field of kvm_device_attr encodes 3 values:
> +      bits:     | 63   ....  52  |  51   ....   12 |11 - 0
> +      values:   |     pfns       |       base      | index
> +      - index encodes the unique redistibutor region index
> +      - base field encodes bits [51:12] the guest physical base address
> +        of the first redistributor in the region. There are two 64K pages
> +        for each VCPU and all of the redistributor pages are contiguous
> +        within the redistributor region.

Why does base have to include bits [15:12] of the IPA? If it is 64kB
aligned (as it should), these bits are guaranteed to be 0. This also
avoid having to return -EINVAL in case of alignment problems.

> +      - pfns encodes the size of the region in 64kB pages.
> +      Only valid for KVM_DEV_TYPE_ARM_VGIC_V3.

"pfns" a bit of an odd name, and is a bit unnatural. Why don't we
instead encode the number of redistributors? You've already imposed that
a redistributor has 2 64kB pages, so let's take advantage of this by
saving yet another bit.

You could dedicate a couple of these bits as a selector for the ITS
version (v3, v4 or whatever comes after that, if ever...). Just make 0
the only valid version for the time being.

>    Errors:
>      -E2BIG:  Address outside of addressable IPA range
>      -EINVAL: Incorrectly aligned address
> 

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
