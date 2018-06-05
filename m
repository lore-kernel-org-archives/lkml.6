Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751890AbeFELgJ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 07:36:09 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:46675 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751755AbeFELgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 07:36:06 -0400
X-Google-Smtp-Source: ADUXVKLLCV0/abHQq9/dsrpmzdD5hCK6JamYMdpGuPes/0wBL8OpuQTsAFM5O9DFJGWiWcSuiuO8ftE9i4rnK4tTeyE=
MIME-Version: 1.0
X-Originating-IP: [194.176.227.33]
In-Reply-To: <20180604084827.GE11333@infradead.org>
References: <20180529144339.16538-1-mszeredi@redhat.com> <20180529144339.16538-7-mszeredi@redhat.com>
 <20180604084827.GE11333@infradead.org>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 5 Jun 2018 13:36:04 +0200
Message-ID: <CAJfpeguhXik+bEb+FWf8s=v93yaoqReAUmr1DkG1zBxEYnEfsg@mail.gmail.com>
Subject: Re: [PATCH 06/39] vfs: add f_op->pre_mmap()
To: Christoph Hellwig <hch@infradead.org>
Cc: Miklos Szeredi <mszeredi@redhat.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 4, 2018 at 10:48 AM, Christoph Hellwig <hch@infradead.org> wrote:
> On Tue, May 29, 2018 at 04:43:06PM +0200, Miklos Szeredi wrote:
>> This is needed by overlayfs to be able to copy up a file from a read-only
>> lower layer to a writable layer when being mapped shared.  When copying up,
>> overlayfs takes VFS locks that would violate locking order when nested
>> inside mmap_sem.
>>
>> Add a new f_op->pre_mmap method, which is called before taking mmap_sem.
>
> NAK.  We really should not add multiple methods for mmap, and everytime
> this came up we found a better way to solve the problem instead.  Most
> recent example was the socket zero copy receive code.

Okay, I'll drop this.

Not sure if it's better, but I have an idea for solving this without pre_mmap():

 - Private maps of lower files continue to use the underlying fs'
mapping.  This keeps the nice page sharing properties of overlays for
shared libraries, executables and most read-only uses.

 - Shared maps of lower file and all maps of upper files go to
overlayfs's own page cache.  In these cases we can't have shared
mappings, so it basically doesn't matter if the cache resides in the
underlying inode or the overlay inode.

The implementation is certainly going to be more complex, since we'll
have to add address space ops to overlayfs. .  The advantage will be
that we won't actually have to do the copy up when a lower file is
mapped with MAP_SHARED.

Thanks,
Miklos
