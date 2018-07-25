Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 250F8C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 09:41:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C702820685
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 09:41:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sBDQQALO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C702820685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728901AbeGYKwV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 06:52:21 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43490 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728644AbeGYKvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 06:51:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Message-Id:Date:Subject:Cc:To:From:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=RLXnBM3MeBE6DBrtM6F7yfb8k8+qGnJs7MIIuPo/FuM=; b=sBDQQALO8fSiTKO245VW3Cx8D
        HQOASz/ILhSc23hidwU4zv0y8wuJjvW4Co/83TEecxmttSWjBzB/cPgaxjdqy9h4IeyE3aeN1PyRY
        ChsU1kj/Yh5fspzkVCDR/JjfNcwDaqgMR/QwE9dxwxcrNeuf/io/ShupJmW8hi7ZwNHHmnXbNkRhW
        vlhXChPep4DGngXS3Hq4XIsg6LExX89JvbZi1goP0oBFeTKkjMXRN+o+PHIGyy4sywGnBocm7a2Av
        +QWCPxnFg/Rd/Xe/gPdjzDbApjVJQeTGswK/Q0mLUrQThSB1tU/jQTaOpT3xQ4LIlO/YTcJZRj3HP
        AK+2vGFLQ==;
Received: from [91.112.108.175] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fiGHm-0007SR-QF; Wed, 25 Jul 2018 09:40:47 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>
Cc:     Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        linux-sh@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: use the generic dma-noncoherent code for sh V3
Date:   Wed, 25 Jul 2018 11:40:38 +0200
Message-Id: <20180725094043.32443-1-hch@lst.de>
X-Mailer: git-send-email 2.18.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

can you review these patches to switch sh to use the generic
dma-noncoherent code?  All the requirements are in mainline already
and we've switched various architectures over to it already.

Changes since V2:
 - drop a now obsolete export

Changes since V1:
 - fixed two stupid compile errors and verified them using a local
   cross toolchain instead of the 0day buildbot
