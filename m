Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00D1AC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 18:27:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6EEC206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 18:27:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Ot+Q29MD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6EEC206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730393AbeKTEwi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 23:52:38 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41762 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730128AbeKTEwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 23:52:37 -0500
Received: by mail-pl1-f193.google.com with SMTP id u6so4088968plm.8
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 10:27:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=w0viHMBWjRvrA/E8RRIxUD6DuZAiEKYp6PVzl4DQ7WE=;
        b=Ot+Q29MDsNF0eymJcR/R9FLjhxGlfyLuhZj6T0kk3FF1v04tC0un8TFxi0XUOhKeOD
         JRaa265WifQtlup4bxZO8r40/8hSU4DAHhMYqu+Zj9rWp7/+SNOkQmEt/N1bdBvE66Fl
         ij+wBsJ19XShlZlTiUPi8mrhoxInE11WGfC2Ago2KdclnpxcZq5YsmaD233+PhiogPb4
         bIaNtIrhT6qXzaxkC5hLCv5hSFDKc4CkaKz+E9UQqCsGN8oJ7z+ACnTEGl52kp1TN3II
         F/91qcJsPBPHZmPcNedMzWxHlfg1NL73rI2pM/7tVjbZFbsUD/iUFMbjZ6l1uBBl5RlG
         QuuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=w0viHMBWjRvrA/E8RRIxUD6DuZAiEKYp6PVzl4DQ7WE=;
        b=sPtaTSjCPuID/rm3KmkUZ9vGHoYruNrOwD+uNMRAKPNOeeHZwZLwOgwGFgb2rl2puQ
         pzbbCNMdeZaawufrQNWxYI5XbbljyVvnzp+nR7Vz2FFrGucc7kt7c1n5s0mJ7EbHS+z3
         tICnFDgfXEnPYa7QIiP8QUdRfnrq53189Pg+wSopZXEI75Ne7J9eqNzo0vC3vk+psoog
         kg7iytCqfyiU6BeL1i9TLFARgBgkg/e9eYFjn3QWa/zpAGSnx0oyXW/evAE7w0fw0E+k
         NA39C616nd3rcdALr0fApKY2g8uRowPi3/fcODNLWU3xWPJPFdU7zFgH5cAo5+wv+jsA
         rhGw==
X-Gm-Message-State: AA+aEWaZGPyxkFOqes45a9USiU3/0cDreta9CPnwZcAaNK9OwmNwWUUT
        GWL4kCaH5O0J2PoiGEBiYsafVw==
X-Google-Smtp-Source: AFSGD/Vwm7n9ehPjJSmzDASPDyS3wkhKNRf+1RESELqUXVpAn58aAmvtvzP5Mjmob2nFERssmFS/LQ==
X-Received: by 2002:a17:902:4d46:: with SMTP id o6mr2703162plh.302.1542652074601;
        Mon, 19 Nov 2018 10:27:54 -0800 (PST)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id b81-v6sm50285206pfj.183.2018.11.19.10.27.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Nov 2018 10:27:53 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1gOoH2-0004qA-Nt; Mon, 19 Nov 2018 11:27:52 -0700
Date:   Mon, 19 Nov 2018 11:27:52 -0700
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jerome Glisse <jglisse@redhat.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Kenneth Lee <liguozhu@hisilicon.com>,
        Tim Sell <timothy.sell@unisys.com>, linux-doc@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Zaibo Xu <xuzaibo@huawei.com>, zhangfei.gao@foxmail.com,
        linuxarm@huawei.com, haojian.zhuang@linaro.org,
        Christoph Lameter <cl@linux.com>,
        Hao Fang <fanghao11@huawei.com>,
        Gavin Schenk <g.schenk@eckelmann.de>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Doug Ledford <dledford@redhat.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        David Kershner <david.kershner@unisys.com>,
        Kenneth Lee <nek.in.cn@gmail.com>,
        Johan Hovold <johan@kernel.org>,
        Cyrille Pitchen <cyrille.pitchen@free-electrons.com>,
        Sagar Dharia <sdharia@codeaurora.org>,
        Jens Axboe <axboe@kernel.dk>, guodong.xu@linaro.org,
        linux-netdev <netdev@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        linux-crypto@vger.kernel.org,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-accelerators@lists.ozlabs.org
Subject: Re: [RFCv3 PATCH 1/6] uacce: Add documents for WarpDrive/uacce
Message-ID: <20181119182752.GA4890@ziepe.ca>
References: <20181112075807.9291-2-nek.in.cn@gmail.com>
 <20181113002354.GO3695@mtr-leonro.mtl.com>
 <95310df4-b32c-42f0-c750-3ad5eb89b3dd@gmail.com>
 <20181114160017.GI3759@mtr-leonro.mtl.com>
 <20181115085109.GD157308@Turing-Arch-b>
 <20181115145455.GN3759@mtr-leonro.mtl.com>
 <20181119091405.GE157308@Turing-Arch-b>
 <20181119091910.GF157308@Turing-Arch-b>
 <20181119104801.GF8268@mtr-leonro.mtl.com>
 <20181119164853.GA4593@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181119164853.GA4593@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 11:48:54AM -0500, Jerome Glisse wrote:

> Just to comment on this, any infiniband driver which use umem and do
> not have ODP (here ODP for me means listening to mmu notifier so all
> infiniband driver except mlx5) will be affected by same issue AFAICT.
> 
> AFAICT there is no special thing happening after fork() inside any of
> those driver. So if parent create a umem mr before fork() and program
> hardware with it then after fork() the parent might start using new
> page for the umem range while the old memory is use by the child. The
> reverse is also true (parent using old memory and child new memory)
> bottom line you can not predict which memory the child or the parent
> will use for the range after fork().
> 
> So no matter what you consider the child or the parent, what the hw
> will use for the mr is unlikely to match what the CPU use for the
> same virtual address. In other word:
> 
> Before fork:
>     CPU parent: virtual addr ptr1 -> physical address = 0xCAFE
>     HARDWARE:   virtual addr ptr1 -> physical address = 0xCAFE
> 
> Case 1:
>     CPU parent: virtual addr ptr1 -> physical address = 0xCAFE
>     CPU child:  virtual addr ptr1 -> physical address = 0xDEAD
>     HARDWARE:   virtual addr ptr1 -> physical address = 0xCAFE
> 
> Case 2:
>     CPU parent: virtual addr ptr1 -> physical address = 0xBEEF
>     CPU child:  virtual addr ptr1 -> physical address = 0xCAFE
>     HARDWARE:   virtual addr ptr1 -> physical address = 0xCAFE

IIRC this is solved in IB by automatically calling
madvise(MADV_DONTFORK) before creating the MR.

MADV_DONTFORK
  .. This is useful to prevent copy-on-write semantics from changing the
  physical location of a page if the parent writes to it after a
  fork(2) ..

Jason
