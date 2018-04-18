Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753372AbeDRJDd (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 05:03:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42166 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753215AbeDRJDb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 05:03:31 -0400
Date: Wed, 18 Apr 2018 06:03:29 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Wanpeng Li <kernellwp@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Subject: Re: [PATCH] KVM: X86: Allow userspace to define the microcode version
Message-ID: <20180418090329.GJ29865@localhost.localdomain>
References: <20180226114409.GD4377@pd.tnic>
 <46cecef2-b0fb-b0c2-bbf3-983328d52763@redhat.com>
 <20180226121509.GE4377@pd.tnic>
 <24cd527d-5287-f0be-ffe8-eab341bf1d94@redhat.com>
 <3866d359-0ef8-6a99-6254-84890be62b93@redhat.com>
 <20180226122205.GG4377@pd.tnic>
 <fb705c01-9bdd-9924-00c6-70d8ee940fb4@redhat.com>
 <CANRm+CyyL2jjjn7nZtLJvP+t1pN9ndAGhijmbX4LJh15=O+dvQ@mail.gmail.com>
 <20180417202417.GA29865@localhost.localdomain>
 <CANRm+CwA22VmpA5cfQg8mF_Xke_hXtP+_ui5xU+LV8v0JNj=3Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANRm+CwA22VmpA5cfQg8mF_Xke_hXtP+_ui5xU+LV8v0JNj=3Q@mail.gmail.com>
X-Fnord: you can see the fnord
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 18, 2018 at 11:24:22AM +0800, Wanpeng Li wrote:
> 2018-04-18 4:24 GMT+08:00 Eduardo Habkost <ehabkost@redhat.com>:
> > On Tue, Apr 17, 2018 at 06:40:58PM +0800, Wanpeng Li wrote:
> >> Cc Eduardo,
> >> 2018-02-26 20:41 GMT+08:00 Paolo Bonzini <pbonzini@redhat.com>:
> >> > On 26/02/2018 13:22, Borislav Petkov wrote:
> >> >> On Mon, Feb 26, 2018 at 01:18:07PM +0100, Paolo Bonzini wrote:
> >> >>>> In this context, "host-initiated" write means written by KVM userspace
> >> >>>> with ioctl(KVM_SET_MSR).  It generally happens only on VM startup, reset
> >> >>>> or live migration.
> >> >>>
> >> >>> To be clear, the target of the write is still the vCPU's emulated MSR.
> >> >>
> >> >> So how am I to imagine this as a user:
> >> >>
> >> >> qemu-system-x86_64 --microcode-revision=0xdeadbeef...
> >> >
> >> > More like "-cpu foo,ucode_rev=0xdeadbeef".  But in practice what would
> >> > happen is one of the following:
> >> >
> >> > 1) "-cpu host" sets ucode_rev to the same value of the host, everyone
> >> > else leaves it to zero as is now.
> >>
> >> Hi Paolo,
> >>
> >> Do you mean the host admin to get the ucode_rev from the host and set
> >> to -cpu host, ucode_rev=xxxxxx or qemu get the ucode_rev directly by
> >> rdmsr?
> >
> > QEMU setting ucode_rev automatically using the host value when
> > using "-cpu host" (with no need for explicit ucode_rev option)
> > makes sense to me.
> 
> QEMU can't get the host value by rdmsr MSR_IA32_UCODE_REV directly
> since rdmsr will #GP when ring !=0, any idea?

By looking at kvm_get_msr_feature(), it looks like
ioctl(system_fd, KVM_GET_MSRS) would return the host MSR value
for us.

-- 
Eduardo
