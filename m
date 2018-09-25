Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2B9DC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 15:25:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 639EF20C0A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 15:25:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="U9LVch04"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 639EF20C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729639AbeIYVdP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 17:33:15 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55478 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729484AbeIYVdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 17:33:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=YZqbmfKjH4sK63MGj/DOrhrO67U5Wd4gJ8PCBf+FDx8=; b=U9LVch04QOLPnumbuppFb+HBj
        ubnd+VCfei8klTrKfmmvb24ckt0fMgpHs/9MxNeAQelORWOscoCfnaqgnRn9Q0QQrFaks/BCfl9lD
        /Jw0WBtlf7ITvA8JpSZwGuLYdPtLFylJOOqWKewFJBMNv7yGZUDJBfy750ZHKeSzO8gjjc259/MSf
        Wuy3YabzQys7WQMsGQDBRx6IBb6Bf4kjBCSn3RiPianlvA166yi0Hdd5y1kwbM5leqbvUG8Yb2yIP
        p4Kf4VuUYvjy1co9HVfCXaXQeXJFf5fPD//gDqquF8N4Qutv5dNtk+kQhiSw8SG6IOPI0uXszHBFP
        +c93N3Mow==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g4pD2-0006oZ-Ly; Tue, 25 Sep 2018 15:25:08 +0000
Date:   Tue, 25 Sep 2018 08:25:08 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Zong Li <zongbox@gmail.com>
Cc:     hch@infradead.org, palmer@sifive.com, aou@eecs.berkeley.edu,
        vincentc@andestech.com, zong@andestech.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] lib: Add umoddi3 and udivmoddi4 of GCC library
 routines
Message-ID: <20180925152508.GA24002@infradead.org>
References: <cover.1537260207.git.zongbox@gmail.com>
 <2ccc6c0758624dbb22f6fe451a3e476a000108ef.1537260207.git.zongbox@gmail.com>
 <20180921070006.GC8401@infradead.org>
 <CA+ZOyaiJv-NZWk3ec_3zhRTSn7G-NGgyaiPTXOmuWfTWD7KSJw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+ZOyaiJv-NZWk3ec_3zhRTSn7G-NGgyaiPTXOmuWfTWD7KSJw@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 10:19:55AM +0800, Zong Li wrote:
> The RV32 need the umoddi3 to do modulo when the operands are long long
> type, like other libraries implementation such as ucmpdi2, lshrdi3 and
> so on. I encounter the undefined reference 'umoddi3' when I use the in
> house dma driver, although it is in house driver, but I think that
> umoddi3 is a common function for RV32. The udivmoddi4 and umoddi3 are
> copies from libgcc in gcc. There are other functions use the
> udivmoddi4 in libgcc, so I separate the umoddi3 and udivmoddi4 for
> flexible extension in the future.

I don't think libgcc is GPLv2 licensed, is it?  Also please retain
the copyright notices from libgcc.
