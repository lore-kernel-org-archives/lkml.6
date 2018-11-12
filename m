Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC444C43610
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 12:34:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7572622443
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 12:34:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hr3gSfrq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7572622443
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729562AbeKLW1T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 17:27:19 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54756 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729133AbeKLW1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 17:27:18 -0500
Received: by mail-wm1-f68.google.com with SMTP id r63-v6so8354457wma.4
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 04:34:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=G6IYBDhDYr+yEklxiFHBq+8KxoF6Te+KzWk97fTNd/k=;
        b=hr3gSfrqK8oJJQUFFycr2XiQA6gFxIvsevIFvClw37Lz/NxsSdKQ+S2oIQ3d8b3oij
         VusJJG8sWhIWsRf2excdo/oniEOAdabCk9DhnDGYrbSY33sbMV+fql2dfSAzNc7ctwja
         kPmRkHryEOYSEjkR/Qm2vxY021+86wiuNN8tg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=G6IYBDhDYr+yEklxiFHBq+8KxoF6Te+KzWk97fTNd/k=;
        b=k/pKIcV0h88Akf3LfCeFSTqjcVXHMtEkcOU4ZOeLpicyLHTFZOdiizab4KrU5qPFoQ
         asbwzefFcxojl6hLpQvdeJXpuN8XqU6tlvUbOOj4pQYa3RZ5dk/qjKLMBypni/vdfx93
         rcqFNxz13i0gG40HewLjcbGbxM/DvSVfZ0b6vICQ/rw7EIWXBlUPH4AzaZBhsgCETY8d
         96pOfE13AzZiLguN17zAVmcinIJGYdo1bRe1cZh8R3JEFjvCUWMfAez2ZyhG1SgK/Tj5
         76Xn53CPbVKMHpUUHdZSzqMy+BP78uSN0Xh+yDl5rKBlu8npLPA7Ry8XBl1qM07i7M6A
         1wdg==
X-Gm-Message-State: AGRZ1gLF36PAYqMfRChkHy8nQxFdEafb7tlHf3jCCk5Ju9S3SWwJW5md
        /ZfsaZV7PACsJ8UQ5zwANSci4A==
X-Google-Smtp-Source: AJdET5cBSwOj0Y4EeOWn/F/g9C4p7ASxrN4uykqBbRB60rvykV4jScHdnwpmj8NHBVzCKQgkD1pC9Q==
X-Received: by 2002:a1c:eed3:: with SMTP id j80mr1348535wmi.58.1542026051693;
        Mon, 12 Nov 2018 04:34:11 -0800 (PST)
Received: from [192.168.27.209] ([37.157.136.206])
        by smtp.googlemail.com with ESMTPSA id z8-v6sm22072836wrr.94.2018.11.12.04.34.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 04:34:10 -0800 (PST)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: Re: [PATCH] media: venus: amend buffer size for bitstream plane
To:     Tomasz Figa <tfiga@chromium.org>, mgottam@codeaurora.org
Cc:     Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        vgarodia@codeaurora.org
References: <1539071530-1441-1-git-send-email-mgottam@codeaurora.org>
 <CAAFQd5BcFr11Hpngpn6hNL91OibAxUv25yh2qMohgfxsKusACw@mail.gmail.com>
Message-ID: <8fe1d205-c5e7-01a0-9569-d3268911cddd@linaro.org>
Date:   Mon, 12 Nov 2018 14:34:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAAFQd5BcFr11Hpngpn6hNL91OibAxUv25yh2qMohgfxsKusACw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tomasz,

On 10/23/2018 05:50 AM, Tomasz Figa wrote:
> Hi Malathi,
> 
> On Tue, Oct 9, 2018 at 4:58 PM Malathi Gottam <mgottam@codeaurora.org> wrote:
>>
>> For lower resolutions, incase of encoder, the compressed
>> frame size is more than half of the corresponding input
>> YUV. Keep the size as same as YUV considering worst case.
>>
>> Signed-off-by: Malathi Gottam <mgottam@codeaurora.org>
>> ---
>>  drivers/media/platform/qcom/venus/helpers.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/media/platform/qcom/venus/helpers.c b/drivers/media/platform/qcom/venus/helpers.c
>> index 2679adb..05c5423 100644
>> --- a/drivers/media/platform/qcom/venus/helpers.c
>> +++ b/drivers/media/platform/qcom/venus/helpers.c
>> @@ -649,7 +649,7 @@ u32 venus_helper_get_framesz(u32 v4l2_fmt, u32 width, u32 height)
>>         }
>>
>>         if (compressed) {
>> -               sz = ALIGN(height, 32) * ALIGN(width, 32) * 3 / 2 / 2;
>> +               sz = ALIGN(height, 32) * ALIGN(width, 32) * 3 / 2;
>>                 return ALIGN(sz, SZ_4K);
>>         }
> 
> Note that the driver should not enforce one particular buffer size for
> bitstream buffers unless it's a workaround for broken firmware or
> hardware. The userspace should be able to select the desired size.

Good point! Yes, we have to extend set_fmt to allow bigger sizeimage for
the compressed buffers (not only for encoder).

-- 
regards,
Stan
