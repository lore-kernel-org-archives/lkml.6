Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 505E1C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 08:40:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13CE62082F
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 08:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547628051;
	bh=GXbmFQCGDHl5m5dWNXv4DarmZHUxdLCFv1bv1UxIb6g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:List-ID:From;
	b=doMth2wBuUCAufK+nZIT+lNgCONKDvTOieuNUa9kFNllpgkYzgDTRvhM91n1flTde
	 5NOFSQ18wAhc6ErgNKH01QT4gAKyH3zwDS2RXnhKxniMraVkS3YhOxvCG8UV/eKtpe
	 cQduQIgUEKllpoeaGXjeCjuKFQuWVneP/faqFO/4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389205AbfAPIkt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 03:40:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:34724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729177AbfAPIkt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 03:40:49 -0500
Received: from localhost.localdomain (91-160-177-164.subs.proxad.net [91.160.177.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 84C5320859;
        Wed, 16 Jan 2019 08:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547628048;
        bh=GXbmFQCGDHl5m5dWNXv4DarmZHUxdLCFv1bv1UxIb6g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:From;
        b=zjE68JqZlcaQYtoFhxObQn0lbu/n7sxT9lIZMr3ZMbexCzF7cQ3sPKUQ14QgbU7B1
         PDdz1tLaAShEKOV3nToS4WTaspegALeJBEEeQzvzKVx1aNt7ODUeOmhTu/1Lr89O6E
         qsTUyuFWrMTO/xoeZiUVKFBh1WcioTbTMEr5cdkk=
From:   Boris Brezillon <bbrezillon@kernel.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: mtd: cfi: cmdset_0001: Use struct_size() in kmalloc()
Date:   Wed, 16 Jan 2019 09:40:40 +0100
Message-Id: <20190116084040.29707-1-bbrezillon@kernel.org>
X-Mailer: git-send-email 2.17.1
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: 04b4c06caf2b810f0ce4822f6611ed35326ca11a
In-Reply-To: <20190108155244.GA15339@embeddedor>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Boris Brezillon <boris.brezillon@bootlin.com>

On Tue, 2019-01-08 at 15:52:44 UTC, "Gustavo A. R. Silva" wrote:
> One of the more common cases of allocation size calculations is finding
> the size of a structure that has a zero-sized array at the end, along
> with memory for some number of elements for that array. For example:
> 
> struct foo {
>     int stuff;
>     void *entry[];
> };
> 
> instance = kmalloc(sizeof(struct foo) + sizeof(void *) * count, GFP_KERNEL);
> 
> Instead of leaving these open-coded and prone to type mistakes, we can
> now use the new struct_size() helper:
> 
> instance = kmalloc(struct_size(instance, entry, count), GFP_KERNEL);
> 
> This code was detected with the help of Coccinelle.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Applied to http://git.infradead.org/linux-mtd.git mtd/next, thanks.

Boris
