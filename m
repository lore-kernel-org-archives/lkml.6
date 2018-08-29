Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 512C1C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 06:32:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 024812086D
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 06:32:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YNO7Kvim"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 024812086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727468AbeH2K2E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 06:28:04 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57934 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726857AbeH2K2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 06:28:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=t7MB3B7X8af7rqWANJC1h7xA7sSDMzInvv2LD+/0T84=; b=YNO7KvimZlw4azsH0N9xv3s0H
        CezAEOdR0qtudZ8gYurBiTLHPd2M+G+/rV209+aipvGEz5SJeWU91YbWZ4jQrwwYvjeoGA4v74vcr
        qTQ1qTeqcFfWoMLHhXVxThy/jjwRR7BMOhXoCYYVy/98mwF2WV9jeCjiMEueTdLA5aya3EWrneZRr
        TZMEY2Gbng8E9Y0SFHHF0VjzYzMPwxS+LWRnE9t7t97118ur4t8wkft9to/faqUzmBCW/hl6dh2v1
        fLMHY9LHWrg2BExEpLeW9XRl5sw6mSNUFvVU/uJV/u5Y6pDP9PHaQHi3wHgnXAAn8xfQDUCmsXvKD
        hdEHM+N1A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fuu20-0000KK-BR; Wed, 29 Aug 2018 06:32:44 +0000
Date:   Tue, 28 Aug 2018 23:32:44 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Sam Protsenko <semen.protsenko@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        codalist@coda.cs.cmu.edu, coda@cs.cmu.edu,
        Jan Harkes <jaharkes@cs.cmu.edu>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Praneeth Bajjuri <praneeth@ti.com>,
        Paul Sokolovsky <paul.sokolovsky@linaro.org>,
        Miklos Szeredi <mszeredi@suse.cz>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Ruslan Bilovol <ruslan.bilovol@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 2/2] scsi: aic7xxx: Fix build using bare-metal toolchain
Message-ID: <20180829063244.GA32392@infradead.org>
References: <20180828142421.15335-1-semen.protsenko@linaro.org>
 <20180828142421.15335-3-semen.protsenko@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180828142421.15335-3-semen.protsenko@linaro.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2018 at 05:24:21PM +0300, Sam Protsenko wrote:
> Bare-metal toolchains don't define __linux__, so aic7xxx build with
> bare-metal toolchain is broken. Let's check __KERNEL__ definition
> instead of __linux__ (as this code won't be build for user-space anyway)
> in order to fix that.

Please just drop the ifdefs entirely.  The codebase used to be partially
shared with at least FreeBSD, but these days there is no point in
keeping the compatibility around.
