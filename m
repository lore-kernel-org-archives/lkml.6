Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753024AbeD2IK7 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 29 Apr 2018 04:10:59 -0400
Received: from mail-pg0-f51.google.com ([74.125.83.51]:33320 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752864AbeD2IK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Apr 2018 04:10:56 -0400
X-Google-Smtp-Source: AB8JxZp/lUa+OU5mfuyPf+Qf90XDKXd82D1c2nkPWzWYW5utm+lI2dOkjxR+PnlwFIt7DGPOE3jVdM70WJ8x+6bkwVg=
MIME-Version: 1.0
In-Reply-To: <20180427223636-mutt-send-email-mst@kernel.org>
References: <000000000000a5b2b1056a86e98c@google.com> <20180427154502.GA22544@la.guarana.org>
 <20180427185501-mutt-send-email-mst@kernel.org> <CACT4Y+b4fEOw=GjTsZMHVyQPOZmuqPWj6AJJshpS-UGRx=bhXA@mail.gmail.com>
 <20180427223636-mutt-send-email-mst@kernel.org>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Sun, 29 Apr 2018 10:10:34 +0200
Message-ID: <CACT4Y+YG+P3NmQsiSwq1WpHiQ6sXaKy650vm1Ah7w+p8ZRtb5Q@mail.gmail.com>
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

On Fri, Apr 27, 2018 at 9:36 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
>> >> The struct vhost_msg within struct vhost_msg_node is copied to userspace,
>> >> so it should be allocated with kzalloc() to ensure all structure padding
>> >> is zeroed.
>> >>
>> >> Signed-off-by: Kevin Easton <kevin@guarana.org>
>> >> Reported-by: syzbot+87cfa083e727a224754b@syzkaller.appspotmail.com
>> >
>> > Does it help if a patch naming the padding is applied,
>> > and then we init just the relevant field?
>> > Just curious.
>>
>> Yes, it would help.
>
> How about a Tested-by tag then?

I didn't test either patch.

>> >> ---
>> >>  drivers/vhost/vhost.c | 2 +-
>> >>  1 file changed, 1 insertion(+), 1 deletion(-)
>> >>
>> >> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>> >> index f3bd8e9..1b84dcff 100644
>> >> --- a/drivers/vhost/vhost.c
>> >> +++ b/drivers/vhost/vhost.c
>> >> @@ -2339,7 +2339,7 @@ EXPORT_SYMBOL_GPL(vhost_disable_notify);
>> >>  /* Create a new message. */
>> >>  struct vhost_msg_node *vhost_new_msg(struct vhost_virtqueue *vq, int type)
>> >>  {
>> >> -     struct vhost_msg_node *node = kmalloc(sizeof *node, GFP_KERNEL);
>> >> +     struct vhost_msg_node *node = kzalloc(sizeof *node, GFP_KERNEL);
>> >>       if (!node)
>> >>               return NULL;
>> >>       node->vq = vq;
>> >> --
>> >> 2.8.1
>> >
>> > --
>> > You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
>> > To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
>> > To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/20180427185501-mutt-send-email-mst%40kernel.org.
>> > For more options, visit https://groups.google.com/d/optout.
