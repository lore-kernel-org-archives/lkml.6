Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 9DB30C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 12:34:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53756208B2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 12:34:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kbMjy9UT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53756208B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935559AbeFMMeV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 08:34:21 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45938 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935328AbeFMMeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 08:34:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Message-Id:Date:Subject:Cc:To:From:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=uVij+/xbaWEZEma42IFEvZ2sSQ4C3+6+1OaY47qBSdI=; b=kbMjy9UTAzRlKIIN298Wn/bxg
        6p979T9ot4OGUVppNh+qLsqTnEPbZlsxJEcFISGey/AgYc8seZRGMdcZxVr8gYh8JVm+anrxnhhbF
        E8qx/q49+n1POla0MkST0IUGpBR23gcUQk40EFGeyFd81PRknn7f0YHRJ5RXqVkQwyuEkFRFHxgEC
        /XFBPkVFRbpPRogIRqAmcc9FJcV7uIqz3RvfPMdtUTcrTNw8yZcNzvbi2y3D4c3sU2S52Z3/CSR2J
        QBUWyqFmsKSnIJe96r7y9ajLQc9Z8GBjN1ztyYctBXbqOnX26YT5UIqsR6L7H0w5j1Fwe1MXlmcr6
        CbcT2SCyA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fT4yd-0006kf-6S; Wed, 13 Jun 2018 12:34:15 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     hans.westgaard.ry@oracle.com, Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-rdma@vger.kernel.org,
        =?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>,
        Parav Pandit <parav@mellanox.com>,
        Jack Morgenstein <jackm@dev.mellanox.co.il>,
        Pravin Shedge <pravin.shedge4linux@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] Convert IB/mad to use an IDR for agent IDs
Date:   Wed, 13 Jun 2018 05:34:01 -0700
Message-Id: <20180613123403.25233-1-willy@infradead.org>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the review / feedback / testing.  Here's v3.  Changes:

 - Split out the change to the IDR code into its own patch.
 - Dropped the "Agent registration is process context only" patch as
   Jason already merged it.
 - Added comment about why we're limiting the agent ID to 2^24.
 - Used a named constant instead of a bare '1 << 24'.
 - Updated the changelog to incorporate more of Hans' original message.
 - Added Tested-by, Acked-by and Reported-by to the second patch.

Matthew Wilcox (2):
  IDR: Expose the XArray lock
  IB/mad: Use IDR for agent IDs

 drivers/infiniband/core/mad.c      | 83 ++++++++++++++++++------------
 drivers/infiniband/core/mad_priv.h |  7 +--
 include/linux/idr.h                | 11 ++++
 3 files changed, 66 insertions(+), 35 deletions(-)

-- 
2.17.1

