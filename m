Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752985AbeDLPvY (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 11:51:24 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43234 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752761AbeDLPvX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 11:51:23 -0400
Subject: Re: [RFC v2 02/12] KVM: arm/arm64: Document
 KVM_VGIC_V3_ADDR_TYPE_REDIST_REGION
To: Christoffer Dall <cdall@kernel.org>
References: <1522159456-10419-1-git-send-email-eric.auger@redhat.com>
 <1522159456-10419-3-git-send-email-eric.auger@redhat.com>
 <20180409213852.GJ10904@cbox>
Cc: eric.auger.pro@gmail.com, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
        marc.zyngier@arm.com, peter.maydell@linaro.org, andre.przywara@arm.com,
        drjones@redhat.com, wei@redhat.com
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <ad884b2d-7809-70e6-c968-8411f43b915e@redhat.com>
Date: Thu, 12 Apr 2018 17:51:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20180409213852.GJ10904@cbox>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoffer,

> Hi Eric,
> 
> On Tue, Mar 27, 2018 at 04:04:06PM +0200, Eric Auger wrote:
>> We introduce a new KVM_VGIC_V3_ADDR_TYPE_REDIST_REGION attribute in
>> KVM_DEV_ARM_VGIC_GRP_ADDR group. It allows userspace to provide the
>> base address and size of a redistributor region
>>
>> Compared to KVM_VGIC_V3_ADDR_TYPE_REDIST, this new attribute allows
>> to declare several separate redistributor regions.
>>
>> So the whole redist space does not need to be contiguous anymore.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> ---
>>  Documentation/virtual/kvm/devices/arm-vgic-v3.txt | 18 ++++++++++++++++++
>>  1 file changed, 18 insertions(+)
>>
>> diff --git a/Documentation/virtual/kvm/devices/arm-vgic-v3.txt b/Documentation/virtual/kvm/devices/arm-vgic-v3.txt
>> index 9293b45..0ded904 100644
>> --- a/Documentation/virtual/kvm/devices/arm-vgic-v3.txt
>> +++ b/Documentation/virtual/kvm/devices/arm-vgic-v3.txt
>> @@ -27,6 +27,24 @@ Groups:
>>        VCPU and all of the redistributor pages are contiguous.
>>        Only valid for KVM_DEV_TYPE_ARM_VGIC_V3.
>>        This address needs to be 64K aligned.
>> +
>> +    KVM_VGIC_V3_ADDR_TYPE_REDIST_REGION (rw, 64-bit)
>> +      The attr field of kvm_device_attr encodes 3 values:
>> +      bits:     | 63   ....  52  |  51   ....   16 | 15 - 12  |11 - 0
>> +      values:   |     count      |       base      |  flags   | index
>> +      - index encodes the unique redistributor region index
>> +      - flags: reserved for future use, currently 0
>> +      - base field encodes bits [51:16] of the guest physical base address
>> +        of the first redistributor in the region. There are two 64K pages
>> +        for each VCPU and all of the redistributor pages are contiguous
> 
> should this be two 64K pages for the number of redistributors in this
> region as specified by count ?
yes it is, I will reword.
> 
>> +        within the redistributor region.
>> +      - count encodes the number of redistributors in the region.
> 
> I assume it's implied that the user must register a total number of
> redistributors across all the regions that matches the number of vcpus,
> and that otherwise something bad happens?

Yes the regions registered by the userspace must be large enough to
assign all the vcpu redistributors. Otherwise an error is produced on
first vcpu run (on map_resources). At that time the number of vcpu is
frozen and we can perform the check.

Thanks

Eric
> 
>> +      Only valid for KVM_DEV_TYPE_ARM_VGIC_V3.
>> +
>> +  It is invalid to mix calls with KVM_VGIC_V3_ADDR_TYPE_REDIST and
>> +  KVM_VGIC_V3_ADDR_TYPE_REDIST_REGION attributes. When attempted an
>> +  -EINVAL error is returned.
>> +
>>    Errors:
>>      -E2BIG:  Address outside of addressable IPA range
>>      -EINVAL: Incorrectly aligned address
>> -- 
>> 2.5.5
>>
> 
> Thanks,
> -Christoffer
> 
