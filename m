Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752604AbeETV2J (ORCPT <rfc822;w@1wt.eu>);
        Sun, 20 May 2018 17:28:09 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46094 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751451AbeETV2H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 May 2018 17:28:07 -0400
Subject: Re: [PATCH v6 00/12] KVM: arm/arm64: Allow multiple GICv3
 redistributor regions
To: Marc Zyngier <marc.zyngier@arm.com>
References: <1525088918-8600-1-git-send-email-eric.auger@redhat.com>
 <20180520144310.378a1712@why.wild-wind.fr.eu.org>
Cc: eric.auger.pro@gmail.com, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu, cdall@kernel.org,
        peter.maydell@linaro.org, andre.przywara@arm.com, drjones@redhat.com,
        wei@redhat.com
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <4c1617e2-2cee-d6d7-b2ae-135347c2fbb7@redhat.com>
Date: Sun, 20 May 2018 23:28:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20180520144310.378a1712@why.wild-wind.fr.eu.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On 05/20/2018 03:43 PM, Marc Zyngier wrote:
> Hi Eric,
> 
> On Mon, 30 Apr 2018 13:48:26 +0200
> Eric Auger <eric.auger@redhat.com> wrote:
> 
>> At the moment the KVM VGICv3 only supports a single redistributor
>> region (whose base address is set through the GICv3 kvm device
>> KVM_DEV_ARM_VGIC_GRP_ADDR/KVM_VGIC_V3_ADDR_TYPE_REDIST). There,
>> all the redistributors are laid out contiguously. The size of this
>> single redistributor region is not set explicitly but instead
>> induced at a late stage by the number of online vcpus.
>>
>> The GIC specification does not mandate all redistributors to be
>> contiguous. Moreover DT and ACPI were specified so that multiple
>> redistributors regions can be defined.
>>
>> The current interface brings a limitation on QEMU where ARM
>> virt machine available GPA holes only allowed to assign a
>> redistributor region fitting a max of 123 vcpus. Overcoming this
>> limitation would force either to create a new machine or relocate
>> the single rdist region or allow the allocation of multiple rdist
>> regions.
>>
>> This series enables this last alternative. A new GICv3 KVM device
>> KVM_DEV_ARM_VGIC_GRP_ADDR/KVM_VGIC_V3_ADDR_TYPE_REDIST_REGION allows
>> to register individual redistributor regions whose size is defined
>> explicitly. Those rdist regions then are filled by vcpu rdist frames
>> according to the need. The vgic init and related base address checks
>> are impacted.
> 
> I've taken this series for a test run, and noticed that it breaks
> kvmtool:
> 
> <quote>
> maz@sy-borg:~$ ./kvmtool/lkvm run -c 1 -k Image --irqchip=gicv3
>   # lkvm run -k Image -m 256 -c 1 --name guest-4929
>   Info: Loaded kernel to 0x80080000 (20126208 bytes)
>   Info: Placing fdt at 0x8fe00000 - 0x8fffffff
>   Info: virtio-mmio.devices=0x200@0x10000:36
> 
>   Info: virtio-mmio.devices=0x200@0x10200:37
> 
>   Info: virtio-mmio.devices=0x200@0x10400:38
> 
> KVM_RUN failed: No such device or address
> </quote>
> 
> Backing out the series results in a working setup.
> 
> I presume that the changes in the init has resulted in a stricter
> initialization order that matches the QEMU flow, but that kvmtool
> doesn't follow.
> 
> Could you please have a look at this? I'd like to have it in for 4.18,
> just without regressions... ;-)

Understood. Just sent a v7, tested with lkvm this time. It fixes the
issue for me. Also tested with qemu using the legacy RDIST and new
multiple RDIST API. I Took the risk to remove kvm_vgic_vcpu_early_init()
as it looks weird to me this gets called after the kvm_vgic_vcpu_init. I
was not able to figure out the rationale behind having this separate
init function. Hope I did not miss another use case.

Thanks

Eric
> 
> Thanks,
> 
> 	M.
> 
