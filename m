Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D654EC65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:56:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB4E72082D
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:56:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="GkLhpz0R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB4E72082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731644AbeKCEEu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 00:04:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:60884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726051AbeKCEEu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 00:04:50 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 04CA32082D;
        Fri,  2 Nov 2018 18:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541184993;
        bh=yfFsV9I0ufO4XyfU5b1dxtZFBglxsvubtFrSJgOh8Ks=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GkLhpz0RvOYNeMmVM7WerxGzbHB9ss/h9vBmxgf2A9j+LB9eoyTp7K7EbGCaQkPjt
         d/Hb4O14WhebifiwZs0aUoJkhhn/4YTn83jU1ewTdrT3gUl/KuXUpzDpxVUM7SGs8D
         FR6LTvQaBnSDcyk8t31PdK77zaSIWMkBxs0Wxzeo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Colin Ian King <colin.king@canonical.com>,
        Nikolay Aleksandrov <nikolay@cumulusnetworks.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 141/143] net: ipmr: fix unresolved entry dumps
Date:   Fri,  2 Nov 2018 19:35:26 +0100
Message-Id: <20181102182908.943296040@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181102182857.064326086@linuxfoundation.org>
References: <20181102182857.064326086@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>

[ Upstream commit eddf016b910486d2123675a6b5fd7d64f77cdca8 ]

If the skb space ends in an unresolved entry while dumping we'll miss
some unresolved entries. The reason is due to zeroing the entry counter
between dumping resolved and unresolved mfc entries. We should just
keep counting until the whole table is dumped and zero when we move to
the next as we have a separate table counter.

Reported-by: Colin Ian King <colin.king@canonical.com>
Fixes: 8fb472c09b9d ("ipmr: improve hash scalability")
Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/ipmr.c |    2 --
 1 file changed, 2 deletions(-)

--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -2499,8 +2499,6 @@ static int ipmr_rtm_dumproute(struct sk_
 next_entry:
 			e++;
 		}
-		e = 0;
-		s_e = 0;
 
 		spin_lock_bh(&mfc_unres_lock);
 		list_for_each_entry(mfc, &mrt->mfc_unres_queue, list) {


