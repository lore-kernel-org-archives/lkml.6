Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FFC2C46462
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 19:42:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7D1720857
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 19:42:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Wf8mW9rE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7D1720857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728637AbeG2VOF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 17:14:05 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46570 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbeG2VOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 17:14:05 -0400
Received: by mail-pg1-f193.google.com with SMTP id p23-v6so6020750pgv.13
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jul 2018 12:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eQtzkxl+5zelMvUlMOP4jFfEI76tX0GopRFobohk7ms=;
        b=Wf8mW9rE27AX/lH9RTsMdV/5ywnkUiM92M4KSCiMI11wNrcAuufVrRaBVOfmR+y8XE
         NIzbcg97ij6U/tkUnzdBhG0sCBRuBcxUc0ubcLPzlPupRn8bfGW2EK/X/joBG9VISFDb
         vrx5Rio8g7g4n4tLbCB5ESOXptx7Xe1bYVhcPeZY3O+45XVaBq2q/g/dbDKT/oupis2q
         COXqwk6z7NVCZhTiiRJcS+CzvUPPDi9mmJnM++c9FHn0pqEjaNkB5DG0G1e4phz2qhXK
         xHITePswT4ebH/KREQY9A+7O77OAz9CvOgnhxzk1g2g4PurUk5X0eFEKGHjw6vets2oX
         4DVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eQtzkxl+5zelMvUlMOP4jFfEI76tX0GopRFobohk7ms=;
        b=LL9kYl1Hw/mZNJv/s8O3Vg/PIf963kjPaTdTcm/4565Ls21EvsNqsg9UvPRw0GdOEN
         BqzR7egwdJJDq8mOWTj+SC9JWUDRcRN4XjOCzYq8C2y6gOJS0+RzmdHBO8Rzn/aTuT67
         7f9dUq223aqx+T8QIyKEQ2d62Jpjram9K5oWsbqB0WxKKLR1pJqENKRsLdWNmhGmvg7w
         N0cQC8JkNkjrqHRgO3v0y5kuxzZNp8M4bSvqP+DnU55TN1KKTmGpymOhZbo0eFHv0bib
         Qoz2DtJwsCr83JZOWrLL4VtuJV1pPPpfEkePrNsFDJxN3H0X9jB0HiW+Z5aRCmefecYm
         85gw==
X-Gm-Message-State: AOUpUlH7qEqp99itU9ceTFrgnEpFLhyizLlpzSVmdwc0KDDm5bVw7MhH
        G40zXjW5iCyc5KKXVUUniiNkmA==
X-Google-Smtp-Source: AAOMgpcAcXhi9skHWi4fYQh8ZrLkX96OVojo9q8hg8rouCy3IVekn/yAcCUuFuu6pKiaILLJ8rlGTw==
X-Received: by 2002:a63:8042:: with SMTP id j63-v6mr13794069pgd.230.1532893351927;
        Sun, 29 Jul 2018 12:42:31 -0700 (PDT)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id b12-v6sm13679327pfe.148.2018.07.29.12.42.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Jul 2018 12:42:31 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.86_2)
        (envelope-from <jgg@ziepe.ca>)
        id 1fjraI-0004Pz-AE; Sun, 29 Jul 2018 13:42:30 -0600
Date:   Sun, 29 Jul 2018 13:42:30 -0600
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-rdma@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Parav Pandit <parav@mellanox.com>,
        Ursula Braun <ubraun@linux.ibm.com>,
        Leon Romanovsky <leonro@mellanox.com>
Subject: Re: [PATCH rdma] IB/cache: Restore compatibility for ib_query_gid
Message-ID: <20180729194230.GB15106@ziepe.ca>
References: <20180727155402.GA15253@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180727155402.GA15253@ziepe.ca>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 27, 2018 at 09:54:02AM -0600, Jason Gunthorpe wrote:
> Code changes in smc have become so complicated this cycle that the RDMA
> patches to remove ib_query_gid in smc create too complex merge conflicts.
> Allow those conflicts to be resolved by using the net/smc hunks by
> providing a compatibility wrapper. During the second phase of the merge
> window this wrapper will be deleted and smc updated to use the new API.
> 
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
>  include/rdma/ib_cache.h | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> The resolution Stephen had to make is too complicated, I think we
> should go this way instead. Parav can send a patch to DaveM during the
> 2nd half of the merge window to safely update SMC and delete this
> wrapper.
> 
> Parav, can you check this?
> 
> Ursula, this is only for SMC, are you able to test SMC with it? You
> will need to apply it to the RDMA tree here:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git/log/?h=for-next
> 
> Thanks,
> Jason

I applied this to rdma for-next with Parav's notes.

Jason
