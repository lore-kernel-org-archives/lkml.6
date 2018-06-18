Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49A31C5AE59
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 17:26:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02D8F20020
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 17:26:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="O7fIOlGr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02D8F20020
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935527AbeFRR0J (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 13:26:09 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:43473 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754642AbeFRR0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 13:26:07 -0400
Received: by mail-pl0-f66.google.com with SMTP id c41-v6so9389099plj.10
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 10:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FTwPQv27wuexWI11SsYTJ/Jcg511fw1brRSTvDsMTCo=;
        b=O7fIOlGruQGihbbLzCi6atsw+N5C6WUO6gtxZr/ERnoCoziK1Wxk4XHdJgmOaBIqPQ
         HRj1Ww6Jc5iHfVj0HBanob6vFivjtxZj5VnWvaRr1zbhmZOxnD3xaLbIMKTwN+NLcBQy
         eMxVfS414B2PhO4F5CN5QRXepANRv4FNg4G+B/7Q08ikQmeKR9rm5+Fv+zb1Q+bCRcPf
         8GEPWlrgbZt41d6uBsu3/2FQRCAMQq3XRfATw41XctOpD3lrccNgnp+Dutwx03fddFWF
         lRyeXBsbR99sbdEQJeh2cVfRNVojfA/i9QxK1gaW+k0cKEdV6vCv0wLHmOd5SjJ8eUlz
         mFiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FTwPQv27wuexWI11SsYTJ/Jcg511fw1brRSTvDsMTCo=;
        b=IADGMAdgIUfQDJ63/UA778sGa8p3bpSMCuePJnKChzLNjQQMMWHNV8xi/q0VWdoLjO
         fdbmaYpjBSB21zQxvzJ6m3YycXb1dq/1Hmr8ylMYcgXZ+XKuIy84IXRdP+F64dMRDYuu
         LhSmn4Ua5mNZSHG9udqMRcVm0xcokrwb6+QbZio/OU9E6Wv0irQL/eCc9CA5ihtMt1oo
         ZtapzUTNtQb5fuwbdilvWNiZK702sBJtcntyevJudO8yU3MBKaGP1LUpICP/yDfaaID6
         xZ/8OloQTV9kovVNtNPkt8MijdPHANb30EgGold6nVBJqneiDD15EpAbFK9pbzOfXgrt
         m2Uw==
X-Gm-Message-State: APt69E3g16mCuc+hx6cODInDByFsFuTrvhnNkJo+vX5Wey7jS7Yi+ygf
        DUKVgnA6sxz43PctkDsRQk4tOQ==
X-Google-Smtp-Source: ADUXVKIO7bEYGxEtmaRsim86IXXQCgLtC3R5oiNGsmWzSH3LWnyoE/gdXtJGxHWbbL4JnC6463jVjw==
X-Received: by 2002:a17:902:8d86:: with SMTP id v6-v6mr11530365plo.325.1529342766655;
        Mon, 18 Jun 2018 10:26:06 -0700 (PDT)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id 63-v6sm22076910pfo.1.2018.06.18.10.26.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jun 2018 10:26:06 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.86_2)
        (envelope-from <jgg@ziepe.ca>)
        id 1fUxun-0008Ke-Bh; Mon, 18 Jun 2018 11:26:05 -0600
Date:   Mon, 18 Jun 2018 11:26:05 -0600
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     willy@infradead.org
Cc:     hans.westgaard.ry@oracle.com, Doug Ledford <dledford@redhat.com>,
        linux-rdma@vger.kernel.org,
        =?utf-8?B?SMOla29u?= Bugge <haakon.bugge@oracle.com>,
        Parav Pandit <parav@mellanox.com>,
        Jack Morgenstein <jackm@dev.mellanox.co.il>,
        Pravin Shedge <pravin.shedge4linux@gmail.com>,
        linux-kernel@vger.kernel.org,
        Matthew Wilcox <mawilcox@microsoft.com>
Subject: Re: [PATCH v3 2/2] IB/mad: Use IDR for agent IDs
Message-ID: <20180618172605.GA32003@ziepe.ca>
References: <20180613123403.25233-1-willy@infradead.org>
 <20180613123403.25233-3-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180613123403.25233-3-willy@infradead.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 13, 2018 at 05:34:03AM -0700, willy@infradead.org wrote:
> Allocate agent IDs from a global IDR instead of an atomic variable.
> This eliminates the possibility of reusing an ID which is already in
> use after 4 billion registrations.  We limit the assigned ID to be less
> than 2^24 as the mlx4 driver uses the most significant byte of the agent
> ID to store the slave number.  Users unlucky enough to see a collision
> between agent numbers and slave numbers see messages like:
> 
>  mlx4_ib: egress mad has non-null tid msb:1 class:4 slave:0
> 
> and the MAD layer stops working.
> 
> We look up the agent under protection of the RCU lock, which means we
> have to free the agent using kfree_rcu, and only increment the reference
> counter if it is not 0.
> 
> Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
> Reported-by: Hans Westgaard Ry <hans.westgaard.ry@oracle.com>
> Acked-by: Jack Morgenstein <jackm@dev.mellanox.co.il>
> Tested-by: Jack Morgenstein <jackm@dev.mellanox.co.il>
> ---
>  drivers/infiniband/core/mad.c      | 83 ++++++++++++++++++------------
>  drivers/infiniband/core/mad_priv.h |  7 +--
>  2 files changed, 55 insertions(+), 35 deletions(-)

Applied to for-next, thanks everyone

Jason
