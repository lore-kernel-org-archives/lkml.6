Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5F80C00449
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 02:48:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55EBA213A2
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 02:48:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="TDKP1yiy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55EBA213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727167AbeJDJjU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 05:39:20 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42515 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbeJDJjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 05:39:20 -0400
Received: by mail-pf1-f195.google.com with SMTP id f26-v6so2458667pfn.9
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 19:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=t1hDd0ExyTDcqpGEMu3OKnUa2NyQjAsVXLWsVgMX2do=;
        b=TDKP1yiyAbq7j8edp9oyKxm1bYn0/5TsJzfhOpi/AhSB/MtV4HTPqKVVACkjEugOgv
         l0Q6Jx6g4St+/f8DNb+7wgAYbsvAbXcJ1FpaqynoQXuWFN/nyYnCbgEMsPNb9TQwnDiS
         SX21manvC+7JaxX89+ELdrVEgpwkFRUSrzQPw55RAOlbAKogd8One+9rIvauCxCq/mPf
         U7m+chtGbfGpxeXOQIvj4M7DGrIujbvQ2HqM0wRVVDypnZE0WteAqUZWbG7O+gQy+LhI
         rfZQtC0S6T4DoDsz8JSCjk7jQoGaYLGao6htHdxIRQL0oq0aPe1h7VDCRGlynbzWUuvs
         hNRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=t1hDd0ExyTDcqpGEMu3OKnUa2NyQjAsVXLWsVgMX2do=;
        b=HG8lcjnOX2NcBA8R7CCHKkfKd4/vUrFzM4akKY8CgA8AXbC3eUvxsiaAiGKAqsuljc
         hwvLtNupS31X3Hv6nNdpSTo6tD7RHRk4jT682Fs5nHkrIAi2NH1NFugPS4hdwa8w8Dkt
         8Zzb99+RzdrJbdYyW/SdAU7e9erdyvF+ZHyvmYGUF5px30NPvWn73hhLh3LSkQycnRQY
         RGgTrXS/t7nCEWb4XTloN1oqWYsaRbl7Is59v9L66wDza22DUr9cILV/f6p+kRqYuuWa
         DunimGBWodsHrzHyPcSw9hf3WHq62zcm1zUSUq92sEpX3fZh8SzjytwsV0jXFON/yqoc
         ytHQ==
X-Gm-Message-State: ABuFfoiE+0uFD2474QmZPaDF++tukc9eYrnqxON5pe+8Bw0NEBGXhgdj
        9MoCvRvxLvQxiGm4i4KF18HtFw==
X-Google-Smtp-Source: ACcGV61zG2NlaXzdZV/Ta/ni4U7T648QF/+GrdnbvOmXOUtLqJQTyhYv/7KodFVgMul0XlBBA/+KJg==
X-Received: by 2002:a62:798e:: with SMTP id u136-v6mr4422849pfc.95.1538621294203;
        Wed, 03 Oct 2018 19:48:14 -0700 (PDT)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id a1-v6sm6104244pfc.28.2018.10.03.19.48.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Oct 2018 19:48:13 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1g7tgS-0002Y4-QO; Wed, 03 Oct 2018 20:48:12 -0600
Date:   Wed, 3 Oct 2018 20:48:12 -0600
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Parav Pandit <parav@mellanox.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "leon@kernel.org" <leon@kernel.org>,
        Daniel Jurgens <danielj@mellanox.com>,
        "dledford@redhat.com" <dledford@redhat.com>
Subject: Re: [PATCHv1] RDMA/core: Check error status of
 rdma_find_ndev_for_src_ip_rcu
Message-ID: <20181004024812.GA18596@ziepe.ca>
References: <1537542022-4451-1-git-send-email-parav@mellanox.com>
 <VI1PR0501MB2271905AAC309C636C0B63B7D1EA0@VI1PR0501MB2271.eurprd05.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI1PR0501MB2271905AAC309C636C0B63B7D1EA0@VI1PR0501MB2271.eurprd05.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 04, 2018 at 02:28:54AM +0000, Parav Pandit wrote:
> Hi Doug, Jason,
> 
> > From: Parav Pandit <parav@mellanox.com>
> > Sent: Friday, September 21, 2018 10:00 AM
> > To: linux-rdma@vger.kernel.org; linux-kernel@vger.kernel.org;
> > leon@kernel.org; jgg@ziepe.ca; syzkaller-bugs@googlegroups.com; Daniel
> > Jurgens <danielj@mellanox.com>; dledford@redhat.com
> > Cc: Parav Pandit <parav@mellanox.com>
> > Subject: [PATCHv1] RDMA/core: Check error status of
> > rdma_find_ndev_for_src_ip_rcu
> > 
> > rdma_find_ndev_for_src_ip_rcu() returns either valid netdev pointer or
> > ERR_PTR().
> > Instead of checking for NULL, check for error.
> > 
> > Fixes: caf1e3ae9fa6 ("RDMA/core Introduce and use
> > rdma_find_ndev_for_src_ip_rcu")
> > Reported-by: syzbot+20c32fa6ff84a2d28c36@syzkaller.appspotmail.com
> > Signed-off-by: Parav Pandit <parav@mellanox.com>
> >  drivers/infiniband/core/addr.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/infiniband/core/addr.c b/drivers/infiniband/core/addr.c
> > index c2ca9e4..3c07eeb 100644
> > +++ b/drivers/infiniband/core/addr.c
> > @@ -513,8 +513,8 @@ static int rdma_set_src_addr_rcu(struct
> > rdma_dev_addr *dev_addr,
> >  		 * loopback IP address.
> >  		 */
> >  		ndev = rdma_find_ndev_for_src_ip_rcu(dev_net(ndev),
> > dst_in);
> > -		if (!ndev)
> > -			return -ENODEV;
> > +		if (IS_ERR(ndev))
> > +			return PTR_ERR(ndev);
> >  	}
> > 
> >  	return copy_src_l2_addr(dev_addr, dst_in, dst, ndev);
> 
> Can you please review this fix?  I got below report from syzbot that
> it tested the patch and reproducer didn't trigger.

It is very strange, but this patch does not show up in rdma's patch
works.

This happened to Dennis as well for one patch, I'm afraid as a general
rule, people will need to check that patchworks has thier patches, and
maybe talk to LF IT about why things have gone missing. 

I would guess it is some spam filter issue?

I have applied this patch from my email.

Jason
