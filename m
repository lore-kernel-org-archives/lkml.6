Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752982AbeFDMfQ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 08:35:16 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:45886 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752399AbeFDMfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 08:35:13 -0400
X-Google-Smtp-Source: ADUXVKKnMjzhM4CE2u0SlOlxj1xHKYwI/07F6be4DpCyZ82ZZSomL/WzAPOW2MQzljJqIIkGb+p/5t518r8dOaMUv5s=
MIME-Version: 1.0
In-Reply-To: <20180530055704-mutt-send-email-mst@kernel.org>
References: <20180427154502.GA22544@la.guarana.org> <20180529221908.GA22742@roeck-us.net>
 <20180530055704-mutt-send-email-mst@kernel.org>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Mon, 4 Jun 2018 14:34:52 +0200
Message-ID: <CACT4Y+aG9_MSdiRTeHzAn2EVaJffCefekRksv+JHY=YsELGHFA@mail.gmail.com>
Subject: Re: [net] vhost: Use kzalloc() to allocate vhost_msg_node
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Guenter Roeck <linux@roeck-us.net>, Kevin Easton <kevin@guarana.org>,
        Jason Wang <jasowang@redhat.com>, KVM list <kvm@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        netdev <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 30, 2018 at 5:01 AM, Michael S. Tsirkin <mst@redhat.com> wrote:
> On Tue, May 29, 2018 at 03:19:08PM -0700, Guenter Roeck wrote:
>> On Fri, Apr 27, 2018 at 11:45:02AM -0400, Kevin Easton wrote:
>> > The struct vhost_msg within struct vhost_msg_node is copied to userspace,
>> > so it should be allocated with kzalloc() to ensure all structure padding
>> > is zeroed.
>> >
>> > Signed-off-by: Kevin Easton <kevin@guarana.org>
>> > Reported-by: syzbot+87cfa083e727a224754b@syzkaller.appspotmail.com
>>
>> Is this patch going anywhere ?
>>
>> The patch fixes CVE-2018-1118. It would be useful to understand if and when
>> this problem is going to be fixed.
>>
>> Thanks,
>> Guenter
>> > ---
>> >  drivers/vhost/vhost.c | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>> > index f3bd8e9..1b84dcff 100644
>> > --- a/drivers/vhost/vhost.c
>> > +++ b/drivers/vhost/vhost.c
>> > @@ -2339,7 +2339,7 @@ EXPORT_SYMBOL_GPL(vhost_disable_notify);
>> >  /* Create a new message. */
>> >  struct vhost_msg_node *vhost_new_msg(struct vhost_virtqueue *vq, int type)
>> >  {
>> > -   struct vhost_msg_node *node = kmalloc(sizeof *node, GFP_KERNEL);
>> > +   struct vhost_msg_node *node = kzalloc(sizeof *node, GFP_KERNEL);
>> >     if (!node)
>> >             return NULL;
>> >     node->vq = vq;
>
> As I pointed out, we don't need to init the whole structure. The proper
> fix is thus (I think) below.
>
> Could you use your testing infrastructure to confirm this fixes the issue?

Hi Michael,

syzbot is self-service, see:

https://github.com/google/syzkaller/blob/master/docs/syzbot.md#testing-patches


> Thanks!
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index f3bd8e941224..58d9aec90afb 100644
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
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/20180530055704-mutt-send-email-mst%40kernel.org.
> For more options, visit https://groups.google.com/d/optout.
