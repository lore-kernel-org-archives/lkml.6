Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BBD1C004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 09:52:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E08012075D
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 09:52:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E08012075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xs4all.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727167AbeJXSUE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 14:20:04 -0400
Received: from lb3-smtp-cloud9.xs4all.net ([194.109.24.30]:59080 "EHLO
        lb3-smtp-cloud9.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726301AbeJXSUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 14:20:04 -0400
Received: from [10.101.224.151] ([185.7.230.215])
        by smtp-cloud9.xs4all.net with ESMTPA
        id FFq3g9j1TSskCFFq8gXDhF; Wed, 24 Oct 2018 11:52:37 +0200
Subject: Re: [RFC] Stateless codecs: how to refer to reference frames
To:     Alexandre Courbot <acourbot@chromium.org>
Cc:     Tomasz Figa <tfiga@chromium.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Pawel Osciak <posciak@chromium.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20181019080928.208446-1-acourbot@chromium.org>
 <a02b50ee-37e1-0202-b999-8e32b7bd1a96@xs4all.nl>
 <CAPBb6MUA5zNL9SsY2AEDNKgazyAqOMxGGSwidMV+RJnnrz7kTg@mail.gmail.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <515520e4-51d6-e4bb-138a-84453ea6e189@xs4all.nl>
Date:   Wed, 24 Oct 2018 10:52:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAPBb6MUA5zNL9SsY2AEDNKgazyAqOMxGGSwidMV+RJnnrz7kTg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfBUe66sk+kZOUBWXzWFoJPJlmyXDme7Gdft76fzxZ6sgASHM862q2looN/5oZy0wMt0M+FWSeSoHaJDUaBWgysR65r+k7cHsMiSYIp9W6+1JCrd6IIO1
 OzxhtLqmCRMEQBILNLJmbvWoBdJqpu8PyCtT44/vhA468/c8TlygKogBOBsJZEKsA/jZp7mvPk+8zfVez2hbHIcYl/UU9qIExjwEkCb47XM/9k4xjg1H/Hzk
 Y1DsL8x1RqwKajz/YIE8y4GVRVqLymWcxPmnSg8AYYXZvpwDQWxb1RsFMto7C+sCNKNsiyAqKvnSXx9J2m3HW2DnTAu3AG6YVuIaXtDc5wSb6qYEPW/Q8Q3m
 d6KGOhjd1SAKQILNAwjHjrhWi8nQkW249pgpSgfKDAy9zU7J5Iw=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI Alexandre,

On 10/24/2018 10:16 AM, Alexandre Courbot wrote:
> Hi Hans,
> 
> On Fri, Oct 19, 2018 at 6:40 PM Hans Verkuil <hverkuil@xs4all.nl> wrote:
>>
>> From Alexandre's '[RFC PATCH v3] media: docs-rst: Document m2m stateless
>> video decoder interface':
>>
>> On 10/19/18 10:09, Alexandre Courbot wrote:
>>> Two points being currently discussed have not been changed in this
>>> revision due to lack of better idea. Of course this is open to change:
>>
>> <snip>
>>
>>> * The other hot topic is the use of capture buffer indexes in order to
>>>   reference frames. I understand the concerns, but I doesn't seem like
>>>   we have come with a better proposal so far - and since capture buffers
>>>   are essentially well, frames, using their buffer index to directly
>>>   reference them doesn't sound too inappropriate to me. There is also
>>>   the restriction that drivers must return capture buffers in queue
>>>   order. Do we have any concrete example where this scenario would not
>>>   work?
>>
>> I'll stick to decoders in describing the issue. Stateless encoders probably
>> do not have this issue.
>>
>> To recap: the application provides a buffer with compressed data to the
>> decoder. After the request is finished the application can dequeue the
>> decompressed frame from the capture queue.
>>
>> In order to decompress the decoder needs to access previously decoded
>> reference frames. The request passed to the decoder contained state
>> information containing the buffer index (or indices) of capture buffers
>> that contain the reference frame(s).
>>
>> This approach puts restrictions on the framework and the application:
>>
>> 1) It assumes that the application can predict the capture indices.
>> This works as long as there is a simple relationship between the
>> buffer passed to the decoder and the buffer you get back.
>>
>> But that may not be true for future codecs. And what if one buffer
>> produces multiple capture buffers? (E.g. if you want to get back
>> decompressed slices instead of full frames to reduce output latency).
>>
>> This API should be designed to be future-proof (within reason of course),
>> and I am not at all convinced that future codecs will be just as easy
>> to predict.
>>
>> 2) It assumes that neither drivers nor applications mess with the buffers.
>> One case that might happen today is if the DMA fails and a buffer is
>> returned marked ERROR and the DMA is retried with the next buffer. There
>> is nothing in the spec that prevents you from doing that, but it will mess
>> up the capture index numbering. And does the application always know in
>> what order capture buffers are queued? Perhaps there are two threads: one
>> queueing buffers with compressed data, and the other dequeueing the
>> decompressed buffers, and they are running mostly independently.
>>
>>
>> I believe that assuming that you can always predict the indices of the
>> capture queue is dangerous and asking for problems in the future.
>>
>>
>> I am very much in favor of using a dedicated cookie. The application sets
>> it for the compressed buffer and the driver copies it to the uncompressed
>> capture buffer. It keeps track of the association between capture index
>> and cookie. If a compressed buffer decompresses into multiple capture
>> buffers, then they will all be associated with the same cookie, so
>> that simplifies how you refer to reference frames if they are split
>> over multiple buffers.
>>
>> The codec controls refer to reference frames by cookie(s).
> 
> So as discussed yesterday, I understand your issue with using buffer
> indexes. The cookie idea sounds like it could work, but I'm afraid you
> could still run into issues when you don't have buffer symmetry.
> 
> For instance, imagine that the compressed buffer contains 2 frames
> worth of data. In this case, the 2 dequeued capture buffers would
> carry the same cookie, making it impossible to reference either frame
> unambiguously.

But this is a stateless codec, so each compressed buffer contains only
one frame. That's the responsibility of the bitstream parser to ensure
that.

The whole idea of the stateless codec is that you supply only one frame
at a time to the codec.

If someone indeed puts multiple frames into a single buffer, then
the behavior is likely undefined. Does anyone have any idea what
would happen with the cedrus driver in that case? This is actually
a good test.

Anyway, I would consider this an application bug. Garbage in, garbage out.

> 
> There may also be a similar, yet simpler solution already in place
> that we can use. The v4l2_buffer structure contains a "sequence"
> member, that is supposed to sequentially count the delivered frames.

The sequence field suffers from exactly the same problems as the
buffer index: it doesn't work if one compressed frame results in
multiple capture buffers (one for each slice), since the sequence
number will be increased for each capture buffer. Also if capture
buffers are marked as error for some reason, the sequence number is
also incremented for that buffer, again making it impossible to
predict in userspace what the sequence counter will be.

> What if we used this field in the same spirit as your cookie?
> Userspace would just need to keep count of the number of frames sent
> to the driver in order to accurately predict which sequence number a
> given frame is going to carry. Then the driver/framework just needs to
> associate the last sequence number of each buffer so it can find the
> reference frames, and we have an way to refer every frame. Would that
> work? We would need to make sure that error buffers are returned for
> every frame that fails (otherwise the counter could deviate between
> kernel and user-space), but if we take care of that it seems to me
> that this would stand, while being simpler and taking advantage of an
> already existing field.
> 

So no, this wouldn't work.

I don't want this 'accurately predict' method: it is inherently fragile.

Regards,

	Hans
