Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755070AbeE3DmM (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 23:42:12 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:36525 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750885AbeE3DmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 23:42:10 -0400
X-Google-Smtp-Source: ADUXVKJ80kIvLNTyC0YLSYc+PYnkWcdu28DFV6mIp76rs2IEVL64BTZO/AW5gLu8QsjcKk5AfhfELQ==
Subject: Re: [net] vhost: Use kzalloc() to allocate vhost_msg_node
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Kevin Easton <kevin@guarana.org>, Jason Wang <jasowang@redhat.com>,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
References: <20180427154502.GA22544@la.guarana.org>
 <20180529221908.GA22742@roeck-us.net>
 <20180530055704-mutt-send-email-mst@kernel.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <436712fe-c927-5f42-9cd0-f4234c55a9f7@roeck-us.net>
Date: Tue, 29 May 2018 20:42:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180530055704-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/29/2018 08:01 PM, Michael S. Tsirkin wrote:
> On Tue, May 29, 2018 at 03:19:08PM -0700, Guenter Roeck wrote:
>> On Fri, Apr 27, 2018 at 11:45:02AM -0400, Kevin Easton wrote:
>>> The struct vhost_msg within struct vhost_msg_node is copied to userspace,
>>> so it should be allocated with kzalloc() to ensure all structure padding
>>> is zeroed.
>>>
>>> Signed-off-by: Kevin Easton <kevin@guarana.org>
>>> Reported-by: syzbot+87cfa083e727a224754b@syzkaller.appspotmail.com
>>
>> Is this patch going anywhere ?
>>
>> The patch fixes CVE-2018-1118. It would be useful to understand if and when
>> this problem is going to be fixed.
>>
>> Thanks,
>> Guenter
>>> ---
>>>   drivers/vhost/vhost.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>>> index f3bd8e9..1b84dcff 100644
>>> --- a/drivers/vhost/vhost.c
>>> +++ b/drivers/vhost/vhost.c
>>> @@ -2339,7 +2339,7 @@ EXPORT_SYMBOL_GPL(vhost_disable_notify);
>>>   /* Create a new message. */
>>>   struct vhost_msg_node *vhost_new_msg(struct vhost_virtqueue *vq, int type)
>>>   {
>>> -	struct vhost_msg_node *node = kmalloc(sizeof *node, GFP_KERNEL);
>>> +	struct vhost_msg_node *node = kzalloc(sizeof *node, GFP_KERNEL);
>>>   	if (!node)
>>>   		return NULL;
>>>   	node->vq = vq;
> 
> As I pointed out, we don't need to init the whole structure. The proper
> fix is thus (I think) below.
> 
> Could you use your testing infrastructure to confirm this fixes the issue?
> 

Sorry, I don't have the means to test the fix.

Guenter

> Thanks!
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index f3bd8e941224..58d9aec90afb 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -2342,6 +2342,9 @@ struct vhost_msg_node *vhost_new_msg(struct vhost_virtqueue *vq, int type)
>   	struct vhost_msg_node *node = kmalloc(sizeof *node, GFP_KERNEL);
>   	if (!node)
>   		return NULL;
> +
> +	/* Make sure all padding within the structure is initialized. */
> +	memset(&node->msg, 0, sizeof node->msg);
>   	node->vq = vq;
>   	node->msg.type = type;
>   	return node;
> 
