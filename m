Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751624AbeEVQc7 convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 12:32:59 -0400
Received: from prv1-mh.provo.novell.com ([137.65.248.33]:55728 "EHLO
        prv1-mh.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751196AbeEVQc6 (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:5:1>);
        Tue, 22 May 2018 12:32:58 -0400
Message-Id: <5B04463502000078001C4CEE@prv1-mh.provo.novell.com>
X-Mailer: Novell GroupWise Internet Agent 18.0.0 
Date: Tue, 22 May 2018 10:32:53 -0600
From: "Jan Beulich" <JBeulich@suse.com>
To: "Boris Ostrovsky" <boris.ostrovsky@oracle.com>
Cc: <brgerst@gmail.com>, "xen-devel" <xen-devel@lists.xenproject.org>,
        "Juergen Gross" <jgross@suse.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 1/2] xen/PVH: Set up GS segment for stack canary
References: <20180522035445.16911-1-boris.ostrovsky@oracle.com>
 <20180522035445.16911-2-boris.ostrovsky@oracle.com>
 <CAMzpN2iMrEqee+8yGP_qk-qAuXf+_o6vrOUSDTvX=8JAUDT5Fg@mail.gmail.com>
 <5B0421E502000078001C4B91@prv1-mh.provo.novell.com>
 <CAMzpN2gRvYMmaf2+Fpi2wkAV_rcH=uDfM8sQQaaGGK2U=7XqMA@mail.gmail.com>
 <5B04410D02000078001C4CC5@prv1-mh.provo.novell.com>
 <70aad5f3-67b9-b1fa-d39c-cfa8615f38da@oracle.com>
In-Reply-To: <70aad5f3-67b9-b1fa-d39c-cfa8615f38da@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>> On 22.05.18 at 18:20, <boris.ostrovsky@oracle.com> wrote:
> On 05/22/2018 12:10 PM, Jan Beulich wrote:
>>>>> On 22.05.18 at 17:15, <brgerst@gmail.com> wrote:
>>> On Tue, May 22, 2018 at 9:57 AM, Jan Beulich <JBeulich@suse.com> wrote:
>>>>>>> On 22.05.18 at 15:45, <brgerst@gmail.com> wrote:
>>>>> On Mon, May 21, 2018 at 11:54 PM, Boris Ostrovsky <boris.ostrovsky@oracle.com> 
> wrote:
>>>>>> @@ -98,6 +101,12 @@ ENTRY(pvh_start_xen)
>>>>>>         /* 64-bit entry point. */
>>>>>>         .code64
>>>>>>  1:
>>>>>> +       /* Set base address in stack canary descriptor. */
>>>>>> +       mov $MSR_GS_BASE,%ecx
>>>>>> +       mov $canary, %rax
>>>>>> +       cdq
>>>>>> +       wrmsr
>>>>> CDQ only sign-extends EAX to RAX.  What you really want is to move the
>>>>> high 32-bits to EDX (or zero EDX if we can guarantee it is loaded
>>>>> below 4G).
>>>> What you describe is CDQE (AT&T name: CLTD); CDQ (AT&T: CLTQ)
>>>> sign-extends EAX to EDX:EAX.
>>> But that would still be wrong, as it would set EDX to 0xFFFFFFFF if
>>> the kernel was loaded between 2G and 4G.  Looking closer at the code,
>>> we just left 32-bit mode, so we must have been loaded below 4G,
>>> therefore EDX must be zero.
>> Ah, yes, indeed.
> 
> We are loading virtual address for $canary so we will always have EDX
> set to 0xffffffff. Isn't that what we want?

Oh, that's rather confusing - we're still running on the low 1:1
mapping when we're here. But yes, by the time we enter C code
(where the GS base starts to matter) we ought to be on the high
mappings - if only there wasn't xen_prepare_pvh().

Jan
