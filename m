Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C750C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:08:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E607320877
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:08:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E607320877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732810AbeIXVLH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 17:11:07 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42342 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728249AbeIXVLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 17:11:06 -0400
Received: by mail-pg1-f196.google.com with SMTP id y4-v6so9276295pgp.9;
        Mon, 24 Sep 2018 08:08:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lkV4a9w6etOvpZz6MO+j9bWyp+4FpRNTcINTGeRdE8c=;
        b=CTl4yvYdWmAop7f4FMA/cshi7KtW0alVxYgS2INpo12khawluRbTRmaMBzrSUlE+li
         lIiRlbhBRtZ/irVk6kuJXxV1Bp/TQy923aePCTVjUutZWpzcJvK34Q3DSWoAPIoBLcse
         A1ws0SU6m1ph/jFtbRVjpqhd+3LNaqzCGZBF5Vk8GcSb7JidgicLuBV9ZTmJ7Ga02pMJ
         V+vf9NXEgtTOXsX/k79gAT8cDyBV7AQEpQJ39FOSvfeT1TDEo1LR77knLdkJZQQGfJqu
         z+W2cXXsoPvb2NPh5mBp7aRZUa/lTUASG6tXXSYc5aqU90Pbs2CrQgFXIDZHuapD/39K
         6Msw==
X-Gm-Message-State: ABuFfojBIrflMY3WijKKqc9za6P06lp0KYKh0lJa/chCDX3cI9ho0B3g
        Wo1mOM+lWfAc4fGLdSMWEnI=
X-Google-Smtp-Source: ACcGV611KBCXlicg+XY9CtIGaDuU6eNmZ+igge8Rkme00zWPx0SJRck/CpBcVRAXCie++VQT7UfvTQ==
X-Received: by 2002:a65:5004:: with SMTP id f4-v6mr9872999pgo.54.1537801708442;
        Mon, 24 Sep 2018 08:08:28 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id s14-v6sm2775042pfh.142.2018.09.24.08.08.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Sep 2018 08:08:27 -0700 (PDT)
Message-ID: <1537801706.195115.7.camel@acm.org>
Subject: Re: block: DMA alignment of IO buffer allocated from slab
From:   Bart Van Assche <bvanassche@acm.org>
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
Date:   Mon, 24 Sep 2018 08:08:26 -0700
In-Reply-To: <12eee877-affa-c822-c9d5-fda3aa0a50da@virtuozzo.com>
References: <CACVXFVOBq3L_EjSTCoiqUL1PH=HMR5EuNNQV0hNndFpGxmUK6g@mail.gmail.com>
         <20180920063129.GB12913@lst.de> <87h8ij0zot.fsf@vitty.brq.redhat.com>
         <20180923224206.GA13618@ming.t460p>
         <38c03920-0fd0-0a39-2a6e-70cd8cb4ef34@virtuozzo.com>
         <20a20568-5089-541d-3cee-546e549a0bc8@acm.org>
         <12eee877-affa-c822-c9d5-fda3aa0a50da@virtuozzo.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-09-24 at 17:43 +-0300, Andrey Ryabinin wrote:
+AD4 
+AD4 On 09/24/2018 05:19 PM, Bart Van Assche wrote:
+AD4 +AD4 On 9/24/18 2:46 AM, Andrey Ryabinin wrote:
+AD4 +AD4 +AD4 On 09/24/2018 01:42 AM, Ming Lei wrote:
+AD4 +AD4 +AD4 +AD4 On Fri, Sep 21, 2018 at 03:04:18PM +-0200, Vitaly Kuznetsov wrote:
+AD4 +AD4 +AD4 +AD4 +AD4 Christoph Hellwig +ADw-hch+AEA-lst.de+AD4 writes:
+AD4 +AD4 +AD4 +AD4 +AD4 
+AD4 +AD4 +AD4 +AD4 +AD4 +AD4 On Wed, Sep 19, 2018 at 05:15:43PM +-0800, Ming Lei wrote:
+AD4 +AD4 +AD4 +AD4 +AD4 +AD4 +AD4 1) does kmalloc-N slab guarantee to return N-byte aligned buffer?  If
+AD4 +AD4 +AD4 +AD4 +AD4 +AD4 +AD4 yes, is it a stable rule?
+AD4 +AD4 +AD4 +AD4 +AD4 +AD4 
+AD4 +AD4 +AD4 +AD4 +AD4 +AD4 This is the assumption in a lot of the kernel, so I think if somethings
+AD4 +AD4 +AD4 +AD4 +AD4 +AD4 breaks this we are in a lot of pain.
+AD4 +AD4 +AD4 
+AD4 +AD4 +AD4 This assumption is not correct. And it's not correct at least from the beginning of the
+AD4 +AD4 +AD4 git era, which is even before SLUB allocator appeared. With CONFIG+AF8-DEBUG+AF8-SLAB+AD0-y
+AD4 +AD4 +AD4 the same as with CONFIG+AF8-SLUB+AF8-DEBUG+AF8-ON+AD0-y kmalloc return 'unaligned' objects.
+AD4 +AD4 +AD4 The guaranteed arch-and-config-independent alignment of kmalloc() result is +ACI-sizeof(void+ACo)+ACI.
+AD4 
+AD4 Correction sizeof(unsigned long long), so 8-byte alignment guarantee.
+AD4 
+AD4 +AD4 +AD4 
+AD4 +AD4 +AD4 If objects has higher alignment requirement, the could be allocated via specifically created kmem+AF8-cache.
+AD4 +AD4 
+AD4 +AD4 Hello Andrey,
+AD4 +AD4 
+AD4 +AD4 The above confuses me. Can you explain to me why the following comment is present in include/linux/slab.h?
+AD4 +AD4 
+AD4 +AD4 /+ACo
+AD4 +AD4  +ACo kmalloc and friends return ARCH+AF8-KMALLOC+AF8-MINALIGN aligned
+AD4 +AD4  +ACo pointers. kmem+AF8-cache+AF8-alloc and friends return ARCH+AF8-SLAB+AF8-MINALIGN
+AD4 +AD4  +ACo aligned pointers.
+AD4 +AD4  +ACo-/
+AD4 +AD4 
+AD4 
+AD4 ARCH+AF8-KMALLOC+AF8-MINALIGN - guaranteed alignment of the kmalloc() result.
+AD4 ARCH+AF8-SLAB+AF8-MINALIGN - guaranteed alignment of kmem+AF8-cache+AF8-alloc() result.
+AD4 
+AD4 If the 'align' argument passed into kmem+AF8-cache+AF8-create() is bigger than ARCH+AF8-SLAB+AF8-MINALIGN
+AD4 than kmem+AF8-cache+AF8-alloc() from that cache should return 'align'-aligned pointers.

Hello Andrey,

Do you realize that that comment from +ADw-linux/slab.h+AD4 contradicts what you
wrote about kmalloc() if ARCH+AF8-KMALLOC+AF8-MINALIGN +AD4 sizeof(unsigned long long)?

Additionally, shouldn't CONFIG+AF8-DEBUG+AF8-SLAB+AD0-y and CONFIG+AF8-SLUB+AF8-DEBUG+AF8-ON+AD0-y
provide the same guarantees as with debugging disabled, namely that kmalloc()
buffers are aligned on ARCH+AF8-KMALLOC+AF8-MINALIGN boundaries? Since buffers
allocated with kmalloc() are often used for DMA, how otherwise is DMA assumed
to work?

Thanks,

Bart.

