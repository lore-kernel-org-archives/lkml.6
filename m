Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82738C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 23:25:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35A082147C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 23:25:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="lYgA0k+G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727272AbfAGXZQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 18:25:16 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33017 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727076AbfAGXZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 18:25:15 -0500
Received: by mail-pg1-f193.google.com with SMTP id z11so840191pgu.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 15:25:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=l01/MrfL8olU8EZ8L5lMkIBR4BL/yTcKxgnAwIdUGeo=;
        b=lYgA0k+GoT3nVtvQex9ttd57uPCZwRsZZjxfqNryk85FK5y2VuD+s08YhREJI57Osf
         0ArhcCeHam8PgZp5GyjRhdeTuP7G1j6+lTPjHmPnNsvGVTYJWJTrC2UFlzNf21XIUvrE
         ILOzL1alWyZ9BoCsGbpBL3Q8ngIhM5awYvqCX+7lnaTbSJZLe+TunLN/U2qOJV22FOVe
         oOcEOWl7rPyfHcCYsAUVYrvMNhyB5AYdzUMyCO5tmu8uLBi+sTwsSPcgIaGj7F13C9xG
         yL/2POfpwONrXmZoGwloGZPwbd4vbHm6KmxE7fjPMd5fKhHJTM4BzRyohRhbq7Z3sJYT
         I04A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=l01/MrfL8olU8EZ8L5lMkIBR4BL/yTcKxgnAwIdUGeo=;
        b=oKZZ+1ROtwkDbJjir87fkaQrG6bMlIOvykllajqXCxFdSzHiaq4hwYSmiE+PMMhWOo
         BZwshUdssX501qi+FI2LyCw5qOBXIs5Yaz8qj5Rw592eRB/EL84qBRuz0TgtfEhq0Zxi
         xof9xyeDr01wpx1G5w+83g3GZQ/so/A+ogx0+qs6xskfMRpGS2/YDEeZqiJS3gxnQy2I
         b7BkeIrEY152/VfFZrRk01+mkf4nfjaCQkBxDngW1N20ISxi9x8gkq8Jsa9ivXgH8P94
         K8S0bpLHBg/4tMp2ZzUki8AvycwXfxBwlIF/KX5a8N0CK+aBFi74KeigJDYz8j56QUS/
         lovw==
X-Gm-Message-State: AA+aEWac0kcJiQ1p3CUkI4FmwfUDhtkCLfbJt28r/p8+jniwnXb7XfOo
        BV0uR1p2RaPi42968lpd8ydvrg==
X-Google-Smtp-Source: AFSGD/W2N9/OrAIUQJcoYI2NF7NfZMlyPMw+WDUY2yUxvK57FAwgbb+tKlFbpi+A1BmM5y8bVp74oA==
X-Received: by 2002:a62:a99:: with SMTP id 25mr63928989pfk.121.1546903514816;
        Mon, 07 Jan 2019 15:25:14 -0800 (PST)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id t90sm141532437pfj.23.2019.01.07.15.25.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 Jan 2019 15:25:14 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1ggeGf-0001rH-81; Mon, 07 Jan 2019 16:25:13 -0700
Date:   Mon, 7 Jan 2019 16:25:13 -0700
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Joe Perches <joe@perches.com>
Cc:     Gal Pressman <galpress@amazon.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Stephen Warren <swarren@wwwdotorg.org>,
        Tariq Toukan <tariqt@mellanox.com>, xavier.huwei@huawei.com,
        netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        Doug Ledford <dledford@redhat.com>,
        Stephen Warren <swarren@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] coding-style: Clarify the expectations around bool
Message-ID: <20190107232513.GA5336@ziepe.ca>
References: <20190107211117.GA24142@ziepe.ca>
 <8ec3603317f477fe9923b87499a33da7a2cf81ff.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ec3603317f477fe9923b87499a33da7a2cf81ff.camel@perches.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2019 at 02:10:22PM -0800, Joe Perches wrote:
> On Mon, 2019-01-07 at 14:11 -0700, Jason Gunthorpe wrote:
> > There has been some confusion since checkpatch started warning about bool
> > use in structures, and people have been avoiding using it.
> > 
> > Many people feel there is still a legitimate place for bool in structures,
> > so provide some guidance on bool usage derived from the entire thread that
> > spawned the checkpatch warning.
> 
> Thanks Jason.
> 
> It'd be nice to combine this with some better checkpatch warning or
> even a removal of that misleading warning from checkpatch
> altogether.

Okay, do you have a preference?

> With a couple minor nits below and and Ack if
> you want one:
> 
> Acked-by: Joe Perches <joe@perches.com>

Thanks, I made the revisions with Bart's extra words. I'll send a v4
in a few days.

Jason
