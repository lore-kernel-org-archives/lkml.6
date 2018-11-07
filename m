Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28861C32789
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 03:11:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDFFC2086C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 03:11:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDFFC2086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731042AbeKGMkG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 07:40:06 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:41302 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727315AbeKGMkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 07:40:06 -0500
Received: by mail-ot1-f65.google.com with SMTP id c32so13539689otb.8;
        Tue, 06 Nov 2018 19:11:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=y2iwNOftUUYfWUpCl4RpNdsGQe3PYSCAPEG4n5Zrro8=;
        b=dE1p2I5/M+5Idzkfp+Pqb9ZTlneSY02i7l2N/s3IkY6V5So5hIfZ+LbyreiwC3YH2e
         61xRmxaWmRKTfzXafoTv4oS5LYoFSOubpHE3V8ZTy7bSVmfygcKsAPr92wATL/jPVDjM
         xJ9JUI/MTqGWyGzgJIp9mrRilUBo1NOf/HHyomBvd1CidRZpQLGMeSNXdugNem/O0uEo
         Ulnjz3hU64wuKCYldob8EknI3Zv8Dmd0GNnGomKlhLtnFj1C6jJ5FRIxQ10XWZrlg6E7
         SU9xC9HBpkGRw+mdRLGbLB5yxcb4aBYSfBkyXuTP/+wGKoZg4de8TPuIPMPjNU6Lia80
         I8iQ==
X-Gm-Message-State: AGRZ1gJz03rb0XGORGCNhHh59kNHqYbcWIUQk43wubIf54RDnwNV2SZR
        phT5dwFH75xaT8YqOhe5D3Vg2Oy3
X-Google-Smtp-Source: AJdET5dNRxXLrjaQ7QaruRtjaH6wUgEuCF3V98MwX2f6A+RJHI+sZRyAtem2ot91oKx4KcsxrlUWqg==
X-Received: by 2002:a9d:3208:: with SMTP id t8mr84217otc.312.1541560298721;
        Tue, 06 Nov 2018 19:11:38 -0800 (PST)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id s30sm4292766ota.80.2018.11.06.19.11.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Nov 2018 19:11:38 -0800 (PST)
Subject: Re: [PATCH] block: respect virtual boundary mask in bvecs
To:     Johannes Thumshirn <jthumshirn@suse.de>,
        Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@fb.com>,
        Linux Block Layer Mailinglist <linux-block@vger.kernel.org>,
        Hannes Reinecke <hare@suse.de>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>
References: <20181105102301.9752-1-jthumshirn@suse.de>
 <20181105105548.GC12367@ming.t460p>
 <7c649b43-f952-cf94-93d6-44fb153acced@suse.de>
 <20181105120153.GD12367@ming.t460p>
 <3c3dd9c2-4240-7bb5-c0ff-af6f2e479c31@suse.de>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <a98db60d-ceb9-2a30-39bb-187125f56627@grimberg.me>
Date:   Tue, 6 Nov 2018 19:11:36 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <3c3dd9c2-4240-7bb5-c0ff-af6f2e479c31@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> If you mean the real huge page, this patch shouldn't have made a difference
>> because bio_vec->bv_offset is in [0, PAGE_SIZE), and iSer sets virt
>> boundary as 4K - 1.
>>
>> However, things will change after multipage bvec is introduced.
> 
> 
> Hi Ming,
> 
> I've received a blktrace from our customer showing the issue [1].
> 
> In this example trace they've submitted (contiguous) 64K I/Os and
> without this patch, they're seeing a lot of splits as indicated by the
> trace.
> 
> With the patch applied the I/O is directly issued to the LLDD without
> the splits.
> 
> [1] http://beta.suse.com/private/jthumshirn/blktrace.txt
> 

This patch makes sense to me. However I agree that we need to clarify
that this addresses cases where PAGE_SIZE-1 > queue_virt_boundary(q).

And also, lets replace "like iser" with "drivers that sets a virtual
boundary constraint" as nvme-rdma does the same thing.
