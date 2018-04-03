Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751990AbeDCOxT (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 10:53:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57988 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751649AbeDCOxQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 10:53:16 -0400
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Roman Kagan <rkagan@virtuozzo.com>
Cc: Denis Plotnikov <dplotnikov@virtuozzo.com>, kvm@vger.kernel.org,
        x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley \(EOSG\)" <Michael.H.Kelley@microsoft.com>,
        Mohammed Gamal <mmorsy@redhat.com>, Cathy Avery <cavery@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] KVM: x86: hyperv: PV TLB flush for Windows guests
References: <20180402161059.8488-1-vkuznets@redhat.com>
        <20180403100003.GE2874@rkaganb.sw.ru>
Date: Tue, 03 Apr 2018 16:53:12 +0200
In-Reply-To: <20180403100003.GE2874@rkaganb.sw.ru> (Roman Kagan's message of
        "Tue, 3 Apr 2018 13:00:04 +0300")
Message-ID: <871sfwxrxj.fsf@vitty.brq.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Kagan <rkagan@virtuozzo.com> writes:

> On Mon, Apr 02, 2018 at 06:10:54PM +0200, Vitaly Kuznetsov wrote:
>> 
>> Feature description:
>> 
>> PV TLB flush helps a lot when running overcommited. KVM gained support for
>> it recently but it is only available for Linux guests. Windows guests use
>> emulated Hyper-V interface and PV TLB flush needs to be added there.
>> 
>
> I vaguely remember Denis Plotnikov (cc-d) did a similar attempt a couple
> of years ago.  IIRC the outcome was that win2012r2 (back then) guests
> started to also use this mechanism for local tlb flushes via self-IPI,
> which led to noticable degradation on certain workloads.
>

Thanks for the feedback,

in theory it shouldn't do that. Hyper-V has different enlightenments for
local and remote TLB flushing:

Implementation Recommendations - 0x40000004
...
Bit 1: Recommend using hypercall for local TLB flushes rather
than INVLPG or MOV to CR3 instructions
Bit 2: Recommend using hypercall for remote TLB flushes
rather than inter-processor interrupts
...

I see no reason to do local flushes with a hypercall so we'll only be
announcing remote.

In case things are irreparably broken with WS2012 we can still have the
feature in KVM and decide if we want to announce it to guests on a
higher level (probably even higher than Qemu as this will just become
another 'hv_tlbflush' feature which needs to be enabled) based on
Windows version.

-- 
  Vitaly
