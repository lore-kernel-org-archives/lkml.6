Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751245AbeBTVyj (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 16:54:39 -0500
Received: from mail-qt0-f196.google.com ([209.85.216.196]:37287 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750710AbeBTVyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 16:54:37 -0500
X-Google-Smtp-Source: AH8x227S3+kxADDjsb3nd1K7N71fCGnrbxWnLxr0g19nX+qEE879S8355lof07iDsfSO5LwuWoyHbd1ojfTCmnqQ66U=
MIME-Version: 1.0
In-Reply-To: <VI1PR0502MB3008B35525901FC935418FB0D1CF0@VI1PR0502MB3008.eurprd05.prod.outlook.com>
References: <20180220205924.2035765-1-arnd@arndb.de> <VI1PR0502MB3008B35525901FC935418FB0D1CF0@VI1PR0502MB3008.eurprd05.prod.outlook.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 20 Feb 2018 22:54:35 +0100
X-Google-Sender-Auth: e7oMkNTfjEUANkBFBHEnbIESpH8
Message-ID: <CAK8P3a10Vw1JjuJmACpFHfm60-K=FyRJfYW045di6eUW6R3wug@mail.gmail.com>
Subject: Re: [PATCH] RDMA/core: reduce IB_POLL_BATCH constant
To: Parav Pandit <parav@mellanox.com>
Cc: Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leonro@mellanox.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bart.vanassche@sandisk.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 20, 2018 at 10:14 PM, Parav Pandit <parav@mellanox.com> wrote:
> Hi Arnd Bergmann,
>
>> -----Original Message-----
>> From: linux-rdma-owner@vger.kernel.org [mailto:linux-rdma-
>> owner@vger.kernel.org] On Behalf Of Arnd Bergmann
>> Sent: Tuesday, February 20, 2018 2:59 PM
>> To: Doug Ledford <dledford@redhat.com>; Jason Gunthorpe <jgg@ziepe.ca>
>> Cc: Arnd Bergmann <arnd@arndb.de>; Leon Romanovsky
>> <leonro@mellanox.com>; Sagi Grimberg <sagi@grimberg.me>; Bart Van Assche
>> <bart.vanassche@sandisk.com>; linux-rdma@vger.kernel.org; linux-
>> kernel@vger.kernel.org
>> Subject: [PATCH] RDMA/core: reduce IB_POLL_BATCH constant
>>
>> The ib_wc structure has grown to much that putting 16 of them on the stack hits
>> the warning limit for dangerous kernel stack consumption:
>>
>> drivers/infiniband/core/cq.c: In function 'ib_process_cq_direct':
>> drivers/infiniband/core/cq.c:78:1: error: the frame size of 1032 bytes is larger
>> than 1024 bytes [-Werror=frame-larger-than=]
>>
>> Using half that number brings us comfortably below that limit again.
>>
>> Fixes: 02d8883f520e ("RDMA/restrack: Add general infrastructure to track
>> RDMA resources")
>
> It is not clear to me how above commit 02d8883f520e introduced this stack issue.

My mistake, I misread the git history.

I did a proper bisection now and ended up with the commit that added the
IB_POLL_BACK sized array on the stack, i.e. commit 246d8b184c10 ("IB/cq:
Don't force IB_POLL_DIRECT poll context for ib_process_cq_direct")

> Bodong and I came across ib_wc size increase in [1] and it was fixed in [2].
> Did you hit this error after/before applying patch [2]?
>
> [1] https://www.spinics.net/lists/linux-rdma/msg50754.html
> [2] https://patchwork.kernel.org/patch/10159623/

I did the analysis a few weeks ago when I first hit the problem but
didn't send it
out at the time. Today I saw the problem still persists on mainline (4.16-rc2),
which does contain the patch from [2].

What I see is that 'ib_wc' is now exactly 59 bytes on 32-bit ARM, plus 5 bytes
of padding, so 16 of them gets us exactly the warning limit, and then there
are a few bytes for the function itself.

       Arnd
