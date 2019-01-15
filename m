Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 138E4C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 13:41:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5B3720656
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 13:41:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="C6gyhQRY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729801AbfAONlK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 08:41:10 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:57888 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729746AbfAONlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 08:41:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=VlYY//8+Fles0GMEl53EXRz9mxxPVZ9NzAxRSdz5ydc=; b=C6gyhQRYQFxic+9n55OCrVFik
        byfSu2Ko7zsy3y1TkDYdMbM7D92Veq3n9AMqZ16Z4Sn6Ebrx+ZofT6QU2YGfcw6QIT/1KtLn2yuul
        sS1EQFmUG4WHIHgM8AqAOt6Gc4b1Z5q8nxW1XPJBMl99mM2hyyqRGmVC+wq5FEUlmpzVs6j4ibWNb
        jvC34AnlnyccttkfI6FuJryt2ZC1uSmGSzFBN1F7fNZPabXOTeMi/zy+70H5sdrBkueQJJp+jVKgK
        ug2tJq4NyuXxJnDzxulZjhpyah9fr64lxdLVERb9uU3Cb8o9mjtJSCEdjH7kUvDHkRWuXrr2cIuzn
        QuonHJtrQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gjOxo-0005IA-Lk; Tue, 15 Jan 2019 13:41:08 +0000
Date:   Tue, 15 Jan 2019 05:41:08 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     G SatishKumar <gsatish.ldd@gmail.com>
Cc:     linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org,
        palmer@sifive.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RISCV:IRQ: Support IRQ_WORK interrupts with self IPI
Message-ID: <20190115134108.GA13216@infradead.org>
References: <1546781578-8126-1-git-send-email-gsatish.ldd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1546781578-8126-1-git-send-email-gsatish.ldd@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 06, 2019 at 07:02:58PM +0530, G SatishKumar wrote:
> 	This patch adds, IRQ Work interrupts support to RISCV arch.
> 
> 	This patch is based on the arm32 patch ARM 7872/1
> 	which ports cleanly.
> 
> 	Done set of changes based on RISCV SMP process.
> 
> 	commit bf18525fd793 ("ARM: 7872/1: Support arch_irq_work_raise()
> 		via self IPIs")
> 	Author: Stephen Boyd <sboyd at codeaurora.org>
> 	Date:   Tue Oct 29 20:32:56 2013 +0100
> 
> 	By default, IRQ work is run from the tick interrupt (see
> 	irq_work_run() in update_process_times()). When we're in full
> 	NOHZ mode, restarting the tick requires the use of IRQ work and
> 	if the only place we run IRQ work is in the tick interrupt we
> 	have an unbreakable cycle. Implement arch_irq_work_raise() via
> 	self IPIs to break this cycle and get the tick started again.
> 	Note that we implement this via IPIs which are only available on
> 	SMP builds. This shouldn't be a problem because full NOHZ is only
> 	supported on SMP builds anyway.

The commit logs here looks oddly indented.  Also what workload did you
test this with?
