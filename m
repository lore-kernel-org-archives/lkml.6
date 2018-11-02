Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9587C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 17:00:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A01BA2082E
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 17:00:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="cLvTly4P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A01BA2082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728107AbeKCCIL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 22:08:11 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36160 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726799AbeKCCIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 22:08:11 -0400
Received: by mail-pl1-f193.google.com with SMTP id w24-v6so1290381plq.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 10:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=+epNv53pBINpVve9YuiRRQBJKb3zG0Ihe3qeNCWLiwY=;
        b=cLvTly4Pzq4gvAaXz3oUuxHu2sAPp0I5CYovBrg2ljvLjfTz0w1xCSxJIRfDKygxpm
         EBCdwZZYm9YyjH8w+Oi0Sw85y9sC3Rnmp4h92M0ueWthmT6u463sS/FzTueWs1DO7Xj6
         O5rhfSkIE/3LbNGAg8e/io4nFE6KN4aDwvNrOaG1QJ1aO+SyHVxvvaq3Ka+zmjJiicjx
         nGBitjBNz4XcItincdL7oLWxIPGk324krxMZtqanyKDDKc8ssDQePjx+P+2b+QKPj9gk
         uVkblpJ7NjcqLKhMrR0MUvpbCb9tqXZmxkWPTpo+1YlzFgxq5zO6VmTW7F4kWT4p/1Yl
         /c+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=+epNv53pBINpVve9YuiRRQBJKb3zG0Ihe3qeNCWLiwY=;
        b=EX1EAyKPbQ15d5PszTnxjGSCJQSfig6lhzosL0tL3ZSCuAjp0LmfKjtNkOci8zXLCZ
         Hb/xMGFINJAfVEVyQgDJM21LepzYU7vJsvaLRIwvyHmJUxhxPqevYGs3XZFoe1XGSrEx
         1VxXm7+LHE2sYZ3JXyj3b8RtGfvT69K760IsEnwQSj++N86t6RIRYNkW1yHb8/1B38pp
         CqByqCL+7S/t//4aeLGEnIy395t8rkDVS5FjVRT7adu9jkKnwYmlqMy/x6p10te8j52h
         gjIPJ2evjDnWA9Lq8TyaMDMo0O0tL53ZHVuNjpIDhNbGk2i62xb6dNlXaxODQ2gbe+i4
         X1zw==
X-Gm-Message-State: AGRZ1gLuSeNRDqXFtjjagqS2Ln/S/0I6f+Hpcxb7AJVXFhukImWT7LLh
        g1cYpCN1A7v1Bo4RcFEQ6b/97Q==
X-Google-Smtp-Source: AJdET5ewCFmssbUMehl+6W5wKorKfVearYZ+bJVA5XFa/9fN/FFYgkfm099ElFYm6MC8qDiPV++Lfg==
X-Received: by 2002:a17:902:6901:: with SMTP id j1-v6mr12525180plk.26.1541178022927;
        Fri, 02 Nov 2018 10:00:22 -0700 (PDT)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id b62-v6sm36509767pfa.159.2018.11.02.10.00.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 02 Nov 2018 10:00:21 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1gIco0-0005qb-O9; Fri, 02 Nov 2018 11:00:20 -0600
Date:   Fri, 2 Nov 2018 11:00:20 -0600
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Saeed Mahameed <saeedm@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Tariq Toukan <tariqt@mellanox.com>,
        Eran Ben Elisha <eranbe@mellanox.com>,
        Boris Pismenny <borisp@mellanox.com>,
        Ilya Lesokhin <ilyal@mellanox.com>,
        Moshe Shemesh <moshe@mellanox.com>,
        Kamal Heib <kamalh@mellanox.com>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net/mlx5e: fix high stack usage
Message-ID: <20181102170020.GB17096@ziepe.ca>
References: <20181102153316.1492515-1-arnd@arndb.de>
 <20181102160858.GA17096@ziepe.ca>
 <CAK8P3a2pvkfR1A6dHAMm8ETd13E1LSxXrEsQHSOFYWbr-7R2Sw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK8P3a2pvkfR1A6dHAMm8ETd13E1LSxXrEsQHSOFYWbr-7R2Sw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 02, 2018 at 05:23:26PM +0100, Arnd Bergmann wrote:
> On 11/2/18, Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > On Fri, Nov 02, 2018 at 04:33:03PM +0100, Arnd Bergmann wrote:
> >> A patch that looks harmless causes the stack usage of the
> >> mlx5e_grp_sw_update_stats()
> >> function to drastically increase with x86 gcc-4.9 and higher (tested up to
> >> 8.1):
> >>
> >> drivers/net/ethernet/mellanox/mlx5/core/en_stats.c: In function
> >> ‘mlx5e_grp_sw_update_stats’:
> >> drivers/net/ethernet/mellanox/mlx5/core/en_stats.c:216:1: warning: the
> >> frame size of 1276 bytes is larger than 500 bytes [-Wframe-larger-than=]
> >
> > Why is the stack size so big here? The mlx5e_sw_stats is < 500 bytes
> > and all the other on-stack stuff looks pretty small?
> 
> I am not entirely sure, but my analysis indicates that gcc tries loop unrolling
> or some other optimization that leads to two copies on the stack.

Wow how strange

Did you consier adding a
  __attribute__((optimize("no-unroll-loops"))) 

type macro?

Jason
