Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754769AbeBGQ5M (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 11:57:12 -0500
Received: from mail-it0-f42.google.com ([209.85.214.42]:35327 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754538AbeBGQ5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 11:57:10 -0500
X-Google-Smtp-Source: AH8x225dIM7+CgivUyaRK24vZOmyFIl2QN4mf+/OwBqoIrTyKGtGcumINQygi0qyywIZxjpUB/NKggwmRgAobAo5Sdo=
MIME-Version: 1.0
In-Reply-To: <CANRm+CyqV6s6etBAveNTG2WjfMZrfuuN+HpF9Ub1ex=JjyA1yw@mail.gmail.com>
References: <1517828686-29070-1-git-send-email-wanpengli@tencent.com>
 <CALMp9eQNB+2KLAR2Tv+By2oTthRLvAQMmJiEs61kFNrZDct3_g@mail.gmail.com>
 <CALMp9eSXvMmRj15q26_=VpJhYfUL_gHP-ce4h9bCv0N55JtT1w@mail.gmail.com>
 <CANRm+Cx_KVftOfeGWjqn_1P=j8R-NsNcH7w+pA9gCouM_4FDRw@mail.gmail.com>
 <CALMp9eRHzmU3Kfr0cxhy2Hrr-RybnjrsKHByoV27TdYffuuC3w@mail.gmail.com> <CANRm+CyqV6s6etBAveNTG2WjfMZrfuuN+HpF9Ub1ex=JjyA1yw@mail.gmail.com>
From: Jim Mattson <jmattson@google.com>
Date: Wed, 7 Feb 2018 08:57:09 -0800
Message-ID: <CALMp9eQ+wJyxQfru1j8i6CmBzvsYEPrK2wx94JFZ0M3rWSV0+g@mail.gmail.com>
Subject: Re: [PATCH] KVM: nVMX: Fix CR4 after VMLAUNCH/VMRESUME failure
To: Wanpeng Li <kernellwp@gmail.com>
Cc: kvm list <kvm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Radim Krcmar <rkrcmar@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vmcs12->host_cr[34] does not contain the up-to-date values when L1 is
running. L1 can vmwrite any values there. We know at this point that
they are legal (because we checked them), but that's about it. If the
VMLAUNCH/VMRESUME of vmcs12 fails for "invalid control field," there
is no VM-exit from L2 to L1, and these fields are not loaded. Instead,
execution just falls through to the next instruction with VMFailValid
semantics.

On Wed, Feb 7, 2018 at 12:31 AM, Wanpeng Li <kernellwp@gmail.com> wrote:
> 2018-02-07 0:58 GMT+08:00 Jim Mattson <jmattson@google.com>:
>> On Mon, Feb 5, 2018 at 4:57 PM, Wanpeng Li <kernellwp@gmail.com> wrote:
>>
>>> This is effective one, what I restore in this patch is
>>> achitectural/guest visible.
>>
>> This patch doesn't "restore" the guest visible CR4 to its value at the
>> time of VMLAUNCH/VMRESUME. It loads a new CR4 value from the vmcs12.
>> That behavior is incorrect.
>
> You have another pointing out about this.
> https://lkml.org/lkml/2018/2/5/518 vmcs12->host_cr3/host_cr4 has the
> up-to-date value when L1 is running, it is still up-to-date after
> vmexit due to L1 executes VMLAUNCH/VMRESUME, I think the value stays
> the same before L0 emulates the VMLAUNCH/VMRESUME, according to below
> comments, why vmcs12->host_cr3/cr4 is not the value which we should
> restore?
>
> * After an early L2 VM-entry failure, we're now back
> * in L1 which thinks it just finished a VMLAUNCH or
> * VMRESUME instruction
>
> Regards,
> Wanpeng Li
