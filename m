Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751404AbeEVPPL (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 11:15:11 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:54774 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751229AbeEVPPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 11:15:08 -0400
X-Google-Smtp-Source: ADUXVKKnTsmPCApuEGmnwds/8op5NMPd9ZSLFBlPkwHf7olfyX6VGM4d3g2utOKnUrIKPVf+Rr4qMxvrbFJVnrasmGs=
MIME-Version: 1.0
In-Reply-To: <5B0421E502000078001C4B91@prv1-mh.provo.novell.com>
References: <20180522035445.16911-1-boris.ostrovsky@oracle.com>
 <20180522035445.16911-2-boris.ostrovsky@oracle.com> <CAMzpN2iMrEqee+8yGP_qk-qAuXf+_o6vrOUSDTvX=8JAUDT5Fg@mail.gmail.com>
 <5B0421E502000078001C4B91@prv1-mh.provo.novell.com>
From: Brian Gerst <brgerst@gmail.com>
Date: Tue, 22 May 2018 11:15:07 -0400
Message-ID: <CAMzpN2gRvYMmaf2+Fpi2wkAV_rcH=uDfM8sQQaaGGK2U=7XqMA@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] xen/PVH: Set up GS segment for stack canary
To: Jan Beulich <JBeulich@suse.com>
Cc: xen-devel <xen-devel@lists.xenproject.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 22, 2018 at 9:57 AM, Jan Beulich <JBeulich@suse.com> wrote:
>>>> On 22.05.18 at 15:45, <brgerst@gmail.com> wrote:
>> On Mon, May 21, 2018 at 11:54 PM, Boris Ostrovsky <boris.ostrovsky@oracle.com> wrote:
>>> @@ -98,6 +101,12 @@ ENTRY(pvh_start_xen)
>>>         /* 64-bit entry point. */
>>>         .code64
>>>  1:
>>> +       /* Set base address in stack canary descriptor. */
>>> +       mov $MSR_GS_BASE,%ecx
>>> +       mov $canary, %rax
>>> +       cdq
>>> +       wrmsr
>>
>> CDQ only sign-extends EAX to RAX.  What you really want is to move the
>> high 32-bits to EDX (or zero EDX if we can guarantee it is loaded
>> below 4G).
>
> What you describe is CDQE (AT&T name: CLTD); CDQ (AT&T: CLTQ)
> sign-extends EAX to EDX:EAX.

But that would still be wrong, as it would set EDX to 0xFFFFFFFF if
the kernel was loaded between 2G and 4G.  Looking closer at the code,
we just left 32-bit mode, so we must have been loaded below 4G,
therefore EDX must be zero.

--
Brian Gerst
