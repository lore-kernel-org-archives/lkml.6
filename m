Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751871AbeCMRg4 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 13:36:56 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:43390 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751412AbeCMRgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 13:36:55 -0400
X-Google-Smtp-Source: AG47ELv22dtgiCiP8Xh9U9qHfTkhBLyrFIOl0FPzV47V57uP/mQcze43nWFoz0hmJ+ExAQebMpiiVGQYVg5p/QmriFc=
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1803131217200.9367@nuc-kabylake>
References: <20180313165428.58699-1-shakeelb@google.com> <alpine.DEB.2.20.1803131217200.9367@nuc-kabylake>
From: Shakeel Butt <shakeelb@google.com>
Date: Tue, 13 Mar 2018 10:36:52 -0700
Message-ID: <CALvZod4qa39QJqCr3n6UqzdD6pfLAQ3Rix6zm9_1pQkfQCDa7Q@mail.gmail.com>
Subject: Re: [PATCH] slab, slub: remove size disparity on debug kernel
To: Christopher Lameter <cl@linux.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Cc: Suleiman Souhlal <suleiman@google.com>,
        Greg Thelen <gthelen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 13, 2018 at 10:19 AM, Christopher Lameter <cl@linux.com> wrote:
> On Tue, 13 Mar 2018, Shakeel Butt wrote:
>
>> However for SLUB in debug kernel, the sizes were same. On further
>> inspection it is found that SLUB always use kmem_cache.object_size to
>> measure the kmem_cache.size while SLAB use the given kmem_cache.size. In
>> the debug kernel the slab's size can be larger than its object_size.
>> Thus in the creation of non-root slab, the SLAB uses the root's size as
>> base to calculate the non-root slab's size and thus non-root slab's size
>> can be larger than the root slab's size. For SLUB, the non-root slab's
>> size is measured based on the root's object_size and thus the size will
>> remain same for root and non-root slab.
>
> Note that the object_size and size may differ for SLUB based on kernel
> parameters and slab configuration. For SLAB these are compilation options.
>

Thanks for the explanation.

>> @@ -379,7 +379,7 @@ struct kmem_cache *find_mergeable(unsigned int size, unsigned int align,
>>  }
>>
>>  static struct kmem_cache *create_cache(const char *name,
>> -             unsigned int object_size, unsigned int size, unsigned int align,
>> +             unsigned int object_size, unsigned int align,
>>               slab_flags_t flags, unsigned int useroffset,
>
> Why was both the size and object_size passed during cache creation in the
> first place? From the flags etc the slab logic should be able to compute
> the actual bytes required for each object and its metadata.
>

+Vladimir

I think it was introduced by 794b1248be4e7 ("memcg, slab: separate
memcg vs root cache creation paths") but I could not find out the
reason.
