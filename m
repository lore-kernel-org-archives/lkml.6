Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756160AbeEIHEs (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 03:04:48 -0400
Received: from lb2-smtp-cloud9.xs4all.net ([194.109.24.26]:59004 "EHLO
        lb2-smtp-cloud9.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1756016AbeEIHEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 03:04:47 -0400
Subject: Re: [PATCH v9 11/15] vb2: add in-fence support to QBUF
To: Ezequiel Garcia <ezequiel@collabora.com>, linux-media@vger.kernel.org
Cc: kernel@collabora.com, Mauro Carvalho Chehab <mchehab@osg.samsung.com>,
        Shuah Khan <shuahkh@osg.samsung.com>, Pawel Osciak <pawel@osciak.com>,
        Alexandre Courbot <acourbot@chromium.org>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Brian Starkey <brian.starkey@arm.com>, linux-kernel@vger.kernel.org,
        Gustavo Padovan <gustavo.padovan@collabora.com>
References: <20180504200612.8763-1-ezequiel@collabora.com>
 <20180504200612.8763-12-ezequiel@collabora.com>
 <5fd5d7a9-5b74-fe2a-6148-59b90cabb9e8@xs4all.nl>
 <5541e08b048b932789db1c58438c2a2c2b6da7ce.camel@collabora.com>
From: Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <0a4f2701-a699-3c28-559d-2bf638178b94@xs4all.nl>
Date: Wed, 9 May 2018 09:04:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <5541e08b048b932789db1c58438c2a2c2b6da7ce.camel@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfJQIN96mJ3dz2rFveDlaQSQiYM2YqJIERFtNcjXJ8al4NRjpeciBnCUM5ttmpZR8jtZ49+AJSm+xNMFa2qCO5wh/g7jy1F1Wa5fi7PrHE4uSOrChAAuH
 qBDe2V6AYR4WZIuvagQBQvW9Zg1WcNs5TbSq/JyfeLnKbptfMaqNSXCv6hY9vNMsmauukiLgxzr+hGn3on6jJIOBpHIvacXFUGrcTBDXVa3dQPEaCKJPLAAa
 gB8lVr/KhTEBKlQUUZyJwleoGaXvUeidEjOGuciEcFS511gpNcI9gzvjbkrkEiP/MGdfSln6wsrOQd/1svsSJkJt4VEOp7yBOdqLgZ/hTugd6tdRM+Wh7TNu
 y/p7J2dOFkzWYwTmhwO+5DrE7Ogu1e3V6tx0PXAw5q9Ccxlvxi0cTpS0tAsuEiXiAeqw7x9Fg1PdHnkTZLRBNiIugEbYFPbgwGotjdllpUsmn5swG1ePDbmg
 b8CBsJ9Xk+pwcODHKIDPT0hrFxWlxU26RKgHTG+yBuJAJ5jxg1AkgNt3jyE=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/08/2018 09:16 PM, Ezequiel Garcia wrote:
> On Mon, 2018-05-07 at 14:07 +0200, Hans Verkuil wrote:
>> On 04/05/18 22:06, Ezequiel Garcia wrote:
>>> @@ -1421,15 +1505,40 @@ int vb2_core_qbuf(struct vb2_queue *q, unsigned int index, void *pb)
>>>  	trace_vb2_qbuf(q, vb);
>>>  
>>>  	/*
>>> -	 * If already streaming, give the buffer to driver for processing.
>>> -	 * If not, the buffer will be given to driver on next streamon.
>>> +	 * For explicit synchronization: If the fence didn't signal
>>> +	 * yet we setup a callback to queue the buffer once the fence
>>> +	 * signals and then return successfully. But if the fence
>>> +	 * already signaled we lose the reference we held and queue the
>>> +	 * buffer to the driver.
>>
>> What happens if the fence signaled an error? Is that error returned to userspace?
>> (i.e. VIDIOC_QBUF will fail in that case)
>>
> 
> Hm, good question. If the fence signals with an error, we won't catch it apparently.
> We should fix dma_fence_add_callback to know about signaled vs. error signaled.

OK, so in the meantime we need a comment explaining this in the code. Perhaps as
a FIXME or TODO.

Regards,

	Hans
