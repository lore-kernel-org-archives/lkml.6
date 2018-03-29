Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752639AbeC2NMN (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 09:12:13 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:40714 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751227AbeC2NML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 09:12:11 -0400
X-Google-Smtp-Source: AIpwx4+gifwFT5OetXs1F8PLo038anLJXnPpfqAuCHJcUP+09Yd9FZZBV4gb5hPeBKXUfHmulw+ZHWQ5smK0smo6i/0=
MIME-Version: 1.0
In-Reply-To: <b15f44f6-d052-17f2-b099-ea2d601c9a6e@redhat.com>
References: <20180329120612.6104-1-agruenba@redhat.com> <b15f44f6-d052-17f2-b099-ea2d601c9a6e@redhat.com>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Thu, 29 Mar 2018 15:12:09 +0200
Message-ID: <CAHc6FU4p7NLEyA88O5tHcQ_58PO0iHrVEDot=XKLWTQp2otagA@mail.gmail.com>
Subject: Re: [Cluster-devel] [PATCH v2 0/2] gfs2: Stop using rhashtable_walk_peek
To: Steven Whitehouse <swhiteho@redhat.com>
Cc: cluster-devel <cluster-devel@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>, netdev@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, NeilBrown <neilb@suse.com>,
        Thomas Graf <tgraf@suug.ch>, Tom Herbert <tom@quantonium.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29 March 2018 at 14:24, Steven Whitehouse <swhiteho@redhat.com> wrote:
> Hi,
>
> Can we solve the problem another way, by not taking refs on the glocks when
> we are iterating over them for the debugfs files? I assume that is the main
> issue here.
>
> We didn't used to take refs since the rcu locking was enough during the walk
> itself. We used to only keep track of the hash bucket and offset within the
> bucket when we dropped the rcu lock between calls to the iterator. I may
> have lost track of why that approach did not work?

That doesn't work because when a glock doesn't fit into one read, we
need to make sure that the next read will continue with the same glock
or else we'll end up with a corrupted dump. And rhashtable_walk_peek
cannot guarantee that.

I've done some minimal performance testing and the additional ref
taking only impacted the performance in the 10% range or less, so it
doesn't really matter.

Andreas
