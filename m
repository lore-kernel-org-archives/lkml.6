Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6AE4ECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 09:40:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C72D2064A
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 09:40:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C72D2064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xs4all.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727189AbeJSRqH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 13:46:07 -0400
Received: from lb3-smtp-cloud8.xs4all.net ([194.109.24.29]:59238 "EHLO
        lb3-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726435AbeJSRqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 13:46:06 -0400
Received: from [IPv6:2001:420:44c1:2579:81f2:73a:bc96:f7b1] ([IPv6:2001:420:44c1:2579:81f2:73a:bc96:f7b1])
        by smtp-cloud8.xs4all.net with ESMTPA
        id DRGrgmfPd0ZZEDRGvgMjpD; Fri, 19 Oct 2018 11:40:45 +0200
Subject: [RFC] Stateless codecs: how to refer to reference frames
To:     Alexandre Courbot <acourbot@chromium.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Pawel Osciak <posciak@chromium.org>,
        linux-media@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <20181019080928.208446-1-acourbot@chromium.org>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <a02b50ee-37e1-0202-b999-8e32b7bd1a96@xs4all.nl>
Date:   Fri, 19 Oct 2018 11:40:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20181019080928.208446-1-acourbot@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfEavPaHegzOQQEOymdCbfDRANfAX0qh7sd98M//GUr8jJ7DJIYPtuNVF+t2f3YKsuJ6n9Gx/9X3hTWNqosOrw6iXmU3hDU421T85iM70p6pZUONmOVU/
 JXmRCAssHeBcSM3GBzr80pBkzjzOTHNmBR5Rad07DkP1B0wXpXVb7up4eo5+CQ57nRQT1PCSpfkoo4vBiWBSpFffyxBVvwbEldy/DdOxYJPb9YXumyfcXKZc
 dP8cLyqr6j1R9ynpMDxukJ/ZzPUBtbFnYT0UkOJhSwXMfTciEW/gDpUpDx6B91By9Q3p8L41ZVKYOdP9XrB1mW8D/Zdcyf1TGRAlzw5dfPoITwKAiKgBWy9C
 UrxfT1DrftnEutdzG+cMsud1XNSRVEw1QnAgt2NeJcnQDMCFXTOtyTetsvEg0cy83EqQriYSNzz2XMG8U1eSkcVnaL2oO4jzG2T96QN/K4UAB+uKEDAOJ8Ls
 PLoQwdFAiTKWF38BAhVNdGTEzkTc1UfLDqb1rA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From Alexandre's '[RFC PATCH v3] media: docs-rst: Document m2m stateless
video decoder interface':

On 10/19/18 10:09, Alexandre Courbot wrote:
> Two points being currently discussed have not been changed in this
> revision due to lack of better idea. Of course this is open to change:

<snip>

> * The other hot topic is the use of capture buffer indexes in order to
>   reference frames. I understand the concerns, but I doesn't seem like
>   we have come with a better proposal so far - and since capture buffers
>   are essentially well, frames, using their buffer index to directly
>   reference them doesn't sound too inappropriate to me. There is also
>   the restriction that drivers must return capture buffers in queue
>   order. Do we have any concrete example where this scenario would not
>   work?

I'll stick to decoders in describing the issue. Stateless encoders probably
do not have this issue.

To recap: the application provides a buffer with compressed data to the
decoder. After the request is finished the application can dequeue the
decompressed frame from the capture queue.

In order to decompress the decoder needs to access previously decoded
reference frames. The request passed to the decoder contained state
information containing the buffer index (or indices) of capture buffers
that contain the reference frame(s).

This approach puts restrictions on the framework and the application:

1) It assumes that the application can predict the capture indices.
This works as long as there is a simple relationship between the
buffer passed to the decoder and the buffer you get back.

But that may not be true for future codecs. And what if one buffer
produces multiple capture buffers? (E.g. if you want to get back
decompressed slices instead of full frames to reduce output latency).

This API should be designed to be future-proof (within reason of course),
and I am not at all convinced that future codecs will be just as easy
to predict.

2) It assumes that neither drivers nor applications mess with the buffers.
One case that might happen today is if the DMA fails and a buffer is
returned marked ERROR and the DMA is retried with the next buffer. There
is nothing in the spec that prevents you from doing that, but it will mess
up the capture index numbering. And does the application always know in
what order capture buffers are queued? Perhaps there are two threads: one
queueing buffers with compressed data, and the other dequeueing the
decompressed buffers, and they are running mostly independently.


I believe that assuming that you can always predict the indices of the
capture queue is dangerous and asking for problems in the future.


I am very much in favor of using a dedicated cookie. The application sets
it for the compressed buffer and the driver copies it to the uncompressed
capture buffer. It keeps track of the association between capture index
and cookie. If a compressed buffer decompresses into multiple capture
buffers, then they will all be associated with the same cookie, so
that simplifies how you refer to reference frames if they are split
over multiple buffers.

The codec controls refer to reference frames by cookie(s).

For existing applications that use the capture index all you need to do
is to set the capture index as the cookie value in the output buffer.

It is my understanding that ChromeOS was using the timestamp as the
cookie value.

I have thought about that, but I am not in favor of doing that. One
reason is that struct timeval comes in various flavors (32 bit, 64 bit,
and a y2038-compatible 32-bit type in the future).

The y2038 compat code that we will need concerns me in particular since
it will mean that the timeval is converted from 32 to 64 bit and back
again, and that might well mangle the data. I'm not so sure if you can
stick a 64-bit pointer in the timeval (e.g. the high 32 bits go to into
the tv_sec field, the low 32 bits go to the usecs). The y2038 conversion
might mangle the tv_usec field (e.g. divide by 1000000 and add the seconds
to the tv_sec field).

I would really prefer an independent 64-bit cookie value that the application
can set instead of abusing something else.

I propose to make a union with v4l2_timecode (which nobody uses) and a
new V4L2_BUF_FLAG_COOKIE flag.

struct v4l2_buffer_cookie {
	__u32 high;
	__u32 low;
};

And in v4l2_buffer:

	union {
		struct v4l2_timecode timecode;
		struct v4l2_buffer_cookie cookie;
	};

And static inlines:

void v4l2_buffer_set_cookie(struct v4l2_buffer *buf, __u64 cookie)
{
	buf->cookie.high = cookie >> 32;
	buf->cookie.low = cookie & 0xffffffffULL;
	buf->flags |= V4L2_BUF_FLAG_COOKIE;
}

void v4l2_buffer_set_cookie_ptr(struct v4l2_buffer *buf, void *cookie)
{
	v4l2_buffer_set_cookie(buf, (__u64)cookie);
}

__u64 v4l2_buffer_get_cookie(struct v4l2_buffer *buf)
{
	if (!(buf->flags & V4L2_BUF_FLAG_COOKIE))
		return 0;
	return (((__u64)buf->cookie.high) << 32) | (__u64)buf->cookie.low;
}

void *v4l2_buffer_get_cookie_ptr(struct v4l2_buffer *buf)
{
	return (void *)v4l2_buffer_get_cookie(buf);
}

Why not just use __u64? Because the alignment in v4l2_buffer is a nightmare.
Using __u64 would create holes, made even worse by different struct timeval
sizes depending on the architecture.

I'm proposing a struct v4l2_ext_buffer together with new streaming ioctls
during the media summit that has a clean layout and there this can be just
a __u64.

I'm calling it a 'cookie' here, but that's just a suggestion. Better
names are welcome.

Comments are welcome.

Regards,

	Hans
