Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FC54C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 14:54:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DCF620837
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 14:54:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rYw5MbVQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DCF620837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933269AbeFUOyB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 10:54:01 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46500 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933186AbeFUOx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 10:53:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=DrYSSFUHn3ccr0T0kO5v2HlOoO14KgiTKme7NKlPX7M=; b=rYw5MbVQbsc21wdYlT8LK348e
        SWF/qRsZim3NwgKkzFLw6Z6o6IzK08BnN22oa6Z5eCYMUjVENLyyNP+p7qh5/2LWQMu/lRAX98484
        Dqc4TcjtXCNDgjc2wDRcurXLKGCFvl4L1zzCEF102aLY72iMiqmBMDmswdNMd7pfsJMALVEOOjkGh
        eN8pP01aLUteouRmh2FttkfZbMiMqDmS2vDW7GS9DbI4xp0Pe354DwISqJ18048omOkY4Jm+A3jKY
        MU8zJyuX3M9noWabUuOFOCHHzoImBL9DGOW+ivoPwCJk1t6DlKX4V6OFKbIAoWKJ1MN9w5k/6A+bB
        j9zMl6qiQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fW0yC-0003Ps-Ju; Thu, 21 Jun 2018 14:53:56 +0000
Date:   Thu, 21 Jun 2018 07:53:56 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Andreas Schwab <schwab@suse.de>
Cc:     Christoph Hellwig <hch@infradead.org>, aou@eecs.berkeley.edu,
        palmer@sifive.com, linux-kernel@vger.kernel.org,
        greentime@adnestech.com, Zong Li <zong@andestech.com>,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH 5/5] RISC-V: Use fixed width integer types for 32-bit
 compatible
Message-ID: <20180621145356.GB12445@infradead.org>
References: <cover.1529506497.git.zong@andestech.com>
 <37a6523947397cd72320676030b96926e373d05a.1529506497.git.zong@andestech.com>
 <20180621064322.GE19319@infradead.org>
 <mvmwousjv8g.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mvmwousjv8g.fsf@suse.de>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 12:21:19PM +0200, Andreas Schwab wrote:
> On Jun 20 2018, Christoph Hellwig <hch@infradead.org> wrote:
> 
> >>  static int apply_r_riscv_32_rela(struct module *me, u32 *location, Elf_Addr v)
> >>  {
> >>  	if (v != (u32)v) {
> >> -		pr_err("%s: value %016llx out of range for 32-bit field\n",
> >> +		pr_err("%s: value %016" PRIxX "out of range for 32-bit field\n",
> >>  		       me->name, v);
> >>  		return -EINVAL;
> >
> > But in general Linux uXX and sXX values are always the same underlying
> > fundamental C type.  What is the mismatch here?
> 
> The mismatch is that v is Elf_Addr, not u32.

Then we'll have to cast to unsigned long before printing, like we
do elsewhere in kernel.
