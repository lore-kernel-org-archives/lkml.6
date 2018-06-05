Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751936AbeFEIQy (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 04:16:54 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:44532 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751865AbeFEIQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 04:16:50 -0400
X-Google-Smtp-Source: ADUXVKKrb5AYbFdFK+MO6nIVi++W3bJJpWI8Cdcq7KhIzNm3zhZEHuK1IXRw0de24Jrc9uTUA4uepkkur5vfM7xUymQ=
MIME-Version: 1.0
In-Reply-To: <79eb119f-efc3-35b7-1377-9e4c03182ebd@redhat.com>
References: <0000000000006370c3056d1855e7@google.com> <CACT4Y+Yqkon84bMamFNQTsn4npJtJnhOOd1ZHx+AkuKG-_eMsg@mail.gmail.com>
 <79eb119f-efc3-35b7-1377-9e4c03182ebd@redhat.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Tue, 5 Jun 2018 10:16:28 +0200
Message-ID: <CACT4Y+Y0d4O3Mgz5fH1nCWdoFOstWPmaRixavb4hfjqOuwhGrg@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in do_general_protection
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: syzbot <syzbot+a1264132fc103340628f@syzkaller.appspotmail.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        KVM list <kvm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 28, 2018 at 1:25 PM, Paolo Bonzini <pbonzini@redhat.com> wrote:
> On 26/05/2018 11:29, Dmitry Vyukov wrote:
>> KASAN: stack-out-of-bounds Read in do_general_protection
>> KASAN: slab-out-of-bounds Read in vmx_vcpu_run
>> KASAN: use-after-scope Read in vmx_vcpu_run
>> KASAN: stack-out-of-bounds Write in notify_die
>>
>> See full info at:
>> https://syzkaller.appspot.com/bug?extid=a1264132fc103340628f
>>
>>
>> There seems to be 2 problems:
>>
>> 1. msr_write_intercepted doing something notoriously bad.
>
> The faulting line is
>
>         msr_bitmap = to_vmx(vcpu)->loaded_vmcs->msr_bitmap;
>
> so I suppose to_vmx(vcpu)->loaded_vmcs is bogus?  That seems like "just"
> a corruption of the struct kvm_vcpu, because the loaded_vmcs field is
> pointing elsewhere inside the same struct.

This is reproducible and the reproducer only uses KVM syscalls. So it
seems that KVM corrupts itself. Perhaps it's KVM_SET_MSRS that messes
things?
