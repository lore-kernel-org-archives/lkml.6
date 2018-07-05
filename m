Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B977C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 15:44:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAB9823FF6
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 15:44:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Tmy4kMVI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAB9823FF6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753902AbeGEPoU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 11:44:20 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53048 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753438AbeGEPoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 11:44:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=G3YcWzA1EO8lHfmr4yE3Grq/8urD7beGbgTq1DBaoLU=; b=Tmy4kMVIf6Lc6yKQS/lG/mXcu
        h11DJya3NIU/yfPfRBIqw21Wu8LI8dR0e9usIkHL2eN37N5vE+miUvjmK+OQyB86gWp+MvedFL6Ml
        95lUIXTAT6qDxedjfaUUlJsATSdVBCiSaLhqEvD1cfcM94UGQPBtxeO5BV0ZqCji92YFb27TCvIcW
        gVtsYk3ywUTITs3ISLtuwQXhtnuxGsw1WYm+vXO+FkO8uXoGepmckwHLswOrXSUur62n/bz6WlUXm
        VPmZGSF2QEaf2uArbAKq5JTE2BVX0kmH+8qFD//zzK1U/LHhHvP9gGZOtodS0JQmHaLBLWzQJv6GO
        cVwm7ffMQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fb6Qb-00037A-Qc; Thu, 05 Jul 2018 15:44:17 +0000
Date:   Thu, 5 Jul 2018 08:44:17 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     zongbox@gmail.com, linux-riscv@lists.infradead.org,
        aou@eecs.berkeley.edu, Andrew Waterman <andrew@sifive.com>,
        linux-kernel@vger.kernel.org, aurelien@aurel32.net
Subject: Re: [PATCH] RISC-V: Use KBUILD_CFLAGS instead of KCFLAGS when
 building the vDSO
Message-ID: <20180705154417.GB31766@infradead.org>
References: <20180704211056.1885-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180704211056.1885-1-palmer@sifive.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 04, 2018 at 02:10:56PM -0700, Palmer Dabbelt wrote:
> If you use a 64-bit compiler to build a 32-bit kernel then you'll get an
> error when building the vDSO due to a library mismatch.  The happens
> because the relevant "-march" argument isn't supplied to the GCC run
> that generates one of the vDSO intermediate files.
> 
> I'm not actually sure what the right thing to do here is as I'm not
> particularly familiar with the kernel build system.  I poked the
> documentation and it appears that KCFLAGS is the correct thing to do
> (it's suggested that should be used when building modules), but we set
> KBUILD_CFLAGS in arch/riscv/Makefile.
> 
> This does at least fix the build error.

Looks good to me for now.  In the future we might want to use different
ABIs in the kernel and in userspace, at which point we'd need yet
another cflags variable.

Reviewed-by: Christoph Hellwig <hch@lst.de>
