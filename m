Return-Path: <SRS0=f4JY=NB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF10BECDE43
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 09:13:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 911A72083E
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 09:13:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 911A72083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbeJUR1V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Oct 2018 13:27:21 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45103 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726980AbeJUR1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Oct 2018 13:27:21 -0400
Received: by mail-wr1-f66.google.com with SMTP id f17-v6so9891788wrs.12
        for <linux-kernel@vger.kernel.org>; Sun, 21 Oct 2018 02:13:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ypOBQ+Gghb4wLXXda8zoXqcy68uCnJ8ENt0OaSW5seY=;
        b=APQpdL9cfZ5TG7G394GIDUdHCcyfGsS/We4iCA4R8JJswo/dyZQWVxCUN+eLCXagLj
         4h0WloDHXQXnR0JEzhiik1GqDfc8lfCPr747Df3LZb9qc9bQg5KQiYkZKHFgzqszIdnk
         r1LCbWVqF56mR5igbgUdL2EktkvGjiwMr8fFQPcV2t714FPKhy+Oln2qw+fRcZdPijdZ
         qbQEFepcRHRG1mc6CaTkEASEo4Dh50tZHYoT4Z6Hc9DVZQvoBIShYkvrrR5AqrrPu0QG
         i3zRJ2a/+cU0sGgHAxfZTUjJWgrFwAG0mvLEsUroemDoiJ0/d9tFr+JTXWI4aeFEYOPQ
         HmHw==
X-Gm-Message-State: ABuFfojMbvf2x6IZxj5bRkoXhrCxQITnsebvVnoDaDqEptgcIwbX8h7x
        gQqVH1DsZra1ovrvKyZgeiTRHg==
X-Google-Smtp-Source: ACcGV60bvBwMMb4q6El7bs98/eATto3ZVucSy4HMGkqQLywARF3NUpRHpi5VhXhs8SmPr5KLa4QKug==
X-Received: by 2002:adf:e94b:: with SMTP id m11-v6mr41708621wrn.126.1540113221258;
        Sun, 21 Oct 2018 02:13:41 -0700 (PDT)
Received: from [10.15.242.27] ([109.144.221.236])
        by smtp.gmail.com with ESMTPSA id k12-v6sm1378645wro.42.2018.10.21.02.13.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Oct 2018 02:13:40 -0700 (PDT)
Subject: Re: [PATCH] staging: ion: Rework ion_map_dma_buf() to minimize
 re-mapping
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Beata Michalska <Beata.Michalska@arm.com>,
        Matt Szczesiak <matt.szczesiak@arm.com>,
        Anders Pedersen <Anders.Pedersen@arm.com>,
        John Reitan <John.Reitan@arm.com>,
        Liam Mark <lmark@codeaurora.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        dri-devel <dri-devel@lists.freedesktop.org>
References: <1539214413-26173-1-git-send-email-john.stultz@linaro.org>
 <7534ca1d-f874-7809-6125-d9fc72f70e39@redhat.com>
 <CALAqxLUd-L+dj=GD5F=PkP5o-FokMCeYHWRJZs24R9-Grbf=PA@mail.gmail.com>
From:   Laura Abbott <labbott@redhat.com>
Message-ID: <e936704c-9bb5-8da8-3d30-e7c9a12a3b07@redhat.com>
Date:   Sun, 21 Oct 2018 02:13:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CALAqxLUd-L+dj=GD5F=PkP5o-FokMCeYHWRJZs24R9-Grbf=PA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/17/2018 07:53 PM, John Stultz wrote:
> On Fri, Oct 12, 2018 at 10:51 AM, Laura Abbott <labbott@redhat.com> wrote:
>>
>> I suspect most of the cost of the dma_map/dma_unmap is from the
>> cache flushing and not the actual mapping operations. If this
>> is the case, another option might be to figure out how to
>> incorporate dma_attrs so drivers can use DMA_ATTR_SKIP_CPU_SYNC
>> to decide when they actually want to sync.
> 
> So just to confirm on this point, I basically tested the following
> change (whitespace corrupt, sorry):
> 
> diff --git a/drivers/staging/android/ion/ion.c
> b/drivers/staging/android/ion/ion.c
> index 24cb666..e76b0e2 100644
> --- a/drivers/staging/android/ion/ion.c
> +++ b/drivers/staging/android/ion/ion.c
> @@ -273,8 +273,8 @@ static struct sg_table *ion_map_dma_buf(struct
> dma_buf_attachment *attachment,
> 
>          table = a->table;
> 
> -       if (!dma_map_sg(attachment->dev, table->sgl, table->nents,
> -                       direction))
> +       if (!dma_map_sg_attrs(attachment->dev, table->sgl, table->nents,
> +                             direction,  DMA_ATTR_SKIP_CPU_SYNC))
>                  return ERR_PTR(-ENOMEM);
> 
>          return table;
> @@ -284,7 +284,7 @@ static void ion_unmap_dma_buf(struct
> dma_buf_attachment *attachment,
>                                struct sg_table *table,
>                                enum dma_data_direction direction)
>   {
> -       dma_unmap_sg(attachment->dev, table->sgl, table->nents, direction);
> +       dma_unmap_sg_attrs(attachment->dev, table->sgl, table->nents,
> direction, DMA_ATTR_SKIP_CPU_SYNC);
>   }
> 
>   static int ion_mmap(struct dma_buf *dmabuf, struct vm_area_struct *vma)
> 
> 
> And indeed, that performed similarly to the pre 4.12 ION code (and it
> also had some of the same image caching error garbage we've seen w/
> 4.9 era kernels, which my earlier patch didn't have).
> 
> So yes, it seems having some way to conditionally skip cpu sync would
> be good.  Though I'm not sure what sort of interface to using this you
> might have in mind?
> 

I hadn't quite gotten anything fully formed but I think solving this
will require changes at the dma-buf layer. One idea I had was allowing
dma_attrs to be set per attachment, the other was extending the
dma_buf_map_attachment to take an attrs argument. I'm at OSSEU this
week but I didn't want to forget about this. I'll see if I can turn
this into a more coherent proposal unless you get to it first.

Thanks,
Laura

> thanks
> -john
> 

