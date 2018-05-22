Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751369AbeEVNOC (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 09:14:02 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35114 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751172AbeEVNOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 09:14:01 -0400
X-Google-Smtp-Source: AB8JxZpy+GKdkMGkJDJODOi4HXqUSgFL9KoRdntDdqvQYScryYont4N+fuXclEvEcfxUNzyh/CXdyg==
Reply-To: christian.koenig@amd.com
Subject: Re: [PATCH] swiotlb: Fix inversed DMA_ATTR_NO_WARN test
To: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>,
        Christoph Hellwig <hch@lst.de>
Cc: iommu@lists.linux-foundation.org,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
References: <20180501132411.2311-1-michel@daenzer.net>
 <786ca83f-45c4-264b-2aef-d84fb18d3d28@gmail.com>
 <CAKMK7uH2+v3_UUqXdCjz_8=H4VRt1zB+dgE99PuuPqd+XM2=-w@mail.gmail.com>
 <20180502124151.GA22857@lst.de>
 <1066dfa2-2f78-815d-c65a-9d09eb35458c@daenzer.net>
 <20180502162145.GA26787@lst.de>
 <ba310210-6f3c-f4e6-29e5-5ae6e791ebeb@daenzer.net>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <1cbc4e10-96e6-c222-fb1a-fd7847be5755@gmail.com>
Date: Tue, 22 May 2018 15:13:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <ba310210-6f3c-f4e6-29e5-5ae6e791ebeb@daenzer.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 02.05.2018 um 18:59 schrieb Michel Dänzer:
> On 2018-05-02 06:21 PM, Christoph Hellwig wrote:
>> On Wed, May 02, 2018 at 04:31:09PM +0200, Michel Dänzer wrote:
>>>> No.  __GFP_NOWARN (and gfp_t flags in general) are the wrong interface
>>>> for dma allocations and just cause problems.  I actually plan to
>>>> get rid of the gfp_t argument in dma_alloc_attrs sooner, and only
>>>> allow either GFP_KERNEL or GFP_DMA passed in dma_alloc_coherent.
>>> How about GFP_TRANSHUGE_LIGHT? TTM uses that to opportunistically
>>> allocate huge pages (GFP_TRANSHUGE can result in unacceptably long
>>> delays with memory pressure).
>> Well, that is exactly what I don't want drivers to do - same for
>> __GFP_COMP in some drm code.  This very much assumes the page allocator
>> is used to back dma allocations, which very often it actually isn't, and
>> any use of magic gfp flags creates a tight coupling of consumers with a
>> specific implementation.
>>
>> In general I can't think of a good reason not to actually use
>> GFP_TRANSHUGE_LIGHT by default in the dma allocator unless
>> DMA_ATTR_ALLOC_SINGLE_PAGES is set.  Can you prepare a patch for that?
> I'm afraid I'll have to leave that to somebody else.

Coming back to this topic once more, sorry for the delay but busy as 
usual :)

What exactly do you mean with "dma allocator" here? The TTM allocator 
using the dma_alloc_coherent calls? Or the swiotlb implementation of the 
calls?

Christian.
