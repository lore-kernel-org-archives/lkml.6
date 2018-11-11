Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7D59C43610
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:16:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A61E12080D
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:16:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A61E12080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731955AbeKLGGN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:06:13 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:53206 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730491AbeKLGGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 01:06:12 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvst-0000l5-Jm; Sun, 11 Nov 2018 19:59:03 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsV-0001fd-D1; Sun, 11 Nov 2018 19:58:39 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Jason Gunthorpe" <jgg@mellanox.com>,
        "Leon Romanovsky" <leonro@mellanox.com>,
        "Ran Rozenstein" <ranro@mellanox.com>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.203293351@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 224/366] RDMA/uverbs: Don't fail in creation of
 multiple flows
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Leon Romanovsky <leonro@mellanox.com>

commit fe48aecb4df837540f13b5216f27ddb306aaf4b9 upstream.

The conversion from offsetof() calculations to sizeof()
wrongly behaved for missed exact size and in scenario with
more than one flow.

In such scenario we got "create flow failed, flow 10: 8 bytes
left from uverb cmd" error, which is wrong because the size of
kern_spec is exactly 8 bytes, and we were not supposed to fail.

Fixes: 4fae7f170416 ("RDMA/uverbs: Fix slab-out-of-bounds in ib_uverbs_ex_create_flow")
Reported-by: Ran Rozenstein <ranro@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/infiniband/core/uverbs_cmd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -2761,7 +2761,7 @@ int ib_uverbs_ex_create_flow(struct ib_u
 	kern_spec = kern_flow_attr->flow_specs;
 	ib_spec = flow_attr + 1;
 	for (i = 0; i < flow_attr->num_of_specs &&
-			cmd.flow_attr.size > sizeof(*kern_spec) &&
+			cmd.flow_attr.size >= sizeof(*kern_spec) &&
 			cmd.flow_attr.size >= kern_spec->size;
 	     i++) {
 		err = kern_spec_to_ib_spec(

