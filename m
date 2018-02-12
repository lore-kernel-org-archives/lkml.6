Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753476AbeBLRiE (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 12:38:04 -0500
Received: from mail-io0-f177.google.com ([209.85.223.177]:45801 "EHLO
        mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753453AbeBLRiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 12:38:01 -0500
X-Google-Smtp-Source: AH8x226NtQ3ZFLD4IB9NDHgqFRK+bZv0NDPKYqb6Na1eEEmorn0KbhcRA5Eu7i8BGtXbz+ZhpPS7eHliBQOsMzfp3g8=
MIME-Version: 1.0
In-Reply-To: <CANRm+CwsT_sL0kbO9ZKW4HJdmRw9sSKpwZAoOjpWBeWXZ-Q7-g@mail.gmail.com>
References: <1517828686-29070-1-git-send-email-wanpengli@tencent.com>
 <CALMp9eQNB+2KLAR2Tv+By2oTthRLvAQMmJiEs61kFNrZDct3_g@mail.gmail.com>
 <CALMp9eSXvMmRj15q26_=VpJhYfUL_gHP-ce4h9bCv0N55JtT1w@mail.gmail.com>
 <CANRm+Cx_KVftOfeGWjqn_1P=j8R-NsNcH7w+pA9gCouM_4FDRw@mail.gmail.com>
 <CALMp9eRHzmU3Kfr0cxhy2Hrr-RybnjrsKHByoV27TdYffuuC3w@mail.gmail.com>
 <CANRm+CyqV6s6etBAveNTG2WjfMZrfuuN+HpF9Ub1ex=JjyA1yw@mail.gmail.com>
 <CALMp9eQ+wJyxQfru1j8i6CmBzvsYEPrK2wx94JFZ0M3rWSV0+g@mail.gmail.com>
 <CANRm+Cx9vBGNgk0Gfc=tNVR49hxwexD7U-NmtBadXy0AadA1fg@mail.gmail.com>
 <CALMp9eR0gaYuYbxKs6oWFJj+ciCtHtU+pnF4pLHmbdf2wnUuPw@mail.gmail.com> <CANRm+CwsT_sL0kbO9ZKW4HJdmRw9sSKpwZAoOjpWBeWXZ-Q7-g@mail.gmail.com>
From: Jim Mattson <jmattson@google.com>
Date: Mon, 12 Feb 2018 09:37:59 -0800
Message-ID: <CALMp9eR9J7yNcb3rLYjO1pg2AYkmy8j7hFor08u1fm5U0i3a7A@mail.gmail.com>
Subject: Re: [PATCH] KVM: nVMX: Fix CR4 after VMLAUNCH/VMRESUME failure
To: Wanpeng Li <kernellwp@gmail.com>
Cc: kvm list <kvm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Radim Krcmar <rkrcmar@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 11, 2018 at 3:56 AM, Wanpeng Li <kernellwp@gmail.com> wrote:

> Writes 0 to cr3 can't be detected during vmentry checks by hardware.

I never suggested otherwise. I was just trying to explain why you
can't assume that the host CR3 field in the VMCS matches the host CR3
at the time of VMLAUNCH.

KVM is set up for failure, because it loads a bunch of guest state
before checking the validity of all of the control fields. If a
control field in the vmcs12 is invalid, but KVM doesn't recognize this
until after it has loaded guest state, all of the host state that has
been overwritten should be restored. "Restored" does not mean "loaded
from the vmcs12." It means reverted to its state at the time of the
failed VMLAUNCH/VMRESUME.
