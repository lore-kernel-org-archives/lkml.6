Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4372DC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 22:34:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E93432154B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 22:34:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="QGyFnELh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E93432154B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbeI0Etp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 00:49:45 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35715 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbeI0Etp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 00:49:45 -0400
Received: by mail-pf1-f193.google.com with SMTP id p12-v6so374064pfh.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 15:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=x/ooLGL5YzTTaMSlnVtFBY0rcZxQULlQxEh/tigD3ac=;
        b=QGyFnELh2NZTcHOhrorHz/MKfNwd/bYFa1HTd7qJriNF6nNnjO5sg/v653K5p38w8E
         8nU55lPIdiOzL+FEbbYSkYq9oWEwxMhDUxfrZpk/MoDVCPTK2+7grpB2COUmMt9MiRNO
         +YMmIfv3WN661AvEirvpq/Q1KQ9xIGylxwJvFTlE6Yo6OJkfcM4XRjZRxENKZHcCk/m9
         TXbd5FAgWld2TI+uUopnc5+W8aagmS2E4bLIbjT+QFeAocP2LFz3GraE7H2Fg9sf6+ig
         7G3H+y8j0D+IwmySUsYrTJMDLNuQ3gCfBXHPyUwx7WcjDIdnOBM6NeOqRNA+7MUirLdl
         Ffwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=x/ooLGL5YzTTaMSlnVtFBY0rcZxQULlQxEh/tigD3ac=;
        b=V/Sg0Eduu3P1lwZBJ/iYwEeSNiKZhIP2V2N6YAEoR3KrNTo0JVUwZhqzFlvb0PvJOM
         8kLC8/whQWj5qGHrN/9slWuMXSxfalB3p3bXv1SOhU+3QROYU+yBdP1Z6d2/EtsPMbqn
         ybPe65uGKkhM88f2+fmH4DFVXhbFcJpGrNXQ3bjfvzj/ZvNFobCN0W9W3BpTz6z/JqhM
         bWLTJm1ckTefhwqAieHDQ24WY44j5cza31a/uDRKekIKCb58go/XS8Sr84cAizgtiAkF
         1UgGyf364+SRE1Gcm+ua3kUP45g3WK2fvACrzYFtPAWEMFarU+d74QKlEJG3ETRAuHan
         1puA==
X-Gm-Message-State: ABuFfojZLJUpF92LAeqoo2YsKSK58flwFAVyIrCaVN89sE5/my00RkxV
        xjwffXqY1iQ2xlvBGY4oQmpKFQ==
X-Google-Smtp-Source: ACcGV60Z0WsNPSuF4vY43mUIEkkXImIzBUEoJpv19UwHlCMkHjLexmZSrwlu7eRRgyCjs/dl4y9a+A==
X-Received: by 2002:a17:902:b682:: with SMTP id c2-v6mr7806881pls.171.1538001276035;
        Wed, 26 Sep 2018 15:34:36 -0700 (PDT)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id 22-v6sm186581pfl.126.2018.09.26.15.34.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Sep 2018 15:34:34 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1g5IOA-0003MG-CW; Wed, 26 Sep 2018 16:34:34 -0600
Date:   Wed, 26 Sep 2018 16:34:34 -0600
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Colin King <colin.king@canonical.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-rdma@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IB/mthca: remove redundant inner check of
 mdev->mthca_flags
Message-ID: <20180926223434.GA12887@ziepe.ca>
References: <20180926122608.29853-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180926122608.29853-1-colin.king@canonical.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 01:26:08PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The inner check for mdev->mthca_flags & MTHCA_FLAG_MSI_X is redundant
> as this is already true because of the previous identical check in
> an outer if statement.  Remove it
> 
> Detected by cppcheck:
> (warning) Identical inner 'if' condition is always true.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/infiniband/hw/mthca/mthca_main.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Applied to for-next, thanks

Jason
