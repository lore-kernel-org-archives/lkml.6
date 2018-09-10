Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6059C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 11:28:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A25302086E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 11:28:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZuB3Zqbd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A25302086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728551AbeIJQVl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 12:21:41 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56324 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728153AbeIJQVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 12:21:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=6SUBQdD4Z7mT4AnPmlbovVbIxrku8bOiYO0UG3D9tXo=; b=ZuB3ZqbdhCyNqp3L6Um++fMIu
        DL4GRoPwbOhC7CNKQe/nyqQWPPKKjgHpj/9KTO43GDpRdmBSTkvBxrGcVma5RdOsu41/BwT9/DDjq
        ocHa14s+S5/7vsVm7Cm708uDdusPFrIgAkKCEGWfxNA1RCn89/ykHUMlWbxfc98hBH3AHr6ppRGAw
        9yybglCywsePgnfs/v7qMg5UlhvMEnay17fnonegBP/GNMemi5wip0dCjuMQOLR0tzGRL2y5T8lRC
        kmy8nZdSOI48jEn92sRlFTYJxlFTyDIUaofGrwR2VVm3BMs8KAkiMuGDVjBWL7paRsCHdh3hdoj/y
        za9eJCFdA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fzKMK-0007fm-6d; Mon, 10 Sep 2018 11:28:00 +0000
Date:   Mon, 10 Sep 2018 04:27:59 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Atish Patra <atish.patra@wdc.com>
Cc:     palmer@sifive.com, linux-riscv@lists.infradead.org,
        hch@infradead.org, anup@brainfault.org, mark.rutland@arm.com,
        Damien.LeMoal@wdc.com, jason@lakedaemon.net,
        ard.biesheuvel@linaro.org, marc.zyngier@arm.com,
        gregkh@linuxfoundation.org, dmitriy@oss-tech.org,
        linux-kernel@vger.kernel.org, jeremy.linton@arm.com,
        catalin.marinas@arm.com, tglx@linutronix.de
Subject: Re: [PATCH v3 10/12] RISC-V: Add logical CPU indexing for RISC-V
Message-ID: <20180910112759.GI12979@infradead.org>
References: <1536221135-182613-1-git-send-email-atish.patra@wdc.com>
 <1536221135-182613-11-git-send-email-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1536221135-182613-11-git-send-email-atish.patra@wdc.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 06, 2018 at 01:05:33AM -0700, Atish Patra wrote:
> Currently, both linux cpu id and hardware cpu id are same.
> This is not recommended as it will lead to discontinuous cpu
> indexing in Linux. Moreover, kdump kernel will run from CPU0
> which would be absent if we follow existing scheme.
> 
> Implement a logical mapping between Linux cpu id and hardware
> cpuid to decouple these two. Always mark the boot processor as
> cpu0 and all other cpus get the logical cpu id based on their
> booting order.
> 
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> Reviewed-by  : Anup Patel <anup@brainfault.org>

drop the two spaces before the ":", please.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
