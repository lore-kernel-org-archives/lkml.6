Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71073C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:55:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 383982087E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:55:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728689AbfA2Mzw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 07:55:52 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:38640 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727580AbfA2Mzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 07:55:52 -0500
Received: by mail-qt1-f193.google.com with SMTP id p17so22054386qtl.5
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 04:55:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JGFrW3OP6YQRsnF2nkrLOYaQuXRHguk99ylgosX9Fw8=;
        b=XGm5VyFCGKG9E30rF2PoBiiEsb/c8ppNC5vhfpbBiDUDKxfC9EMBaqy0gsf8il0zix
         w7IQ3pXkxI+e0DI4oOrlPmgEzS+xbqgpvsiSMrCT3g2ED2qd3VFcNrnvmHMfcgXqPva3
         po65D6NlWXoOvpBYZJ5eWI0lKEYksJs5mE6gbJqGkiswsZp2jp6M9G7Pqu02aqdMWics
         8nyLHIUMWOfK2q9KmpOSKfoFMXYP2sg0JQIQ90l8P5Z6uRBcYJb+GC8cLp5XJyZtmrqb
         1h99AaoeYMZHp99zbaDMalA/3AGQslNjyXrN1e/QMirLfmWC2pH9aKIgiRIQRAbTRkDF
         PTvQ==
X-Gm-Message-State: AJcUukdDPX0yuYnjSpWIXtM+j+VwVcntFzZtmwixCZiaokFHo8nHDguJ
        stDaZAjcIDQOY8kgLaPCKIWC60AK5Z/pB+qiEga3JA==
X-Google-Smtp-Source: ALg8bN583QZFTb6Q4h7nHV7j2gaJhFXUU2y43TCc9RA56uNCv10YuBG8abubaKqkroh36f6QAATfG/64AP1lbkGSfgM=
X-Received: by 2002:aed:3084:: with SMTP id 4mr25215334qtf.30.1548766550773;
 Tue, 29 Jan 2019 04:55:50 -0800 (PST)
MIME-Version: 1.0
References: <20190129105835.4723-1-vdronov@redhat.com>
In-Reply-To: <20190129105835.4723-1-vdronov@redhat.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Tue, 29 Jan 2019 13:55:38 +0100
Message-ID: <CAO-hwJLWRjyqqTnwzKVgZOunEuFWDtUO9Ma9=aoPEnVGhN1TFw@mail.gmail.com>
Subject: Re: [PATCH v3] HID: debug: fix the ring buffer implementation
To:     Vladis Dronov <vdronov@redhat.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "3.8+" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2019 at 11:58 AM Vladis Dronov <vdronov@redhat.com> wrote:
>
> Ring buffer implementation in hid_debug_event() and hid_debug_events_read()
> is strange allowing lost or corrupted data. After commit 717adfdaf147
> ("HID: debug: check length before copy_to_user()") it is possible to enter
> an infinite loop in hid_debug_events_read() by providing 0 as count, this
> locks up a system. Fix this by rewriting the ring buffer implementation
> with kfifo and simplify the code.
>
> This fixes CVE-2019-3819.
>
> v2: fix an execution logic and add a comment
> v3: use __set_current_state() instead of set_current_state()
>
> Link: https://bugzilla.redhat.com/show_bug.cgi?id=1669187
> Cc: stable@vger.kernel.org # v4.18+
> Fixes: cd667ce24796 ("HID: use debugfs for events/reports dumping")
> Fixes: 717adfdaf147 ("HID: debug: check length before copy_to_user()")
> Signed-off-by: Vladis Dronov <vdronov@redhat.com>
> ---

Thanks for the quick v3.

I have now applied this to for-5.0/upstream-fixes with Oleg's rev-by.

Cheers,
Benjamin

>  drivers/hid/hid-debug.c   | 116 ++++++++++++++------------------------
>  include/linux/hid-debug.h |   9 ++-
>  2 files changed, 47 insertions(+), 78 deletions(-)
>
> diff --git a/drivers/hid/hid-debug.c b/drivers/hid/hid-debug.c
> index c530476edba6..08870c909268 100644
> --- a/drivers/hid/hid-debug.c
> +++ b/drivers/hid/hid-debug.c
> @@ -30,6 +30,7 @@
>
>  #include <linux/debugfs.h>
>  #include <linux/seq_file.h>
> +#include <linux/kfifo.h>
>  #include <linux/sched/signal.h>
>  #include <linux/export.h>
>  #include <linux/slab.h>
> @@ -661,17 +662,12 @@ EXPORT_SYMBOL_GPL(hid_dump_device);
>  /* enqueue string to 'events' ring buffer */
>  void hid_debug_event(struct hid_device *hdev, char *buf)
>  {
> -       unsigned i;
>         struct hid_debug_list *list;
>         unsigned long flags;
>
>         spin_lock_irqsave(&hdev->debug_list_lock, flags);
> -       list_for_each_entry(list, &hdev->debug_list, node) {
> -               for (i = 0; buf[i]; i++)
> -                       list->hid_debug_buf[(list->tail + i) % HID_DEBUG_BUFSIZE] =
> -                               buf[i];
> -               list->tail = (list->tail + i) % HID_DEBUG_BUFSIZE;
> -        }
> +       list_for_each_entry(list, &hdev->debug_list, node)
> +               kfifo_in(&list->hid_debug_fifo, buf, strlen(buf));
>         spin_unlock_irqrestore(&hdev->debug_list_lock, flags);
>
>         wake_up_interruptible(&hdev->debug_wait);
> @@ -722,8 +718,7 @@ void hid_dump_input(struct hid_device *hdev, struct hid_usage *usage, __s32 valu
>         hid_debug_event(hdev, buf);
>
>         kfree(buf);
> -        wake_up_interruptible(&hdev->debug_wait);
> -
> +       wake_up_interruptible(&hdev->debug_wait);
>  }
>  EXPORT_SYMBOL_GPL(hid_dump_input);
>
> @@ -1083,8 +1078,8 @@ static int hid_debug_events_open(struct inode *inode, struct file *file)
>                 goto out;
>         }
>
> -       if (!(list->hid_debug_buf = kzalloc(HID_DEBUG_BUFSIZE, GFP_KERNEL))) {
> -               err = -ENOMEM;
> +       err = kfifo_alloc(&list->hid_debug_fifo, HID_DEBUG_FIFOSIZE, GFP_KERNEL);
> +       if (err) {
>                 kfree(list);
>                 goto out;
>         }
> @@ -1104,77 +1099,57 @@ static ssize_t hid_debug_events_read(struct file *file, char __user *buffer,
>                 size_t count, loff_t *ppos)
>  {
>         struct hid_debug_list *list = file->private_data;
> -       int ret = 0, len;
> +       int ret = 0, copied;
>         DECLARE_WAITQUEUE(wait, current);
>
>         mutex_lock(&list->read_mutex);
> -       while (ret == 0) {
> -               if (list->head == list->tail) {
> -                       add_wait_queue(&list->hdev->debug_wait, &wait);
> -                       set_current_state(TASK_INTERRUPTIBLE);
> -
> -                       while (list->head == list->tail) {
> -                               if (file->f_flags & O_NONBLOCK) {
> -                                       ret = -EAGAIN;
> -                                       break;
> -                               }
> -                               if (signal_pending(current)) {
> -                                       ret = -ERESTARTSYS;
> -                                       break;
> -                               }
> -
> -                               if (!list->hdev || !list->hdev->debug) {
> -                                       ret = -EIO;
> -                                       set_current_state(TASK_RUNNING);
> -                                       goto out;
> -                               }
> -
> -                               /* allow O_NONBLOCK from other threads */
> -                               mutex_unlock(&list->read_mutex);
> -                               schedule();
> -                               mutex_lock(&list->read_mutex);
> -                               set_current_state(TASK_INTERRUPTIBLE);
> -                       }
> -
> -                       set_current_state(TASK_RUNNING);
> -                       remove_wait_queue(&list->hdev->debug_wait, &wait);
> -               }
> -
> -               if (ret)
> -                       goto out;
> +       if (kfifo_is_empty(&list->hid_debug_fifo)) {
> +               add_wait_queue(&list->hdev->debug_wait, &wait);
> +               set_current_state(TASK_INTERRUPTIBLE);
> +
> +               while (kfifo_is_empty(&list->hid_debug_fifo)) {
> +                       if (file->f_flags & O_NONBLOCK) {
> +                               ret = -EAGAIN;
> +                               break;
> +                       }
> +
> +                       if (signal_pending(current)) {
> +                               ret = -ERESTARTSYS;
> +                               break;
> +                       }
> +
> +                       /* if list->hdev is NULL we cannot remove_wait_queue().
> +                        * if list->hdev->debug is 0 then hid_debug_unregister()
> +                        * was already called and list->hdev is being destroyed.
> +                        * if we add remove_wait_queue() here we can hit a race.
> +                        */
> +                       if (!list->hdev || !list->hdev->debug) {
> +                               ret = -EIO;
> +                               set_current_state(TASK_RUNNING);
> +                               goto out;
> +                       }
> +
> +                       /* allow O_NONBLOCK from other threads */
> +                       mutex_unlock(&list->read_mutex);
> +                       schedule();
> +                       mutex_lock(&list->read_mutex);
> +                       set_current_state(TASK_INTERRUPTIBLE);
> +               }
> +
> +               __set_current_state(TASK_RUNNING);
> +               remove_wait_queue(&list->hdev->debug_wait, &wait);
> +
> +               if (ret)
> +                       goto out;
> +       }
>
> -               /* pass the ringbuffer contents to userspace */
> -copy_rest:
> -               if (list->tail == list->head)
> -                       goto out;
> -               if (list->tail > list->head) {
> -                       len = list->tail - list->head;
> -                       if (len > count)
> -                               len = count;
> -
> -                       if (copy_to_user(buffer + ret, &list->hid_debug_buf[list->head], len)) {
> -                               ret = -EFAULT;
> -                               goto out;
> -                       }
> -                       ret += len;
> -                       list->head += len;
> -               } else {
> -                       len = HID_DEBUG_BUFSIZE - list->head;
> -                       if (len > count)
> -                               len = count;
> -
> -                       if (copy_to_user(buffer, &list->hid_debug_buf[list->head], len)) {
> -                               ret = -EFAULT;
> -                               goto out;
> -                       }
> -                       list->head = 0;
> -                       ret += len;
> -                       count -= len;
> -                       if (count > 0)
> -                               goto copy_rest;
> -               }
> -
> -       }
> +       /* pass the fifo content to userspace, locking is not needed with only
> +        * one concurrent reader and one concurrent writer
> +        */
> +       ret = kfifo_to_user(&list->hid_debug_fifo, buffer, count, &copied);
> +       if (ret)
> +               goto out;
> +       ret = copied;
>  out:
>         mutex_unlock(&list->read_mutex);
>         return ret;
> @@ -1185,7 +1160,7 @@ static __poll_t hid_debug_events_poll(struct file *file, poll_table *wait)
>         struct hid_debug_list *list = file->private_data;
>
>         poll_wait(file, &list->hdev->debug_wait, wait);
> -       if (list->head != list->tail)
> +       if (!kfifo_is_empty(&list->hid_debug_fifo))
>                 return EPOLLIN | EPOLLRDNORM;
>         if (!list->hdev->debug)
>                 return EPOLLERR | EPOLLHUP;
> @@ -1200,7 +1175,7 @@ static int hid_debug_events_release(struct inode *inode, struct file *file)
>         spin_lock_irqsave(&list->hdev->debug_list_lock, flags);
>         list_del(&list->node);
>         spin_unlock_irqrestore(&list->hdev->debug_list_lock, flags);
> -       kfree(list->hid_debug_buf);
> +       kfifo_free(&list->hid_debug_fifo);
>         kfree(list);
>
>         return 0;
> @@ -1246,4 +1221,3 @@ void hid_debug_exit(void)
>  {
>         debugfs_remove_recursive(hid_debug_root);
>  }
> -
> diff --git a/include/linux/hid-debug.h b/include/linux/hid-debug.h
> index 8663f216c563..e7a7c92aaf09 100644
> --- a/include/linux/hid-debug.h
> +++ b/include/linux/hid-debug.h
> @@ -24,7 +24,10 @@
>
>  #ifdef CONFIG_DEBUG_FS
>
> +#include <linux/kfifo.h>
> +
>  #define HID_DEBUG_BUFSIZE 512
> +#define HID_DEBUG_FIFOSIZE 512
>
>  void hid_dump_input(struct hid_device *, struct hid_usage *, __s32);
>  void hid_dump_report(struct hid_device *, int , u8 *, int);
> @@ -38,10 +41,7 @@ void hid_debug_event(struct hid_device *, char *);
>  void hid_debug_event(struct hid_device *, char *);
>
> -
>  struct hid_debug_list {
> -       char *hid_debug_buf;
> -       int head;
> -       int tail;
> +       DECLARE_KFIFO_PTR(hid_debug_fifo, char);
>         struct fasync_struct *fasync;
>         struct hid_device *hdev;
>         struct list_head node;
> @@ -64,4 +64,3 @@ struct hid_debug_list {
>  #endif
>
>  #endif
> -
