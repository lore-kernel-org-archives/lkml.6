Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758787AbeD0Q3o (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 12:29:44 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:33637 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758550AbeD0Q3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 12:29:42 -0400
X-Google-Smtp-Source: AB8JxZrqj6qU5nUnAem9VAM5QJ56YNPQJ1V6YbZ355h5oSYmA+wa2EIZ/G5j7I83bsQMaEE2YqXR1RnitEL0QeKzeT8=
MIME-Version: 1.0
In-Reply-To: <CACT4Y+bzWiPvV+pVvys4v8CwUhF7iYVskxn_yeo6ztN5uKA0VA@mail.gmail.com>
References: <000000000000a5b2b1056a86e98c@google.com> <20180427154502.GA22544@la.guarana.org>
 <20180427185501-mutt-send-email-mst@kernel.org> <CACT4Y+b4fEOw=GjTsZMHVyQPOZmuqPWj6AJJshpS-UGRx=bhXA@mail.gmail.com>
 <20180427191430-mutt-send-email-mst@kernel.org> <CACT4Y+bzWiPvV+pVvys4v8CwUhF7iYVskxn_yeo6ztN5uKA0VA@mail.gmail.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Fri, 27 Apr 2018 18:29:20 +0200
Message-ID: <CACT4Y+ZUoAB8ZORGnR+xhcg46XqP+HsfbeuQ+HNcRVE51xdH6A@mail.gmail.com>
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

On Fri, Apr 27, 2018 at 6:25 PM, Dmitry Vyukov <dvyukov@google.com> wrote:
>>> >> The struct vhost_msg within struct vhost_msg_node is copied to userspace,
>>> >> so it should be allocated with kzalloc() to ensure all structure padding
>>> >> is zeroed.
>>> >>
>>> >> Signed-off-by: Kevin Easton <kevin@guarana.org>
>>> >> Reported-by: syzbot+87cfa083e727a224754b@syzkaller.appspotmail.com
>>> >
>>> > Does it help if a patch naming the padding is applied,
>>> > and then we init just the relevant field?
>>> > Just curious.
>>>
>>> Yes, it would help.
>>
>> I think it's slightly better that way then. node has a lot of internal
>> stuff we don't care to init. Would you mind taking my patch and building
>> on top of that then?
>
>
> But it's asking for more information leaks in future. This looks like
> work for compiler.


Modern compilers are perfectly capable of doing this:

#include <memory.h>
#include <unistd.h>
int main()
{
    int x[10];
    memset(&x, 0, sizeof(x));
    x[0] = 0;
    x[2] = 2;
    x[3] = 3;
    x[4] = 4;
    x[5] = 5;
    x[6] = 6;
    x[7] = 7;
    x[8] = 8;
    x[9] = 9;
    write(0, x, sizeof(x));
    return 0;
}

gcc 7.2 -O3

0000000000000540 <main>:
 540:   sub    $0x38,%rsp
 544:   mov    $0x28,%edx
 549:   xor    %edi,%edi
 54b:   movdqa 0x1cd(%rip),%xmm0        # 720 <_IO_stdin_used+0x10>
 553:   mov    %rsp,%rsi
 556:   movq   $0x0,(%rsp)
 55e:   movups %xmm0,0x8(%rsp)
 563:   movdqa 0x1c5(%rip),%xmm0        # 730 <_IO_stdin_used+0x20>
 56b:   movups %xmm0,0x18(%rsp)
 570:   callq  520 <write@plt>
 575:   xor    %eax,%eax
 577:   add    $0x38,%rsp
 57b:   retq
 57c:   nopl   0x0(%rax)


But they will not put a security hole next time fields are shuffled.




>>> >> ---
>>> >>  drivers/vhost/vhost.c | 2 +-
>>> >>  1 file changed, 1 insertion(+), 1 deletion(-)
>>> >>
>>> >> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>>> >> index f3bd8e9..1b84dcff 100644
>>> >> --- a/drivers/vhost/vhost.c
>>> >> +++ b/drivers/vhost/vhost.c
>>> >> @@ -2339,7 +2339,7 @@ EXPORT_SYMBOL_GPL(vhost_disable_notify);
>>> >>  /* Create a new message. */
>>> >>  struct vhost_msg_node *vhost_new_msg(struct vhost_virtqueue *vq, int type)
>>> >>  {
>>> >> -     struct vhost_msg_node *node = kmalloc(sizeof *node, GFP_KERNEL);
>>> >> +     struct vhost_msg_node *node = kzalloc(sizeof *node, GFP_KERNEL);
>>> >>       if (!node)
>>> >>               return NULL;
>>> >>       node->vq = vq;
>>> >> --
>>> >> 2.8.1
