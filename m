Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D17E2C5CFE7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 19:18:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81D6E208DB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 19:18:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="lgiN4jRT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81D6E208DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754638AbeGITSU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 15:18:20 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34951 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754581AbeGITSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 15:18:18 -0400
Received: by mail-wr1-f66.google.com with SMTP id a3-v6so2868489wrt.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 12:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gDsVRJSXEkgoXybK4LCgzwyItSiWvW1mZLoOS4VnaCs=;
        b=lgiN4jRT8BWmNPsn6ck/njYDXNiQmAD9tqJaXLYEfWmd34yDUqp0Dt/8lv781WtkEZ
         SWSITtnMXyMfeBrURteFSFVYjP7ZtWRDGuOyjpLvBvbwFKzSlT9S948EFEA+tAhalGYo
         NPGmUGKfqiwE36YXccmU8V2HhSRYLPkc0g6XinucjNzS5LWeiEbzfKdpoSsXlUcUWDiY
         W4s2FA8mmLSRRiZYvmvs9lsEPE1Aupbm1TJBYr9v3B3utVcwZGRAQZZam6KAurlSmY+e
         ZOP6DYED2lGuxz1aSI19fLAgs2hELq5adLm9VB0eLuU6Gg+jTC4uvkB/3TSRpBTAvDhu
         G5sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gDsVRJSXEkgoXybK4LCgzwyItSiWvW1mZLoOS4VnaCs=;
        b=eVWchgSe49VyTPf/1uX7ttElx/URDQBRIMeBsPfjVHO0CzCnTqKEkpRxoIfYP6U7YX
         e0PFL8+4GQ7J/SWJ9drfyADjUFvPYsM1A9+Gwh8VBCcaBiL9zi0bwPoBhJEgAKiFlvbV
         +WYE2qOHjbrAjr9c9OOlN1Ibifcr6LNZHPJxhEoJbG02QrAbDkBq1AH1h0atbeKm5/cv
         fXBY5zt8ykT15bDqn9S7ejKmCDEVBz2lYPdfjWpGdubFSqNB+zpiVK96ctuzyueOZlhJ
         Ae5tCeWFHF4kb8v7k00zZwLpJBADmz5fPaVyCUwcFbIJ1DAMYIS0+OOs6Tfcw33k4KCD
         40JA==
X-Gm-Message-State: AOUpUlFWaNSONKC1xbe7FIOjxnpLzWimiYMbUO7T6lJmri4y3HIG3r3k
        RakXM5WQ6Rj9uMoquQyuZyET1w==
X-Google-Smtp-Source: AAOMgpfDG6BsdAKC08oD2xUZaMordYimY8NcQUa3JgMSALLVviZWm/ULMLFLxM2lkoNTDKEnnviT4Q==
X-Received: by 2002:adf:f8c7:: with SMTP id f7-v6mr7662957wrq.237.1531163897724;
        Mon, 09 Jul 2018 12:18:17 -0700 (PDT)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id e12-v6sm3509930wrt.29.2018.07.09.12.18.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Jul 2018 12:18:17 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.86_2)
        (envelope-from <jgg@ziepe.ca>)
        id 1fcbfq-0006mu-6O; Mon, 09 Jul 2018 13:18:14 -0600
Date:   Mon, 9 Jul 2018 13:18:14 -0600
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jann Horn <jannh@google.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] IB/mlx5: fix uaccess beyond "count" in debugfs
 read/write handlers
Message-ID: <20180709191814.GA26059@ziepe.ca>
References: <20180706204803.131152-1-jannh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180706204803.131152-1-jannh@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 06, 2018 at 10:48:03PM +0200, Jann Horn wrote:
> In general, accessing userspace memory beyond the length of the supplied
> buffer in VFS read/write handlers can lead to both kernel memory corruption
> (via kernel_read()/kernel_write(), which can e.g. be triggered via
> sys_splice()) and privilege escalation inside userspace.
> 
> In this case, the affected files are in debugfs (and should therefore only
> be accessible to root), and the read handlers check that *pos is zero
> (meaning that at least sys_splice() can't trigger kernel memory
> corruption). Because of the root requirement, this is not a security fix,
> but rather a cleanup.
> 
> For the read handlers, fix it by using simple_read_from_buffer() instead of
> custom logic. Add min() calls to the write handlers.
> 
> changed in v2:
>  - also fix write handlers
> 
> Fixes: 4a2da0b8c078 ("IB/mlx5: Add debug control parameters for congestion control")
> Fixes: e126ba97dba9 ("mlx5: Add driver for Mellanox Connect-IB adapters")
> Signed-off-by: Jann Horn <jannh@google.com>
> Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  drivers/infiniband/hw/mlx5/cong.c |  9 +--------
>  drivers/infiniband/hw/mlx5/mr.c   | 32 ++++++++-----------------------
>  2 files changed, 9 insertions(+), 32 deletions(-)

Applied to for-next

Thanks,
Jason
