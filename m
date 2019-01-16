Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC59DC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 08:40:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 893A620859
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 08:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547628037;
	bh=REZp0kgkXDT/X19DOI1MmwqxPHPSj6ZVD1XwMxTrXbY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:List-ID:From;
	b=WIUGFbVit+H0cP5bV6dAnZVCVge9dPuSrUY40CYCx7HtiJL+wvc7dr2/prgnpjv+E
	 ac9Ge2+XlpZlWmAWD9Ioi6PY/4tbwfAUnbXg6A13H5yiM98QcJ9/zEfjV9va062Pmp
	 JqBtKJPQ8Fxb1pgalyv3m0wJcWku/H71uaApx9hM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389130AbfAPIkf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 03:40:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:34564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729177AbfAPIkf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 03:40:35 -0500
Received: from localhost.localdomain (91-160-177-164.subs.proxad.net [91.160.177.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9588B2082F;
        Wed, 16 Jan 2019 08:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547628034;
        bh=REZp0kgkXDT/X19DOI1MmwqxPHPSj6ZVD1XwMxTrXbY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:From;
        b=eobEc69y4hVI4vgaYory2u3hUKvNIa4EIUyDwW2vhd9X4XHP4DAJ5rEoU8LvRmzz5
         K8hnaBD93qOcZeShQ4hyJwOycj5c4iREtuVMQv42M2JzGzS0fSv10iyojZPOYFV2qp
         ZazGR4D4BLwu2KDtHyT9PgmceDg/R2YqIVF8YpWs=
From:   Boris Brezillon <bbrezillon@kernel.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: mtd: lpddr: Use struct_size() in kzalloc()
Date:   Wed, 16 Jan 2019 09:40:26 +0100
Message-Id: <20190116084026.29622-1-bbrezillon@kernel.org>
X-Mailer: git-send-email 2.17.1
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: 2037f9d8c242af5d549dd5ba32ff1ec1f49ceaad
In-Reply-To: <20190108210946.GA4014@embeddedor>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Boris Brezillon <boris.brezillon@bootlin.com>

On Tue, 2019-01-08 at 21:09:46 UTC, "Gustavo A. R. Silva" wrote:
> One of the more common cases of allocation size calculations is finding the
> size of a structure that has a zero-sized array at the end, along with memory
> for some number of elements for that array. For example:
> 
> struct foo {
>     int stuff;
>     void *entry[];
> };
> 
> instance = kzalloc(sizeof(struct foo) + sizeof(void *) * count, GFP_KERNEL);
> 
> Instead of leaving these open-coded and prone to type mistakes, we can now
> use the new struct_size() helper:
> 
> instance = kzalloc(struct_size(instance, entry, count), GFP_KERNEL);
> 
> This code was detected with the help of Coccinelle.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Applied to http://git.infradead.org/linux-mtd.git mtd/next, thanks.

Boris
