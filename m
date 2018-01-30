Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932075AbeA3XLk (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 18:11:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41776 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753610AbeA3XLi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 18:11:38 -0500
Subject: Re: [9/8] KVM: x86: limit MSR_IA32_SPEC_CTRL access based on CPUID
 availability
To: Thomas Gleixner <tglx@linutronix.de>,
        David Woodhouse <dwmw2@infradead.org>
Cc: Jim Mattson <jmattson@google.com>,
        Mihai Carabas <mihai.carabas@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>, kvm list <kvm@vger.kernel.org>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Liran Alon <liran.alon@oracle.com>,
        Anthony Liguori <aliguori@amazon.com>,
        Tom Lendacky <thomas.lendacky@amd.com>, Borislav Petkov <bp@alien8.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
References: <20180109120311.27565-10-pbonzini@redhat.com>
 <6dc02278-7004-1794-3705-69c8cad86be4@oracle.com>
 <CALMp9eSVC=LO-SrPkA3m6eSpgJ6X4rNCRCf3uvtJEdMG_B72cQ@mail.gmail.com>
 <beb9f9b4-7bc0-4a3a-73c2-0828febbd06c@oracle.com>
 <CALMp9eT6i9bhG005S5sqV-Y1RUhsc+AXE42ww8Ej+TXSjD6tEg@mail.gmail.com>
 <1517332457.18619.132.camel@infradead.org>
 <alpine.DEB.2.20.1801301842310.1797@nanos>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <75049dca-3389-9cc7-44e3-a487a797c605@redhat.com>
Date: Tue, 30 Jan 2018 18:11:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1801301842310.1797@nanos>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/01/2018 12:45, Thomas Gleixner wrote:
> On Tue, 30 Jan 2018, David Woodhouse wrote:
> 
>> On Tue, 2018-01-30 at 08:57 -0800, Jim Mattson wrote:
>>> It's really hard to tell which patches are being proposed for which
>>> repositories, but assuming that everything else is correct, I don't
>>> think your condition is adequate. What if the physical CPU and the
>>> virtual CPU both have CPUID.(EAX=7H,ECX=0):EDX[26], but only the
>>> physical CPU has CPUID.(EAX=7H,ECX=0):EDX[27]? If the guest has write
>>> access to MSR_IA32_SPEC_CTRL, it can set MSR_IA32_SPEC_CTRL[1]
>>> (STIBP), even though setting that bit in the guest should raise #GP.
>>
>> Everything we're talking about here is for tip/x86/pti. Which I note
>> has just updated to be 4.15-based, although I thought it was going to
>> stay on 4.14 for now. So I've updated my tree at
>> http://git.infradead.org/linux-retpoline.git/shortlog/refs/heads/ibpb
>> accordingly.
> 
> Yes, we tried to stay on 4.14 base but this started to created nasty merge
> conflicts for no value. Merging in v4.15 turned out to resolve those issues
> while still serving as the feed branch for Gregs stable work. For the time
> being we try to make stable backporting at least for 4.14/15 as painless as
> possible.

Great, then the "per-VCPU MSR bitmaps" branch
(git://git.kernel.org/pub/scm/virt/kvm/kvm.git refs/heads/msr-bitmaps)
that I created last weekend can be pulled directly in tip/x86/pti.

It cherry-picks directly to both 4.14 so it will be fine for Greg too.

Paolo
