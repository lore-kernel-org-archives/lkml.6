Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932255AbeCKQ7B (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Mar 2018 12:59:01 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:42410 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932153AbeCKQ7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Mar 2018 12:59:00 -0400
X-Google-Smtp-Source: AG47ELtUTvGpvoP3eJ8NfYHLT+oEBEGbJ2lwBWsrAEvafefciUqrkmDV5DZdvrqSP0AfORGXCQtcn+vWELxewrv+B1g=
MIME-Version: 1.0
From: =?UTF-8?B?54Sm5pmT5Yas?= <milestonejxd@gmail.com>
Date: Mon, 12 Mar 2018 00:58:59 +0800
Message-ID: <CAJDTihxS9SiYohtgfdXpZc-=Z7vdUP7U9+ShPfK+9C-82SxsBg@mail.gmail.com>
Subject: resend, finish_wait with list_empty_careful maybe fragile or buggy
To: linux-kernel@vger.kernel.org
Cc: mingo@elte.hu
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, this is a resend because the previous one was messed
up by my editor and hard to be read.

void finish_wait(
struct wait_queue_head *wq_head,
struct wait_queue_entry *wq_entry)
{
       ....
->    if (!list_empty_careful(&wq_entry->entry)) {
->        spin_lock_irqsave(&wq_head->lock, flags);
->        list_del_init(&wq_entry->entry);
->        spin_unlock_irqrestore(&wq_head->lock, flags);
->    }
}

After careful look into the stop/wakeup code, I found
the above code fragile or even buggy. This code was
introduced at least 14 years ago and seems fragile or
buggy now after years of study on SMP synchronization
by us.

I understand this code are being used a lot and no bug
seems to emerge. But, as I'll explain, it depends on a lot
of unreliable implementation details.

Firstly,

static inline int list_empty_careful(const struct list_head *head)
{
    struct list_head *next = head->next;
    return (next == head) && (next == head->prev);
}

note that the read of head->next & head->prev is not
protected by READ_ONCE. So the read is free to be
optimized out entirely. Luckily, this optimization is hard
for compilers now, since all other accesses are out of
finish_wait. And still, GCC won't spit aligned accesses
into multiple instructions so it is atomic so far.

Secondly,

if ( ! list_empty_careful(&wq_entry->entry) ) {
     <remove entry with spinning-lock>
}
<ends stack frame of the function calling finish_wait>
<overwrites wq_entry with another frame>

and

__wake_up_common()   -->
<read wq_entry->func>  -->
<read wq_entry->flags>  -->
autoremove_wake_function()  -->
<remove wq_entry->entry from wait queue>  -->

are not properly ordered for SMP so that  <read wq_entry->flags>
may be reordered after <remove wq_entry->entry from wait queue>
since no dependency or memory barrier forbids it. This may cause
<overwrites wq_entry with another frame> on one CPU takes place
before <read wq_entry->flags> on another CPU and cause
<read wq_entry->flags> to return bad value.

This behavior is not reported may thank to:
- quite a few code is using autoremove_wake_function
- CPU pipeline is not as deep as to make this emerge

Best regards,
Patrick Trol
