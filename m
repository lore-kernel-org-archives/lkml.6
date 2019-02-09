Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E37CC282CB
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 06:58:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03F9420857
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 06:58:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbfBIG6X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 01:58:23 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:41388 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726792AbfBIG6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 01:58:21 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 1F152149CF792;
        Fri,  8 Feb 2019 22:58:21 -0800 (PST)
Date:   Fri, 08 Feb 2019 22:58:20 -0800 (PST)
Message-Id: <20190208.225820.1267799543305280077.davem@davemloft.net>
To:     gustavo@embeddedor.com
Cc:     khc@pm.waw.pl, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] wan: wanxl: use struct_size() in kzalloc()
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190208031648.GA3022@embeddedor>
References: <20190208031648.GA3022@embeddedor>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 08 Feb 2019 22:58:21 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Date: Thu, 7 Feb 2019 21:16:48 -0600

> One of the more common cases of allocation size calculations is finding
> the size of a structure that has a zero-sized array at the end, along
> with memory for some number of elements for that array. For example:
> 
> struct foo {
>     int stuff;
>     struct boo entry[];
> };
> 
> size = sizeof(struct foo) + count * sizeof(struct boo);
> instance = alloc(size, GFP_KERNEL)
> 
> Instead of leaving these open-coded and prone to type mistakes, we can
> now use the new struct_size() helper:
> 
> instance = alloc(struct_size(instance, entry, count), GFP_KERNEL)
> 
> Notice that, in this case, variable alloc_size is not necessary, hence
> it is removed.
> 
> This code was detected with the help of Coccinelle.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Applied.
