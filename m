Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78928C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 08:54:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33A1B20850
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 08:54:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vq/fY/9o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33A1B20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbeKZTr4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 14:47:56 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43927 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbeKZTrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 14:47:55 -0500
Received: by mail-wr1-f68.google.com with SMTP id r10so17927940wrs.10
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 00:54:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zHnWv3d3yb6Hw2J9pDGopeGI4bLUy88fCknQsL2tCjA=;
        b=Vq/fY/9oDTLlOVCc512sYlzVz061IdUYttODFFnqVgq74mWidnAwBoIU1aZBFiB5VG
         OFR4loRJck/jB30cxLpXgeZI4i8LhFLWP+8R+pFJoetF9T3HpjG4+nmw+o6OMnvtCi3p
         4ka5+gbb4Zy11nxYTb3Ms4FqHVaIdzE+FmmeA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zHnWv3d3yb6Hw2J9pDGopeGI4bLUy88fCknQsL2tCjA=;
        b=SDK2dvRAFjZ9ijKuCdT7NOXreut5cwrHoaTqPNujU8gGMsXgS9+FPFC+w+fDVrpFC4
         S2S7aYgd+c0Z/+lKI4kFRdm7O94Ja/6sTZBvCwNSU4I+Za4EgXhL4sPlJV5l//t99ab9
         Ovi91ksl4Sq/z6UbMkZiKm8s+L0to3if+wWH4YSsj0r+66PaBqt+2GlSNW1JnbdTnhsl
         WEK1TdnhZusR7mSTDnk9n9+g+nvhuduoDuo4orV+XQ4TknviwpTvhxjnh5boBp1Ygbxq
         eXkHjbnmVAsKlKWoFP9elbFCCWgVWalVSzFlbuZHctAxH0wBBoPyYEvadTKo95G5/jMx
         EKrQ==
X-Gm-Message-State: AA+aEWbHvhMyfwrwW2f4O0yS/MhWzHb0xQgfL9eMu3XD5iT1il0bmXob
        GkAx8/EAShdfaOc4psv5IycRYBo2i4s=
X-Google-Smtp-Source: AFSGD/XuBL6xt7XvRg1jUSL8rUBJ8MGm2hsITyXVd9zA79hGWp4nqYe02bCFQbgCTKQ2ubXdnPI77g==
X-Received: by 2002:adf:fe8f:: with SMTP id l15mr21705786wrr.313.1543222467246;
        Mon, 26 Nov 2018 00:54:27 -0800 (PST)
Received: from [192.168.27.209] ([37.157.136.206])
        by smtp.googlemail.com with ESMTPSA id a125-v6sm146080wmf.8.2018.11.26.00.54.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Nov 2018 00:54:26 -0800 (PST)
Subject: Re: [PATCH] media: venus: fix reported size of 0-length buffers
To:     Alexandre Courbot <acourbot@chromium.org>,
        Nicolas Dufresne <nicolas@ndufresne.ca>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <20181113093048.236201-1-acourbot@chromium.org>
 <CAKQmDh-91tHP1VxLisW1A3GR9G7du3F-Y2XrrgoFU=gvhGoP6w@mail.gmail.com>
 <CAPBb6MWJ1Qu9YoRRusOGiC7dioMkgvU=1dCF6XZ4xDUxp7ri9A@mail.gmail.com>
 <463ac42b795933a54daa8d2bbba3ff1ac2b733db.camel@ndufresne.ca>
 <CAPBb6MVzqqgUD5faN06=s-UNA9obxjiBQdMDNDK7m=m3=Utk3w@mail.gmail.com>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <f84018c6-1a55-8cdd-0fc5-748f7940da7f@linaro.org>
Date:   Mon, 26 Nov 2018 10:54:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAPBb6MVzqqgUD5faN06=s-UNA9obxjiBQdMDNDK7m=m3=Utk3w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

On 11/22/18 10:31 AM, Alexandre Courbot wrote:
> On Fri, Nov 16, 2018 at 1:49 AM Nicolas Dufresne <nicolas@ndufresne.ca> wrote:
>>
>> Le mercredi 14 novembre 2018 à 13:12 +0900, Alexandre Courbot a écrit :
>>> On Wed, Nov 14, 2018 at 3:54 AM Nicolas Dufresne <nicolas@ndufresne.ca> wrote:
>>>>
>>>>
>>>> Le mar. 13 nov. 2018 04 h 30, Alexandre Courbot <acourbot@chromium.org> a écrit :
>>>>> The last buffer is often signaled by an empty buffer with the
>>>>> V4L2_BUF_FLAG_LAST flag set. Such buffers were returned with the
>>>>> bytesused field set to the full size of the OPB, which leads
>>>>> user-space to believe that the buffer actually contains useful data. Fix
>>>>> this by passing the number of bytes reported used by the firmware.
>>>>
>>>> That means the driver does not know on time which one is last. Why not just returned EPIPE to userspace on DQBUF and ovoid this useless roundtrip ?
>>>
>>> Sorry, I don't understand what you mean. EPIPE is supposed to be
>>> returned after a buffer with V4L2_BUF_FLAG_LAST is made available for
>>> dequeue. This patch amends the code that prepares this LAST-flagged
>>> buffer. How could we avoid a roundtrip in this case?
>>
>> Maybe it has changed, but when this was introduced, we found that some
>> firmware (Exynos MFC) could not know which one is last. Instead, it
>> gets an event saying there will be no more buffers.
>>
>> Sending buffers with payload size to 0 just for the sake of setting the
>> V4L2_BUF_FLAG_LAST was considered a waste. Specially that after that,
>> every polls should return EPIPE. So in the end, we decided the it
>> should just unblock the userspace and return EPIPE.
>>
>> If you look at the related GStreamer code, it completely ignores the
>> LAST flag. With fake buffer of size 0, userspace will endup dequeuing
>> and throwing away. This is not useful to the process of terminating the
>> decoding. To me, this LAST flag is not useful in this context.
> 
> Note that this patch does not interfere with DQBUF returning -EPIPE
> after the last buffer has been dequeued. It just fixes an invalid size
> that was returned for the last buffer.
> 
> Note also that if I understand the doc properly, the kernel driver
> *must* set the V4L2_BUF_FLAG_LAST on the last buffer. With Venus the
> last buffer is signaled by the firmware with an empty buffer. That's

Small correction, the firmware signals EoS with HFI_BUFFERFLAG_EOS flag
with the returned buffer, then we set V4L2_BUF_FLAG_LAST.

Usually with v1 and v3 when HFI_BUFFERFLAG_EOS is set the bytesused is zero.

> not something we can change or predict earlier, so in order to respect
> the specification we need to return that empty buffer. After that
> DQBUF will behave as expected (returning -EPIPE), so GStreamer should
> be happy as well.
> 
> Without the proposed fix however, GStreamer would receive the last
> buffer with an incorrect size, and thus interpret random data as a
> frame.
> 
> So to me this fix seems to be both correct, and needed. Isn't it?
> 
> Cheers,
> Alex.
> 

-- 
regards,
Stan
