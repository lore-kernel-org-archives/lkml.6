Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ECC8C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 15:53:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8C8A216E6
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 15:53:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="LN1bHqgs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8C8A216E6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727754AbeHHSNY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 14:13:24 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:46161 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727141AbeHHSNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 14:13:21 -0400
Received: by mail-pl0-f66.google.com with SMTP id t17-v6so1205003ply.13
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 08:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LpamEgG78zeZqPhI/INx5O8fGWwvu34ertMGVPlLrN0=;
        b=LN1bHqgsXDRwT32n1HXdJpLuBs7hvtTDzaR8n2RFQKIQSuKZiLgF3THwEVXG2S3rdv
         jWWOU8AYLzjsS5JJ/VP1T5yUvZ694BvB5tljqjVSTarbL3anbIgCOqRQPkkSDS/DQhiJ
         yeY/4lgyvIP3aQa8dzGZbR3G/rZKcx1qw2DiWVKE206LhPExc3aHkz+Gqowkd9pqaZk/
         vG1/HaAnCR2ZKJ54kKC5M9SjXB8cTvc6htFDgDHyniKYMalbjFmZ9mjEN2LJaOQS0sZ5
         RMb4h5va6MmyM10V1vScPTbTHI7BvJvDdubop1Bf1QQuh9lPPmNfN32RO9+CuQ31KxQO
         m1bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LpamEgG78zeZqPhI/INx5O8fGWwvu34ertMGVPlLrN0=;
        b=SBgbz4J4BAKDpBuykUFAywcWE5p0Govqal9HjR0oO2yfWHirLHYy1rkeX2/VQbHVTZ
         OL3cL6aBngu5aIwylXi+ukMQhlUGccVbhReBpxokumgXkwo5haZ4A4MIkdqFWZndNcTv
         OdfHTyExoxU/q/XMHN6A+ACv0xZ5J95sVLMpLE/pUl7iqEfA2mS1jh4lbSdtiAzWdOoO
         Wa6qGSsQlvcKwg+4n+rkeXiNVo3/3Krg20gYzTa+7ReyeiGCgMx5iPPez9AZorFfkxIm
         nDJCMKDYQIvk8zR7sDKyoGk9Lbi+7ifrCnMxz7opBi755cN9cTlFe0XuJlmyUJHpPUJk
         Pg9w==
X-Gm-Message-State: AOUpUlH7xwVyv5RwowOfe7/prnUc0GvuiiQX9bDWwcdmVGz1L49MSLfW
        2rZ9eYnsY0lrpPZgvAYUy073og==
X-Google-Smtp-Source: AA+uWPwfwNXvb05RN3STFOwq0ROo5FsDzAEKr9FLjjLVUXZ4h1GQVvIXtBEIyVkHOwY22KQCBvSeeg==
X-Received: by 2002:a17:902:e3:: with SMTP id a90-v6mr3165701pla.227.1533743585449;
        Wed, 08 Aug 2018 08:53:05 -0700 (PDT)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id j5-v6sm5607694pff.139.2018.08.08.08.53.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 Aug 2018 08:53:04 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1fnQlj-0001lb-Ch; Wed, 08 Aug 2018 09:53:03 -0600
Date:   Wed, 8 Aug 2018 09:53:03 -0600
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Kees Cook <keescook@chromium.org>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Leon Romanovsky <leon@kernel.org>,
        Bart Van Assche <Bart.VanAssche@wdc.com>,
        Doug Ledford <dledford@redhat.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH rdma-next v4 0/3] overflow.h: Add left-shift helper
Message-ID: <20180808155303.GA6761@ziepe.ca>
References: <20180801212541.22889-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180801212541.22889-1-keescook@chromium.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 01, 2018 at 02:25:38PM -0700, Kees Cook wrote:
> This adds the left-shift overflow helper, selftests, and first usage.
> 
> -Kees
> 
> v4:
> - actually fix docs typo
> - rename to check_shl_overflow()
> v3:
> - add even more test cases (type mismatches, more signed overflows).
> - fix documentation typo on argument name.
> v2:
> - swap out selftests with framework from Rasmus, add lots more tests.
> - drop double-assignment in helper.
> 
> 
> Jason Gunthorpe (1):
>   overflow.h: Add arithmetic shift helper
> 
> Kees Cook (1):
>   test_overflow: Add shift overflow tests
> 
> Leon Romanovsky (1):
>   RDMA/mlx5: Fix shift overflow in mlx5_ib_create_wq

Applied to the RDMA for-next tree, thanks

Jason
