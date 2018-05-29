Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967866AbeE2Wkx (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 18:40:53 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:33127 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967588AbeE2Wkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 18:40:51 -0400
X-Google-Smtp-Source: ADUXVKKGgWWSIIYpENJmwg4fYj0rYIcVsIbUztB+Z7/UvMVY+3TG0FjHfSCdV1DhYLb37kPajmCdn3EzrthWYiqvcrw=
MIME-Version: 1.0
In-Reply-To: <CAPcyv4i__AQmCxM1rVBrLqXreMxQ5u9uRHRyJ=XZjDELxxJTzw@mail.gmail.com>
References: <20180505075854.192237-1-ksspiers@google.com> <CAPcyv4i__AQmCxM1rVBrLqXreMxQ5u9uRHRyJ=XZjDELxxJTzw@mail.gmail.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 29 May 2018 15:40:50 -0700
Message-ID: <CAPcyv4jrUwXFrF7aB-bKqfZ=17T5ie27KEO0JYWD=ETAqOqA4g@mail.gmail.com>
Subject: Re: [PATCH v2] async_pq: Remove VLA usage
To: Kyle Spiers <ksspiers@google.com>
Cc: David Miller <davem@davemloft.net>, Kees Cook <keescook@chromium.org>,
        ray.jui@broadcom.com, linux-crypto@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-raid <linux-raid@vger.kernel.org>, vkoul@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ add Vinod's korg address ]

On Tue, May 29, 2018 at 3:37 PM, Dan Williams <dan.j.williams@intel.com> wrote:
> [ adding linux-raid ]
>
> Apologies for the delay, the recent ping from Kees made me take a closer look.
>
> On Sat, May 5, 2018 at 12:58 AM, Kyle Spiers <ksspiers@google.com> wrote:
>> In the quest to remove VLAs from the kernel[1], this moves the
>> allocation of coefs and blocks from the stack to being kmalloc()ed.
>>
>> [1] https://lkml.org/lkml/2018/3/7/621
>>
>> Signed-off-by: Kyle Spiers <ksspiers@google.com>
>> ---
>> Forgot to add slab.h
>> ---
>>  crypto/async_tx/async_pq.c  | 18 ++++++++++++++----
>>  crypto/async_tx/raid6test.c |  9 ++++++++-
>>  2 files changed, 22 insertions(+), 5 deletions(-)
>>
>> diff --git a/crypto/async_tx/async_pq.c b/crypto/async_tx/async_pq.c
>> index 56bd612927ab..af1912313a23 100644
>> --- a/crypto/async_tx/async_pq.c
>> +++ b/crypto/async_tx/async_pq.c
>> @@ -194,9 +194,9 @@ async_gen_syndrome(struct page **blocks, unsigned int offset, int disks,
>>             (src_cnt <= dma_maxpq(device, 0) ||
>>              dma_maxpq(device, DMA_PREP_CONTINUE) > 0) &&
>>             is_dma_pq_aligned(device, offset, 0, len)) {
>> -               struct dma_async_tx_descriptor *tx;
>> +               struct dma_async_tx_descriptor *tx = NULL;
>>                 enum dma_ctrl_flags dma_flags = 0;
>> -               unsigned char coefs[src_cnt];
>> +               unsigned char *coefs;
>>                 int i, j;
>>
>>                 /* run the p+q asynchronously */
>> @@ -207,6 +207,9 @@ async_gen_syndrome(struct page **blocks, unsigned int offset, int disks,
>>                  * sources and update the coefficients accordingly
>>                  */
>>                 unmap->len = len;
>> +               coefs = kmalloc_array(src_cnt, sizeof(*coefs), GFP_KERNEL);
>
> At a minimum this needs to be GFP_NOIO since raid may be in the
> page-reclaim path.
>
> However, I think it may be better to allocate this with the rest of
> the stripe resources and pass it in as a scratch buffer. See the usage
> / implementation of scribble_alloc() in drivers/md/raid5.c.
