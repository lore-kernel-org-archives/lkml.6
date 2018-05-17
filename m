Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752130AbeEQNQb (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 09:16:31 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:34685 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751976AbeEQNQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 09:16:29 -0400
X-Google-Smtp-Source: AB8JxZp4L+SbUHnQ+TlmHGaAYh8kl8PeaQA/X30ZJegpZFfiyW3QKDTPaqop+9SzS06E77eToAZmFw==
Date: Thu, 17 May 2018 22:16:22 +0900
From: DaeRyong Jeong <threeearcat@gmail.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: dledford@redhat.com, leon@kernel.org, parav@mellanox.com,
        danielj@mellanox.com, swise@opengridcomputing.com, monis@mellanox.com,
        inux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        byoungyoung@purdue.edu, kt0755@gmail.com, bammanag@purdue.edu
Subject: Re: KASAN: use-after-free Read in cma_cancel_operation
Message-ID: <20180517131620.GA12745@dragonet.kaist.ac.kr>
References: <20180511052519.GA14824@dragonet.kaist.ac.kr>
 <20180513203413.GB16286@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180513203413.GB16286@ziepe.ca>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 13, 2018 at 02:34:13PM -0600, Jason Gunthorpe wrote:
> On Fri, May 11, 2018 at 02:25:22PM +0900, DaeRyong Jeong wrote:
> > We report the crash: KASAN: use-after-free Read in cma_cancel_operation
> > 
> > Note that this bug is previously reported by syzkaller.
> > https://syzkaller.appspot.com/bug?id=95f89b8fb9fdc42e28ad586e657fea074e4e719b
> > Nonetheless, this bug has not fixed yet, and we hope that this report and our
> > analysis, which gets help by the RaceFuzzer's feature, will helpful to fix the
> > crash.
> > 
> > This crash has been found in v4.17-rc1 using RaceFuzzer (a modified
> > version of Syzkaller), which we describe more at the end of this
> > report. Our analysis shows that the race occurs when invoking two
> > syscalls concurrently, write$rdma_cm and write$rdma_cm.
> 
> Well, calling rdma_destroy_id() twice/concurrently is invalid.. The
> confusing part of this is how does it happen from ucma.c ..
> 
> Double calls via write look OK to me, the ID is removed from the IDR
> at the top so it cannot be invoked twice.. So not sure what
> "write$rdma_cm and write$rdma_cm." is supposed to me?

It meant two write syscalls. One for ucma_listen, one for ucma_resolve_ip.
> 
> Is your test showing that write() vs close() is the problem? The oops
> suggests that.. And the logic around ctx->closing looks tortured
> enough that it is probably wrong...

My previous dianosis seems wrong... I'm sorry to make you confusing.
I'm looking into the code and trying to find out the cause of the crash.

> 
> Jason

We have found the one more crash. null-ptr-deref in cma_bind_listen caused
by two ucma_listen calls.
I think I have the clear idea why null-ptr-deref occured. I will send the
report for the null-ptr-deref. Please look at it.

We suspect that this crash and null-ptr-deref have the same root cause,
incomplete state check.
Hopefully, the second report is helpful to find out the root cause of this
bug.

DaeRyong Jeong
