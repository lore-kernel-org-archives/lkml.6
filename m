Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752134AbeENK2I convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 06:28:08 -0400
Received: from prv1-mh.provo.novell.com ([137.65.248.33]:55383 "EHLO
        prv1-mh.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751487AbeENK2H (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:7:1>);
        Mon, 14 May 2018 06:28:07 -0400
Message-Id: <5AF964B302000078001C26BC@prv1-mh.provo.novell.com>
X-Mailer: Novell GroupWise Internet Agent 18.0.0 
Date: Mon, 14 May 2018 04:28:03 -0600
From: "Jan Beulich" <JBeulich@suse.com>
To: "Andrew Lutomirski" <luto@kernel.org>
Cc: <mingo@elte.hu>, <tglx@linutronix.de>,
        "xen-devel" <xen-devel@lists.xenproject.org>,
        "Boris Ostrovsky" <boris.ostrovsky@oracle.com>,
        "Juergen Gross" <jgross@suse.com>, <linux-kernel@vger.kernel.org>,
        <hpa@zytor.com>
Subject: Re: [PATCH] x86-64/Xen: fix stack switching
References: <5AF03EBD02000078001C1303@prv1-mh.provo.novell.com>
 <CALCETrX=SM=YBSpRv53Qmxk2PkHcTFWWvw-JGOh0C4UpvTReAA@mail.gmail.com>
In-Reply-To: <CALCETrX=SM=YBSpRv53Qmxk2PkHcTFWWvw-JGOh0C4UpvTReAA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>> On 08.05.18 at 04:38, <luto@kernel.org> wrote:
> On Mon, May 7, 2018 at 5:16 AM Jan Beulich <JBeulich@suse.com> wrote:
> 
>> While on native entry into the kernel happens on the trampoline stack,
>> PV Xen kernels are being entered with the current thread stack right
>> away. Hence source and destination stacks are identical in that case,
>> and special care is needed.
> 
>> Other than in sync_regs() the copying done on the INT80 path as well as
>> on the NMI path itself isn't NMI / #MC safe, as either of these events
>> occurring in the middle of the stack copying would clobber data on the
>> (source) stack. (Of course, in the NMI case only #MC could break
>> things.)
> 
> I think I'd rather fix this by changing the stack switch code or

Well, isn't that what I'm doing in the patch?

> alternativing around it on non-stack-switching kernels.

Fine with me if that's considered better than adding the conditionals.

>  Or make Xen use a trampoline stack just like native.

Well, as said I'd rather not, unless x86 and Xen maintainers agree
that's the way to go. But see below for NMI.

>> I'm not altering the similar code in interrupt_entry(), as that code
>> path is unreachable when running an PV Xen guest afaict.
> 
>> Signed-off-by: Jan Beulich <jbeulich@suse.com>
>> Cc: stable@kernel.org 
>> ---
>> There would certainly have been the option of using alternatives
>> patching, but afaict the patching code isn't NMI / #MC safe, so I'd
>> rather stay away from patching the NMI path. And I thought it would be
>> better to use similar code in both cases.
> 
> I would hope we do the patching before we enable any NMIs.

"Enable NMIs"? I don't think they're getting disabled anywhere in the
kernel. Perhaps you merely mean ones the kernel sends itself (which
I agree would hopefully only be enabled after alternatives patching?

>> Another option would be to make the Xen case match the native one, by
>> going through the trampoline stack, but to me this would look like extra
>> overhead for no gain.
> 
> Avoiding even more complexity in the nmi code seems like a big gain to me.

I'm not sure the added conditional is more complexity than making Xen
switch to the trampoline stack just to switch back almost immediately.
But yes, I could see complexity of the NMI code to be a reason to use
different solutions on the NMI and INT80 paths. It's just that I'd like
you, the x86 maintainters, and the Xen ones to agree on which solution
to use where before I'd send a v2.

Jan
