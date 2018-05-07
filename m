Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752242AbeEGNM4 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 09:12:56 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:42409 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751943AbeEGNMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 09:12:53 -0400
X-Google-Smtp-Source: AB8JxZpawmwBzlg93AqnZZeupLiknzLLHAxE8eVymC9f9MSAqg21CEPSSesSuGMDiIlQdgYV6a++yqF/u5Ocrt7MvTg=
MIME-Version: 1.0
In-Reply-To: <20180507155534-mutt-send-email-mst@kernel.org>
References: <000000000000a5b2b1056a86e98c@google.com> <20180427154502.GA22544@la.guarana.org>
 <20180507155534-mutt-send-email-mst@kernel.org>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Mon, 7 May 2018 15:12:31 +0200
Message-ID: <CACT4Y+afbOXELeXDMcJ0958rDZOMBCsFRrZTLrc6MErwH=nP9A@mail.gmail.com>
Subject: Re: [PATCH net] vhost: Use kzalloc() to allocate vhost_msg_node
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Kevin Easton <kevin@guarana.org>, Jason Wang <jasowang@redhat.com>,
        KVM list <kvm@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        netdev <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 7, 2018 at 3:03 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> On Fri, Apr 27, 2018 at 11:45:02AM -0400, Kevin Easton wrote:
>> The struct vhost_msg within struct vhost_msg_node is copied to userspace,
>> so it should be allocated with kzalloc() to ensure all structure padding
>> is zeroed.
>>
>> Signed-off-by: Kevin Easton <kevin@guarana.org>
>> Reported-by: syzbot+87cfa083e727a224754b@syzkaller.appspotmail.com
>> ---
>>  drivers/vhost/vhost.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>> index f3bd8e9..1b84dcff 100644
>> --- a/drivers/vhost/vhost.c
>> +++ b/drivers/vhost/vhost.c
>> @@ -2339,7 +2339,7 @@ EXPORT_SYMBOL_GPL(vhost_disable_notify);
>>  /* Create a new message. */
>>  struct vhost_msg_node *vhost_new_msg(struct vhost_virtqueue *vq, int type)
>>  {
>> -     struct vhost_msg_node *node = kmalloc(sizeof *node, GFP_KERNEL);
>> +     struct vhost_msg_node *node = kzalloc(sizeof *node, GFP_KERNEL);
>>       if (!node)
>>               return NULL;
>>       node->vq = vq;
>
>
> Let's just init the msg though.
>
> OK it seems this is the best we can do for now,
> we need a new feature bit to fix it for 32 bit
> userspace on 64 bit kernels.
>
> Does the following help?

Hi Michael,

You can ask reporter (syzbot) to test:
https://github.com/google/syzkaller/blob/master/docs/syzbot.md#testing-patches
https://github.com/google/syzkaller/blob/master/docs/syzbot.md#kmsan-bugs


> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index f3bd8e9..58d9aec 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -2342,6 +2342,9 @@ struct vhost_msg_node *vhost_new_msg(struct vhost_virtqueue *vq, int type)
>         struct vhost_msg_node *node = kmalloc(sizeof *node, GFP_KERNEL);
>         if (!node)
>                 return NULL;
> +
> +       /* Make sure all padding within the structure is initialized. */
> +       memset(&node->msg, 0, sizeof node->msg);
>         node->vq = vq;
>         node->msg.type = type;
>         return node;
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/20180507155534-mutt-send-email-mst%40kernel.org.
> For more options, visit https://groups.google.com/d/optout.
