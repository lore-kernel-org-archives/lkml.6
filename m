Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50CF0C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 20:32:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE55C20856
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 20:32:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="czWMnFGg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE55C20856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727235AbeICAta (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 20:49:30 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33139 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727175AbeICAta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 20:49:30 -0400
Received: by mail-pf1-f196.google.com with SMTP id d4-v6so7754851pfn.0
        for <linux-kernel@vger.kernel.org>; Sun, 02 Sep 2018 13:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Kq+jt5n5gDAGAHCmHd3b6Ss0kzC3LhEgsBkl7v4x1nI=;
        b=czWMnFGgLIDSP3423fIr4i5ntB56pqZDkQQav6XF96EjelcNoAD9awkJTsc4GMNnZu
         7sUPQgyc7kfwICzkBpvGD3XyYOzbV83lR7w2MU84PbSMn0ElMhvdzlFHTsSNxLdkAa3E
         vBPKiZFM3zqwOF9GinzZ4aA56G8B+Ff1/nR0Pt2ZcdF6hhNdwLHOh7ODkqppjOCFOxkZ
         nXf80D2hfVlfEPUcLurMHHKuEXyZzb/gFrbUyHAMT3ShrKacqTPZvCA77x85ow+R4qCr
         Q8Cug+Sh7dMc40ALmiQgJvFHBtw5LZqRo+PAfevznjM5OobzZmuffASmMVa/3Jqduu7N
         dc5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Kq+jt5n5gDAGAHCmHd3b6Ss0kzC3LhEgsBkl7v4x1nI=;
        b=q27CN72QJMwh6M5C5n83LTCDPAxc1Jv8Pmxo3NVHhFvbKIZp/NDTHdXRGhDv+FipRh
         YqmFj2F7f0bxmUL/vtEWMmDwJCX0R1tAwVP7rwAuPKRQfLP1O+xV8GA89B7RYnjO6LPT
         Id4q7hfKAVhiZXxLVIZZxLqkN1hKn/S4NtwOi5flFJk7Ic9pChYyVV5+HJfbBsCkur/L
         f0cLOaazuzPAjied8Gt3gt/Vo8pmuAFkR+Cv4HI9mDOF8Ux+HzRVpvovJAM2K7HIadSn
         U95JlsotTLBBLvG38nmufEdjpoxXcfHHpp3U+0IwshSv9Ega+d/eM1JAozngOXvpj0Re
         4v+Q==
X-Gm-Message-State: APzg51BiLeKlWzurIvfvsjZo5Y/w0jzkdH9iaKQZYrGcRPnPPPlisLnx
        8ZqLJfTWur0H4HiZ/z8hBwNQ0g==
X-Google-Smtp-Source: ANB0Vdbxh0a/hwRQRRA7XqscaXxV5o8nMXRdOfXdf+/ZzaVkDSGr9Z2dk7AqeS6YvRiYVb/S5sOsog==
X-Received: by 2002:a63:2bc9:: with SMTP id r192-v6mr3496087pgr.386.1535920350943;
        Sun, 02 Sep 2018 13:32:30 -0700 (PDT)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id m15-v6sm28638567pfk.149.2018.09.02.13.32.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 02 Sep 2018 13:32:30 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1fwZ2r-0004TG-D1; Sun, 02 Sep 2018 14:32:29 -0600
Date:   Sun, 2 Sep 2018 14:32:29 -0600
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jia-Ju Bai <baijiaju1990@gmail.com>
Cc:     dledford@redhat.com, leon@kernel.org, ira.weiny@intel.com,
        pravin.shedge4linux@gmail.com, hal@mellanox.com,
        parav@mellanox.com, haakon.bugge@oracle.com,
        bart.vanassche@sandisk.com, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] infiniband: core: mad: Fix a sleep-in-atomic-context bug
 in ib_mad_recv_done()
Message-ID: <20180902203229.GA13946@ziepe.ca>
References: <20180901120659.32509-1-baijiaju1990@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180901120659.32509-1-baijiaju1990@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 01, 2018 at 08:06:59PM +0800, Jia-Ju Bai wrote:
> The driver may sleep with holding a spinlock.
> 
> The function call paths (from bottom to top) in Linux-4.16 are:
> 
> [FUNC] alloc_mad_private(GFP_KERNEL)
> drivers/infiniband/core/mad.c, 2264: 
> 	alloc_mad_private in ib_mad_recv_done
> drivers/infiniband/core/cq.c, 45: 
> 	[FUNC_PTR]ib_mad_recv_done in __ib_process_cq
> drivers/infiniband/core/cq.c, 77: 
> 	__ib_process_cq in ib_process_cq_direct
> drivers/infiniband/ulp/srp/ib_srp.c, 2010: 
> 	ib_process_cq_direct in __srp_get_tx_iu
> drivers/infiniband/ulp/srp/ib_srp.c, 2353: 
> 	__srp_get_tx_iu in srp_queuecommand
> drivers/infiniband/ulp/srp/ib_srp.c, 2352: 
> 	_raw_spin_lock_irqsave in srp_queuecommand
> 
> [FUNC] alloc_mad_private(GFP_KERNEL)
> drivers/infiniband/core/mad.c, 2264: 
> 	alloc_mad_private in ib_mad_recv_done
> drivers/infiniband/core/cq.c, 45: 
> 	[FUNC_PTR]ib_mad_recv_done in __ib_process_cq
> drivers/infiniband/core/cq.c, 77: 
> 	__ib_process_cq in ib_process_cq_direct

This trace doesn't seem right, the CQ used by SRP will never have
ib_mad_recv_done as a function pointer.

Jason
