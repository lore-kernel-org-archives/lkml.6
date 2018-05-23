Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753829AbeEWDSy (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 23:18:54 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:33143 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753657AbeEWDSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 23:18:52 -0400
X-Google-Smtp-Source: AB8JxZok6lcBBp+ZxOctYlKoBS/JVnEblM79HAvsG/SOEryTIFxgMOs6HV3rMUXFFiVXAP5J2N+HR3yl5LlZm0RxBsw=
MIME-Version: 1.0
In-Reply-To: <1527043191-23610-1-git-send-email-lipengcheng8@huawei.com>
References: <1527043191-23610-1-git-send-email-lipengcheng8@huawei.com>
From: John Stultz <john.stultz@linaro.org>
Date: Tue, 22 May 2018 20:18:50 -0700
Message-ID: <CALAqxLWGJxaaGih3n9XT81ur7gV3AOPUSQ-_Me7bG7PyKP=dMQ@mail.gmail.com>
Subject: Re: [PATCH] misc: st_core: Fix skb double free corruption
To: Pengcheng Li <lipengcheng8@huawei.com>
Cc: amira@ti.com, pavan_savoy@ti.com, x0153368@ti.com, gigi.joseph@ti.com,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        Guodong Xu <guodong.xu@linaro.org>,
        Dmitry Shmidt <dimitrysh@google.com>,
        lkml <linux-kernel@vger.kernel.org>,
        "Yaobaofeng (Yaobaofeng)" <yaobaofeng@huawei.com>,
        Lijiangxiong <lijiangxiong@hisilicon.com>,
        Kongfei <kongfei@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4N3J1x5024841

On Tue, May 22, 2018 at 7:39 PM, Pengcheng Li <lipengcheng8@huawei.com> wrote:
> St_gdata->list[chnl_id]->recv function pointer to hci_recv_frame interface,
> hci_recv_frame interface releases skb buffer in case of exception.

Thanks for sending out this patch!

However, you could probably use a little more verbose explanation of
why this patch is needed. The above description is very short and
difficult to see exactly what might go wrong and how your patch fixes
the problem.

>From your earlier mail to me:
"The pointer skb may double freed by both st_send_frame() and
hci_recv_frame() functions marked in the following blue boxes when
hci_recv_frame() return –EINVAL

<image>

[  351.362627] BUG: Double free or freeing an invalid pointer
[  351.368130] Unexpected shadow byte: 0xFB
[  351.372088] CPU: 3 PID: 6 Comm: kworker/u16:0 Tainted: G    B
    4.9.59-g5947c38 #1
[  351.380370] Hardware name: HiKey970 (DT)
[  351.384331] Workqueue: events_unbound flush_to_ldisc
[  351.389318] Call trace:
[  351.391804] [<ffff20000808bef8>] dump_backtrace+0x0/0x230
[  351.397241] [<ffff20000808c35c>] show_stack+0x14/0x1c
[  351.402328] [<ffff2000084e01d4>] dump_stack+0xa0/0xc8
[  351.407418] [<ffff200008273f68>] kasan_object_err+0x24/0x80
[  351.413032] [<ffff200008274af4>] kasan_report_double_free+0x84/0xcc
[  351.419339] [<ffff200008273b7c>] kasan_slab_free+0x164/0x1c0
[  351.425030] [<ffff200008270894>] kfree+0x78/0x1d8
[  351.429766] [<ffff200008e6df18>] skb_free_head+0x28/0x44
[  351.435114] [<ffff200008e74100>] skb_release_data+0x138/0x178
[  351.440893] [<ffff200008e75148>] kfree_skb+0x4c/0x84
[  351.445899] [<ffff20000887c6c8>] st_send_frame+0x11c/0x120
[  351.451418] [<ffff20000887d534>] st_int_recv+0x1f0/0x5f0
[  351.456771] [<ffff20000887c49c>] st_tty_receive+0x3c/0x48
[  351.462209] [<ffff2000086e9914>] tty_ldisc_receive_buf+0xb8/0xd0
[  351.468257] [<ffff2000086eac58>] tty_port_default_receive_buf+0x5c/0x90
[  351.474911] [<ffff2000086e9bdc>] flush_to_ldisc+0x144/0x164
[  351.480520] [<ffff2000080ffcec>] process_one_work+0x25c/0x56c
[  351.486303] [<ffff200008100098>] worker_thread+0x9c/0x6d4
[  351.491742] [<ffff200008109a30>] kthread+0x14c/0x168
[  351.496741] [<ffff200008083850>] ret_from_fork+0x10/0x40
[  351.502078] Object at ffff800137909980, in cache kmalloc-2048 size: 2048
[  351.508792] Allocated:
[  351.511163] PID = 6
[  351.513298]  save_stack_trace_tsk+0x0/0x1b4
[  351.517515]  save_stack_trace+0x28/0x34
[  351.521385]  kasan_kmalloc.part.5+0x4c/0x128
[  351.525687]  kasan_kmalloc+0xc4/0xe4
[  351.529295]  kasan_slab_alloc+0x14/0x1c
[  351.533163]  __kmalloc_track_caller+0x12c/0x230
[  351.537723]  __alloc_skb+0x7c/0x250
[  351.541237]  st_int_recv+0x2a0/0x5f0
[  351.544849]  st_tty_receive+0x3c/0x48
[  351.548545]  tty_ldisc_receive_buf+0xb8/0xd0
[  351.552851]  tty_port_default_receive_buf+0x5c/0x90
[  351.557762]  flush_to_ldisc+0x144/0x164
[  351.561629]  process_one_work+0x25c/0x56c
[  351.565669]  worker_thread+0x9c/0x6d4
[  351.569367]  kthread+0x14c/0x168
[  351.572623]  ret_from_fork+0x10/0x40
[  351.576210] Freed:
[  351.578235] PID = 6
[  351.580367]  save_stack_trace_tsk+0x0/0x1b4
[  351.584585]  save_stack_trace+0x28/0x34
[  351.588454]  kasan_slab_free+0xb4/0x1c0
[  351.592318]  kfree+0x78/0x1d8
[  351.595312]  skb_free_head+0x28/0x44
[  351.598917]  skb_release_data+0x138/0x178
[  351.602955]  kfree_skb+0x4c/0x84
[  351.606218]  hci_recv_frame+0xd4/0xec
[  351.609911]  st_receive+0x30/0xa8
[  351.613263]  st_send_frame+0x88/0x120
[  351.616951]  st_int_recv+0x1f0/0x5f0
[  351.620561]  st_tty_receive+0x3c/0x48
[  351.624256]  tty_ldisc_receive_buf+0xb8/0xd0
[  351.628562]  tty_port_default_receive_buf+0x5c/0x90
[  351.633473]  flush_to_ldisc+0x144/0x164
[  351.637340]  process_one_work+0x25c/0x56c
[  351.641380]  worker_thread+0x9c/0x6d4
[  351.645077]  kthread+0x14c/0x168
[  351.648335]  ret_from_fork+0x10/0x40
"
This is useful information, so you should rewrite the commit message
to include these details (not using the image of course, but
describing the problematic code paths), and resend the patch so that
folks can better understand and evaluate the proposed fix.

thanks
-john
