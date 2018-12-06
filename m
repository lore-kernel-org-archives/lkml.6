Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63177C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:37:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E104214C1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:37:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bKtv9us2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E104214C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726169AbeLFPhc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 10:37:32 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:35508 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbeLFPhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 10:37:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=7/CO/XZKBp5lTPZblOoX1Ml/Yl52k3jny4cR57zEhBs=; b=bKtv9us2R5DregY2MBf5CUU1E
        Vez0eQ0ajmYmPUQbIe6lCBpl/ytsllBiyumFpxjade1yTW1nnx2zfPdwiCC0APyoPwOkKGp4fTc01
        igAWi3YXlSl41Uwi4hQZhdcsy74MwPZ/hZeOYueHXZ+GuoKU41x8WGWsoVEMRoSAkxtqbxaGHvRU6
        SXV1+7d+0A6KWgF7jiRjYJOwPnGoDDlfzrd3zK4W3EmwaRwb1PzlkPYoBTifusMhLhQHelmytzp85
        XHUUtaGuF8QTT0sKzgTQUflsg7jiNhZMHtyEtOPKWBEQpRWc3I/E84kvy2YYolHjXry/MLq3aycl2
        OwIj1aG0w==;
Received: from [38.126.112.138] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gUviO-0000ms-1b; Thu, 06 Dec 2018 15:37:24 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Cc:     Tariq Toukan <tariqt@mellanox.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org
Subject: [RFC] avoid indirect calls for DMA direct mappings
Date:   Thu,  6 Dec 2018 07:37:19 -0800
Message-Id: <20181206153720.10702-1-hch@lst.de>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

a while ago Jesper reported major performance regressions due to the
spectre v2 mitigations in his XDP forwarding workloads.  A large part
of that is due to the DMA mapping API indirect calls.

It turns out that the most common implementation of the DMA API is the
direct mapping case, and now that we have merged almost all duplicate
implementations of that into a single generic one is easily feasily to
direct calls for this fast path.

This patch adds a check if we are using dma_direct_ops in each fast path
DMA operation, and just uses a direct call instead.  For the XDP workload
this increases the number of packets per second from 7,438,283 to
9,610,088, so it provides a very significant speedup.

Note that the patch depends on a lot of work either queued up in the
DMA mapping tree, or still out on the list from review, so to actually
try the patch you probably want this git tree:


    git://git.infradead.org/users/hch/misc.git dma-direct-calls

Gitweb:

    http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/dma-direct-calls

