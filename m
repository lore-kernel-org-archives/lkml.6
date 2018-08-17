Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B81DC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 10:57:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DD12218A8
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 10:57:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="RhnCDf3q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DD12218A8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbeHQOA0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 10:00:26 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45169 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbeHQOA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 10:00:26 -0400
Received: by mail-pg1-f194.google.com with SMTP id f1-v6so3429528pgq.12
        for <linux-kernel@vger.kernel.org>; Fri, 17 Aug 2018 03:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qs8G6e1qz0ELQ9ecNkFiGsoXF63CXcC1BeRBAmPI+wA=;
        b=RhnCDf3qkapJhqw/jLYZx5QK5a+T2kaIIjOTaJnfi/VuGydn04QQ6cx4i/aLayP2De
         9Uuk3j3xcTvbc4CBifyMuMdw0ovPoOVmh/mpAqZPQ5zjchEwP8ru0bt4reBvomO3m4MO
         Wdn95lq1Gpf294qsT3Zmdh+oeaGMD7KEHXS/h3xCfx4CWjcyEoDKJreJVyAtxzbSjY2s
         Lad86ucVF60aEEuZPBgmT0Qwfr5FsBdf/wrR8sJ9oi5umqiupXQOiPSA34IGkl8LXlMQ
         X/nimofcLi6r/qEB3vT9D3d5MhPIUBnTuf6/Cm6f3RUVaj8+McOLKzGMFJVA3dkTvNNd
         QZxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qs8G6e1qz0ELQ9ecNkFiGsoXF63CXcC1BeRBAmPI+wA=;
        b=HScE4qPkWuNdO0fu454P6068KU9oiJzwpKR+AHNbNCHvNrTKrP8qiHwYhGMrdfIR55
         G+sDuoFX5bMB++rWUKCDp/38PzWCp7qDbOTCssFDyXQddoiSQ2Z3JPnVD8heMO++qbwg
         cGgLxe19MXUe5zRmfrFY8WvRHnSzX5R0f5DqXCeuMDq8+rLxQzXvp5lNBMNSZMFowJ8D
         /RVrcd5/2RkH5Rsn+mJoWftaI/lV31cbr3TQQqaysvBV2nM05TBh0kmT9CJ71rJmYT2l
         +ZgtFLa4OzlwRBw3i23n3GGIbzmFY2OQIdh2lVo8B+N/EULferPJY44wPcGHVTjmJe/K
         VdVw==
X-Gm-Message-State: AOUpUlHSMyGzKKnzsWFx7a9ZCDqqLq2UAZC6W27kwHc0DiNlwOhgU3HT
        RqbkzlPZZcyLQqS0pqPLX3QFmF/C+RZT2w==
X-Google-Smtp-Source: AA+uWPzznA1CjMYgsWLBcy/ylKCM/qff6ehPMeSShAyNtIGp/U5NHrpMv0dwGMpRqhuEnajwna7NIw==
X-Received: by 2002:a62:5b85:: with SMTP id p127-v6mr36625212pfb.33.1534503445276;
        Fri, 17 Aug 2018 03:57:25 -0700 (PDT)
Received: from [10.86.58.199] (rap-us.hgst.com. [199.255.44.250])
        by smtp.googlemail.com with ESMTPSA id l85-v6sm2855926pfk.34.2018.08.17.03.57.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Aug 2018 03:57:24 -0700 (PDT)
Subject: Re: [RFC PATCH v2 0/1] lightnvm: move bad block and chunk state logic
 to core
To:     javier@cnexlabs.com
Cc:     igor.j.konopko@intel.com, marcin.dziegielewski@intel.com,
        hans.holmberg@cnexlabs.com, hlitz@ucsc.edu,
        youngtack.jin@circuitblvd.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180816113417.3641-1-mb@lightnvm.io>
 <00698BD3-4382-4033-908F-BEB63E7FAD57@cnexlabs.com>
 <2ed73237-2657-17a8-7134-2267ffb7e35d@lightnvm.io>
 <956344E2-D7B3-480D-9C1D-7C385B2EFA14@cnexlabs.com>
 <f7413a26-97bc-6c38-b365-ad824375ca96@lightnvm.io>
 <05339052-F338-45A5-B3E2-43152A4A0DF6@cnexlabs.com>
 <d17ce375-6ddb-8fd2-a8c1-f1e7d3572b37@lightnvm.io>
 <F3989C76-24EF-4E26-801A-DB3E1CC45981@cnexlabs.com>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <d0f29b8f-7ea1-fce9-f7f8-120834375b82@lightnvm.io>
Date:   Fri, 17 Aug 2018 12:57:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <F3989C76-24EF-4E26-801A-DB3E1CC45981@cnexlabs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/17/2018 12:49 PM, Javier Gonzalez wrote:
> 
>> On 17 Aug 2018, at 11.42, Matias Bjørling <mb@lightnvm.io> wrote:
>>
>> On 08/17/2018 11:34 AM, Javier Gonzalez wrote:
>>>> On 17 Aug 2018, at 11.29, Matias Bjørling <mb@lightnvm.io> wrote:
>>>>
>>>> On 08/17/2018 10:44 AM, Javier Gonzalez wrote:
>>>>>> On 17 Aug 2018, at 10.21, Matias Bjørling <mb@lightnvm.io> wrote:
>>>>>>
>>>>>> On 08/16/2018 05:53 PM, Javier Gonzalez wrote:
>>>>>>>> On 16 Aug 2018, at 13.34, Matias Bjørling <mb@lightnvm.io> wrote:
>>>>>>>>
>>>>>>>> This patch moves the 1.2 and 2.0 block/chunk metadata retrieval to
>>>>>>>> core.
>>>>>>>>
>>>>>>>> Hi Javier, I did not end up using your patch. I had misunderstood what
>>>>>>>> was implemented. Instead I implemented the detection of the each chunk by
>>>>>>>> first sensing the first page, then the last page, and if the chunk
>>>>>>>> is sensed as open, a per page scan will be executed to update the write
>>>>>>>> pointer appropriately.
>>>>>>> I see why you want to do it this way for maintaining the chunk
>>>>>>> abstraction, but this is potentially very inefficient as blocks not used
>>>>>>> by any target will be recovered unnecessarily.
>>>>>>
>>>>>> True. It will up to the target to not ask for more metadata than necessary (similarly for 2.0)
>>>>>>
>>>>>> Note that in 1.2, it is
>>>>>>> expected that targets will need to recover the write pointer themselves.
>>>>>>> What is more, in the normal path, this will be part of the metadata
>>>>>>> being stored so no wp recovery is needed. Still, this approach forces
>>>>>>> recovery on each 1.2 instance creation (also on factory reset). In this
>>>>>>> context, you are right, the patch I proposed only addresses the double
>>>>>>> erase issue, which was the original motivator, and left the actual
>>>>>>> pointer recovery to the normal pblk recovery process.
>>>>>>> Besides this, in order to consider this as a real possibility, we need
>>>>>>> to measure the impact on startup time. For this, could you implement
>>>>>>> nvm_bb_scan_chunk() and nvm_bb_chunk_sense() more efficiently by
>>>>>>> recovering (i) asynchronously and (ii) concurrently across luns so that
>>>>>>> we can establish the recovery cost more fairly? We can look at a
>>>>>>> specific penalty ranges afterwards.
>>>>>>
>>>>>> Honestly, 1.2 is deprecated.
>>>>> For some...
>>>> No. OCSSD 1.2 is deprecated. Others that have a derivative of 1.2 have
>>>> their own storage stack and spec that they will continue development
>>>> on, which can not be expected to be compatible with the OCSSD 1.2 that
>>>> is implemented in the lightnvm subsystem.
>>> There are 1.2 devices out there using the current stack with no changes. >
>>
>> Yes, obviously, and they should continue to work. Which this patch doesn't change.
>>
>>>>>> I don't care about the performance, I
>>>>>> care about being easy to maintain, so it doesn't borg me down in the
>>>>>> future.
>>>>> This should be stated clear in the commit message.
>>>>>> Back of the envelope calculation for a 64 die SSD with 1024 blocks per
>>>>>> die, and 60us read time, will take 4 seconds to scan if all chunks are
>>>>>> free, a worst case something like ~10 seconds. -> Not a problem for
>>>>>> me.
>>>>> Worst case is _much_ worse than 10s if you need to scan the block to
>>>>> find the write pointer. We are talking minutes.
>>>>
>>>> I think you may be assuming that all blocks are open. My assumption is
>>>> that this is very rare (given the NAND characteristics). At most a
>>>> couple of blocks may be open per die. That leads me to the time
>>>> quoted.
>>> Worst case is worst case, no assumptions.
>>>>> At least make the recovery reads asynchronous. It is low hanging fruit
>>>>> and will help the average case significantly.
>>>>>>> Also, the recovery scheme in pblk will change significantly by doing
>>>>>>> this, so I assume you will send a followup patchset reimplementing
>>>>>>> recovery for the 1.2 path?
>>>>>>
>>>>>> The 1.2 path shouldn't be necessary after this. That is the idea of
>>>>>> this work. Obviously, the set bad block interface will have to
>>>>>> preserved and called.
>>>>> If we base this patch on top of my 2.0 recovery, we will still need to
>>>>> make changes to support all 1.2 corner cases.
>>>>> How do you want to do it? We get this patch in shape and I rebase on top
>>>>> or the other way around?
>>>>
>>>> I'll pull this in when you're tested it with your 1.2 implementation.
>>> Please, address the asynchronous read comment before considering pulling
>>> this path. There is really no reason not to improve this.
>>
>> I'll accept patches, but I won't spend time on it. Please let me know if you have other comments.
> 
> Your choice to ignore my comment on a RFC at this early stage of the
> 4.20 window.
> 
> In any case, I tested on our 1.2 devices and the patch has passed
> functionality.
> 
> Please do not add reviewed-by or tested-by tags with my name as I do not
> back the performance implications of the current implementation (on an
> otherwise good cleanup patch).
> 

Thanks for testing. I appreciate it.
