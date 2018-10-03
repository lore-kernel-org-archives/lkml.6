Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E485C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 22:35:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B8562089F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 22:35:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="j8mUx8PQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B8562089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727264AbeJDFZp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 01:25:45 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46852 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726668AbeJDFZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 01:25:45 -0400
Received: by mail-wr1-f68.google.com with SMTP id a2-v6so742220wrc.13
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 15:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9gw0VG4SmtfMjoiQrL3PUyqLDohd6eBqw2yb36naa94=;
        b=j8mUx8PQuFAakoPp/ZlJuLqCaseqWisPuc/eFbUr8qTZizrYbURoqjOfwF0kfGsb/N
         1ZAoFT3THe1oi09n39yA9MCSfE0owEfZ8Gitj7MVjZp0XdptGCh0njqUy/3ejNFYoiOF
         GAOiJyfLJn5f7CZG+voS/Hw50pEpdMRvSasm+FJgwBQ6kfzpq1EZn7PwdeMw4ziex8GR
         lZ9yJBfNt2MoRncRQoUOGTAzFU8LTD4k5GqTPx4BrLf634F1ctZm9DlHwZGn5jCPYg1e
         4ynzpKWM1AFxNxR5eNbOzoFsllvc89yS3zaRbplS5pC73t17HIl8XXXtW8o+gfmPa659
         dQ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9gw0VG4SmtfMjoiQrL3PUyqLDohd6eBqw2yb36naa94=;
        b=ITnzZ9M4vCoHvJALwsuXIkt3yyQvQXiGx192z6BcMYjyZESxCE/fFAb7/lk3FQzCfV
         j+LJgJjXWKNbvPKWFL2GAXZsebzW972bu3GQFhMuaYfzol96xgV54KFDpNV9ekxggK63
         HOhVjHFQJX5s+Lpv9PglXxiCetBgfoWDgAlHSN0vXcxzZ1fyYZaFNSybnY16dZ8qd4hU
         8blCVSIE9SYXfkYW1aJycNYWyHedXdik5RZmKPttZcJ2JolRh+8Vic4f3AOOi7XqMnPn
         uVo0uIrsx0HDJ2LLOKlzaAdwyuZMIIVrcmxjywCM6GURTJ7tOnmBLwUVDiZm01BUE1fR
         ydIw==
X-Gm-Message-State: ABuFfogzmFkUeVHVwSQRfsuuRS0g08rrlC62xreWiJHYeNUFR16eTNlF
        vk84OatjE+e7iGVDpfoqnneAAw==
X-Google-Smtp-Source: ACcGV61v42q3v7vtsr97UmFfvei+DJdzx8RsVI9b7lrO+V5Rhw103uwiFz5Z755PtEX3cstqIjBk9w==
X-Received: by 2002:a5d:5588:: with SMTP id i8-v6mr2644523wrv.38.1538606122824;
        Wed, 03 Oct 2018 15:35:22 -0700 (PDT)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id o7-v6sm2825246wma.17.2018.10.03.15.35.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Oct 2018 15:35:21 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1g7pji-0002Gk-5A; Wed, 03 Oct 2018 16:35:18 -0600
Date:   Wed, 3 Oct 2018 16:35:18 -0600
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] IB/mlx4: Avoid implicit enumerated type conversion
Message-ID: <20181003223518.GA8700@ziepe.ca>
References: <20180924195716.30848-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180924195716.30848-1-natechancellor@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, 2018 at 12:57:16PM -0700, Nathan Chancellor wrote:
> Clang warns when one enumerated type is implicitly converted to another.
> 
> drivers/infiniband/hw/mlx4/mad.c:1811:41: warning: implicit conversion
> from enumeration type 'enum mlx4_ib_qp_flags' to different enumeration
> type 'enum ib_qp_create_flags' [-Wenum-conversion]
>                 qp_init_attr.init_attr.create_flags = MLX4_IB_SRIOV_TUNNEL_QP;
>                                                     ~ ^~~~~~~~~~~~~~~~~~~~~~~
> 
> drivers/infiniband/hw/mlx4/mad.c:1819:41: warning: implicit conversion
> from enumeration type 'enum mlx4_ib_qp_flags' to different enumeration
> type 'enum ib_qp_create_flags' [-Wenum-conversion]
>                 qp_init_attr.init_attr.create_flags = MLX4_IB_SRIOV_SQP;
>                                                     ~ ^~~~~~~~~~~~~~~~~
> 
> The type mlx4_ib_qp_flags explicitly provides supplemental values to the
> type ib_qp_create_flags. Make that clear to Clang by changing the
> create_flags type to u32.
> 
> Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  include/rdma/ib_verbs.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-next, thanks

BTW, how are you compiling with clang?

Jason
