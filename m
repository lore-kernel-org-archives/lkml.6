Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S939623AbeE1PBd (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 11:01:33 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:39056 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932423AbeE1PB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 11:01:28 -0400
X-Google-Smtp-Source: ADUXVKKk/QHrXseOiPYwKgtK6EZyjxCwIE6w6tIUGZMRvPpC+zBLTC/3kisUrq1W6MuXM9jWTcRS4GGQ+YICetd+uVU=
MIME-Version: 1.0
In-Reply-To: <01fca256074b74598608c261a2f956af7308e1db.camel@pengutronix.de>
References: <20180521171241.GA18441@jordon-HP-15-Notebook-PC> <01fca256074b74598608c261a2f956af7308e1db.camel@pengutronix.de>
From: Souptick Joarder <jrdr.linux@gmail.com>
Date: Mon, 28 May 2018 20:31:25 +0530
Message-ID: <CAFqt6zYBbwJMT=DKjsaEg1KKTyBTT4MegvPNLzzSEXu31-Ov6Q@mail.gmail.com>
Subject: Re: [PATCH] gpu: drm: etnaviv: Change return type to vm_fault_t
To: Lucas Stach <l.stach@pengutronix.de>
Cc: linux+etnaviv@armlinux.org.uk,
        Christian Gmeiner <christian.gmeiner@gmail.com>, airlied@linux.ie,
        Matthew Wilcox <willy@infradead.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>, etnaviv@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 28, 2018 at 6:20 PM, Lucas Stach <l.stach@pengutronix.de> wrote:
> Hi Souptick,
>
> Am Montag, den 21.05.2018, 22:42 +0530 schrieb Souptick Joarder:
>> Use new return type vm_fault_t for fault handler. For
>> now, this is just documenting that the function returns
>> a VM_FAULT value rather than an errno. Once all instances
>> are converted, vm_fault_t will become a distinct type.
>>
>> Ref- commit 1c8f422059ae ("mm: change return type to vm_fault_t")
>>
>> Previously vm_insert_page() returns err which driver
>> mapped into VM_FAULT_* type. The new function
>> vmf_insert_page() will replace this inefficiency by
>> returning VM_FAULT_* type.
>>
>> A non-fatal signal being delivered to a task which is
>> in the middle of a page fault may well end up in an
>> infinite loop, attempting to handle the page fault and
>> failing forever.
>>
>> On seeing NOPAGE, the fault handler believes the PTE
>> is in the page table, so does nothing before it returns
>> to arch code. It will end up returning to userspace if
>> the signal is non-fatal, at which point it'll go right
>> back into the page fault handler, and mutex_lock_interruptible()
>> will immediately fail.  So we've converted a sleeping lock
>> into the most expensive spinlock.
>>
>> I don't think the graphics drivers really want to be
>> interrupted by any signal.  I think they want to be
>> interruptible by fatal signals and should use the
>> mutex_lock_killable / fatal_signal_pending family of
>> functions. So mutex_lock_interruptible() is replaced
>> by mutex_lock_killable()
>
> I don't think the other thread discussing this issue has reached a
> proper conclusion and I would rather not pull in a patch based on thin
> reasoning. If we want to change this behavior I would really like to
> see the issue it is solving and it should be a separate patch, not
> intermixed with some return value change.
>
> Regards,
> Lucas
>

Ok, I will separate the vm_fault_t type return value patch
and send v2 for it. We would like to get this patch in queue
for 4.18.

The patch consists, mutex_lock_interruptible/killable() can be keep
on hold until we reached to a proper conclusion.
