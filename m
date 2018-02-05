Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753306AbeBEPPx (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 10:15:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55848 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753136AbeBEPPq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 10:15:46 -0500
Subject: Re: [PATCH] KVM: x86: Reduce retpoline performance impact in
 slot_handle_level_range()
To: Linus Torvalds <torvalds@linux-foundation.org>,
        David Woodhouse <dwmw@amazon.co.uk>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        KarimAllah Ahmed <karahmed@amazon.de>, sironi@amazon.de,
        the arch/x86 maintainers <x86@kernel.org>,
        KVM list <kvm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>
References: <1517583559-424-1-git-send-email-dwmw@amazon.co.uk>
 <CA+55aFwg88mxuOiJSh+xLnAfqEwAC-ReB9rdNx+r8fy=FTSHJw@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <362dd50d-67ff-3802-e65d-68949cf80879@redhat.com>
Date: Mon, 5 Feb 2018 16:15:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <CA+55aFwg88mxuOiJSh+xLnAfqEwAC-ReB9rdNx+r8fy=FTSHJw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/02/2018 19:50, Linus Torvalds wrote:
> On Fri, Feb 2, 2018 at 6:59 AM, David Woodhouse <dwmw@amazon.co.uk> wrote:
>> With retpoline, tight loops of "call this function for every XXX" are
>> very much pessimised by taking a prediction miss *every* time.
>>
>> This one showed up very high in our early testing, and it only has five
>> things it'll ever call so make it take an 'op' enum instead of a
>> function pointer and let's see how that works out...
> Umm. May I suggest a different workaround?
> 
> Honestly, if this is so performance-critical, the *real* fix is to
> actually just mark all those "slot_handle_*()" functions as
> "always_inline".

I replied quickly from the phone before reading the rest of the
thread---yeah, always_inline is the way to go.  I see the same
differences as Linus and David (slight improvement for slot_handle_*,
+1k if you add kvm_handle_hva and kvm_handle_hva_range).

At least for slot_handle_* it's a no-brainer.  The others are basically
the MMU notifier implementation; in the perfect case it should actually
never be called (or at least it ought to be very rare), so I think we
can keep the indirect calls for now.

Paolo
