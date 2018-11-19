Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C316C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 21:26:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 049E52086A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 21:26:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="E6UIRx9/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 049E52086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731204AbeKTHwO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 02:52:14 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34300 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730976AbeKTHwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 02:52:13 -0500
Received: by mail-pf1-f193.google.com with SMTP id h3so8913219pfg.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 13:26:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FDJZfcAoRFuPs73eEKk1KIT7jJTr1E9628DZngqfpiY=;
        b=E6UIRx9/Fdo7EDDGjXZ3hVkbkKiyuntD1JTFFmRUgkrYg3lVTY/3oSvCwAIRuce5b3
         +lsZPvPvyC9Niw1XR4txYwg8BT0CSXybwJ1lbe5yjS0n03dy/DFIwAtRBn0uFQ4jGkcR
         ur2z46LIvkTENr+SHmcL9aWDUdzwEdLR7GTfcgaGzWqEHFzvfhT2lpZVY+FyvDMXG+TM
         0ZLLwj8ySDtgvQru4rSvO5slaungMJdxdsJ+i43ymSSb3HPmrp7elGNcvGB0FIEiJ7PC
         y7gUlj3xn7k238FtsmA7drdoMISpIMInHbI6tUuAShgNspsvT+GzybLEffKHJnDXftuP
         tj2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FDJZfcAoRFuPs73eEKk1KIT7jJTr1E9628DZngqfpiY=;
        b=ZKTJj0S95aZ6YGRTetQdlL4cyFhMm7S5yua9kmALiuSAl5zuua4uq4yVDV2bDcd7j9
         qpvaUja4GDb8uqNvViX1eqbRka8XHaAMxEWoWZFmLf90QSAGewrH2Qy8hz9sYp6KXA1M
         gbqwSF6Q6dVoUGjhXeEuJoXmuKkR8JxbwkkYLq4dezFB7dNTbXboSX298K4+gH7j48eg
         rYxHDq2iWyTmyEM8ux+AorHkRM2PmCCCkGCJ6GuTctloQKhVhUswoolrsifVTlPn1t6q
         dqIu1CKA5t6WgbrkzuB/U5ryB3eiTIV0n+Mo8/9nOhjF1aK+JzUKetGLxWD+pflFynKX
         fGHA==
X-Gm-Message-State: AGRZ1gIvJrkGIRv90JuHzYS1wX0j3zXYFXcfZ7D8yDw3SaWKMFdATfju
        gAHBMM02wMN3WvFqrRe8fOlhdg==
X-Google-Smtp-Source: AJdET5cYZDMWU1NZbt10IaMISKdWNzL6CGBHnLcRSeMr2baVKsQX6VXlowQnw9vu06EMYlJupYpXhQ==
X-Received: by 2002:a63:da45:: with SMTP id l5mr21813504pgj.111.1542662800726;
        Mon, 19 Nov 2018 13:26:40 -0800 (PST)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id v62sm3653979pfd.163.2018.11.19.13.26.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Nov 2018 13:26:39 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1gOr42-0006YR-Si; Mon, 19 Nov 2018 14:26:38 -0700
Date:   Mon, 19 Nov 2018 14:26:38 -0700
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jerome Glisse <jglisse@redhat.com>
Cc:     Tim Sell <timothy.sell@unisys.com>, linux-doc@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Zaibo Xu <xuzaibo@huawei.com>, zhangfei.gao@foxmail.com,
        linuxarm@huawei.com, haojian.zhuang@linaro.org,
        Christoph Lameter <cl@linux.com>,
        Hao Fang <fanghao11@huawei.com>,
        Gavin Schenk <g.schenk@eckelmann.de>,
        Leon Romanovsky <leon@kernel.org>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        David Kershner <david.kershner@unisys.com>,
        Kenneth Lee <nek.in.cn@gmail.com>,
        Johan Hovold <johan@kernel.org>,
        Cyrille Pitchen <cyrille.pitchen@free-electrons.com>,
        Sagar Dharia <sdharia@codeaurora.org>,
        Jens Axboe <axboe@kernel.dk>, guodong.xu@linaro.org,
        linux-netdev <netdev@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, Zhou Wang <wangzhou1@hisilicon.com>,
        linux-crypto@vger.kernel.org,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Kenneth Lee <liguozhu@hisilicon.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-accelerators@lists.ozlabs.org
Subject: Re: [RFCv3 PATCH 1/6] uacce: Add documents for WarpDrive/uacce
Message-ID: <20181119212638.GI4890@ziepe.ca>
References: <20181119104801.GF8268@mtr-leonro.mtl.com>
 <20181119164853.GA4593@redhat.com>
 <20181119182752.GA4890@ziepe.ca>
 <20181119184215.GB4593@redhat.com>
 <20181119185333.GC4890@ziepe.ca>
 <20181119191721.GC4593@redhat.com>
 <20181119192702.GD4890@ziepe.ca>
 <20181119194631.GE4593@redhat.com>
 <20181119201156.GG4890@ziepe.ca>
 <20181119202614.GF4593@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181119202614.GF4593@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 03:26:15PM -0500, Jerome Glisse wrote:
> On Mon, Nov 19, 2018 at 01:11:56PM -0700, Jason Gunthorpe wrote:
> > On Mon, Nov 19, 2018 at 02:46:32PM -0500, Jerome Glisse wrote:
> > 
> > > > ?? How can O_DIRECT be fine but RDMA not? They use exactly the same
> > > > get_user_pages flow, right? Can we do what O_DIRECT does in RDMA and
> > > > be fine too?
> > > > 
> > > > AFAIK the only difference is the length of the race window. You'd have
> > > > to fork and fault during the shorter time O_DIRECT has get_user_pages
> > > > open.
> > > 
> > > Well in O_DIRECT case there is only one page table, the CPU
> > > page table and it gets updated during fork() so there is an
> > > ordering there and the race window is small.
> > 
> > Not really, in O_DIRECT case there is another 'page table', we just
> > call it a DMA scatter/gather list and it is sent directly to the block
> > device's DMA HW. The sgl plays exactly the same role as the various HW
> > page list data structures that underly RDMA MRs.
> > 
> > It is not a page table that matters here, it is if the DMA address of
> > the page is active for DMA on HW.
> > 
> > Like you say, the only difference is that the race is hopefully small
> > with O_DIRECT (though that is not really small, NVMeof for instance
> > has windows as large as connection timeouts, if you try hard enough)
> > 
> > So we probably can trigger this trouble with O_DIRECT and fork(), and
> > I would call it a bug :(
> 
> I can not think of any scenario that would be a bug with O_DIRECT.
> Do you have one in mind ? When you fork() and do other syscall that
> affect the memory of your process in another thread you should
> expect non consistant results. Kernel is not here to provide a fully
> safe environement to user, user can shoot itself in the foot and
> that's fine as long as it only affect the process itself and no one
> else. We should not be in the business of making everything baby
> proof :)

Sure, I setup AIO with O_DIRECT and launch a read.

Then I fork and dirty the READ target memory using the CPU in the
child.

As you described in this case the fork will retain the physical page
that is undergoing O_DIRECT DMA, and the parent gets a new copy'd page.

The DMA completes, and the child gets the DMA'd to page. The parent
gets an unchanged copy'd page.

The parent gets the AIO completion, but can't see the data.

I'd call that a bug with O_DIRECT. The only correct outcome is that
the parent will always see the O_DIRECT data. Fork should not cause
the *parent* to malfunction. I agree the child cannot make any
prediction what memory it will see.

I assume the same flow is possible using threads and read()..

It is really no different than the RDMA bug with fork.

Jason
