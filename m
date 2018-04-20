Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754014AbeDTAzJ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 20:55:09 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:38691 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753761AbeDTAzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 20:55:07 -0400
X-Google-Smtp-Source: AIpwx49fWZuUPXKYnINXKocCK63BGuAqaN6tuK23+OjEPj9v5L3SyCNLjCqg2aTOqXBugTShTGlVXkXX0bUJcBTiH1M=
MIME-Version: 1.0
In-Reply-To: <20180419160929.2c2f5e1b.cohuck@redhat.com>
References: <1524141040-50214-1-git-send-email-wanpengli@tencent.com>
 <20180419150641.5922e7e1.cohuck@redhat.com> <KL1PR02MB1301D3C3A62E6CED2530496180B50@KL1PR02MB1301.apcprd02.prod.outlook.com>
 <20180419160929.2c2f5e1b.cohuck@redhat.com>
From: Wanpeng Li <kernellwp@gmail.com>
Date: Fri, 20 Apr 2018 08:55:06 +0800
Message-ID: <CANRm+CxRJKgAgZ7NNBAEZfHTE6=TUP0UCQuksHFpc=efrbeZeA@mail.gmail.com>
Subject: Re: [PATCH] KVM: X86: Extend MAX_IRQ_ROUTES to 4096
To: Cornelia Huck <cohuck@redhat.com>
Cc: Wanpeng Li <wanpeng.li@hotmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Tonny Lu <tonnylu@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3K0tFNg012480

2018-04-19 22:09 GMT+08:00 Cornelia Huck <cohuck@redhat.com>:
> On Thu, 19 Apr 2018 13:42:55 +0000
> Wanpeng Li <wanpeng.li@hotmail.com> wrote:
>
>> On Thu, 19 Apr 2018 05:30:40 -0700
>>
>> Wanpeng Li <kernellwp@gmail.com> wrote:
>>
>> > From: Wanpeng Li <wanpengli@tencent.com>
>> >
>> > Our virtual machines make use of device assignment by configuring
>> > 12 NVMe disks for high I/O performance. Each NVMe device has 129
>> > MSI-X Table entries:
>> > Capabilities: [50] MSI-X: Enable+ Count=129 Masked-Vector table: BAR=0 offset=00002000
>> > The windows virtual machines fail to boot since they will map the number of
>> > MSI-table entries that the NVMe hardware reported to the bus to msi routing
>> > table, this will exceed the 1024. This patch extends MAX_IRQ_ROUTES to 4096,
>> > In the future this might be extended if needed.
>> >
>> > Cc: Paolo Bonzini <pbonzini@redhat.com>
>> > Cc: Radim Krčmář <rkrcmar@redhat.com>
>> > Cc: Tonny Lu <tonnylu@tencent.com>
>> > Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
>> > Signed-off-by: Tonny Lu <tonnylu@tencent.com>
>> > ---
>> >  include/linux/kvm_host.h | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
>> > index 6930c63..815ae66 100644
>> > --- a/include/linux/kvm_host.h
>> > +++ b/include/linux/kvm_host.h
>> > @@ -1050,7 +1050,7 @@ static inline int mmu_notifier_retry(struct kvm *kvm, unsigned long mmu_seq)
>> >  #elif defined(CONFIG_ARM64)
>> >  #define KVM_MAX_IRQ_ROUTES 4096
>> >  #else
>> > -#define KVM_MAX_IRQ_ROUTES 1024
>> > +#define KVM_MAX_IRQ_ROUTES 4096
>> >  #endif
>> >
>> >  bool kvm_arch_can_set_irq_routing(struct kvm *kvm);
>>
>> So, this basically means we have 4096 everywhere, no?
>>
>> I suspect different architectures maybe extend to different limits again according to their requirements.
>
> Yes, but for now, we have the same everywhere (as you also bumped the
> limit on power and 32-bit arm, implicitly). If that's ok, we might as

I suspect they will have the same issue when configured as our
production environment, so v2 gets rid of the ifdeffey.

Regards,
Wanpeng Li
