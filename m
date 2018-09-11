Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60E01C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 08:48:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E63320839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 08:48:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E63320839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xs4all.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbeIKNqy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 09:46:54 -0400
Received: from lb3-smtp-cloud8.xs4all.net ([194.109.24.29]:49515 "EHLO
        lb3-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726804AbeIKNqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 09:46:54 -0400
Received: from [IPv6:2001:420:44c1:2579:b9e5:7489:b855:62dc] ([IPv6:2001:420:44c1:2579:b9e5:7489:b855:62dc])
        by smtp-cloud8.xs4all.net with ESMTPA
        id zeLWfIHvSxO9BzeLafOEqc; Tue, 11 Sep 2018 10:48:34 +0200
Subject: Re: [RFC PATCH] media: docs-rst: Document m2m stateless video decoder
 interface
To:     Alexandre Courbot <acourbot@chromium.org>
Cc:     Tomasz Figa <tfiga@chromium.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Pawel Osciak <posciak@chromium.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20180831074743.235010-1-acourbot@chromium.org>
 <b8a80df8-fd07-6820-3021-670c360ff306@xs4all.nl>
 <CAPBb6MU=wJ5WrHpwXZcWLsv7dD42UT+R6ppKyLnZesuExAbNWA@mail.gmail.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <604a46db-b912-4b78-620e-1b1ba38fa130@xs4all.nl>
Date:   Tue, 11 Sep 2018 10:48:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <CAPBb6MU=wJ5WrHpwXZcWLsv7dD42UT+R6ppKyLnZesuExAbNWA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfJh93DE2XSuNkuponYojTKQqcYOxqnLGy2SO/4ViTMw7tL5dL2tGtoccD/Ypi/W9KtvXi30hWlxrGps3XHJbSoXKPeeDUAXdH01gmCv+8pNWiYUF+zkU
 C0UgaZmpce3JfJPH/GrxnaD1urbDis2qM0b/NbpThYmCk0dDrd3MbcdvQsCX67wfBHsmTRg2txQPsaLPL8lz2LH47QnOu7zh5Fq+Ictk0nwvUnDsuAByhots
 H+JIBQ6xChIfbrkXT6A7JhBiPZz8hw2+RVn31uPRVtU41/lS58lti8eEHBH0bDPRbMciI/eE29o+MZZLZjdB3y3EWyvs16k6nCn6gTu/9nWQM7HY++Q57Q8o
 fYFmqn+D0SQQyv4Nlk3CXKIaDszwLucVJCBz1eINiCs/ikfNkB4fRx2t4s8BSdsrhAmr522xIzF2JUJ4U3NX9RxTS8JCmS1HFZzyQAWfFPB3rvtAl4dSjLDH
 QxvP/X8b63rGWrdRGi80qnGeaIXWsyXgca/NOw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/11/18 10:40, Alexandre Courbot wrote:
>> I am not sure whether this should be documented, but there are some additional
>> restrictions w.r.t. reference frames:
>>
>> Since decoders need access to the decoded reference frames there are some corner
>> cases that need to be checked:
>>
>> 1) V4L2_MEMORY_USERPTR cannot be used for the capture queue: the driver does not
>>    know when a malloced but dequeued buffer is freed, so the reference frame
>>    could suddenly be gone.
> 
> It it is confirmed that we cannot use USERPTR buffers as CAPTURE then
> this probably needs to be documented. I wonder if there isn't a way to
> avoid this by having vb2 keep a reference to the pages in such a way
> that they would not be recycled after after userspace calls free() on
> the buffer. Is that possible with user-allocated memory?

vb2 keeps a reference while the buffer is queued, but that reference is
released once the buffer is dequeued. Correctly, IMHO. If you provide
USERPTR, than userspace is responsible for the memory. Changing this
would require changing the API, since USERPTR has always worked like
this.

> 
> Not that I think that forbidding USERPTR buffers in this scenario
> would be a big problem.

I think it is perfectly OK to forbid this. Ideally I would like to have
some test in v4l2-compliance or (even better) v4l2-mem2mem.c for this,
but it is actually not that easy to identify drivers like this.

Suggestions for this on a postcard...

> 
>>
>> 2) V4L2_MEMORY_DMABUF can be used, but drivers should check that the dma buffer is
>>    still available AND increase the dmabuf refcount while it is used by the HW.
> 
> Yeah, with DMABUF the above problem can easily be avoided at least.
> 
>>
>> 3) What to do if userspace has requeued a buffer containing a reference frame,
>>    and you want to decode a B/P-frame that refers to that buffer? We need to
>>    check against that: I think that when you queue a capture buffer whose index
>>    is used in a pending request as a reference frame, than that should fail with
>>    an error. And trying to queue a request referring to a buffer that has been
>>    requeued should also fail.
>>
>> We might need to add some support for this in v4l2-mem2mem.c or vb2.
> 
> Sounds good, and we should document this as well.
> 

Right. And test it!

Regards,

	Hans
