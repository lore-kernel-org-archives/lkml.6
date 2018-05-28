Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S939484AbeE1Ozq (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 10:55:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:47106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936926AbeE1K1m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:27:42 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Shiraz Saleem <shiraz.saleem@intel.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 034/329] i40iw: Zero-out consumer key on allocate stag for FMR
Date: Mon, 28 May 2018 11:59:23 +0200
Message-Id: <20180528100245.278270126@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100241.796630982@linuxfoundation.org>
References: <20180528100241.796630982@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shiraz Saleem <shiraz.saleem@intel.com>

[ Upstream commit 6376e926af1a8661dd1b2e6d0896e07f84a35844 ]

If the application invalidates the MR before the FMR WR, HW parses the
consumer key portion of the stag and returns an invalid stag key
Asynchronous Event (AE) that tears down the QP.

Fix this by zeroing-out the consumer key portion of the allocated stag
returned to application for FMR.

Fixes: ee855d3b93f3 ("RDMA/i40iw: Add base memory management extensions")
Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/hw/i40iw/i40iw_verbs.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/infiniband/hw/i40iw/i40iw_verbs.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_verbs.c
@@ -1515,6 +1515,7 @@ static struct ib_mr *i40iw_alloc_mr(stru
 		err_code = -EOVERFLOW;
 		goto err;
 	}
+	stag &= ~I40IW_CQPSQ_STAG_KEY_MASK;
 	iwmr->stag = stag;
 	iwmr->ibmr.rkey = stag;
 	iwmr->ibmr.lkey = stag;
