Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62A03C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:19:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C3B320C0A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:19:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C3B320C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728914AbeIXUVm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 16:21:42 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46869 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727494AbeIXUVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:21:42 -0400
Received: by mail-pl1-f193.google.com with SMTP id v19-v6so1511170ply.13;
        Mon, 24 Sep 2018 07:19:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BEtXEmV+colSyj+N+YYwVyKrduG6ry/YpPcHyo7hjOw=;
        b=Mm2YWCUQMfHsVd7KJwsSQUqu/eIdz1B0/4gmh11DjKeu8au76f9j0dPBuRlkbrGaJ0
         E9dCZ6U6RmRL9+vCsWmKVDB7vn7jkPwlhVgTd/5yEqsN7O9IKfylNsoIYUFVyq+L+Qtf
         RpE002BB8lH44XPrVm2X1DC2N6/YquUk4k1Vn7iCOVGXzKInE4PHVDsznLcSrC2UFItJ
         I1N1abKLzlNDTrmZn/IIMUMJz0KMbydjHDdIuL1SXPU+FAVzl4waMJcQxP+AtjCHtWNv
         WyDgUwU7qfbUirucGdMtDa4b+1XNWkPpnZaujEkCj3qLxCyN7ualUtR7SWeNbNlOxsQj
         krFA==
X-Gm-Message-State: ABuFfog3ymhM7daCGTVdRjROFyKOjkWDp9pMJm755f2N7ab6ENWAOzx5
        U2PKDDk8/4NonGmW0Rr58zo=
X-Google-Smtp-Source: ACcGV62fSmYyCi3pBXR/GWOLldMshfJ2ED3GUvIAKRsOtYQ3RqDhWQhG3fg1wIuCCqNaKQkS1dEU2A==
X-Received: by 2002:a17:902:34a:: with SMTP id 68-v6mr11008058pld.39.1537798759652;
        Mon, 24 Sep 2018 07:19:19 -0700 (PDT)
Received: from asus.site ([2601:647:4601:42b4:3842:3e31:3bb6:cf62])
        by smtp.googlemail.com with ESMTPSA id f62-v6sm49502757pfg.74.2018.09.24.07.19.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Sep 2018 07:19:18 -0700 (PDT)
Subject: Re: block: DMA alignment of IO buffer allocated from slab
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Ming Lei <ming.lei@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Ming Lei <tom.leiming@gmail.com>,
        linux-block <linux-block@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        "open list:XFS FILESYSTEM" <linux-xfs@vger.kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Lameter <cl@linux.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <CACVXFVOBq3L_EjSTCoiqUL1PH=HMR5EuNNQV0hNndFpGxmUK6g@mail.gmail.com>
 <20180920063129.GB12913@lst.de> <87h8ij0zot.fsf@vitty.brq.redhat.com>
 <20180923224206.GA13618@ming.t460p>
 <38c03920-0fd0-0a39-2a6e-70cd8cb4ef34@virtuozzo.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <20a20568-5089-541d-3cee-546e549a0bc8@acm.org>
Date:   Mon, 24 Sep 2018 07:19:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <38c03920-0fd0-0a39-2a6e-70cd8cb4ef34@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/24/18 2:46 AM, Andrey Ryabinin wrote:
> On 09/24/2018 01:42 AM, Ming Lei wrote:
>> On Fri, Sep 21, 2018 at 03:04:18PM +0200, Vitaly Kuznetsov wrote:
>>> Christoph Hellwig <hch@lst.de> writes:
>>>
>>>> On Wed, Sep 19, 2018 at 05:15:43PM +0800, Ming Lei wrote:
>>>>> 1) does kmalloc-N slab guarantee to return N-byte aligned buffer?  If
>>>>> yes, is it a stable rule?
>>>>
>>>> This is the assumption in a lot of the kernel, so I think if somethings
>>>> breaks this we are in a lot of pain.
> 
> This assumption is not correct. And it's not correct at least from the beginning of the
> git era, which is even before SLUB allocator appeared. With CONFIG_DEBUG_SLAB=y
> the same as with CONFIG_SLUB_DEBUG_ON=y kmalloc return 'unaligned' objects.
> The guaranteed arch-and-config-independent alignment of kmalloc() result is "sizeof(void*)".
> 
> If objects has higher alignment requirement, the could be allocated via specifically created kmem_cache.

Hello Andrey,

The above confuses me. Can you explain to me why the following comment 
is present in include/linux/slab.h?

/*
  * kmalloc and friends return ARCH_KMALLOC_MINALIGN aligned
  * pointers. kmem_cache_alloc and friends return ARCH_SLAB_MINALIGN
  * aligned pointers.
  */

Thanks,

Bart.
