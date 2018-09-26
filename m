Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44599C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 17:07:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E03592152F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 17:07:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="PJXinC5B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E03592152F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728646AbeIZXUw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 19:20:52 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:42560 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727698AbeIZXUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 19:20:52 -0400
Received: by mail-io1-f66.google.com with SMTP id n18-v6so23871309ioa.9
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 10:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NTBa50NEYXcUWjgNglB/yKU2lMiq08+c/rCM4WNV92I=;
        b=PJXinC5BnUOvLpUn6pBUbSNEornpDEeCFJO7FFRT34L6aVb0yhF25yVV6QOESs/TAB
         kfMdWa/7excZOEDv79pkGuzNL+t91SEaHOpQe0y+7kTWaAOafd1TnPtLFIMjXgjJTqKO
         ELvWiN8gdUbEXwr2a7IrOiWOCaxntKgjJuo5ySUZM1DsB5Labb8QBfp8U4Jp0XH9Nkdx
         hubkxAwaWV3Cb+mUq8+t7QSTUHsdkJFNGf7JWC+cVE5W1BfK3vf7jn5eqz0T1AdAXBK1
         f7H/vngZyjLEGY6VcKdlcQUVmMI3OMAboqVgnIBtMUQQMwn9MphV0LodqfsmgsSuB3zN
         lRbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NTBa50NEYXcUWjgNglB/yKU2lMiq08+c/rCM4WNV92I=;
        b=uJjLwPGqfO/RLZvjOzC4TqvtYpGUL7jFFBwANfk2TrumU+CMQOLV/Fq+xUbru3LCOL
         CaoMq0DOaWLAInxMAL/MC6bQUYzA9Gcxwio/pCOVQJtfkM/Og/pbGe5SdO+LSv6vK0ML
         uwUOuP3Brfig8epGOvon3srfaZqzwrgHzehp3bDi6G9TkNKCM95NQhXVHcpuKmIlRaaa
         CMBIT/Wvpd9VY/OrU4FL/Z8hh0+RFlIcqqooQncfz+eXYQwJYa3UnvOACeyDnX8sHhgq
         JT8NSlauCiES+Zvt2V0skjJ1ZY7ayU3EYPwLFh/Rg0sUg75SGQlXDncox57CmVhQya8p
         uLpA==
X-Gm-Message-State: ABuFfoiOb1Hgr9WsyZlB0Cctkf5OkExH03OMIKfyQWiTghtJzUsh/xxb
        eB0/DjvVXieCsn/Fbphf0yQvWA==
X-Google-Smtp-Source: ACcGV61fdlv3EWkiVAweGYX0xiAI3vUeq3JXYGfqqhKDRsQVtuPCaMze45tQhuT3kC5Wg37wEhc48A==
X-Received: by 2002:a5e:8d02:: with SMTP id m2-v6mr1253653ioj.122.1537981617415;
        Wed, 26 Sep 2018 10:06:57 -0700 (PDT)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id m186-v6sm1165036itg.29.2018.09.26.10.06.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Sep 2018 10:06:56 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1g5DH5-0005jX-VA; Wed, 26 Sep 2018 11:06:55 -0600
Date:   Wed, 26 Sep 2018 11:06:55 -0600
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jan Dakinevich <jan.dakinevich@virtuozzo.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Yishai Hadas <yishaih@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        Parav Pandit <parav@mellanox.com>,
        Mark Bloch <markb@mellanox.com>,
        Daniel Jurgens <danielj@mellanox.com>,
        Kees Cook <keescook@chromium.org>,
        Kamal Heib <kamalheib1@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Denis Lunev <den@virtuozzo.com>,
        Konstantin Khorenko <khorenko@virtuozzo.com>
Subject: Re: [PATCH 0/4] IB: decrease large contigous allocation
Message-ID: <20180926170655.GC16163@ziepe.ca>
References: <1537275826-27247-1-git-send-email-jan.dakinevich@virtuozzo.com>
 <20180918144623.GI11367@ziepe.ca>
 <20180926184809.5d37cdb7@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180926184809.5d37cdb7@virtuozzo.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 06:48:09PM +0300, Jan Dakinevich wrote:
> On Tue, 18 Sep 2018 08:46:23 -0600
> Jason Gunthorpe <jgg@ziepe.ca> wrote:
> 
> > On Tue, Sep 18, 2018 at 04:03:42PM +0300, Jan Dakinevich wrote:
> > > The size of mlx4_ib_device became too large to be allocated as
> > > whole contigous block of memory. Currently it takes about 55K. On
> > > architecture with 4K page it means 3rd order.
> > > 
> > > This patch series makes an attempt to split mlx4_ib_device into
> > > several parts and allocate them with less expensive kvzalloc
> > 
> > Why split it up? Any reason not to just allocate the whole thing with
> > kvzalloc?
> > 
> 
> To allocate whole ib_device with kvmalloc I will need replace kzalloc()
> by kvzalloc() in ib_alloc_device() and then review allocation, to make
> sure that no one uses this memory for DMA.

I would be shocked if some driver was DMA'ing out of struct ib_device
memory..

Jason
