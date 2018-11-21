Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CE7DC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 22:59:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6E50206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 22:59:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="kOMvrFrR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6E50206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390435AbeKVJgW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 04:36:22 -0500
Received: from mail-pl1-f181.google.com ([209.85.214.181]:44405 "EHLO
        mail-pl1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390422AbeKVJgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 04:36:22 -0500
Received: by mail-pl1-f181.google.com with SMTP id s5-v6so7501605plq.11
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 14:59:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=G8Lcqx3cUpoFYRuzhAQkrxjzq6Z0cu78ABUoX1o5ZGE=;
        b=kOMvrFrRFWw/jCwPKbpZ2GTDeLYzqhUYk4LUKujYnULWXgLMhcsdLSlyN6uYWUQYgz
         7BLYOgIOlsyTLqKM81yNpHonWoEAywYkboHys59Cm7oFlxDkUpao7lrA1ok5AqMSfavB
         RNSodS15a8N5RGQgDMOMZeV2hZmsENGqVMAAytvPVL7zjKgKWlgfTL7RZbkS6FFm/iYg
         e0AVxbb2yOapYTN8NUbbWTYacF6BBFB9jaoiJ037huwMUAT2bQ9DHQeu3Ao6v9XOujuW
         z7F2FiGItGRIxxVheoyqeJ87TX+c2d8/UwlrxR/fQKsE+DSk8gyOKPVwxr3zdcoD0sk3
         QeNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=G8Lcqx3cUpoFYRuzhAQkrxjzq6Z0cu78ABUoX1o5ZGE=;
        b=TByoU2A5ChcvFqIIqffjOFaFKLvPXVKFNXJnSf4LIDshUZjB4z4DSeo25I37Fgou7+
         0MFAYybph8xW8/ywhxWKsAU+xjhllKak09b5jDN4ugx08lYTh9e3Z2tHUaB7TIs1bJfs
         Rg8vfKfjeVi86lT1N0gmFBdTxhuBDGNxGLYve7r1LPhKrxDSz/LgAjn2C+adHVwbbP5Q
         Hb5AftP8xQrQaRSOssFPV90ukWxKQIuEo510Rf33HdK+/rVv6JE7LcTclPMNKZVMx5Od
         Fyve6N+zUh/RqnmQsHvLi8jcFBdUKFG7RSayFYig2gCYSa1qESL7CYrzQSaBl2kZj0A2
         LELg==
X-Gm-Message-State: AA+aEWadUACKwkrqB+DLdzB5meF6Fh4aO9p050Htym5s8TeYLr+nLJ2M
        5N2Q28ikId21FByXX5ksLS0jxA==
X-Google-Smtp-Source: AFSGD/V+V+ShXY6xtkef78NaISSMuw5OipaVgpj0ZdVmzq2OVF4C1cGLnHGSMHLvx1J4Y3pxornPvQ==
X-Received: by 2002:a17:902:b118:: with SMTP id q24mr8815002plr.209.1542841194407;
        Wed, 21 Nov 2018 14:59:54 -0800 (PST)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id 78sm36656166pft.184.2018.11.21.14.59.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Nov 2018 14:59:53 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1gPbTM-0007nE-Rz; Wed, 21 Nov 2018 15:59:52 -0700
Date:   Wed, 21 Nov 2018 15:59:52 -0700
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Sabyasachi Gupta <sabyasachi.linux@gmail.com>
Cc:     swise@chelsio.com, dledford@redhat.com, jrdr.linux@gmail.com,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        brajeswar.linux@gmail.com
Subject: Re: [PATCH] infiniband/hw/cxgb4/qp.c: Use dma_zalloc_coherent
Message-ID: <20181121225952.GB29924@ziepe.ca>
References: <5be99a9e.1c69fb81.87c65.4ec2@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5be99a9e.1c69fb81.87c65.4ec2@mx.google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2018 at 08:51:59PM +0530, Sabyasachi Gupta wrote:
> Replaced dma_alloc_coherent + memset with dma_zalloc_coherent
> 
> Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
> Acked-by: Steve Wise <swise@opengridcomputing.com>
> ---
>  drivers/infiniband/hw/cxgb4/qp.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Applied to for-next

Thanks,
Jason
