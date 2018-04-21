Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752838AbeDUAiT (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 20:38:19 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:44826 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752715AbeDUAiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 20:38:17 -0400
X-Google-Smtp-Source: AB8JxZqC6N6DDb0mhsQXvsVLHEfwCQpCG/G7zJSynu1ky1UeMTLWRT3cGFNcJ8o9riY8f/rv+BM/eZoE2fthlpp63wA=
MIME-Version: 1.0
In-Reply-To: <20180420162155.675d516d.cohuck@redhat.com>
References: <1524185248-51744-1-git-send-email-wanpengli@tencent.com>
 <20180420091537.1c6cb06b.cohuck@redhat.com> <CANRm+CxTDFu4C7bB_9e2a4Wi3BKDvc-RrX3Pj4Q5SRdZHmO-BA@mail.gmail.com>
 <20180420162155.675d516d.cohuck@redhat.com>
From: Wanpeng Li <kernellwp@gmail.com>
Date: Sat, 21 Apr 2018 08:38:16 +0800
Message-ID: <CANRm+CwQB_EBK_GSF-Nrm6kfpQoNZJmg+N382B+d4YVNjj_gOA@mail.gmail.com>
Subject: Re: [PATCH v2] KVM: Extend MAX_IRQ_ROUTES to 4096 for all archs
To: Cornelia Huck <cohuck@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Tonny Lu <tonnylu@tencent.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3L0cV4p000998

2018-04-20 22:21 GMT+08:00 Cornelia Huck <cohuck@redhat.com>:
> On Fri, 20 Apr 2018 21:51:13 +0800
> Wanpeng Li <kernellwp@gmail.com> wrote:
>
>> 2018-04-20 15:15 GMT+08:00 Cornelia Huck <cohuck@redhat.com>:
>> > On Thu, 19 Apr 2018 17:47:28 -0700
>> > Wanpeng Li <kernellwp@gmail.com> wrote:
>> >
>> >> From: Wanpeng Li <wanpengli@tencent.com>
>> >>
>> >> Our virtual machines make use of device assignment by configuring
>> >> 12 NVMe disks for high I/O performance. Each NVMe device has 129
>> >> MSI-X Table entries:
>> >> Capabilities: [50] MSI-X: Enable+ Count=129 Masked-Vector table: BAR=0 offset=00002000
>> >> The windows virtual machines fail to boot since they will map the number of
>> >> MSI-table entries that the NVMe hardware reported to the bus to msi routing
>> >> table, this will exceed the 1024. This patch extends MAX_IRQ_ROUTES to 4096
>> >> for all archs, in the future this might be extended again if needed.
>> >>
>> >> Cc: Paolo Bonzini <pbonzini@redhat.com>
>> >> Cc: Radim Krčmář <rkrcmar@redhat.com>
>> >> Cc: Tonny Lu <tonnylu@tencent.com>
>> >> Cc: Cornelia Huck <cohuck@redhat.com>
>> >> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
>> >> Signed-off-by: Tonny Lu <tonnylu@tencent.com>
>> >> ---
>> >> v1 -> v2:
>> >>  * extend MAX_IRQ_ROUTES to 4096 for all archs
>> >>
>> >>  include/linux/kvm_host.h | 6 ------
>> >>  1 file changed, 6 deletions(-)
>> >>
>> >> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
>> >> index 6930c63..0a5c299 100644
>> >> --- a/include/linux/kvm_host.h
>> >> +++ b/include/linux/kvm_host.h
>> >> @@ -1045,13 +1045,7 @@ static inline int mmu_notifier_retry(struct kvm *kvm, unsigned long mmu_seq)
>> >>
>> >>  #ifdef CONFIG_HAVE_KVM_IRQ_ROUTING
>> >>
>> >> -#ifdef CONFIG_S390
>> >>  #define KVM_MAX_IRQ_ROUTES 4096 //FIXME: we can have more than that...
>> >
>> > What about /* might need extension/rework in the future */ instead of
>> > the FIXME?
>>
>> Yeah, I guess the maintainers can help to fix it when applying. :)
>>
>> >
>> > As far as I understand, 4096 should cover most architectures and the
>> > sane end of s390 configurations, but will not be enough at the scarier
>> > end of s390. (I'm not sure how much it matters in practice.)
>> >
>> > Do we want to make this a tuneable in the future? Do some kind of
>> > dynamic allocation? Not sure whether it is worth the trouble.
>>
>> I think keep as it is currently.
>
> My main question here is how long this is enough... the number of
> virtqueues per device is up to 1K from the initial 64, which makes it
> possible to hit the 4K limit with fewer virtio devices than before (on
> s390, each virtqueue uses a routing table entry). OTOH, we don't want
> giant tables everywhere just to accommodate s390.

I suspect there is no real scenario to futher extend for s390 since no
guys report.

> If the s390 maintainers tell me that nobody is doing the really insane
> stuff, I'm happy as well :)

Christian, any thoughts?

Regards,
Wanpeng Li
