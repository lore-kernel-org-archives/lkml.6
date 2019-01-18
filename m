Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2080CC5AE5E
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 22:45:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E813520823
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 22:45:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729978AbfARWpH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 17:45:07 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:43736 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729746AbfARWpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 17:45:06 -0500
Received: by mail-qt1-f196.google.com with SMTP id i7so16997898qtj.10
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 14:45:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=spoip0+3fKHMuffSDIO0NNyi5v4LsaENWyYz5KZcMMQ=;
        b=Y/KXsjQIUp8Fg2j9nl6HxaqpN5Ap3MLNQD7ZQncpbD1CF9RByfUb0keo+dAz3tW+Ae
         UxPn0FzbXSWy5ao1M6vhxAI2Pzd9uGAsf/FjWj+OxYsyktQsTVm0EnXuMW86DnxYOmns
         QK6E3LcQn83GF1LNRJnBPe29SCJSCB968ttDblhTfOSTZqt6yGy0lapRwmDnLR/Y+qXb
         TV7ldvsEbXYVJTBGeRvqgPh0KRZVBcSIYEXyR6lZ8botDe1N/E4coMAN/XfdpS0tSayB
         o0J1YpgkNWdRpblF4eNppZufteYTistirscmwF2u0b+NmntebYBSr0aKt1tEqmr2TYhJ
         lGew==
X-Gm-Message-State: AJcUuke5tVG9rQJsrBPZGlB8IEH/FJwLPjH7/nfIklzZRBgNLvgABBS0
        Y5ny4+weT+K5tA6E9JKWQE2Q4w==
X-Google-Smtp-Source: ALg8bN69XYHfgJ6HDeql6xCCtTrsGHk+tBTR/Z06gzJ+sdp/gHz4yF+2dlOD5RBLge35Ie7Uukjv3Q==
X-Received: by 2002:a0c:95b5:: with SMTP id s50mr17497526qvs.64.1547851505402;
        Fri, 18 Jan 2019 14:45:05 -0800 (PST)
Received: from ?IPv6:2601:602:9800:dae6::fb21? ([2601:602:9800:dae6::fb21])
        by smtp.gmail.com with ESMTPSA id p8sm62056975qtk.70.2019.01.18.14.45.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 14:45:04 -0800 (PST)
Subject: Re: [PATCH 3/4] dma-buf: add support for mapping with dma mapping
 attributes
To:     Liam Mark <lmark@codeaurora.org>
Cc:     sumit.semwal@linaro.org, arve@android.com, tkjos@android.com,
        maco@android.com, joel@joelfernandes.org, christian@brauner.io,
        devel@driverdev.osuosl.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
        afd@ti.com, john.stultz@linaro.org
References: <1547836667-13695-1-git-send-email-lmark@codeaurora.org>
 <1547836667-13695-4-git-send-email-lmark@codeaurora.org>
 <9f654f36-08de-f5e8-c9b3-ff9b2954f0a6@redhat.com>
 <alpine.DEB.2.10.1901181322300.9328@lmark-linux.qualcomm.com>
From:   Laura Abbott <labbott@redhat.com>
Message-ID: <ef73a46c-ab17-cc39-7e34-f51f6ce3a9a9@redhat.com>
Date:   Fri, 18 Jan 2019 14:45:02 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.10.1901181322300.9328@lmark-linux.qualcomm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/18/19 1:32 PM, Liam Mark wrote:
> On Fri, 18 Jan 2019, Laura Abbott wrote:
> 
>> On 1/18/19 10:37 AM, Liam Mark wrote:
>>> Add support for configuring dma mapping attributes when mapping
>>> and unmapping memory through dma_buf_map_attachment and
>>> dma_buf_unmap_attachment.
>>>
>>> Signed-off-by: Liam Mark <lmark@codeaurora.org>
>>> ---
>>>    include/linux/dma-buf.h | 3 +++
>>>    1 file changed, 3 insertions(+)
>>>
>>> diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
>>> index 58725f890b5b..59bf33e09e2d 100644
>>> --- a/include/linux/dma-buf.h
>>> +++ b/include/linux/dma-buf.h
>>> @@ -308,6 +308,8 @@ struct dma_buf {
>>>     * @dev: device attached to the buffer.
>>>     * @node: list of dma_buf_attachment.
>>>     * @priv: exporter specific attachment data.
>>> + * @dma_map_attrs: DMA mapping attributes to be used in
>>> + *		   dma_buf_map_attachment() and dma_buf_unmap_attachment().
>>>     *
>>>     * This structure holds the attachment information between the dma_buf
>>> buffer
>>>     * and its user device(s). The list contains one attachment struct per
>>> device
>>> @@ -323,6 +325,7 @@ struct dma_buf_attachment {
>>>    	struct device *dev;
>>>    	struct list_head node;
>>>    	void *priv;
>>> +	unsigned long dma_map_attrs;
>>>    };
>>>      /**
>>>
>>
>> Did you miss part of this patch? This only adds it to the structure but
>> doesn't
>> add it to any API. The same commment applies to the follow up patch,
>> I don't quite see how it's being used.
>>
> 
> Were you asking for a cleaner DMA-buf API to set this field or were you
> asking for a change to an upstream client to make use of this field?
> 
> I have clients set the dma_map_attrs field directly on their
> dma_buf_attachment struct before calling dma_buf_map_attachment (if they
> need this functionality).
> Of course this is all being used in Android for out of tree drivers, but
> I assume it is just as useful to everyone else who has cached ION buffers
> which aren't always accessed by the CPU.
> 
> My understanding is that AOSP Android on Hikey 960 also is currently
> suffering from too many CMOs due to dma_map_attachemnt always applying
> CMOs, so this support should help them avoid it.
> 

Ahhhh I see how you intend this to be used now! I was missing
that clients would do attachment->dma_map_attrs = blah
and that was how it would be stored as opposed to passing
it in at the top level for dma_buf_map. I'll give this some
more thought but I think it could work if Sumit is okay
with the approach.

Thanks,
Laura
