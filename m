Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 930D9C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 09:59:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 568CC20663
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 09:59:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VAtkHUKW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbfANJ7p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 04:59:45 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:57548 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726613AbfANJ6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 04:58:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=9zVnbZFF6VQhFEeZa4Fxs5Rbe32mfsDR1+//PoM/j7I=; b=VAtkHUKWQBwwUKRqcGYqL6dDe
        OfF3DtVvJU3Q3AJ9kWWFuVoFFXKvoq2gah10bpIRRS+t75DDLR88sFBUO9hNcCtjKzba+m4L5RF4v
        qGvYvlFO3FbdmhJyfL4ThE6ASM2hPE5y9Y441CNWkLHWctSs9iQW2DwHjGvGPuJDo9hxa6GPNZuLv
        OA/dzBdgQf6UEyMVHz2AJa7hBRTix9mFVZWDJKewy0dujrbYE8YGaklhS88kdl+mnXpT6zntNIBYi
        Mxge0UEwipfOirPdNOOd7npebUQLONZF3w9HkYgR7kcdghQsJS4WwHTWTYt/qcZy4+KphV2wG8ex7
        82VWMkCAQ==;
Received: from 089144213167.atnat0022.highway.a1.net ([89.144.213.167] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1giz0Q-0001qs-MQ; Mon, 14 Jan 2019 09:58:07 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Nicolas Pitre <nico@fluxnic.net>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Ben Dooks <ben-linux@fluff.org>, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: remove block layer bounce buffering for MMC
Date:   Mon, 14 Jan 2019 10:57:53 +0100
Message-Id: <20190114095804.27978-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

this series converts the remaining MMC host drivers to properly kmap the
scatterlist entries it does PIO operations on, and then goes on to
remove the usage of block layer bounce buffering (which I plan to remove
eventually) from the MMC layer.

As a bonus I've converted various drivers to the proper scatterlist
helpers so that at least in theory they are ready for chained
scatterlists.

All the changes are compile tested only as I don't have any of the
hardware, so a careful review would be appreciated.
