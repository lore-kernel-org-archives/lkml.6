Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753019AbeDLU7g (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 16:59:36 -0400
Received: from mail-ua0-f195.google.com ([209.85.217.195]:38602 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752676AbeDLU7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 16:59:33 -0400
X-Google-Smtp-Source: AIpwx49Opknun9dbzCtNOzyE2alyeCRFwKTKadA9ErL9p/sk3TlJx0QHA03R3+YbUzcz14LlB4nKhIdvAWlpzeFNoRA=
MIME-Version: 1.0
In-Reply-To: <20180313132639.17387-8-willy@infradead.org>
References: <20180313132639.17387-1-willy@infradead.org> <20180313132639.17387-8-willy@infradead.org>
From: Ross Zwisler <zwisler@gmail.com>
Date: Thu, 12 Apr 2018 14:59:32 -0600
Message-ID: <CAOxpaSXDX1fyrOnnsehEoRgQz2_K1OmOn9TikZzJcXmwMLEfnA@mail.gmail.com>
Subject: Re: [PATCH v9 07/61] xarray: Add the xa_lock to the radix_tree_root
To: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        LKML <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Ryusuke Konishi <konishi.ryusuke@lab.ntt.co.jp>,
        linux-nilfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3CKxggK015947

On Tue, Mar 13, 2018 at 7:25 AM, Matthew Wilcox <willy@infradead.org> wrote:
> From: Matthew Wilcox <mawilcox@microsoft.com>
>
> This results in no change in structure size on 64-bit machines as it
> fits in the padding between the gfp_t and the void *.  32-bit machines
> will grow the structure from 8 to 12 bytes.  Almost all radix trees
> are protected with (at least) a spinlock, so as they are converted from
> radix trees to xarrays, the data structures will shrink again.
>
> Initialising the spinlock requires a name for the benefit of lockdep,
> so RADIX_TREE_INIT() now needs to know the name of the radix tree it's
> initialising, and so do IDR_INIT() and IDA_INIT().
>
> Also add the xa_lock() and xa_unlock() family of wrappers to make it
> easier to use the lock.  If we could rely on -fplan9-extensions in
> the compiler, we could avoid all of this syntactic sugar, but that
> wasn't added until gcc 4.6.
>
> Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
> Reviewed-by: Jeff Layton <jlayton@kernel.org>

This is causing build breakage in the radix tree test suite in the
current linux/master:

5d1365940a68 (linux/master) Merge
git://git.kernel.org/pub/scm/linux/kernel/git/davem/net

Here's the first breakage:

cc -I. -I../../include -g -O2 -Wall -D_LGPL_SOURCE -fsanitize=address
 -c -o idr.o idr.c
In file included from ./linux/radix-tree.h:6:0,
                 from ./linux/../../../../include/linux/idr.h:15,
                 from ./linux/idr.h:1,
                 from idr.c:4:
./linux/../../../../include/linux/idr.h: In function ‘idr_init_base’:
./linux/../../../../include/linux/radix-tree.h:129:2: warning:
implicit declaration of function ‘spin_lock_init’; did you mean
‘spinlock_t’? [-Wimplicit-function-declaration]
  spin_lock_init(&(root)->xa_lock);    \
  ^
./linux/../../../../include/linux/idr.h:126:2: note: in expansion of
macro ‘INIT_RADIX_TREE’
  INIT_RADIX_TREE(&idr->idr_rt, IDR_RT_MARKER);
  ^~~~~~~~~~~~~~~
