Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CE68C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:25:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02F3D2184E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:25:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kZp/FFFN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbfBKNZk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 08:25:40 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:37078 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727473AbfBKNZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 08:25:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=241WfaVALdT/S8dzhbRmGfT6lkYWBdbO9x1Wi/qJFQ4=; b=kZp/FFFNvAOzhaVbg6GBmxoUD
        v/yHlYssVC5Pt7wAns1csvgAFAACDCNJo/TyfQAUzUHXmmIOPYQ4P8ARR8Gozty/jepmsmtcMFD7v
        RgPRnh/+1kT/YnMroMdjhOQI7IQAl0D2aLGTeoF1m/aPhn2O/FGVK/P+cVUXkWqDzvx25TKYlYrSe
        U4ZfQm7PucKGYfdpOuoyM31p3bdeX9a/5ezBCezFxFVTThZ1H6HkMUwm/LGNmhftCqQo8XVUHbwHb
        qgxa4Pf0btdHnU12ocu0f51RZxGnAQEkfWiX2BXQGgCte2E2VOAoDN0IUggrvNB8QU03tqtZqXmoC
        5DYPGmwLg==;
Received: from 089144210182.atnat0019.highway.a1.net ([89.144.210.182] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gtBab-0003ge-Mz; Mon, 11 Feb 2019 13:25:38 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: RFC: drop ISA support in the synlink tty driver?
Date:   Mon, 11 Feb 2019 14:25:33 +0100
Message-Id: <20190211132534.29407-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg and Jiri,

I've been working hard to get rid of the remaining callers the pass a
NULL struct device to the DMA mapping functions and am almost done.

The only non-trivial driver is the synclink driver, which has legacy
early 90s style ISA support that doesn't use the device model at all.

In theory we could convert it to an isa_driver, but without testing
that seems rather dangerous.  So for now I would suggest that we
remove the ISA support in this driver - if anyone cares enough we
can resurrect it from the git history and convert it to use the driver
model.
