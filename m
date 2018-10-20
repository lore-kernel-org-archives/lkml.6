Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B74E4C67863
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 23:14:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5673321523
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 23:14:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5673321523
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=opengridcomputing.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbeJUH0W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Oct 2018 03:26:22 -0400
Received: from linode.aoot.com ([69.164.194.13]:42518 "EHLO linode.aoot.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726609AbeJUH0W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Oct 2018 03:26:22 -0400
Received: from stevoacer (47-221-137-213.gtwncmta03.res.dyn.suddenlink.net [47.221.137.213])
        by linode.aoot.com (Postfix) with ESMTP id D70FA835F;
        Sat, 20 Oct 2018 18:14:13 -0500 (CDT)
From:   "Steve Wise" <swise@opengridcomputing.com>
To:     "'Wenwen Wang'" <wang6495@umn.edu>
Cc:     "'Kangjie Lu'" <kjlu@umn.edu>, "'Steve Wise'" <swise@chelsio.com>,
        "'Doug Ledford'" <dledford@redhat.com>,
        "'Jason Gunthorpe'" <jgg@ziepe.ca>,
        "'open list:CXGB4 IWARP RNIC DRIVER \(IW_CXGB4\)'" 
        <linux-rdma@vger.kernel.org>,
        "'open list'" <linux-kernel@vger.kernel.org>
References: <1540072741-18856-1-git-send-email-wang6495@umn.edu>
In-Reply-To: <1540072741-18856-1-git-send-email-wang6495@umn.edu>
Subject: RE: [PATCH] iw_cxgb4: fix a missing-check bug
Date:   Sat, 20 Oct 2018 18:14:12 -0500
Message-ID: <038301d468ca$9d30ca90$d7925fb0$@opengridcomputing.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
Thread-Index: AQHGM3QZHxRys26vq/PiwJXt1dGVDaVFLSog
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Wenwen,

> Subject: [PATCH] iw_cxgb4: fix a missing-check bug
> 
> In c4iw_flush_hw_cq, the next CQE is acquired through t4_next_hw_cqe(). In
> t4_next_hw_cqe(), the CQE, i.e., 'cq->queue[cq->cidx]', is checked to see
> whether it is valid through t4_valid_cqe(). If it is valid, the address of
> the CQE is then saved to 'hw_cqe'. Later on, the CQE is copied to the
local
> memory in create_read_req_cqe(). The problem here is that the CQE is
> actually in a DMA region allocated by dma_alloc_coherent() in create_cq().
> Given that the device also has the permission to access the DMA region, a
> malicious device controlled by an attacker can modify the CQE in the DMA
> region after the check in t4_next_hw_cqe() but before the copy in
> create_read_req_cqe(). By doing so, the attacker can supply invalid CQE,
> which can cause undefined behavior of the kernel and introduce potential
> security risks.
> 

If the dma device is malicious, couldn't it just dma some incorrect CQE but
still valid in the first place?  I don't think this patch actually solves
the issue, and it forces a copy of a 64B CQE in a critical data io path.  

So I must NACK this. 

Thanks,

Steve.


