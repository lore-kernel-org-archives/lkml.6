Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCBB2C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 22:48:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F0CF20879
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 22:48:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="YrkLVVSZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729940AbfABWsk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 17:48:40 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:32902 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726875AbfABWsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 17:48:40 -0500
Received: by mail-pf1-f194.google.com with SMTP id c123so15797198pfb.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jan 2019 14:48:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3WhVCQhZOtORYuh+/dnVCObSLZZhAbXOiiQqWuucFIU=;
        b=YrkLVVSZkUSQWwPRQ9+2McOfiItzA4uSkOYIF8N2SW14nXeftAP6G3HizJDf/in5+P
         nmu72Dr5tuh3rGvn7YpIByLAVRdrpiKLmfz/ec/tmxVwoJVh1I9CfCgaF/dLkMyyoZPd
         mYu1tft6s7JJUwhuVaRL+g/vJQRIGzW8PyyqEkjTA1Gp9eJKLih5P21Igj/JksHmLAx5
         rmb55EEs1jnO1peoZE9d5F/m1SQhoeZFGTAwpj46iPboxViEIMWbD21i3g2G7IKt6quP
         vKJ5yg5NU17PuYX0G+RtFYb1WR1BKbmqqMxgGzUFcazTtVUYbagJ1OXGRSqlV8WE43P9
         w63w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3WhVCQhZOtORYuh+/dnVCObSLZZhAbXOiiQqWuucFIU=;
        b=e1ZryUfGU+Y9HzBTX+XdkkyJKUpVwL99hnbtS+h5BRdvuYcf6VSDtHnZQb0pOp1Xri
         R5j6ggdwiE9aKe7xJyXkB1LifNVGRPOMXTdKwwT/g81ES48x8/3zaiSTNgNehSY2u7gT
         XWGujm/H86WUut69Ja4ySE8dgFRXP5Z/DaldIUGxJK07tCMnT2ssEjq6ZkdK1+Zi1yqj
         TebjVgxTskO/xhCzKD8sYI0mZKrO5SmC3v1q2EOT4HMZ2oVnEpLpyfljoghon+7Fi4st
         mY3pk2pca0QGP+uXrtWYmiTwXO4RdoT7SyeVQGDm5a339oxomYgICjjggvYg53/G4SKn
         S6Ow==
X-Gm-Message-State: AA+aEWY+nWYa3qixGuMtsX7pB6MtKx+jbENircDpfn+DfWvCrFM4pG29
        SiWvF7xbBwfdV5eatkrHPoeQIw==
X-Google-Smtp-Source: AFSGD/WtUFVlfBXHzbhJ1h97EoWmM+O2AVFoir6FdSxxcJQ0LqkyJitgF48z1rhC7LEbD2SQb5fN3Q==
X-Received: by 2002:a62:6408:: with SMTP id y8mr45745510pfb.202.1546469319515;
        Wed, 02 Jan 2019 14:48:39 -0800 (PST)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id u137sm94810084pfc.140.2019.01.02.14.48.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 02 Jan 2019 14:48:38 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1gepJV-0007Ie-HN; Wed, 02 Jan 2019 15:48:37 -0700
Date:   Wed, 2 Jan 2019 15:48:37 -0700
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Julia Lawall <Julia.Lawall@lip6.fr>
Cc:     Doug Ledford <dledford@redhat.com>,
        kernel-janitors@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/20] IB/ipoib: drop useless LIST_HEAD
Message-ID: <20190102224837.GA28029@ziepe.ca>
References: <1545555435-24576-1-git-send-email-Julia.Lawall@lip6.fr>
 <1545555435-24576-7-git-send-email-Julia.Lawall@lip6.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1545555435-24576-7-git-send-email-Julia.Lawall@lip6.fr>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 23, 2018 at 09:57:01AM +0100, Julia Lawall wrote:
> Drop LIST_HEAD where the variable it declares is never used.
> 
> Commit 31c02e215700 ("IPoIB: Avoid using stale last_send counter
> when reaping AHs") removed the uses, but not the declaration.
> 
> The semantic patch that fixes this problem is as follows:
> (http://coccinelle.lip6.fr/)
> 
> // <smpl>
> @@
> identifier x;
> @@
> - LIST_HEAD(x);
>   ... when != x
> // </smpl>
> 
> Fixes: 31c02e215700 ("IPoIB: Avoid using stale last_send counter when reaping AHs")
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
> Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
> ---
> Successfully 0-day tested on 151 configurations.
> 
>  drivers/infiniband/ulp/ipoib/ipoib_ib.c |    1 -
>  1 file changed, 1 deletion(-)

Applied to rdma for-next thanks

Jason
