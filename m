Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id Y4voDBLAGlshfgAAmS7hNA
	; Fri, 08 Jun 2018 17:42:42 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 182446089E; Fri,  8 Jun 2018 17:42:42 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Am/DcqBz"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 89C74605A2;
	Fri,  8 Jun 2018 17:42:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 89C74605A2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752984AbeFHRmi (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 13:42:38 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36712 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752328AbeFHRmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 13:42:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Message-Id:Date:Subject:Cc:To:From:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=8svxQJHCnDNwnOBLknPNB23MDOWLTKyhqQk3ffmgcdM=; b=Am/DcqBzSoATmNBax2a7vEi+G
        F/tYv42ccM3Flig31/2DswoWrfUxSoveXzqttjjMZRCoVYlWjM7JpbP5XWDE66v3wbzhQwtTxYgzA
        L125/vz6ksapClEAz1Ov7w87mTbvVlawk+iW/7+qvuisI3QuAc0Za1QWOn8EOcMEKLKMIu3H6W5C3
        jiMNm/2wCv8lXHzQuPUsB5P9UMHlappjcOKJ5hsSTeFhK2kahZqoIsK5d+VMYFGeFbXDx81tpZ+Rt
        5hs+ENmDlMKNXZjAtdTtABH+/HAzQEYWhyDn3l0a3L5jmREs2E57ygYFHFAmE2emjMJBPbgyQQz4J
        JS/4QrRxw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fRLP3-0008TM-0M; Fri, 08 Jun 2018 17:42:21 +0000
From: Matthew Wilcox <willy@infradead.org>
To: hans.westgaard.ry@oracle.com, Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc: Matthew Wilcox <mawilcox@microsoft.com>,
        linux-rdma@vger.kernel.org,
        =?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>,
        Parav Pandit <parav@mellanox.com>,
        Jack Morgenstein <jackm@dev.mellanox.co.il>,
        Pravin Shedge <pravin.shedge4linux@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Convert IB/mad to use an IDR for agent IDs
Date: Fri,  8 Jun 2018 10:42:16 -0700
Message-Id: <20180608174218.32455-1-willy@infradead.org>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthew Wilcox <mawilcox@microsoft.com>

Compared to the RFC I sent yesterday, this version retains the per-port
spinlock for use when looking up the MAD agent by vendor/class/etc.
Now we should only see a performance improvement relative to the current
code.  We should see that improvement two different ways: interrupts
remain enabled and no spinlock is taken when doing a lookup in the IDR,
and we don't walk a linked list looking for the right agent; we just
walk the (low height) tree and find the correct agent.

There are more improvements that could be made, but this fixes the mlx4
bug that Hans reported.

Matthew Wilcox (2):
  IB/mad: Agent registration is process context only
  IB/mad: Use IDR for agent IDs

 drivers/infiniband/core/mad.c      | 90 ++++++++++++++++++------------
 drivers/infiniband/core/mad_priv.h |  7 ++-
 include/linux/idr.h                |  9 +++
 3 files changed, 66 insertions(+), 40 deletions(-)

-- 
2.17.1
