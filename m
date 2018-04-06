Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751813AbeDFStt (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 14:49:49 -0400
Received: from mail-yb0-f175.google.com ([209.85.213.175]:39720 "EHLO
        mail-yb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751642AbeDFSts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 14:49:48 -0400
X-Google-Smtp-Source: AIpwx4+ms7B0MPcCuWBq8j6g5NrZfxYbvBjn/r/TroIzzoTArbQchGQvfI29yA4V2hQ37S/W+Ghus2KfDb/HWznCDew=
MIME-Version: 1.0
References: <2cb713cd-0b9b-594c-31db-b4582f8ba822@meituan.com>
 <20180406080324.160306-1-gthelen@google.com> <20180406080714.GG8286@dhcp22.suse.cz>
In-Reply-To: <20180406080714.GG8286@dhcp22.suse.cz>
From: Greg Thelen <gthelen@google.com>
Date: Fri, 06 Apr 2018 18:49:35 +0000
Message-ID: <CAHH2K0YyAK2jBaLv0r7B5wfyyq0OZFpRyqcW92_H_hpLrU_A-A@mail.gmail.com>
Subject: Re: [PATCH] writeback: safer lock nesting
To: Michal Hocko <mhocko@kernel.org>
Cc: Wang Long <wanglong19@meituan.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>,
        npiggin@gmail.com, LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 6, 2018 at 1:07 AM Michal Hocko <mhocko@kernel.org> wrote:

> On Fri 06-04-18 01:03:24, Greg Thelen wrote:
> [...]
> > diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> > index d4d04fee568a..d51bae5a53e2 100644
> > --- a/fs/fs-writeback.c
> > +++ b/fs/fs-writeback.c
> > @@ -746,10 +746,11 @@ int inode_congested(struct inode *inode, int
cong_bits)
> >       if (inode && inode_to_wb_is_valid(inode)) {
> >               struct bdi_writeback *wb;
> >               bool locked, congested;
> > +             unsigned long flags;
> >
> > -             wb = unlocked_inode_to_wb_begin(inode, &locked);
> > +             wb = unlocked_inode_to_wb_begin(inode, &locked, &flags);

> Wouldn't it be better to have a cookie (struct) rather than 2 parameters
> and let unlocked_inode_to_wb_end DTRT?

Nod.  I'll post a V2 patch with that change.

> >               congested = wb_congested(wb, cong_bits);
> > -             unlocked_inode_to_wb_end(inode, locked);
> > +             unlocked_inode_to_wb_end(inode, locked, flags);
> >               return congested;
> >       }
> --
> Michal Hocko
> SUSE Labs
