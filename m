Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF92EC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 16:25:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ACA9206E0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 16:25:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729980AbeLNQZy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 11:25:54 -0500
Received: from foss.arm.com ([217.140.101.70]:54890 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727795AbeLNQZy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 11:25:54 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B999480D;
        Fri, 14 Dec 2018 08:25:53 -0800 (PST)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 898603F59C;
        Fri, 14 Dec 2018 08:25:53 -0800 (PST)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id E3D4C1AE087D; Fri, 14 Dec 2018 16:25:52 +0000 (GMT)
Date:   Fri, 14 Dec 2018 16:25:52 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     yulei.kernel@gmail.com, Stefani Seibold <stefani@seibold.net>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, mkelly@xevo.com,
        Jiri Kosina <jkosina@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>, yuleixzhang@tencent.com,
        xiaoguangrong@tencent.com
Subject: Re: [PATCH] kfifo: add memory barrier in kfifo to prevent data loss
Message-ID: <20181214162552.GD8148@edgewater-inn.cambridge.arm.com>
References: <20181211034032.32338-1-yuleixzhang@tencent.com>
 <CAGXu5jKkqf-9ksvNTCS5xgB_JtfvCc=Eot2uWYYP8rpoKLw=mg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGXu5jKkqf-9ksvNTCS5xgB_JtfvCc=Eot2uWYYP8rpoKLw=mg@mail.gmail.com>
User-Agent: Mutt/1.11.1+30 (d10eec459b35) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 04:50:34PM -0800, Kees Cook wrote:
> On Mon, Dec 10, 2018 at 7:41 PM <yulei.kernel@gmail.com> wrote:
> >
> > From: Yulei Zhang <yuleixzhang@tencent.com>
> >
> > Early this year we spot there may be two issues in kernel
> > kfifo.
> >
> > One is reported by Xiao Guangrong to linux kernel.
> > https://lkml.org/lkml/2018/5/11/58
> > In current kfifo implementation there are missing memory
> > barrier in the read side, so that without proper barrier
> > between reading the kfifo->in and fetching the data there
> > is potential ordering issue.
> >
> > Beside that, there is another potential issue in kfifo,
> > please consider the following case:
> > at the beginning
> > ring->size = 4
> > ring->out = 0
> > ring->in = 4
> >
> >     Consumer                        Producer
> > ---------------                  --------------
> > index = ring->out; /* index == 0 */
> > ring->out++; /* ring->out == 1 */
> > < Re-Order >
> >                                  out = ring->out;
> >                                  if (ring->in - out >= ring->mask)
> >                                      return -EFULL;
> >                                  /* see the ring is not full */
> >                                  index = ring->in & ring->mask;
> >                                  /* index == 0 */
> >                                  ring->data[index] = new_data;
> > 　　　　　　　　　　　　　　　　 ring->in++;
> >
> > data = ring->data[index];
> > /* you will find the old data is overwritten by the new_data */
> >
> > In order to avoid the issue:
> > 1) for the consumer, we should read the ring->data[] out before
> > updating ring->out
> > 2) for the producer, we should read ring->out before updating
> > ring->data[]
> >
> > So in this patch we introduce the following four functions which
> > are wrapped with proper memory barrier and keep in pairs to make
> > sure the in and out index are fetched and updated in order to avoid
> > data loss.
> >
> > kfifo_read_index_in()
> > kfifo_write_index_in()
> > kfifo_read_index_out()
> > kfifo_write_index_out()
> >
> > Signed-off-by: Yulei Zhang <yuleixzhang@tencent.com>
> > Signed-off-by: Guangrong Xiao <xiaoguangrong@tencent.com>
> 
> I've added some more people to CC that might want to see this. Thanks
> for sending this!

I haven't looked at the guts of kfifo before and I'm fully prepared to
believe that there are ordering problems in there. However, I'm having a
hard time matching the implementation to the snippets above.

Please could you provide the description of the consumer/producer
interaction as above, but annotated with the function/macro names?

There are things like kfifo_get() using smp_wmb(), which looks suspicious,
but doesn't appear to be what you're reporting here.

Thanks,

Will
