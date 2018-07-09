Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E93EC6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 10:47:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E677B20862
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 10:47:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E677B20862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932638AbeGIKrt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 06:47:49 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:56656 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932278AbeGIKrs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 06:47:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C2D217A9;
        Mon,  9 Jul 2018 03:47:47 -0700 (PDT)
Received: from [10.1.206.75] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6B8543F318;
        Mon,  9 Jul 2018 03:47:46 -0700 (PDT)
Subject: Re: [PATCH] KVM: arm64: vgic-its: Remove VLA usage
To:     Kees Cook <keescook@chromium.org>,
        Auger Eric <eric.auger@redhat.com>
Cc:     Christoffer Dall <christoffer.dall@arm.com>,
        Andre Przywara <andre.przywara@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
References: <20180629184618.GA37364@beast>
 <19f9ddb1-6009-850c-1949-3a8cdacdd2fc@redhat.com>
 <CAGXu5jJcqMX7HjvgqcR37jnuN48PtyHd+VVmfcQH6YfXXSpO_g@mail.gmail.com>
From:   Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <f213e03a-66a6-0c07-7bb8-2061b9c24731@arm.com>
Date:   Mon, 9 Jul 2018 11:47:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAGXu5jJcqMX7HjvgqcR37jnuN48PtyHd+VVmfcQH6YfXXSpO_g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi kees,

On 02/07/18 18:15, Kees Cook wrote:
> On Mon, Jul 2, 2018 at 12:36 AM, Auger Eric <eric.auger@redhat.com> wrote:
>> Hi Kees,
>>
>> On 06/29/2018 08:46 PM, Kees Cook wrote:
>>> In the quest to remove all stack VLA usage from the kernel[1], this
>>> switches to using a maximum size and adds sanity checks. Additionally
>>> cleans up some of the int-vs-u32 usage and adds additional bounds checking.
>>> As it currently stands, this will always be 8 bytes until the ABI changes.
>>>
>>> [1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com
>>>
>>> Cc: Christoffer Dall <christoffer.dall@arm.com>
>>> Cc: Marc Zyngier <marc.zyngier@arm.com>
>>> Cc: Eric Auger <eric.auger@redhat.com>
>>> Cc: Andre Przywara <andre.przywara@arm.com>
>>> Cc: linux-arm-kernel@lists.infradead.org
>>> Cc: kvmarm@lists.cs.columbia.edu
>>> Signed-off-by: Kees Cook <keescook@chromium.org>
>>> ---
>>>  virt/kvm/arm/vgic/vgic-its.c | 19 +++++++++++++++----
>>>  1 file changed, 15 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/virt/kvm/arm/vgic/vgic-its.c b/virt/kvm/arm/vgic/vgic-its.c
>>> index 4ed79c939fb4..3143fc047fcf 100644
>>> --- a/virt/kvm/arm/vgic/vgic-its.c
>>> +++ b/virt/kvm/arm/vgic/vgic-its.c
>>> @@ -168,8 +168,14 @@ struct vgic_its_abi {
>>>       int (*commit)(struct vgic_its *its);
>>>  };
>>>
>>> +#define ABI_0_ESZ    8
>>> +#define ESZ_MAX              ABI_0_ESZ
>>> +
>>>  static const struct vgic_its_abi its_table_abi_versions[] = {
>>> -     [0] = {.cte_esz = 8, .dte_esz = 8, .ite_esz = 8,
>>> +     [0] = {
>>> +      .cte_esz = ABI_0_ESZ,
>>> +      .dte_esz = ABI_0_ESZ,
>>> +      .ite_esz = ABI_0_ESZ,
>>>        .save_tables = vgic_its_save_tables_v0,
>>>        .restore_tables = vgic_its_restore_tables_v0,
>>>        .commit = vgic_its_commit_v0,
>>> @@ -180,10 +186,12 @@ static const struct vgic_its_abi its_table_abi_versions[] = {
>>>
>>>  inline const struct vgic_its_abi *vgic_its_get_abi(struct vgic_its *its)
>>>  {
>>> +     if (WARN_ON(its->abi_rev >= NR_ITS_ABIS))
>>> +             return NULL;
>>>       return &its_table_abi_versions[its->abi_rev];
>>>  }
>>>
>>> -int vgic_its_set_abi(struct vgic_its *its, int rev)
>>> +static int vgic_its_set_abi(struct vgic_its *its, u32 rev)
>>>  {
>> if vgic_its_get_abi is likely to return NULL, don't we need to check abi
>> != NULL in all call sites.
> 
> My thinking was that since it should never happen, a WARN_ON would be
> sufficient. But I can drop all these changes if you want. I just
> wanted to see the VLA removed. :)

Are you going to respin this patch limiting it to just the VLA changes?
I'm actively queuing stuff for the next merge window, and it'd be good
to get that one in.

Alternatively, I can drop the WARN_ONs myself. Just let me know.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
