Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90C56C43142
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 02:15:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F4F2208A2
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 02:15:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="YiiayDqn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F4F2208A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733042AbeHAD6V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 23:58:21 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37123 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732972AbeHAD6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 23:58:20 -0400
Received: by mail-pg1-f194.google.com with SMTP id n7-v6so10007495pgq.4
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 19:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=w5Z06nGU0ss0clzd6otDySQyFs3u9TkaDMFPn2WPorI=;
        b=YiiayDqnGrNC93aEgItciU7VoaysOFVw07PG8utMq1evWJ+SuM7LwItgnfNFU8kLKj
         M1PRGeQmNStjXVP2oSGOxCA53OnfgK5W5TolDmtkN8WL5N5iqIXSWZu7W7nYjLyksdDo
         FccKLTYn+r2VzclsnItHZRAEAxN9tueVP2SR1v+Npr+pyqvKSGNb7wl5UPBj9vnUnzJ5
         FzUKkVMcL+fhywMz7psrhvzUeh4cBh/R5P+a6TqLF7BQ2GhGwJu7WhgK8ATE4/N1J57Y
         umtjyOqgSrB6lwats8cGxUi1iVHvUJk8dMPhfTKYY2z5+9vGrnekz0ueNl5FX5M2AISc
         eN4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=w5Z06nGU0ss0clzd6otDySQyFs3u9TkaDMFPn2WPorI=;
        b=ukLbxqGtMu2hhS652nG31XNLP6Xu5E0mx6QkKP83wWklsw/TpboCsA3xDHasIVVR1w
         U2EuaFyeV3+5M7R3OmL1WkQZSUA2al0hJAkk8zIWOuNnFGuu3Xsb0W2m4ujLqMor+Wl+
         LJGNQU33PWvisHNzvMS77yDKQmyNAYE42/knM3disEuYasAqIsF8GLI5frhUIdq5NpjV
         K/XIfLRYf9ftnta1PZ066tAIMbLAsQbCvvaHnFsjlAEXWzFr2r2xrSBBlZbc4IYSB9+y
         Kdpv/n3FxCWeCoCuIwXjIQgZpw1kT1d+TQVql+LeZt7mn3E2HFmvESDf1f0hGqZnKK8f
         TM6g==
X-Gm-Message-State: AOUpUlG8ic/Md66N1AlcJuOz/7HFxRpcL26N6FkIMJoExZ5wPmZS1JGE
        Qv85qyN7ZKubNO8Kovt4vg3VD3K3bWs=
X-Google-Smtp-Source: AAOMgpcBmmaTwzLj4RO8y7Y9K5W6xKnX+Lh8IkVhLYXoLehmMQW2NPue50rPMfZ9rtgKHG8Ezs3Phw==
X-Received: by 2002:a63:380d:: with SMTP id f13-v6mr22860061pga.124.1533089709606;
        Tue, 31 Jul 2018 19:15:09 -0700 (PDT)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id 5-v6sm22627795pgc.86.2018.07.31.19.15.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Jul 2018 19:15:09 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.86_2)
        (envelope-from <jgg@ziepe.ca>)
        id 1fkgfM-0006VA-CL; Tue, 31 Jul 2018 20:15:08 -0600
Date:   Tue, 31 Jul 2018 20:15:08 -0600
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Kees Cook <keescook@chromium.org>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Leon Romanovsky <leonro@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        Bart Van Assche <Bart.VanAssche@wdc.com>,
        Doug Ledford <dledford@redhat.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] overflow.h: Add arithmetic shift helper
Message-ID: <20180801021508.GB31192@ziepe.ca>
References: <20180801000039.44314-1-keescook@chromium.org>
 <20180801000039.44314-2-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180801000039.44314-2-keescook@chromium.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 31, 2018 at 05:00:37PM -0700, Kees Cook wrote:
> From: Jason Gunthorpe <jgg@mellanox.com>
> 
> Add shift_overflow() helper to assist driver authors in ensuring that
> shift operations don't cause overflows or other odd conditions.
> 
> Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> [kees: tweaked comments and commit log, dropped unneeded assignment]
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  include/linux/overflow.h | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/include/linux/overflow.h b/include/linux/overflow.h
> index 8712ff70995f..69fc366ce865 100644
> --- a/include/linux/overflow.h
> +++ b/include/linux/overflow.h
> @@ -202,6 +202,37 @@
>  
>  #endif /* COMPILER_HAS_GENERIC_BUILTIN_OVERFLOW */
>  
> +/** check_shift_overflow() - Calculate a left-shifted value and check overflow
> + *
> + * @a: Value to be shifted
> + * @b: How many bits left to shift

The above @b should be @s

> +#define check_shift_overflow(a, s, d) ({				\

Should I run this series through the rdma tree?

Thanks,
Jason
