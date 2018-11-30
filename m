Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3E86C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 16:40:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E09620868
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 16:40:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DK1vAmJf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E09620868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727176AbeLADt6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 22:49:58 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54462 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726878AbeLADt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 22:49:58 -0500
Received: by mail-wm1-f65.google.com with SMTP id z18so6463272wmc.4
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 08:40:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RiD43XBdbofYAMKPSfiaK3i8AWh7DfIwvsMH/+vYZqs=;
        b=DK1vAmJfENgOL7dylX/XHCQ4a2rmBsT/n42lvSLWm+95dpJSftirMBm60FWobW8v0L
         VBj3GsUhwPTvGfWvW9P8bHR7N8rE0VQqwg2xcZSSJLJUYqWFsaO9djlvE3TfdxWWla1H
         mx4NwsahT/FO++zVwUiiMTYsYJRQk/wE2jR8s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RiD43XBdbofYAMKPSfiaK3i8AWh7DfIwvsMH/+vYZqs=;
        b=eS0WUZTypIcmTh+flnalvCZLjEQDmtRnzEFrPJKaBZzqUeuCf9sdf5h/Wiy7kZRY4i
         GWEEIaNU5n3VllzH1ctuwmWqDWEDMx9/JLxUGt0FOgj6QXuyGuvAOgoYBC36Wg1l6T/2
         TExK5kQwqLvH8NzyTON3WbnIFzs/093EflupjxquB2EAzl7E3EBkDD9aejGMJ44HSo1Z
         noP7u4tMBwqHz8K6mOteCkLk5X1hY4gpdwQILO5EXCHsqzqi97eEpz8Nsrc1oEVorAc0
         3PrdnB+vEbVIVDvkPUg5nEBRZsNJlY6gKDUquvFyf6H8pjMKJ550vMno1iY8jh8xkdCe
         9hxQ==
X-Gm-Message-State: AA+aEWaOgxa8miFesvqhSa25VsooSNLx0+uu0okEXjpaYk59OeJS1qf2
        fB76op2gnTbmqdKJ4F2BkzRTTw==
X-Google-Smtp-Source: AFSGD/UR0OOxTI5SVedH1B3/VojRsb5/HXUrRG/x8JJFC1HKXdJQqYLK+HpGxPSayh/KuM4GZn5MxA==
X-Received: by 2002:a1c:a3c3:: with SMTP id m186mr6206171wme.16.1543596003063;
        Fri, 30 Nov 2018 08:40:03 -0800 (PST)
Received: from [192.168.86.29] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id m126sm8776662wmb.30.2018.11.30.08.40.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Nov 2018 08:40:02 -0800 (PST)
Subject: Re: [RFC PATCH 3/6] char: fastrpc: Add support for context Invoke
 method
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
 <20181130104657.14875-4-srinivas.kandagatla@linaro.org>
 <CAK8P3a1mFWJyXCn74_Yd_y3Df0JN=qM4nw4-2t_LjRO7yXmXBw@mail.gmail.com>
 <3c177508-cf6f-1f8d-a324-5bec40fd9a9c@linaro.org>
 <CAK8P3a0d=VRP+9vZm+eJeJM933PWYL4sruMAYBYzWjg5B_kL2g@mail.gmail.com>
 <633cb111-f5d7-3648-54af-a476f3cbb279@linaro.org>
 <CAK8P3a1JSyxjuH2Xez-K3SFV20f-FJnzZHdNR1o41VrNNZkUPQ@mail.gmail.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <35bfe1db-ae9c-4858-c1a3-12a0306bfa3a@linaro.org>
Date:   Fri, 30 Nov 2018 16:40:01 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <CAK8P3a1JSyxjuH2Xez-K3SFV20f-FJnzZHdNR1o41VrNNZkUPQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30/11/18 16:19, Arnd Bergmann wrote:
> On Fri, Nov 30, 2018 at 5:03 PM Srinivas Kandagatla
> <srinivas.kandagatla@linaro.org> wrote:
>> On 30/11/18 15:08, Arnd Bergmann wrote:
>>> On Fri, Nov 30, 2018 at 4:01 PM Srinivas Kandagatla
>>> <srinivas.kandagatla@linaro.org> wrote:
>>>> Thanks Arnd for the review comments!
>>>> On 30/11/18 13:41, Arnd Bergmann wrote:
>>>>> On Fri, Nov 30, 2018 at 11:48 AM Srinivas Kandagatla
>>>>> <srinivas.kandagatla@linaro.org> wrote:
>>>
>>>>>> +static long fastrpc_device_ioctl(struct file *file, unsigned int cmd,
>>>>>> +                                unsigned long arg)
>>>>>> +{
>>>>>> +       struct fastrpc_user *fl = (struct fastrpc_user *)file->private_data;
>>>>>> +       struct fastrpc_channel_ctx *cctx = fl->cctx;
>>>>>> +       char __user *argp = (char __user *)arg;
>>>>>> +       int err;
>>>>>> +
>>>>>> +       if (!fl->sctx) {
>>>>>> +               fl->sctx = fastrpc_session_alloc(cctx, 0);
>>>>>> +               if (!fl->sctx)
>>>>>> +                       return -ENOENT;
>>>>>> +       }
>>>>>
>>>>> Shouldn't that session be allocated during open()?
>>>>>
>>>> Yes, and no, we do not need context in all the cases. In cases like we
>>>> just want to allocate dmabuf.
>>>
>>> Can you give an example what that would be good for?
>>>
>>
>> Currently the instance which does not need session is used as simple
>> memory allocator (rpcmem), TBH, this is the side effect of trying to fit
>> in with downstream application infrastructure which uses ion for andriod
>> usecases.
> 
> That does not sound like enough of a reason then, user space is
> easy to change here to just allocate the memory from the device itself.
> The only reason that I can see for needing a dmabuf would be if
> you have to share a buffer between two instances, and then you
> can use either of them.

I agree, I will try rework this and remove the instances that does not 
require sessions!

Sharing buffer is also a reason for dmabuf here.

> 
>>>>>> +static void fastrpc_notify_users(struct fastrpc_user *user)
>>>>>> +{
>>>>>> +       struct fastrpc_invoke_ctx *ctx, *n;will go
>>>>>> +
>>>>>> +       spin_lock(&user->lock);
>>>>>> +       list_for_each_entry_safe(ctx, n, &user->pending, node)
>>>>>> +               complete(&ctx->work);
>>>>>> +       spin_unlock(&user->lock);
>>>>>> +}
>>>>>
>>>>> Can you explain here what it means to have multiple 'users'
>>>>> a 'fastrpc_user' structure? Why are they all done at the same time?
>>
>> user is allocated on every open(). Having multiple users means that
>> there are more than one compute sessions running on a given dsp.
>>
>> They reason why all the users are notified here is because the dsp is
>> going down, so all the compute sessions associated with it will not see
>> any response from dsp, so any pending/waiting compute contexts are
>> explicitly notified.
> 
> I don't get it yet. What are 'compute sessions'? Do you have
> multiple threads running on a single instance at the same time?

compute sessions are "compute context-banks" instances in DSP.

DSP supports multiple compute banks, Ideally 12 context banks, 4 which 
are reserved for other purposes and 8 of them are used for compute, one 
for each process. So ideally we can run 8 parallel computes.


> I would have expected to only ever see one thread in the
> 'wait_for_completion()' above, and others possibly waiting
> for a chance to get to but not already running.
> 
>>>> struct fastrpc_remote_crc {
>>>>           __u64 crc;
>>>>           __u64 reserved1
>>>>           __u64 reserved2
>>>>           __u64 reserved3
>>>> };
>>>
>>> I don't see a need to add extra served fields for structures
>>> that are already naturally aligned here, e.g. in
>>> fastrpc_remote_arg we need the 'reserved1' but not
>>> the 'reserved2'.
>> Yes, I see, I overdone it!
>> Other idea, is, may be I can try to combine these into single structure
>> something like:
>>
>> struct fastrpc_invoke_arg {
>>          __u64 ptr;
>>          __u64 len;
>>          __u32 fd;
>>          __u32 reserved1
>>          __u64 attr;
>>          __u64 crc;
>> };
>>
>> struct fastrpc_ioctl_invoke {
>>          __u32 handle;
>>          __u32 sc;
>>          /* The minimum size is scalar_length * 32*/
>>          struct fastrpc_invoke_args *args;
>> };
> 
> That is still two structure, not one ;-)
> 
>>>> struct fastrpc_ioctl_invoke {
>>>>           __u32 handle;
>>>>           __u32 sc;
>>>>           /* The minimum size is scalar_length * 32 */
>>>>           struct fastrpc_remote_args *rargs;
>>>>           struct fastrpc_remote_fd *fds;
>>>>           struct fastrpc_remote_attr *attrs;
>>>>           struct fastrpc_remote_crc *crc;
>>>> };
>>>
>>> Do these really have to be indirect then? Are they all
>>> lists of variable length? How do you know how long?
>> Yes, they are variable length and will be scalar length long.
>> Scalar length is derived from sc variable in this structure.
> 
> Do you mean we have a variable number 'sc', but each array
> always has the same length as the other ones? In that
> case: yes, combining them seems sensible.
Yes thats what I meant!

> 
> The other question this raises is: what is 'handle'?
> Why is the file descriptor not enough to identify the
> instance we want to talk to?
This is remote handle to opened interface on which this method has to be 
invoked.
For example we are running a calculator application, calculator will 
have a unique handle on which calculate() method needs to be invoked.


thanks,
srini
> 
>        Arnd
> 
