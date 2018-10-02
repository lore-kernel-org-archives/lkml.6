Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 296C2C004D2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 14:50:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E397D20666
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 14:50:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GBSUB4ay"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E397D20666
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728693AbeJBVea (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 17:34:30 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52898 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728011AbeJBVea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 17:34:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=+0FUfnpwE6tgG3L/Bn/7usEhLXFSGLkr/4GEmbbg4CQ=; b=GBSUB4ayon22M28Q+SlvR3w4w
        7yRDuxVhL0y5rGo897XqExALMyAx/BGtRRPp9PMzOJH+HEB1o5UcEkjmC5lbLfX9FmcZ9VJnzAv9G
        TgEW5O62FRZDblzSVLmS2I6CQ7OczuWU8CNTV7rAcLS4bxe9anKXG+71fPCHQ6zuOOn6O0cp3lo5M
        BMcZqVn3MY9Jrxxk9p76XU4HZ+QkKpRMWN0/xY0kaSZIqgcOJuWH02BNpRYxRE1h70iCWVl0tazsH
        3vv6Uq7V2Ofn8nRS9DpaP4RATYdYKZIWTCjcxLt+fcAgciGsvhPGYVH+484geFBu1J7iEQpappzQ3
        Rwlg3EX6Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g7M0Y-0002jC-6x; Tue, 02 Oct 2018 14:50:42 +0000
Date:   Tue, 2 Oct 2018 07:50:41 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Zong Li <zongbox@gmail.com>
Cc:     palmer@sifive.com, aou@eecs.berkeley.edu, hch@infradead.org,
        zong@andestech.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/5] lib: Add umoddi3 and udivmoddi4 of GCC library
 routines
Message-ID: <20181002145041.GC3889@infradead.org>
References: <cover.1538470103.git.zongbox@gmail.com>
 <2144f372b95f236afe47da4fc575a42ec95e8239.1538470103.git.zongbox@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2144f372b95f236afe47da4fc575a42ec95e8239.1538470103.git.zongbox@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The udivmoddi4 and umoddi3 are copies from libgcc in gcc. There are other
> functions use the udivmoddi4 in libgcc, so I separate the umoddi3 and
> udivmoddi4 for flexible extension in the future.

Can you please mention which exact version of an external projected
you imported things from?  That will generally help if/when someone
has to dig into diverging versions.

> +++ b/lib/udivmoddi4.c
> @@ -0,0 +1,310 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/*
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, see the file COPYING, or write
> + * to the Free Software Foundation, Inc.
> + */

The SPDX tag was supposed to replace this boiler plate.  On the other
hand I'm surpriced there is no Copyright statement here - the FSF is
usually very good about having them uptodate in every GNU project.
