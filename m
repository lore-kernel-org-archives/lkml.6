Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0FB3C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 21:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9109E2073D
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 21:37:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="CbApuUev"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9109E2073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727731AbeIFCJS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 22:09:18 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45409 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727586AbeIFCJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 22:09:18 -0400
Received: by mail-pg1-f194.google.com with SMTP id x26-v6so4055846pge.12
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 14:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5k1qAKsxRepfHCMmt2ib2d/mR2Lb2aErIkq7H2Xa64s=;
        b=CbApuUevcKry8d0J5SlSjoiIh8JQgbCMZ305XEk1/vB39oC0jO2CRzrQdo0mZ/UXMV
         eIVjCRSKxjAoPpFZXGaxJFYXHFMV+WBp8jCGxkZo5WFSSSrOevnIYK9rbHjp3hGdW81L
         Jne4g9a5dwO6Qt73DzlZOpp29YPjpwBZUs2Equt/VdbDhIdgVJ47wnyhgnZutQhxU1Y0
         0X/kj3JSjrg90FAPTjsO0qrXcT/k2oqR/JxwMJd9xDJ1+rLJZShSMHYKzBAMydX2Z9rB
         PQyano8X+osttVX/liY+2Gsufy/P7M8wQoGW7Bz//YqWVicPIQIZ7T1NjpqMbBx24wlH
         RcHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5k1qAKsxRepfHCMmt2ib2d/mR2Lb2aErIkq7H2Xa64s=;
        b=sFUaIlVt/Pd+79gH6wlAZrIr4hxEtmJXo5ivgLeMFvT614CtFHBvQtvo3eBYHTM43P
         lTdcK4VqGS0wnIdt/Gkn1QkS9uj7FATRilpiIf4Dj6Z0OcdtQ6zZ2KR561qP63qPuP19
         HPh55AmNtZwfLMRq6exL5uq5aAlWd39RFXPpxUM5aEeQwAnagY74qr2tBqFohkbEBw8y
         lwQ59xDzwQ7XCpw1cSCB+7A1ISGhdjSznWEX/OduFxrLCKJ+43xI7sqN/s5xwZrbK4vs
         4xJLFjhWSVQbZ5ANsc1B7jOmmQkgxtakEz/M879xTw8YKarxltThAy4JISDYJv//xbsb
         nYOQ==
X-Gm-Message-State: APzg51CU2fblf3l5iIRHurfzjWMKYtM+DRTUXlYS8EaQquVTyMTsAPKG
        F0EsNW50bZFOw1uOJWFSuG8e+w==
X-Google-Smtp-Source: ANB0VdbKAcxp1+iY+KHGF9/VwXVmgWfRyuiIESqcH3MYu+XF6jHoyfVlXjr+HXDof/9f60pkDCyT4Q==
X-Received: by 2002:a62:411a:: with SMTP id o26-v6mr43135446pfa.111.1536183433938;
        Wed, 05 Sep 2018 14:37:13 -0700 (PDT)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id n83-v6sm4613125pfk.19.2018.09.05.14.37.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Sep 2018 14:37:13 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1fxfU8-0004br-9Z; Wed, 05 Sep 2018 15:37:12 -0600
Date:   Wed, 5 Sep 2018 15:37:12 -0600
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Joe Perches <joe@perches.com>
Cc:     Selvin Xavier <selvin.xavier@broadcom.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        Somnath Kotur <somnath.kotur@broadcom.com>,
        Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/bnxt_re: QPLIB: Add and use #define dev_fmt(fmt)
 "QPLIB: " fmt
Message-ID: <20180905213712.GA17698@ziepe.ca>
References: <fe07a1dbe1f6699b4a64444505ae2dbacc2155cc.1533926549.git.joe@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe07a1dbe1f6699b4a64444505ae2dbacc2155cc.1533926549.git.joe@perches.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 10, 2018 at 11:42:46AM -0700, Joe Perches wrote:
> Consistently use the "QPLIB: " prefix for dev_<level> logging.
> 
> Miscellanea:
> 
> o Add missing newlines to avoid possible message interleaving
> o Coalesce consecutive dev_<level> uses that emit a message header to
>   avoid < 80 column lengths and mistakenly output on multiple lines
> o Reflow modified lines to use 80 columns where appropriate
> o Consistently use "%s: " where __func__ is output
> o QPLIB: is now always output immediately after the dev_<level> header
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> Acked-by: Selvin Xavier <selvin.xavier@broadcom.com>
> ---
>  drivers/infiniband/hw/bnxt_re/qplib_fp.c   | 130 +++++++++++------------------
>  drivers/infiniband/hw/bnxt_re/qplib_rcfw.c |  51 ++++++-----
>  drivers/infiniband/hw/bnxt_re/qplib_res.c  |  29 ++++---
>  drivers/infiniband/hw/bnxt_re/qplib_sp.c   |  57 ++++++-------
>  4 files changed, 116 insertions(+), 151 deletions(-)

Applied to for-next, thanks

Jason
