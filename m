Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932077AbeEWHRu convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 03:17:50 -0400
Received: from prv1-mh.provo.novell.com ([137.65.248.33]:59413 "EHLO
        prv1-mh.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754284AbeEWHRn (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:5:1>);
        Wed, 23 May 2018 03:17:43 -0400
Message-Id: <5B05159302000078001C4FBE@prv1-mh.provo.novell.com>
X-Mailer: Novell GroupWise Internet Agent 18.0.0 
Date: Wed, 23 May 2018 01:17:39 -0600
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
 <5B04463502000078001C4CEE@prv1-mh.provo.novell.com>
 <1bb1b3b0-fae1-9c2e-f5b8-0c51f06d6fa9@oracle.com>
In-Reply-To: <1bb1b3b0-fae1-9c2e-f5b8-0c51f06d6fa9@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>> On 22.05.18 at 19:10, <boris.ostrovsky@oracle.com> wrote:
> On 05/22/2018 12:32 PM, Jan Beulich wrote:
>>>>> On 22.05.18 at 18:20, <boris.ostrovsky@oracle.com> wrote:
>>> We are loading virtual address for $canary so we will always have EDX
>>> set to 0xffffffff. Isn't that what we want?
>> Oh, that's rather confusing - we're still running on the low 1:1
>> mapping when we're here. But yes, by the time we enter C code
>> (where the GS base starts to matter) we ought to be on the high
>> mappings - if only there wasn't xen_prepare_pvh().
> 
> xen_prepare_pvh() (and whatever it might call) is the only reason for
> this patch to exist. It's the only C call that we are making before
> jumping to startup_64, which I assume will have to set up GS itself
> before calling into C.
> 
> I didn't realize we are still on identity mapping. I'll clear EDX (and
> load $_pa(canary)) then.
> 
> BTW, don't we have the same issue in startup_xen()?

I don't think so, no - there we're on the high mappings already (the
ELF note specifies the virtual address of the entry point, after all).

Jan
