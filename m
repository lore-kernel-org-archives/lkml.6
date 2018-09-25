Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0A37C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 20:36:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ED472083A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 20:36:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="hZeXGCe8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7ED472083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbeIZCpo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 22:45:44 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34465 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbeIZCpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 22:45:44 -0400
Received: by mail-pf1-f193.google.com with SMTP id k19-v6so12021079pfi.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 13:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kOp/1Ja8EC6KSeYk+G4d5TGAVp1CJqfP1bVQUVPkuh0=;
        b=hZeXGCe8HyzZSl276bFeLce6o9eVFI3/rAiwyLpreJB632nNv4ifd+9/Y19YPj2BvE
         Pn1PEmQ/Mu9NeaLRKSvsaW0xV6hISKmYc07ItZAYxuemEDfkWABRZW4fLbQN9Ty1Ny50
         mnj91teyJQskh20is2Ue+tXe0CkguLeJW4aMSpMrDnQBw8/Xy/TdTIlljQDsbVzq0SYr
         y+u9cYcSzhCQyztQtoqp9fYE2acrfiRcv36+UW7BwT0uLA1cT2uWbdDDGIjYpDM+W3Ss
         0qyHD62XBoQTySzgt07ihFjpiZvyw0ZZZi8HCJ3KnJLpENBiQgTcqXZMWbP4JGSO4EO/
         wFNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kOp/1Ja8EC6KSeYk+G4d5TGAVp1CJqfP1bVQUVPkuh0=;
        b=jju1FD+y/qnLtJha/DCKxIOD6I6WMMK+WSNZBAM0lbSe3OghsiX86uNiJJuViNwVNX
         m1dGVvbQoUgyw8nF0q1vqGgp2SwbiKXMFc5Qqx+bYbcUTGNjmywsFltsRKqzO4/h+MFb
         RPUAfy2ygO4bjR7hWvyCWpPBS5RvcmiILYB5aPeA2drZLOQP0gzzhT3qXwoYnlU7iici
         HvS52LVCwQWfD5C9+R/xpAtCdUslwajBu9nLP4PMAjP5MGJyw84q8qc9POM/pS0tgBPr
         VCBGdd4ipd0zfkl4OLXWMz1dTCBUaO3QPQz3yTOVgzVs7whrLwgG0V/PZ5QFa46b5+4B
         lehA==
X-Gm-Message-State: ABuFfog29QAqGtS4RhYnpIIzTc8bmyIIneFdxMxuyd8YC345cRgXxMOL
        MmNNO0DTF/JVBS+u83X/n1LPNQ==
X-Google-Smtp-Source: ACcGV628ePUmeu5UzP5Kp8ODRUvwmHKJmmQjxzxQ8tsd4F6AYF5rJ/V/zX4HJJNGMn0sh3+G33NeYg==
X-Received: by 2002:a62:ba0b:: with SMTP id k11-v6mr2747958pff.171.1537907784359;
        Tue, 25 Sep 2018 13:36:24 -0700 (PDT)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id t1-v6sm3850240pgp.32.2018.09.25.13.36.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Sep 2018 13:36:23 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1g4u4F-0005UL-2d; Tue, 25 Sep 2018 14:36:23 -0600
Date:   Tue, 25 Sep 2018 14:36:23 -0600
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Colin King <colin.king@canonical.com>
Cc:     Christian Benvenuti <benve@cisco.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IB/usnic: fix spelling mistake "unvalid" -> "invalid"
Message-ID: <20180925203623.GA21074@ziepe.ca>
References: <20180924172738.3508-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180924172738.3508-1-colin.king@canonical.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, 2018 at 06:27:38PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Trivial fix to spelling mistake in usnic_err error message.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/infiniband/hw/usnic/usnic_transport.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-next

Thanks,
Jason
