Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751635AbeFDQw5 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 12:52:57 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33969 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751473AbeFDQwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 12:52:54 -0400
X-Google-Smtp-Source: ADUXVKJ8SZ0bNezRmN7ovOYc8bFzgB9lYm4SOV9TeHTVt+bxwHqqk09mD68usqFvmSY9Xzq2XWcf+HMTCoif1JllZXw=
MIME-Version: 1.0
In-Reply-To: <20180604164631.GB12777@ziepe.ca>
References: <20180601183144.17374-1-xiyou.wangcong@gmail.com>
 <CAJX1YtZNdwiwPmj5gGTqURjvLqa5g7Ly_h+TEZfNJSW=mrqRiQ@mail.gmail.com> <20180604164631.GB12777@ziepe.ca>
From: Gi-Oh Kim <gi-oh.kim@profitbricks.com>
Date: Mon, 4 Jun 2018 18:52:12 +0200
Message-ID: <CAJX1YtYFyUEj6jOf9Prdc-5e2=8BTZh3BB7KweXUF+xzE4uoHg@mail.gmail.com>
Subject: Re: [PATCH] infiniband: fix a possible use-after-free bug
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Cong Wang <xiyou.wangcong@gmail.com>, linux-kernel@vger.kernel.org,
        noamr@beyondsecurity.com, Sean Hefty <sean.hefty@intel.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w54Gr1T1031419

On Mon, Jun 4, 2018 at 6:46 PM, Jason Gunthorpe <jgg@ziepe.ca> wrote:
> On Mon, Jun 04, 2018 at 06:23:20PM +0200, Gi-Oh Kim wrote:
>> On Fri, Jun 1, 2018 at 8:31 PM, Cong Wang <xiyou.wangcong@gmail.com> wrote:
>> > ucma_process_join() will free the new allocated "mc" struct,
>> > if there is any error after that, especially the copy_to_user().
>> >
>> > But in parallel, ucma_leave_multicast() could find this "mc"
>> > through idr_find() before ucma_process_join() frees it, since it
>> > is already published.
>> >
>> > So "mc" could be used in ucma_leave_multicast() after it is been
>> > allocated and freed in ucma_process_join(), since we don't refcnt
>> > it.
>> >
>> > Fix this by separating "publish" from ID allocation, so that we
>> > can get an ID first and publish it later after copy_to_user().
>> >
>> > Fixes c8f6a362bf3e ("RDMA/cma: Add multicast communication support")
>> > Reported-by: Noam Rathaus <noamr@beyondsecurity.com>
>> > Cc: Sean Hefty <sean.hefty@intel.com>
>> > Cc: Doug Ledford <dledford@redhat.com>
>> > Cc: Jason Gunthorpe <jgg@ziepe.ca>
>> > Cc: linux-rdma@vger.kernel.org
>> > Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
>> >  drivers/infiniband/core/ucma.c | 6 +++++-
>> >  1 file changed, 5 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/drivers/infiniband/core/ucma.c b/drivers/infiniband/core/ucma.c
>> > index eab43b17e9cf..ec8fb289621f 100644
>> > +++ b/drivers/infiniband/core/ucma.c
>> > @@ -235,7 +235,7 @@ static struct ucma_multicast* ucma_alloc_multicast(struct ucma_context *ctx)
>> >                 return NULL;
>> >
>> >         mutex_lock(&mut);
>> > -       mc->id = idr_alloc(&multicast_idr, mc, 0, 0, GFP_KERNEL);
>> > +       mc->id = idr_alloc(&multicast_idr, NULL, 0, 0, GFP_KERNEL);
>> >         mutex_unlock(&mut);
>> >         if (mc->id < 0)
>> >                 goto error;
>> > @@ -1421,6 +1421,10 @@ static ssize_t ucma_process_join(struct ucma_file *file,
>> >                 goto err3;
>> >         }
>> >
>> > +       mutex_lock(&mut);
>> > +       idr_replace(&multicast_idr, mc, mc->id);
>> > +       mutex_unlock(&mut);
>> > +
>> >         mutex_unlock(&file->mut);
>> >         ucma_put_ctx(ctx);
>> >         return 0;
>> >
>>
>>
>> Hi,
>>
>> Your patch is reasonable to me.
>> Can I ask a question for that?
>> Could it be solved by asymmetric locking as following?
>
> No, there are many other paths that touch multicast_idr that don't
> hold both locks, we should protect all of them from accessing an
> incompletely initialized structure.
>
> Jason

Understood. Thank you.


-- 
GIOH KIM
Linux Kernel Entwickler

ProfitBricks GmbH
Greifswalder Str. 207
D - 10405 Berlin

Tel:       +49 176 2697 8962
Fax:      +49 30 577 008 299
Email:    gi-oh.kim@profitbricks.com
URL:      https://www.profitbricks.de

Sitz der Gesellschaft: Berlin
Registergericht: Amtsgericht Charlottenburg, HRB 125506 B
Geschäftsführer: Achim Weiss, Matthias Steinberg, Christoph Steffens
