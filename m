Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C460C3279B
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 01:52:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0870921EB7
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 01:52:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="MVperJgr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0870921EB7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754173AbeGGBw3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 21:52:29 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:46199 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753796AbeGGBw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 21:52:27 -0400
Received: by mail-pf0-f194.google.com with SMTP id l123-v6so9712365pfl.13
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 18:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fsDVwBZe1NpsyD2sRutJlVW0REYqYNeCPCbKERXjs6I=;
        b=MVperJgrUyU/XjaAYTr7GD+1VworafjXlVFC2zKUhrCSfegbd+GeLtMggDdLGiIWDs
         JKrlpeuPm3VbkuSwTAEDNVDOgCxPra3IVcnD45c8NRckN3vohE2hGVkA+HdvPPriXeWn
         8tqju8m8mn6efu1sHZWusj0OivAVWQKVjkzGftLh4Wj0Cplf8dXUwyWJ+cbtozBUy7jY
         l/b8gQYyPeKs8dOvf3D2BJ7C7dgpMkToUz3dpQ0qfvwusPHh6Z1eSQnCwxbyYndrLOyG
         HUslVUwgV6Pv/2cYk6D3h+rVB79SpQ2XHNMOSUMcoryXJmgaUYXBIIx6ORBm2I5hijRc
         4Biw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fsDVwBZe1NpsyD2sRutJlVW0REYqYNeCPCbKERXjs6I=;
        b=CjvgYHPONHVEGniYFjm7w620+2xaadOFfB27M4TpQ4SSq80+R6zuULsJW+dN3pM39U
         b107nA4pyq8LCpTslaWM8ysNLXiPea51JyvDsBUtn2cKh0R7OrMS9koWeHecfweunt4v
         2LaIJcD4T7AsTjM4n68G3AIDs0/R6BFkSZZWyHeztTGmj4ZiTXjcHTMeYjNzA/NJ2eN0
         6ujPPxyFGReKtfvR7iViXI9d8g8I1v3ZPJzSYZJyRriHGrAmTZNQQGheGOct7rhYNyeb
         AgxIIs+gngdQiypxWptwWeEmLTASdUa2im2GJ4BeNAhwvTuHcwpLDQMBA/rAJlAI7+yC
         CwdQ==
X-Gm-Message-State: APt69E2U3MmJENPl5I6lIuDbiLHDnrh/H9rwTbRLItNgKrp6oBzu3mVJ
        mPl9nZRE70QFsCQazZcxmKY54Q==
X-Google-Smtp-Source: AAOMgpeDEi+rq84klJEhj3NrvA7vhHK9hXq/K6hWKjfH8i5k5GeR5j9xe5YN1wMn0XqbYlNrlCgDRg==
X-Received: by 2002:a63:4c21:: with SMTP id z33-v6mr11205201pga.383.1530928347093;
        Fri, 06 Jul 2018 18:52:27 -0700 (PDT)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id j13-v6sm13610006pgq.73.2018.07.06.18.52.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Jul 2018 18:52:26 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.86_2)
        (envelope-from <jgg@ziepe.ca>)
        id 1fbcOf-0007nw-NA; Fri, 06 Jul 2018 19:52:25 -0600
Date:   Fri, 6 Jul 2018 19:52:25 -0600
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Tomas Bortoli <tomasbortoli@gmail.com>
Cc:     dledford@redhat.com, leon@kernel.org, parav@mellanox.com,
        roland@purestorage.com, swise@opengridcomputing.com,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller@googlegroups.com
Subject: Re: [PATCH] KASAN: use-after-free Read in rdma_listen
Message-ID: <20180707015225.GC9976@ziepe.ca>
References: <b7dd13a9-cb0d-7e10-beb2-3fb25214067a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7dd13a9-cb0d-7e10-beb2-3fb25214067a@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 07, 2018 at 03:41:30AM +0200, Tomas Bortoli wrote:
> I don't have a background on usage or internals of the driver at issue
> but I hope these clues will help in finding the proper fix.

I think anything is useful, thanks..

The truth is that nobody is left that seems to really understand this
code and syzkaller has shown it is full of various bugs..

If there is someone out there that would like to tackle it, let me
know. There might be a possibility to support such work.

Jason
