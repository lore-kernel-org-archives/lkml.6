Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21B7BC43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 18:07:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9343218D3
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 18:07:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="I/U4wYZu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728111AbfADSHO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 13:07:14 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:35918 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbfADSHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 13:07:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=aaxugEIMoUecQ5Xm1HD7MszHeJEuals5ZJzfLcrAQG8=; b=I/U4wYZuX98pzOXS4tQEjfobu
        6DgVtRfWobY0BauQUywF3xs4s510b9nNYpmBpvz65wz0rI7M5B/Ioz72fa3uPm9c9yfhnY8CsUhvG
        t+SDV+hY/BBuxYfaQuM3DYbUDewJAw5soe2pdOijQ2LkPBF9tZzpBPYyThQ7qChy255nHFVTvJi+Z
        YNTG51+WHGv4keO3NfW4SPfOtDJqTR3ye5/4M2ltg1CJKy6NHHQ2UaqUGZe+PFi5830A9m+za7/2n
        sg+zE1KSxZ984bQCIIO7iserIIrUys+6I9xBIdf2LNdEUaqeZpzYfYKifT52/BQ1aUY08SO10XDwH
        2eSYxKujg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gfTsE-00036Z-Vt; Fri, 04 Jan 2019 18:07:11 +0000
Date:   Fri, 4 Jan 2019 10:07:10 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Lulina (A)" <lina.lulina@huawei.com>
Cc:     "axboe@kernel.dk" <axboe@kernel.dk>, "hch@lst.de" <hch@lst.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH v2] nvme-pci: fix dbbuf_sq_db point to freed memory
Message-ID: <20190104180710.GA4642@infradead.org>
References: <E5D59058E6941147BD3ACF9CB4AA49E3B3572EC2@DGGEMA505-MBX.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E5D59058E6941147BD3ACF9CB4AA49E3B3572EC2@DGGEMA505-MBX.china.huawei.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 21, 2018 at 01:07:25AM +0000, Lulina (A) wrote:
> The case is that nvme device support NVME_CTRL_OACS_DBBUF_SUPP, and
> return failed when the driver sent nvme_admin_dbbuf. The nvmeq->dbbuf_sq_db
> point to freed memory, as nvme_dbbuf_set is called after nvme_dbbuf_init.

But we never use those pointers in that state, do we?  Can you explain
the problem in a little more detail?
