Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3428C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 15:24:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B42FC20817
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 15:24:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B42FC20817
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xs4all.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbeK0CSZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 21:18:25 -0500
Received: from lb3-smtp-cloud8.xs4all.net ([194.109.24.29]:36144 "EHLO
        lb3-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726167AbeK0CSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 21:18:24 -0500
Received: from [192.168.2.10] ([212.251.195.8])
        by smtp-cloud8.xs4all.net with ESMTPA
        id RIjogDaI4IGBARIjrgfcWc; Mon, 26 Nov 2018 16:23:57 +0100
Subject: Re: [PATCH v3] media: venus: amend buffer size for bitstream plane
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Malathi Gottam <mgottam@codeaurora.org>, mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, acourbot@chromium.org,
        vgarodia@codeaurora.org, Tomasz Figa <tfiga@chromium.org>
References: <1543227173-2160-1-git-send-email-mgottam@codeaurora.org>
 <d74281c8-a177-12a3-9e72-7a7db3014943@xs4all.nl>
 <f6106d20-abee-979c-8ac1-6c9115e8373c@linaro.org>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <57b28a7f-8c5c-22d2-2f89-e6d6ebdcb8a2@xs4all.nl>
Date:   Mon, 26 Nov 2018 16:23:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <f6106d20-abee-979c-8ac1-6c9115e8373c@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfISXF+eRkpVnhf4Z/3F84PafkCHgnu7bRH9AxzaGgryI+PKf0Q0gTNJFhaWRQF0cG+Bj1fLo7O8hUmHjfDsgUBgeMdyEv4D42EMEY/WtNd6mCElAqqCc
 LOPaENOqU8I+IlL3DwtlFLB58B64jVQtqaLWeR6iLN7mZBvHfo0VJVeLXi9atm59f9MSQaUDkQ6w5UQeXuwyIEDdQYfggHIZCnNKjq+bxgfTi2H17noAkc1t
 oyJo9w8OrBVq4+DSaPRnArWmKaYfoTxsEldDyrSIMHLlThvWNAXmHaUKt2JRC2T7zct15xI720/1CRH9CtVMLoqsZpEdOBB2iKQdqbHOzumKB/nnFXS6sSjF
 qemA2qkiOKXFn4P8gpSn32oRrtGoVZRK1tevZgSk1ih2FabtCDHbKRSvez7LT4l58hlA3BWPgVUFvXZ9C+nLtm4tXLivkAQb8m4qllEG87bQbk5senk=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/26/2018 03:57 PM, Stanimir Varbanov wrote:
> Hi Hans,
> 
> On 11/26/18 3:37 PM, Hans Verkuil wrote:
>> On 11/26/2018 11:12 AM, Malathi Gottam wrote:
>>> Accept the buffer size requested by client and compare it
>>> against driver calculated size and set the maximum to
>>> bitstream plane.
>>>
>>> Signed-off-by: Malathi Gottam <mgottam@codeaurora.org>
>>
>> Sorry, this isn't allowed. It is the driver that sets the sizeimage value,
>> never the other way around.
> 
> I think for decoders (OUTPUT queue) and encoders (CAPTURE queue) we
> allowed userspace to set sizeimage for buffers. See [1] Initialization
> paragraph point 2:
> 
>     ``sizeimage``
>        desired size of ``CAPTURE`` buffers; the encoder may adjust it to
>        match hardware requirements
> 
> Similar patch we be needed for decoder as well.

I may have missed that change since it wasn't present in v1 of the stateful
encoder spec.

Tomasz, what was the reason for this change? I vaguely remember some thread
about this, but I forgot the details. Since this would be a departure of
the current API this should be explained in more detail.

I don't really see the point of requiring userspace to fill this in. For
stateful codecs it can just return some reasonable size. Possibly calculated
using the provided width/height values or (if those are 0) some default value.

Ditto for decoders.

Stanimir, I certainly cannot merge this until this has been fully nailed down
as it would be a departure from the current API.

And looking at the venus patch I do not see how it helps userspace.

Regards,

	Hans

> 
>>
>> If you need to allocate larger buffers, then use VIDIOC_CREATE_BUFS instead
>> of VIDIOC_REQBUFS.
>>
>> What problem are you trying to solve with this patch?
>>
>> Regards,
>>
>> 	Hans
>>
> 

