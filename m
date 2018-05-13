Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752030AbeEMUeQ (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 16:34:16 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:46412 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751926AbeEMUeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 16:34:14 -0400
X-Google-Smtp-Source: AB8JxZqDVwuP0sJn+CvTzGBD8zCBbX6B37aC9w2mi7N6cZ813MyhIkT1HWQGQDuC4G42rxoQ5ngCcg==
Date: Sun, 13 May 2018 14:34:13 -0600
From: Jason Gunthorpe <jgg@ziepe.ca>
To: DaeRyong Jeong <threeearcat@gmail.com>
Cc: dledford@redhat.com, leon@kernel.org, parav@mellanox.com,
        danielj@mellanox.com, swise@opengridcomputing.com, monis@mellanox.com,
        inux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        byoungyoung@purdue.edu, kt0755@gmail.com, bammanag@purdue.edu
Subject: Re: KASAN: use-after-free Read in cma_cancel_operation
Message-ID: <20180513203413.GB16286@ziepe.ca>
References: <20180511052519.GA14824@dragonet.kaist.ac.kr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180511052519.GA14824@dragonet.kaist.ac.kr>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 11, 2018 at 02:25:22PM +0900, DaeRyong Jeong wrote:
> We report the crash: KASAN: use-after-free Read in cma_cancel_operation
> 
> Note that this bug is previously reported by syzkaller.
> https://syzkaller.appspot.com/bug?id=95f89b8fb9fdc42e28ad586e657fea074e4e719b
> Nonetheless, this bug has not fixed yet, and we hope that this report and our
> analysis, which gets help by the RaceFuzzer's feature, will helpful to fix the
> crash.
> 
> This crash has been found in v4.17-rc1 using RaceFuzzer (a modified
> version of Syzkaller), which we describe more at the end of this
> report. Our analysis shows that the race occurs when invoking two
> syscalls concurrently, write$rdma_cm and write$rdma_cm.

Well, calling rdma_destroy_id() twice/concurrently is invalid.. The
confusing part of this is how does it happen from ucma.c ..

Double calls via write look OK to me, the ID is removed from the IDR
at the top so it cannot be invoked twice.. So not sure what
"write$rdma_cm and write$rdma_cm." is supposed to me?

Is your test showing that write() vs close() is the problem? The oops
suggests that.. And the logic around ctx->closing looks tortured
enough that it is probably wrong...

Jason
