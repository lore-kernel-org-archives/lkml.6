Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B47DCC00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 10:07:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8023C205C9
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 10:07:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8023C205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xs4all.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727672AbeJHRSJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 13:18:09 -0400
Received: from lb1-smtp-cloud9.xs4all.net ([194.109.24.22]:38722 "EHLO
        lb1-smtp-cloud9.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726193AbeJHRSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 13:18:09 -0400
Received: from [192.168.2.10] ([212.251.195.8])
        by smtp-cloud9.xs4all.net with ESMTPA
        id 9SRPgLSKkSskC9SRSgfo7b; Mon, 08 Oct 2018 12:07:11 +0200
Subject: Re: [RFC PATCH] media: docs-rst: Document m2m stateless video decoder
 interface
To:     Tomasz Figa <tfiga@chromium.org>
Cc:     Alexandre Courbot <acourbot@chromium.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Pawel Osciak <posciak@chromium.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20180831074743.235010-1-acourbot@chromium.org>
 <b8a80df8-fd07-6820-3021-670c360ff306@xs4all.nl>
 <CAPBb6MU=wJ5WrHpwXZcWLsv7dD42UT+R6ppKyLnZesuExAbNWA@mail.gmail.com>
 <604a46db-b912-4b78-620e-1b1ba38fa130@xs4all.nl>
 <CAAFQd5ANVWury7c1xH6r6uX-SFgSzsTyonFan5TjdOytmoW-kw@mail.gmail.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <3cd8e2f0-d9c1-6907-d16b-d3c6699c9ef8@xs4all.nl>
Date:   Mon, 8 Oct 2018 12:07:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <CAAFQd5ANVWury7c1xH6r6uX-SFgSzsTyonFan5TjdOytmoW-kw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfNAxquIzA7cZ3tn0fzN9rBt3jCQYlWMS6EWXme12TvrCg1NBglqxdQZTYh8LBcA0U99zhMWvLiQy9XLeKEkXD0tt3sm3hm2MBC1XMH1m2n7HAcO9VLn0
 VVDwMPFjSXXeyaLQdQ89bgkTVA10RgA2YC6oqWbUXN1KqWG93wReFFaV/gRul5k/jeo8s2t77W++QSVUFI13niAYAYuVQoOUlMKIZWEzlY302AD9eLdk4lA3
 yPFe80puYk57UC6mQgELwx6n3p/hHS9IR++wg3+HWfTLyrnUBczftny1+hlBLMbx4TLbpRZ3aWb9Z1dJstW06ZNb8G4m/2qJwp+O771G5cJvjrQppCVsnFiA
 H4S1JK36uH5msLjGKU5W16s7dupUITfx0/ZqZCRqRGGsbIKyTHM=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/03/2018 12:10 PM, Tomasz Figa wrote:
> On Tue, Sep 11, 2018 at 5:48 PM Hans Verkuil <hverkuil@xs4all.nl> wrote:
>>
>> On 09/11/18 10:40, Alexandre Courbot wrote:
>>>> I am not sure whether this should be documented, but there are some additional
>>>> restrictions w.r.t. reference frames:
>>>>
>>>> Since decoders need access to the decoded reference frames there are some corner
>>>> cases that need to be checked:
>>>>
>>>> 1) V4L2_MEMORY_USERPTR cannot be used for the capture queue: the driver does not
>>>>    know when a malloced but dequeued buffer is freed, so the reference frame
>>>>    could suddenly be gone.
>>>
>>> It it is confirmed that we cannot use USERPTR buffers as CAPTURE then
>>> this probably needs to be documented. I wonder if there isn't a way to
>>> avoid this by having vb2 keep a reference to the pages in such a way
>>> that they would not be recycled after after userspace calls free() on
>>> the buffer. Is that possible with user-allocated memory?
>>
>> vb2 keeps a reference while the buffer is queued, but that reference is
>> released once the buffer is dequeued. Correctly, IMHO. If you provide
>> USERPTR, than userspace is responsible for the memory. Changing this
>> would require changing the API, since USERPTR has always worked like
>> this.
> 
> That would be a userspace bug wouldn't it? The next try to get user
> pages would fail in that case and we could just fail such decode
> request, couldn't we?
> 
> (Personally I'm not a big fan of USERPTR, though.)

Yes, just don't support USERPTR for drivers like this. USERPTR just
doesn't make sense.

> 
>>
>>>
>>> Not that I think that forbidding USERPTR buffers in this scenario
>>> would be a big problem.
>>
>> I think it is perfectly OK to forbid this. Ideally I would like to have
>> some test in v4l2-compliance or (even better) v4l2-mem2mem.c for this,
>> but it is actually not that easy to identify drivers like this.
>>
>> Suggestions for this on a postcard...
>>
>>>
>>>>
>>>> 2) V4L2_MEMORY_DMABUF can be used, but drivers should check that the dma buffer is
>>>>    still available AND increase the dmabuf refcount while it is used by the HW.
>>>
>>> Yeah, with DMABUF the above problem can easily be avoided at least.
>>>
>>>>
>>>> 3) What to do if userspace has requeued a buffer containing a reference frame,
>>>>    and you want to decode a B/P-frame that refers to that buffer? We need to
>>>>    check against that: I think that when you queue a capture buffer whose index
>>>>    is used in a pending request as a reference frame, than that should fail with
>>>>    an error.

Perhaps an error is overkill, but I think a warning should be issued.

 And trying to queue a request referring to a buffer that has been
 requeued should also fail.

I don't think this is right, this is likely a valid case.

Regards,

	Hans

>>>>
>>>> We might need to add some support for this in v4l2-mem2mem.c or vb2.
>>>
>>> Sounds good, and we should document this as well.
>>>
>>
>> Right. And test it!
> 
> I'm not convinced that we should be enforcing this. Moreover,
> requeuing a buffer containing a reference frame for a pending request
> is not bound to be an error. It might be a legit case when the same
> entry in the reference list is replaced with a different key frame
> decoded into the same buffer as the reference list entry pointed until
> now.
> 
> Best regards,
> Tomasz
> 

