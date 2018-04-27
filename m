Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932874AbeD0QZn (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 12:25:43 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:40650 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758610AbeD0QZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 12:25:41 -0400
X-Google-Smtp-Source: AB8JxZodcemdiQefybSCgnGYt1awyUUanF5h+nFiUt5TvL4DHOomDlz5MO3Qrs0HxBiaTY5ev/QG0oZWhRAuuho5U4I=
MIME-Version: 1.0
In-Reply-To: <20180427191430-mutt-send-email-mst@kernel.org>
References: <000000000000a5b2b1056a86e98c@google.com> <20180427154502.GA22544@la.guarana.org>
 <20180427185501-mutt-send-email-mst@kernel.org> <CACT4Y+b4fEOw=GjTsZMHVyQPOZmuqPWj6AJJshpS-UGRx=bhXA@mail.gmail.com>
 <20180427191430-mutt-send-email-mst@kernel.org>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Fri, 27 Apr 2018 18:25:19 +0200
Message-ID: <CACT4Y+bzWiPvV+pVvys4v8CwUhF7iYVskxn_yeo6ztN5uKA0VA@mail.gmail.com>
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

On Fri, Apr 27, 2018 at 6:15 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
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
> I think it's slightly better that way then. node has a lot of internal
> stuff we don't care to init. Would you mind taking my patch and building
> on top of that then?


But it's asking for more information leaks in future. This looks like
work for compiler.


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
