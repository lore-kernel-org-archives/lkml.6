Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 713EEC43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 19:56:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2435120645
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 19:56:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2435120645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727817AbeIFA2c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 20:28:32 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38276 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727494AbeIFA2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 20:28:31 -0400
Received: by mail-lj1-f193.google.com with SMTP id p6-v6so7325377ljc.5
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 12:56:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ULWOC2rFF1l9xcg8Wdpe1GnXzmo0Q30feOQBGs/6KFQ=;
        b=Kr7KCBcoLGaVJhPpYfZoJwNmJF0zyhE0VW12VBsltzKjSdBiK7wPlKvkQAufpTwz6d
         vU9QmehKKxFHovlb1apOjs6LF5c/o5NqXoOSZ7G4+oO60Cgu4HtljGeIFGDiyXRmKNHC
         jraPO2xdoFfuH0cf0add3wnZRfJWzdbWq4uMKVHXgdpB3A0KdJO18ypFlV2cUw2vOw+M
         XqmQLaIfJP4gV3fka6dqre8+U7mXszRdUu0XGtVjl3STmT7Tta7v0Ln4V6LXUBwNohtk
         5JJfmOfKF7rXYi9FQFNmuV5N/Rg3DrwbMPOV0I79YhNZn4eYdPn/06p5CrwSEA4X/T7K
         mb5A==
X-Gm-Message-State: APzg51BKFDDPMQ3w6oB/qY/piNbbTIdMbs4B3R5zebZKssukm9dkp/Ml
        4iLDM4tU5mJz4IpRb3azZTlnTDusIoO8g9OgAPzkbg==
X-Google-Smtp-Source: ANB0Vda+Xq6jCLQgiZ6DICEfxW+UG4CJY1xHIWMbiC2D49o4fVpKBxAkOYUVgwirai707TRx7sKH7nhJ2EzGoRGCVe4=
X-Received: by 2002:a2e:8:: with SMTP id 8-v6mr24536515lja.112.1536177408164;
 Wed, 05 Sep 2018 12:56:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:9357:0:0:0:0:0 with HTTP; Wed, 5 Sep 2018 12:56:47 -0700 (PDT)
In-Reply-To: <20180904224150.GD24406@vader>
References: <1536100545-26905-1-git-send-email-asmadeus@codewreck.org>
 <1536100702-28706-1-git-send-email-asmadeus@codewreck.org> <20180904224150.GD24406@vader>
From:   Bhupesh Sharma <bhsharma@redhat.com>
Date:   Thu, 6 Sep 2018 01:26:47 +0530
Message-ID: <CACi5LpNVCXXPnWMAabUxFBKW7R9rH5vKVE0DZ3NENOM_nFAZrw@mail.gmail.com>
Subject: Re: [PATCH v3] proc/kcore: fix invalid memory access in multi-page
 read optimization
To:     Omar Sandoval <osandov@osandov.com>
Cc:     Dominique Martinet <asmadeus@codewreck.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Eric Biederman <ebiederm@xmission.com>,
        James Morse <james.morse@arm.com>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 5, 2018 at 4:11 AM, Omar Sandoval <osandov@osandov.com> wrote:
> On Wed, Sep 05, 2018 at 12:38:22AM +0200, Dominique Martinet wrote:
>> The 'm' kcore_list item could point to kclist_head, and it is incorrect to
>> look at m->addr / m->size in this case.
>> There is no choice but to run through the list of entries for every address
>> if we did not find any entry in the previous iteration
>>
>> Reset 'm' to NULL in that case at Omar Sandoval's suggestion.
>>
>> Fixes: bf991c2231117 ("proc/kcore: optimize multiple page reads")
>
> Reviewed-by: Omar Sandoval <osandov@fb.com>
>
> Thanks again for catching this!
>
>> Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
>> ---
>>
>> Sorry, resent v2 because From didn't match sob tag
>>
>>  fs/proc/kcore.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
>> index ad72261ee3fe..578926032880 100644
>> --- a/fs/proc/kcore.c
>> +++ b/fs/proc/kcore.c
>> @@ -464,6 +464,7 @@ read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
>>                               ret = -EFAULT;
>>                               goto out;
>>                       }
>> +                     m = NULL;
>>               } else if (m->type == KCORE_VMALLOC) {
>>                       vread(buf, (char *)start, tsz);
>>                       /* we have to zero-fill user buffer even if no read */
>> --
>> 2.17.1

Looks sane to me, so:

Reviewed-by: Bhupesh Sharma <bhsharma@redhat.com>

Thanks.
