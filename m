Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D12AC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 02:55:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C47BA20844
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 02:55:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SrIJMxIr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C47BA20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725904AbeGYEE6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 00:04:58 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42360 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725771AbeGYEE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 00:04:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=lW6sH7wArClqtphZNJ2S2tG9Im7H6j+98eJQRI2NXeY=; b=SrIJMxIrRPGD8U++arm/K2vEv
        sr1waEO+zIWxkYm+9HJW4Hj9Om3/oG+3jEhJ6BV/cCMKRzYFY5KD3OHAKCPTeh3qXBnJRQMnzI+Hi
        v3WxBDo+omivBDk2HvForq9K6ftbzxfdcXKGCrATupoWMHVVewZPGs3oVxvn6At+z+rTgQRpCmQyt
        UPN7ynFsNevAR2FhmhK2JYVspN+V+P3VVyM2aB00yx5HW+XH1etCNsWglmjYfAELEogS6U2eLI69P
        BTSxnzUqxxfM2b0ka9SXAlQkFTv+D1P9C51wkDfmwEeBjvFfU8G66SuMcjHlMCCgC1LvV26euZb5s
        voiJYiVeQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fi9xV-0003PQ-Hf; Wed, 25 Jul 2018 02:55:25 +0000
Date:   Tue, 24 Jul 2018 19:55:25 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Tino Lehnig <tino.lehnig@contabo.de>, ngupta@vflare.org,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: Zram writeback feature unstable with heavy swap utilization -
 BUG: Bad page state in process...
Message-ID: <20180725025525.GD16271@bombadil.infradead.org>
References: <0516ae2d-b0fd-92c5-aa92-112ba7bd32fc@contabo.de>
 <20180724010342.GA195675@rodete-desktop-imager.corp.google.com>
 <d4f4b5a1-9e31-375d-0599-b6d8b0ebc9df@contabo.de>
 <20180725013250.GA66792@rodete-desktop-imager.corp.google.com>
 <20180725015502.GA16271@bombadil.infradead.org>
 <20180725021657.GA87819@rodete-desktop-imager.corp.google.com>
 <20180725023532.GB16271@bombadil.infradead.org>
 <20180725025106.GA99093@rodete-desktop-imager.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180725025106.GA99093@rodete-desktop-imager.corp.google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 25, 2018 at 11:51:06AM +0900, Minchan Kim wrote:
> On Tue, Jul 24, 2018 at 07:35:32PM -0700, Matthew Wilcox wrote:
> > There is NOTHING in a union with _refcount.
> 
> Confusing. Matthew, what am I missing?
> 
> Before:
> 
> counters consumes 8 bytes
> units and _refcount consumes each 4 bytes so memory space is not overlapped.

Correct.  _mapcount is at offset 24, as is units.  _refcount is at offset 28.

>         union {
>                 unsigned long counters;
>                 struct {
>                         union {
>                                 atomic_t _mapcount;
>                                 int units;                      /* SLOB */
>                         };
>                         atomic_t _refcount;
>                 };
>         };
> 
> 
> After:
> 
> Now, units is overlapped with _refcount and _mapcount.

No.  units is at offset 24, as is _mapcount.  But _refcount is still at
offset 28.

>         union {
>                 unsigned long counters;
>                 int units;                      /* SLOB */
>                 struct {                        /* Page cache */
>                         atomic_t _mapcount;
>                         atomic_t _refcount;
>                 };
>         };
