Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB6A1C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 13:34:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8102A20868
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 13:34:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dVwYgBCl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8102A20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbeLAAn6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 19:43:58 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54292 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726595AbeLAAn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 19:43:57 -0500
Received: by mail-wm1-f65.google.com with SMTP id z18so5838308wmc.4
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 05:34:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MMGXRMRtE05p93+vMI2n+wqxDfDOwZHz2XT8CLr6tqM=;
        b=dVwYgBCl9GdX6h+hrPFjFDS9tll2bUjKTX3C4Q2A5aFCIwy5exKbAZnByj54PkFw/G
         r1w5mCf2q70vzsm2u74MZsyhLVZEazn+B+4+DpTOFJ19L+WERQ3dUhHggFh1iOAYTOCs
         brYuGOWes6ejyLiEfjlrGCspzcJrJ91lD9pts=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MMGXRMRtE05p93+vMI2n+wqxDfDOwZHz2XT8CLr6tqM=;
        b=mL4HJB63ohVbPynbc7KUVjbFj1S8+gkkcHtmSvLoUjQolq7ihMOI4q9bE2hIIniWl0
         K3NEJqg2ozGPBJ+cjAiHlsCF0hcSpp7WlIDKIjFiZ+lf5v7sBw9YV9GI3jLPKKEXkjip
         obveHfalH3iIavniNAvfqWrS/GQnhvN97cd5YwL63+9fDV8q5kpr2p2zz8NKplXH1rAX
         YhGD7feGFBhOZ9ApMsGV+wG9HjXkKD3EAa9p2AxVw5UA5eb5TPq+HmzP0qJ1dJgW50BB
         MNJr32Vhbz2osoqw3+eV1ww0sQdHKPaGrp9P/UyeyGmSk+FRakX0yQn+rP6MmLvPPFNt
         w7uQ==
X-Gm-Message-State: AA+aEWYj9jDg0TET4GgGQQ8xm2zv5xyucDUf2Y/pnmeyzbWNHJyFo4T5
        BBdCbXh1KZG9j5Cwf0AynmSddg==
X-Google-Smtp-Source: AFSGD/Xv9N2emlhqyCar033DPq2lI7KDaPPBaTo3DthV8ugkw4W+CMeUKjlDr0NMzQFt2drxCEiCGg==
X-Received: by 2002:a1c:e046:: with SMTP id x67mr5388263wmg.122.1543584875400;
        Fri, 30 Nov 2018 05:34:35 -0800 (PST)
Received: from [192.168.86.29] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id m126sm8086243wmb.30.2018.11.30.05.34.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Nov 2018 05:34:34 -0800 (PST)
Subject: Re: [RFC PATCH 4/6] char: fastrpc: Add support for create remote init
 process
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        gregkh <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, bkumar@qti.qualcomm.com,
        thierry.escande@linaro.org
References: <20181130104657.14875-1-srinivas.kandagatla@linaro.org>
 <20181130104657.14875-5-srinivas.kandagatla@linaro.org>
 <CAK8P3a0CzU5mGE9YBfe5FVPGCBhjFRsZbgbyy8Yvopu4wQ7uxA@mail.gmail.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <ccfd45be-d51a-f6f5-1c36-fcd1a37359d9@linaro.org>
Date:   Fri, 30 Nov 2018 13:34:33 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <CAK8P3a0CzU5mGE9YBfe5FVPGCBhjFRsZbgbyy8Yvopu4wQ7uxA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Arnd for the review comments,

On 30/11/18 13:26, Arnd Bergmann wrote:
> On Fri, Nov 30, 2018 at 11:48 AM Srinivas Kandagatla
> <srinivas.kandagatla@linaro.org> wrote:
> 
>> +
>> +static int fastrpc_init_process(struct fastrpc_user *fl,
>> +                               struct fastrpc_ioctl_init *init)
>> +{
>> +       struct fastrpc_ioctl_invoke *ioctl;
>> +       struct fastrpc_phy_page pages[1];
>> +       struct fastrpc_map *file = NULL, *mem = NULL;
>> +       struct fastrpc_buf *imem = NULL;
>> +       int err = 0;
>> +
>> +       ioctl = kzalloc(sizeof(*ioctl), GFP_KERNEL);
>> +       if (!ioctl)
>> +               return -ENOMEM;
>> +
>> +       if (init->flags == FASTRPC_INIT_ATTACH) {
>> +               remote_arg_t ra[1];
>> +               int tgid = fl->tgid;
>> +
>> +               ra[0].buf.pv = (void *)&tgid;
>> +               ra[0].buf.len = sizeof(tgid);
>> +               ioctl->handle = 1;
>> +               ioctl->sc = FASTRPC_SCALARS(FASTRPC_RMID_INIT_ATTACH, 1, 0);
>> +               ioctl->pra = ra;
>> +               fl->pd = 0;
>> +
>> +               err = fastrpc_internal_invoke(fl, 1, ioctl);
>> +               if (err)
>> +                       goto bail;
> 
> It doesn't seem right to me to dynamically allocate an 'ioctl' data structure
> from kernel context and pass that down to another function. Maybe eliminate
> that structure and change fastrpc_internal_invoke to take the individual
> arguments here instead of a pointer?
Yes, I totally agree with you, Will rework this part as suggested.
> 
>> +       } else if (init->flags == FASTRPC_INIT_CREATE) {
> 
> How about splitting each flags== case into a separate function?

Once I move this to a command code then make this a separate function.
> 
>> diff --git a/include/uapi/linux/fastrpc.h b/include/uapi/linux/fastrpc.h
>> index 8fec66601337..6b596fc7ddf3 100644
>> --- a/include/uapi/linux/fastrpc.h
>> +++ b/include/uapi/linux/fastrpc.h
>> @@ -6,6 +6,12 @@
>>   #include <linux/types.h>
>>
>>   #define FASTRPC_IOCTL_INVOKE   _IOWR('R', 3, struct fastrpc_ioctl_invoke)
>> +#define FASTRPC_IOCTL_INIT     _IOWR('R', 4, struct fastrpc_ioctl_init)
>> +
>> +/* INIT a new process or attach to guestos */
>> +#define FASTRPC_INIT_ATTACH      0
>> +#define FASTRPC_INIT_CREATE      1
>> +#define FASTRPC_INIT_CREATE_STATIC  2
> 
> Maybe use three command codes here, and remove the 'flags' member?
> 
Make sense, will do it in next version.

>> @@ -53,4 +59,16 @@ struct fastrpc_ioctl_invoke {
>>          unsigned int *crc;
>>   };
>>
>> +struct fastrpc_ioctl_init {
>> +       uint32_t flags;         /* one of FASTRPC_INIT_* macros */
>> +       uintptr_t file;         /* pointer to elf file */
>> +       uint32_t filelen;       /* elf file length */
>> +       int32_t filefd;         /* ION fd for the file */
> 
> What does this have to do with ION? The driver seems to otherwise
> just use the generic dma_buf interfaces.
Yes, the driver just uses dma_buf, it looks like leftover from downstream!

> 
>> +       uintptr_t mem;          /* mem for the PD */
>> +       uint32_t memlen;        /* mem length */
>> +       int32_t memfd;          /* fd for the mem */
>> +       int attrs;
>> +       unsigned int siglen;
>> +};
> 
> This structure is again not suitable for ioctls. Please used fixed-length
> members and no holes in the structure.
Sure, Will recheck all the structures before sending next version!


--srini
> 
>         Arnd
> 
