Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935357AbeEXDfS (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 23:35:18 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:39385 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935171AbeEXDfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 23:35:17 -0400
X-Google-Smtp-Source: AB8JxZpnzEz1oqQqJBBHk/lCvF9qnfa4vul6rukU13uZ+kp1DVXBG36lEMDTrFsaXa6ZRekIIZOy8lMH8w5eseIjAg4=
MIME-Version: 1.0
In-Reply-To: <20180521171241.GA18441@jordon-HP-15-Notebook-PC>
References: <20180521171241.GA18441@jordon-HP-15-Notebook-PC>
From: Souptick Joarder <jrdr.linux@gmail.com>
Date: Thu, 24 May 2018 09:05:15 +0530
Message-ID: <CAFqt6zajWBwA227SAYdp6X+o43kBuxqGX5Vzy-Ey5vVeEvaz3w@mail.gmail.com>
Subject: Re: [PATCH] gpu: drm: etnaviv: Change return type to vm_fault_t
To: l.stach@pengutronix.de, linux+etnaviv@armlinux.org.uk,
        Christian Gmeiner <christian.gmeiner@gmail.com>, airlied@linux.ie,
        Matthew Wilcox <willy@infradead.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> A non-fatal signal being delivered to a task which is
> in the middle of a page fault may well end up in an
> infinite loop, attempting to handle the page fault and
> failing forever.
>
> On seeing NOPAGE, the fault handler believes the PTE
> is in the page table, so does nothing before it returns
> to arch code. It will end up returning to userspace if
> the signal is non-fatal, at which point it'll go right
> back into the page fault handler, and mutex_lock_interruptible()
> will immediately fail.  So we've converted a sleeping lock
> into the most expensive spinlock.
>
> I don't think the graphics drivers really want to be
> interrupted by any signal.  I think they want to be
> interruptible by fatal signals and should use the
> mutex_lock_killable / fatal_signal_pending family of
> functions. So mutex_lock_interruptible() is replaced
> by mutex_lock_killable()
>

Matthew, are we going to fix similar issues in all drivers
as part of this clean up ?
