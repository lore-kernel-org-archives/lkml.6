Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751309AbeFBEGw (ORCPT <rfc822;w@1wt.eu>);
        Sat, 2 Jun 2018 00:06:52 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:41652 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750748AbeFBEGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jun 2018 00:06:51 -0400
X-Google-Smtp-Source: ADUXVKL/hTCabr9xqx4w5b9veRfcvZMRKuqDvpL9UPYYUyNiiabX17ZPlir8PGSgbMi27JTZpSmnSxMkITl6P/y2zNk=
MIME-Version: 1.0
In-Reply-To: <CAB+yDaZAwFny2NdOZfymdpdR3Sf7pdkxahgQ6v2zBzUvSwBWTA@mail.gmail.com>
References: <CAB+yDaZAwFny2NdOZfymdpdR3Sf7pdkxahgQ6v2zBzUvSwBWTA@mail.gmail.com>
From: shankarapailoor <shankarapailoor@gmail.com>
Date: Fri, 1 Jun 2018 21:06:49 -0700
Message-ID: <CAB+yDaZFZhku34wp-t_i32Vy6cYB9fnS0iboPnQZ26sQeAZ+Uw@mail.gmail.com>
Subject: Re: Slab out of bounds in setxattr
To: shaggy@kernel.org
Cc: jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Looking at the crash some more, it seems that if value_len > PAGE_SIZE
then e_buf->max_size is rounded up nearest page size [1]. If a new
attribute is added with value_len < e_buf->max_size - EA_SIZE(ea) then
no new space is allocated for the attiribute list [2] and this
triggers the KASAN slab out of bounds error. This is the case in the C
repro I provided.


1. https://elixir.bootlin.com/linux/v4.17-rc7/source/fs/jfs/xattr.c#L501
2. https://elixir.bootlin.com/linux/v4.17-rc7/source/fs/jfs/xattr.c#L723

On Fri, Jun 1, 2018 at 1:52 PM, shankarapailoor
<shankarapailoor@gmail.com> wrote:
> Hi Dave et al,
>
> I have been fuzzing linux 4.17-rc4 with JFS using Syzkaller  KASAN:
> slab-out-of-bounds in jfs_xattr.
>
> Attached are my kernel configs and a C reproducer. In the first
> setxattr call it appears that length is much larger than the name. In
> __jfs_setxattr, I don't see where the length is checked against the
> actual value length.
>
> Regards,
> Shankara Pailoor



-- 
Regards,
Shankara Pailoor
