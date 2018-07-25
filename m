Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8931DC6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 20:37:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 361C020671
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 20:37:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="mxpKN1TO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 361C020671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731174AbeGYVu6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 17:50:58 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35023 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730400AbeGYVu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 17:50:57 -0400
Received: by mail-wr1-f66.google.com with SMTP id a3-v6so8601573wrt.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 13:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vKDETsHnvTLfesHzrWb14X2/JJ+X61sc87ApQVWWC+k=;
        b=mxpKN1TOlhSPBTpPIu3d4y3ocSdCgB0U7n3zf6U42J8ckv6G08EmaQKzLGld8pWYCJ
         gxEdE9VDijiat3PE2p8SpR5U7fYCkEUdKMx2/gw0Z9H5+CW4vvcq9Lh4EY4ZKopRB/R9
         C4basYgUTX4o7w22xHsfvE0RKgktueaVXrYSRehbWaCdgqu4K239AUGDsLlcafmnXtxv
         cJIUDOwO9/PIcROB4y4dcQfd6HNEKvfVQEKN1rVl8+VChmPBVuc3zrbeVZJ+QgCu5Lds
         Q5iUhDbOuhA2R8rA4On0f0uhra2vupdJ0yp0cgeefPeMRTi8z/hIgimGGrP/xoJBS1N2
         OM7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vKDETsHnvTLfesHzrWb14X2/JJ+X61sc87ApQVWWC+k=;
        b=avYHSvZE/sSD4FRFQ5VuZJCLejXXcYUNlrG4D6UDUUyTUaRztzOrlgxMoC0/DudNyt
         6F7Gt5qnbAy/5wtJpx17m0Dx39AaZAbgYp3YweZlRyaU+lN2pO++Ea4RsIAooNFqD0L0
         JcC7zLSRHdINk/6EdQb+lfMGfKiVAvBTJVAskwW+iLqZdlnbqn++NBD+LampK5B0BRL1
         i8uCMayWzG8N/atJRd4OGTimGu4XEdr0vREW2jZ8bq5afMwXbuZlg8xinxcGuATDuo/f
         eHeFY2GDckd76tPFTU4CPMfcJ48MD1Gq5vp8JXIC+qQ1AbOi3tlvR0Or2t8IVs9W+2uu
         0VlQ==
X-Gm-Message-State: AOUpUlGY1T6aeb7/ezUBtyrGKSCGyFyTVrjCPsBNHeb0dYB8MoLE3X2l
        b0RtwwZ2Bhy9V8NffTULyN7Syw==
X-Google-Smtp-Source: AAOMgpchGzO3oWlNEGMj4bhL9dxexTpGJ5dpgEP8XGyqlhcUSSQ01LBNQT77QWqEqD/2mYPI5XHhyA==
X-Received: by 2002:a5d:438d:: with SMTP id i13-v6mr16254245wrq.156.1532551057170;
        Wed, 25 Jul 2018 13:37:37 -0700 (PDT)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id h17-v6sm11320010wrq.73.2018.07.25.13.37.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Jul 2018 13:37:36 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.86_2)
        (envelope-from <jgg@ziepe.ca>)
        id 1fiQXN-0001U7-3P; Wed, 25 Jul 2018 14:37:33 -0600
Date:   Wed, 25 Jul 2018 14:37:33 -0600
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Varsha Rao <rvarsha016@gmail.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Nicholas Mc Guire <der.herr@hofr.at>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: infiniband: core: Remove extra parentheses
Message-ID: <20180725203733.GA5678@ziepe.ca>
References: <20180725184356.3754-1-rvarsha016@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180725184356.3754-1-rvarsha016@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 25, 2018 at 08:43:56PM +0200, Varsha Rao wrote:
> Remove unnecessary parentheses to fix the clang warning of extraneous
> parentheses.
> 
> Signed-off-by: Varsha Rao <rvarsha016@gmail.com>
> ---
>  drivers/infiniband/core/cma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-next, thanks

Curious, what configuration are you using clang with? I'd like to have
it run here..

Jason
