Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5267C433F4
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 12:26:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 639A82150F
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 12:26:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ACfOKr8p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 639A82150F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729399AbeIVSOb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 14:14:31 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37546 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728233AbeIVSOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 14:14:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3QfhdJZNt4fiGQPQy7ApuFLqsniBm5nJGwsjCbbCLjk=; b=ACfOKr8pebojErAjIg8cpvNep
        B1V0rtkyaqEnHl56o03epE5QmFiv7Xep1x56nYfNxdXmupJI6FUZqF03zkijB/prkPlHGuCG6q8bJ
        t/U/d0xOOcCz4mlPNtqAwq8oh/tvDGMGZMZA/twsaKuUrDZ2SC4X1pNhG32ddn9+fjI5smFMmmzec
        f7woZJt+/5ZSvdrulSjiNmcWCIOIGBoA3vzdqEdyw4orliWml/nQeeazWgJDCsHIlDxYGjHmhQVjy
        zB3FUCkw1XOcjZ5SCjqlJnZjBmLljJZpMuMYu4XUysuSWprqNGuwbtbCIRyJB7Xxgpl/JY9a5qA9/
        Mbkerb5Yw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g3guJ-00053H-Ko; Sat, 22 Sep 2018 12:21:07 +0000
Date:   Sat, 22 Sep 2018 05:21:07 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     miguel.ojeda.sandonis@gmail.com, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org
Subject: Re: [PATCH] auxdisplay/cfag12864bfb.c: Replace vm_insert_page
Message-ID: <20180922122107.GA14042@bombadil.infradead.org>
References: <20180920202316.GA6038@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180920202316.GA6038@jordon-HP-15-Notebook-PC>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 21, 2018 at 01:53:16AM +0530, Souptick Joarder wrote:
> There is a plan to remove vm_insert_page permanently
> and replace it with new API vmf_insert_page which will
> return vm_fault_t type. As part of it vm_insert_page
> is removed from this driver.
> 
> remap_pfn_range() will be used to map kernel memory to
> user vma.

I think this patch is dangerous.  It's not buggy *for this driver*,
but it gives the impression that it's safe to use remap_pfn_range()
for this *kind* of driver.
