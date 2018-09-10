Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82DEEC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 11:57:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B07E20833
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 11:57:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B07E20833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xs4all.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728295AbeIJQvi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 12:51:38 -0400
Received: from lb2-smtp-cloud7.xs4all.net ([194.109.24.28]:41551 "EHLO
        lb2-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727727AbeIJQvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 12:51:37 -0400
Received: from [192.168.2.10] ([212.251.195.8])
        by smtp-cloud7.xs4all.net with ESMTPA
        id zKpBf2g1Rw2L8zKpEfKH5a; Mon, 10 Sep 2018 13:57:52 +0200
Subject: Re: [RFC PATCH] media: docs-rst: Document m2m stateless video decoder
 interface
From:   Hans Verkuil <hverkuil@xs4all.nl>
To:     Alexandre Courbot <acourbot@chromium.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Pawel Osciak <posciak@chromium.org>,
        linux-media@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <20180831074743.235010-1-acourbot@chromium.org>
 <b8a80df8-fd07-6820-3021-670c360ff306@xs4all.nl>
Message-ID: <38b32d24-6957-4bee-9168-b3afbfcae083@xs4all.nl>
Date:   Mon, 10 Sep 2018 13:57:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <b8a80df8-fd07-6820-3021-670c360ff306@xs4all.nl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfH0ubcmSl7w0k5sl2GBmFNf8aH7TwDsPyVyc6FtpNg85nVNhISHtew5TmDMAxkcwmonvTMvhwFnmZy76BrVRLL2XIqbAw3LaAFrp6TSNmAvJLBo2nhUD
 52JfMtOLjNecTAvs8h8yrVTUp5t4EJMrIFBgc16O9UoEB0LLePySd6dP0tdH1tdxvaRc/63GrFQqRvLfDC/9nK46CHk+R5jLTCKGgKpsCMb89gVcO1kT/X5x
 m+mWhJmjXJkvls0lz6+n0ScLOe+8Paq8NroxhdlnIoh6OQMdnlxLaDkwR2CjvAHSL23ez7U0rs3ldxS0WzeLz3G7ChO7Fhk6rSDiZe2hEPRNiwqTsYEIjAJm
 8f3iMu4LKVCTHbPRVb5+dj65QwK+kPqiQR9LrXQONygqdAyoiRk=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/10/2018 01:25 PM, Hans Verkuil wrote:
>> +
>> +Decoding
>> +========
>> +
>> +For each frame, the client is responsible for submitting a request to which the
>> +following is attached:
>> +
>> +* Exactly one frame worth of encoded data in a buffer submitted to the
>> +  ``OUTPUT`` queue,
>> +* All the controls relevant to the format being decoded (see below for details).
>> +
>> +``CAPTURE`` buffers must not be part of the request, but must be queued
>> +independently. The driver will pick one of the queued ``CAPTURE`` buffers and
>> +decode the frame into it. Although the client has no control over which
>> +``CAPTURE`` buffer will be used with a given ``OUTPUT`` buffer, it is guaranteed
>> +that ``CAPTURE`` buffers will be returned in decode order (i.e. the same order
>> +as ``OUTPUT`` buffers were submitted), so it is trivial to associate a dequeued
>> +``CAPTURE`` buffer to its originating request and ``OUTPUT`` buffer.
>> +
>> +If the request is submitted without an ``OUTPUT`` buffer or if one of the
>> +required controls are missing, then :c:func:`MEDIA_REQUEST_IOC_QUEUE` will return
>> +``-EINVAL``.
> 
> Not entirely true: if buffers are missing, then ENOENT is returned. Missing required
> controls or more than one OUTPUT buffer will result in EINVAL. This per the latest
> Request API changes.
> 
>  Decoding errors are signaled by the ``CAPTURE`` buffers being
>> +dequeued carrying the ``V4L2_BUF_FLAG_ERROR`` flag.
> 
> Add here that if the reference frame had an error, then all other frames that refer
> to it should also set the ERROR flag. It is up to userspace to decide whether or
> not to drop them (part of the frame might still be valid).
> 
> I am not sure whether this should be documented, but there are some additional
> restrictions w.r.t. reference frames:
> 
> Since decoders need access to the decoded reference frames there are some corner
> cases that need to be checked:
> 
> 1) V4L2_MEMORY_USERPTR cannot be used for the capture queue: the driver does not
>    know when a malloced but dequeued buffer is freed, so the reference frame
>    could suddenly be gone.
> 
> 2) V4L2_MEMORY_DMABUF can be used, but drivers should check that the dma buffer is
>    still available AND increase the dmabuf refcount while it is used by the HW.
> 
> 3) What to do if userspace has requeued a buffer containing a reference frame,
>    and you want to decode a B/P-frame that refers to that buffer? We need to
>    check against that: I think that when you queue a capture buffer whose index
>    is used in a pending request as a reference frame, than that should fail with
>    an error. And trying to queue a request referring to a buffer that has been
>    requeued should also fail.
> 
> We might need to add some support for this in v4l2-mem2mem.c or vb2.
> 
> We will have similar (but not quite identical) issues with stateless encoders.

Related to this is the question whether buffer indices that are used to refer
to reference frames should refer to the capture or output queue.

Using capture indices works if you never queue more than one request at a time:
you know exactly what the capture buffer index is of the decoded I-frame, and
you can use that in the following requests.

But if multiple requests are queued, then you don't necessarily know to which
capture buffer an I-frame will be decoded, so then you can't provide this index
to following B/P-frames. This puts restrictions on userspace: you can only
queue B/P-frames once you have decoded the I-frame. This might be perfectly
acceptable, though.

Using output buffer indices will work (the driver will know to which capture
buffer index the I-frames mapped), but it requires that the output buffer that
contained a reference frame isn't requeued, since that means that the driver
will lose this mapping. I think this will make things too confusing, though.

A third option is that you don't refer to reference frames by buffer index,
but instead by some other counter (sequence counter, perhaps?).

Regards,

	Hans
