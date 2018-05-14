Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753143AbeENMIV (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 08:08:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:45298 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752632AbeENMIH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 08:08:07 -0400
Subject: Re: [PATCH] x86-64/Xen: fix stack switching
To: Jan Beulich <JBeulich@suse.com>, Andrew Lutomirski <luto@kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
        xen-devel <xen-devel@lists.xenproject.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        lkml <linux-kernel@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
References: <5AF03EBD02000078001C1303@prv1-mh.provo.novell.com>
 <CALCETrX=SM=YBSpRv53Qmxk2PkHcTFWWvw-JGOh0C4UpvTReAA@mail.gmail.com>
 <5AF964B302000078001C26BC@suse.com>
From: Juergen Gross <jgross@suse.com>
Message-ID: <577d2651-387a-ac1f-4b03-2855009943ee@suse.com>
Date: Mon, 14 May 2018 14:08:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <5AF964B302000078001C26BC@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/05/18 12:28, Jan Beulich wrote:
>>>> On 08.05.18 at 04:38, <luto@kernel.org> wrote:
>> On Mon, May 7, 2018 at 5:16 AM Jan Beulich <JBeulich@suse.com> wrote:
>>
>>> While on native entry into the kernel happens on the trampoline stack,
>>> PV Xen kernels are being entered with the current thread stack right
>>> away. Hence source and destination stacks are identical in that case,
>>> and special care is needed.
>>
>>> Other than in sync_regs() the copying done on the INT80 path as well as
>>> on the NMI path itself isn't NMI / #MC safe, as either of these events
>>> occurring in the middle of the stack copying would clobber data on the
>>> (source) stack. (Of course, in the NMI case only #MC could break
>>> things.)
>>
>> I think I'd rather fix this by changing the stack switch code or
> 
> Well, isn't that what I'm doing in the patch?
> 
>> alternativing around it on non-stack-switching kernels.
> 
> Fine with me if that's considered better than adding the conditionals.
> 
>>  Or make Xen use a trampoline stack just like native.
> 
> Well, as said I'd rather not, unless x86 and Xen maintainers agree
> that's the way to go. But see below for NMI.

I'd prefer not using a trampoline stack, too.

> 
>>> I'm not altering the similar code in interrupt_entry(), as that code
>>> path is unreachable when running an PV Xen guest afaict.
>>
>>> Signed-off-by: Jan Beulich <jbeulich@suse.com>
>>> Cc: stable@kernel.org 
>>> ---
>>> There would certainly have been the option of using alternatives
>>> patching, but afaict the patching code isn't NMI / #MC safe, so I'd
>>> rather stay away from patching the NMI path. And I thought it would be
>>> better to use similar code in both cases.
>>
>> I would hope we do the patching before we enable any NMIs.
> 
> "Enable NMIs"? I don't think they're getting disabled anywhere in the
> kernel. Perhaps you merely mean ones the kernel sends itself (which
> I agree would hopefully only be enabled after alternatives patching?
> 
>>> Another option would be to make the Xen case match the native one, by
>>> going through the trampoline stack, but to me this would look like extra
>>> overhead for no gain.
>>
>> Avoiding even more complexity in the nmi code seems like a big gain to me.
> 
> I'm not sure the added conditional is more complexity than making Xen
> switch to the trampoline stack just to switch back almost immediately.

I agree.

> But yes, I could see complexity of the NMI code to be a reason to use
> different solutions on the NMI and INT80 paths. It's just that I'd like
> you, the x86 maintainters, and the Xen ones to agree on which solution
> to use where before I'd send a v2.

With my Xen maintainer hat on I'd prefer Jan's current solution.


Juergen
