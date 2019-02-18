Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31EFFC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 15:22:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F06B6217D9
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 15:22:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731986AbfBRPWl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 10:22:41 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:58490 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731378AbfBRPWl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 10:22:41 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id A7894BBA42A4FE0B69C4;
        Mon, 18 Feb 2019 23:22:36 +0800 (CST)
Received: from localhost (10.47.94.189) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.408.0; Mon, 18 Feb 2019
 23:22:35 +0800
Date:   Mon, 18 Feb 2019 15:22:24 +0000
From:   Jonathan Cameron <jonathan.cameron@huawei.com>
To:     Sven Van Asbroeck <thesven73@gmail.com>
CC:     Robert Eshleman <bobbyeshleman@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 1/3] iio: light: Add driver for ap3216c
Message-ID: <20190218152224.00007920@huawei.com>
In-Reply-To: <CAGngYiUvEpSgESzFGJOtYjLi+_xmZ18GwiSTxaaMjEmjk2pu4Q@mail.gmail.com>
References: <89716a4433cd83aea5f4200359b184b0ee2cc8bd.1549828313.git.bobbyeshleman@gmail.com>
        <CAGngYiXPsj-TAZxC43UtAZYTkbztFtDB-z4jW29CthmaoeNy_w@mail.gmail.com>
        <20190213021753.GA19621@bobby.localdomain>
        <CAGngYiUvEpSgESzFGJOtYjLi+_xmZ18GwiSTxaaMjEmjk2pu4Q@mail.gmail.com>
Organization: Huawei
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.94.189]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Feb 2019 22:25:39 -0500
Sven Van Asbroeck <thesven73@gmail.com> wrote:

> Hi Bobby,
> 
> On Tue, Feb 12, 2019 at 9:17 PM Robert Eshleman <bobbyeshleman@gmail.com> wrote:
> >
> > First, thank you for the feedback.  
> 
> First of all, thank _you_ for doing the hard work on this driver !
> I very much respect what you've done here.
> 
> >
> > I had initially went with a similar design, but there is
> > the case in which the interrupt fires and then before the status
> > register is read by the handler a user process reads the data and
> > clears the interrupt.  When the handler continues execution it will
> > read a zero status and return IRQ_NONE.  My understanding of how
> > Linux handles IRQ_NONE is pretty poor, but I felt that this behavior
> > is incorrect even if inconsequential.  This could be avoided by
> > doing a status register read with every data read, and buffering
> > that as well, but then we lose the benefit altogether by increasing
> > I2C reads.
> >
> > In the approach you describe here, it seems like that would
> > work if this driver wasn't supporting shared interrupts.  In the
> > case that a user-space read happens to clear the interrupt before
> > the handler reads the status register, I think we would end up
> > falsely returning IRQ_NONE.
> >
> > Is my understanding of this correct?  It's very possible I'm
> > misunderstanding IRQ_NONE and shared interrupts.
> >  
> 
> Yes, I can see how one can run into those issues.
> 
> I believe that this whole class of problems goes away if PS/ALS
> are _exclusively_ read inside the interrupt, and cached.
> 
> Then, whenever a user process wants to read the data, the function
> does not touch the h/w, but simply return the cached value.
> 
> But hang on, I will have more to say on this when replying to Jonathan's
> feedback.

As mentioned in the other thread.  Can't do that.  Then we don't get a readout for
a normal read of the value.  If we aren't above the threshold then
we don't an interrupt, hence no value is ever read.

So, what I'm reading above is worrying.   The interrupt is cleared
by the read of the data registers?  I thought the datasheet allowed
for an explicit clear?

If it clears on a read, then we are on one of those rare and really
annoying devices where we have to deal with them not really being able
to do monitoring and polled reading at the same time and also not
providing a dataready interrupt (which allows for the solution Sven
gives)

Basically we've only ever had one of these that I can recall and on that
max1363 it was more a case of the format being really nasty to decode
than the hardware not being capable of safely do it, so we didn't bother.

Jonathan




