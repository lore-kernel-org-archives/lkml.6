Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBB4EC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 20:13:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81F062084C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 20:13:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GFdJDYeY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81F062084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbeJBCw3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 22:52:29 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48934 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbeJBCw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 22:52:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ImQIRzPG9HykwdfAz8RtfMS/Opx97ncw0m/la15jfqM=; b=GFdJDYeY/jKhG2XAn9Y2QpNzc
        XJ+gqADZGwAFkvevcSCU38WIUQCtIzg0h0pTKi/H4AmD8il8AE3Xqe5hO1TSoUXAn4pu6J2rZ4QRB
        2GuaqF9awrJT+W4knLg797/rjRPQyLquLcRIbnuJPCKzGEspDVQlhxQaZmeASWg3CHyPx3EuQLQz3
        MTJ0VFrV2c12hLn/gph+IL2+0CxNSQTmRo0aCcCbkf7VNOIa3wEAbbSpBGI3mlqPGV+bcqB0ahAgT
        HlBnC1McrOEVcs7o6Gww8SgVKz93ku28QoRp4itFoBD69RD7/tx68GHCBpZjHB7kPwu/AhQZGujcN
        jAh0Icycg==;
Received: from [38.126.112.138] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g74Yr-0006w5-WC; Mon, 01 Oct 2018 20:12:58 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org
Subject: fix up nowarn confusion in the dma mapping layer
Date:   Mon,  1 Oct 2018 13:12:55 -0700
Message-Id: <20181001201257.366-1-hch@lst.de>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

this series sorts out how we deal with the nowarn flags in the dma
mapping code.  We still support __GFP_NOWARN for the legacy APIs that
don't support passing the dma specific flags, but we generally want
every implementation to actually check DMA_ATTR_NO_WARN instead.
