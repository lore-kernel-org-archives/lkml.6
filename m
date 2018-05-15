Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752383AbeEOV5z (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 17:57:55 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:39200 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751664AbeEOV5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 17:57:53 -0400
X-Google-Smtp-Source: AB8JxZp3E1nBfsXCMVk+vS4P5QktC3sWeOtR/P0KkJHK58SjSU8jolETeIKFmzw+XtxRbayTUP2Li+CkD5d8qDMchdc=
MIME-Version: 1.0
In-Reply-To: <20180511154458.GI27459@char.us.oracle.com>
References: <1523943962-25415-1-git-send-email-wanpengli@tencent.com>
 <1523943962-25415-4-git-send-email-wanpengli@tencent.com> <20180511154458.GI27459@char.us.oracle.com>
From: Jim Mattson <jmattson@google.com>
Date: Tue, 15 May 2018 14:57:52 -0700
Message-ID: <CALMp9eSKd3naf7KrU97qgB4vNtpLotC+6+k+40E_S1oA122Yvg@mail.gmail.com>
Subject: Re: [PATCH 3/3] KVM: VMX: Allow I/O port 0x80 bypass when userspace prefer
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Wanpeng Li <kernellwp@gmail.com>, LKML <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Tim Shearer <tshearer@advaoptical.com>,
        Liran Alon <liran.alon@oracle.com>, Andrew Honig <ahonig@google.com>,
        Lars Bull <larsbull@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4FLw0nn029084

This does seem to allow a DoS from userspace if userspace prefers it.
That doesn't seem wise.

On Fri, May 11, 2018 at 8:44 AM, Konrad Rzeszutek Wilk
<konrad.wilk@oracle.com> wrote:
> On Mon, Apr 16, 2018 at 10:46:02PM -0700, Wanpeng Li wrote:
>> From: Wanpeng Li <wanpengli@tencent.com>
>>
>> Tim Shearer reported that "There is a guest which is running a packet
>> forwarding app based on the DPDK (dpdk.org). The packet receive routine
>> writes to 0xc070 using glibc's "outw_p" function which does an additional
>> write to I/O port 80. It does this write for every packet that's received,
>> causing a flood of KVM userspace context switches". He uses mpstat to
>> observe a CPU performing L2 packet forwarding on a pinned guest vCPU,
>> the guest time is 95 percent when allowing I/O port 0x80 bypass, however,
>> it is 65.78 percent when I/O port 0x80 bypss is disabled.
>>
>> This patch allows I/O port 0x80 bypass when userspace prefer.
>
> s/prefer/requests it/
>>
>
> Perhaps:
>
> Reported-by: Tim Shearer as well?
>
>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>> Cc: Radim Krčmář <rkrcmar@redhat.com>
>> Cc: Tim Shearer <tshearer@advaoptical.com>
>> Cc: Liran Alon <liran.alon@oracle.com>
>> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
>> ---
>>  arch/x86/kvm/vmx.c | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
>> index ebf1140..d3e5fef 100644
>> --- a/arch/x86/kvm/vmx.c
>> +++ b/arch/x86/kvm/vmx.c
>> @@ -10118,6 +10118,13 @@ static int vmx_vm_init(struct kvm *kvm)
>>                       goto out;
>>               memset(kvm_vmx->vmx_io_bitmap[i], 0xff, PAGE_SIZE);
>>       }
>> +     if (kvm->arch.ioport_disable_intercept) {
>> +             /*
>> +              * Allow direct access to the PC debug port (it is often used for I/O
>> +              * delays, but the vmexits simply slow things down).
>> +              */
>> +             clear_bit(0x80, kvm_vmx->vmx_io_bitmap[VMX_IO_BITMAP_A]);
>> +     }
>>       return 0;
>>
>>  out:
>> --
>> 2.7.4
>>
