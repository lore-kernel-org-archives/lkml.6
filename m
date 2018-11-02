Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4889C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 22:15:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A261220831
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 22:15:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="cdRCDy7O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A261220831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728409AbeKCHYv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 03:24:51 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46393 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbeKCHYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 03:24:51 -0400
Received: by mail-pg1-f195.google.com with SMTP id w7so1530778pgp.13
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 15:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qj0b57hV9EgqkQpKOK/D4WFdGabmpNEqOgCWjUOkSsU=;
        b=cdRCDy7OLv5SPxHiKjSoLoi93iTlWmC/ZPTRloPlVY0LazUdu83F+q0qA32O9lL7jB
         s2DmmU2w1QhxCXVkShvbeyoEC+0X9mu/CNrEqEX5QT010VUAEfZeF+9OJmHt98m8wFcu
         j4Z+HMkDEtqpy9xuZCPU6a8jrHWbbmLM/wyBl6PYpJsRAZWJVUADjNSu0FYPcBeEkwgy
         79/iRQRubL7k2i7ozRZWinOS+aIwzVmtEcGD3KvPCMDxKptZJGovaZ1zcFjX5DCqcKv2
         oi8QaNqI5zxxXwuHRPGnnFa5g7xTT4kVJRfEfDTpvGozrGb8T/HdkqVojKjO3AqhEgyo
         WPVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qj0b57hV9EgqkQpKOK/D4WFdGabmpNEqOgCWjUOkSsU=;
        b=C4fYy5/7UBtLErTm5k0eG8u6AKfKVm/IQ4VIGb78TPwFvCQTIzw9aN7ugC5b5bdPd5
         J/Z/x6dqtxTnAbLx5+Kt/Mw/erw2oWtxeOW60BEIm7IlaiQDyj1yYh9RoiVSMXNVHyXb
         w7F9BUbpgjXFHIB99ViNChnzj0j7B2+SCdQW/MjkTfUotf+mjteOLFRfwDHf6pbeYAUe
         ytlHg0MsYNrHUpwBqlYaQy18OsVmiTXcIwv814spvI5DkaaBnj33kdgKHNM59/nmdJXm
         ieFfYT020L2ormPTZq7d+l4pGCL9z/r6AecxOLLkL7F1giWRd+i11Kd4polKtBNptlj6
         Cvzw==
X-Gm-Message-State: AGRZ1gLtU9B2kOycbMdTmc57gpBi529DklwO2cpgds5Qiw/bmiNAWuu/
        t4yTvBaid459Apz4ZF3f29Lblg==
X-Google-Smtp-Source: AJdET5e7jh74USg1dmHkiCrbBEVHbkALQJ4llWaZQyjt5/MVPKvLnZ8Fc5CUf+uoPy8/bthv0KUKVg==
X-Received: by 2002:a62:6143:: with SMTP id v64-v6mr13556571pfb.125.1541196954870;
        Fri, 02 Nov 2018 15:15:54 -0700 (PDT)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id z63-v6sm39877896pfz.31.2018.11.02.15.15.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 02 Nov 2018 15:15:53 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1gIhjM-0002xd-My; Fri, 02 Nov 2018 16:15:52 -0600
Date:   Fri, 2 Nov 2018 16:15:52 -0600
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Saeed Mahameed <saeedm@mellanox.com>
Cc:     "eric.dumazet@gmail.com" <eric.dumazet@gmail.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Moshe Shemesh <moshe@mellanox.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Boris Pismenny <borisp@mellanox.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        Eran Ben Elisha <eranbe@mellanox.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Ilya Lesokhin <ilyal@mellanox.com>,
        Kamal Heib <kamalh@mellanox.com>
Subject: Re: [PATCH] net/mlx5e: fix high stack usage
Message-ID: <20181102221552.GC17096@ziepe.ca>
References: <20181102153316.1492515-1-arnd@arndb.de>
 <9f214f12ec89020ceb14c1aec25b3a0d968507aa.camel@mellanox.com>
 <2727f37b-1742-5532-317e-3be8a984266b@gmail.com>
 <4ebfc3aeb5335a1f671602f9a906f948c39a30da.camel@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ebfc3aeb5335a1f671602f9a906f948c39a30da.camel@mellanox.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 02, 2018 at 10:07:02PM +0000, Saeed Mahameed wrote:
> On Fri, 2018-11-02 at 14:39 -0700, Eric Dumazet wrote:
> > 
> > On 11/02/2018 02:05 PM, Saeed Mahameed wrote:
> >  
> > > temp will be mem copied to priv->stats.sw at the end,
> > > memcpy(&priv->stats.sw, &s, sizeof(s)); 
> > > 
> > > one other way to solve this as suggested by Andrew, is to get rid
> > > of
> > > the temp var and make it point directly to priv->stats.sw 
> > > 
> > 
> > What about concurrency ?
> > 
> > This temp variable is there to make sure concurrent readers of stats
> > might
> > not see mangle data (because another 'reader' just did a memset() and
> > is doing the folding)
> > 
> > 
> > mlx5e_get_stats() can definitely be run at the same time by multiple
> > threads.
> > 
> 
> hmm, you are right, i was thinking that mlx5e_get_Stats will trigger a
> work to update stats and grab the state_lock, but for sw stats this is
> not the case it is done in place.

That was my guess when I saw this.. the confusing bit is why is there
s and temp, why not just s?

> BTW memcpy itself is not thread safe.

At least on 64 bit memcpy will do > 8 byte stores when copying so on
most architectures it will cause individual new or old u64 to be
returned and not a mess..

32 bit will always make a mess.

If the stats don't update that often then kmalloc'ing a new buffer and
RCU'ing it into view might be a reasonable alternative to this?

Jason
