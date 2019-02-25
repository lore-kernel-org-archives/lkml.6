Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D53EC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:33:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDA7A21841
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551130424;
	bh=vudtx12oHcq2Bp0tQq5lxNFVflGs+C9/eCjyPrrrM/g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=x7SDSwUnA90SjhFG6DS7UjFuC/yJrTW9AIyG+r76LAbspBdeHISK+8sKY6vipL970
	 9Br3Bgm7LrlhzZn7iEYNVchrOZr91CZLXaVEzwUx9clrYBfASQIRpkGH+UJEcT4GRd
	 E0zfbOKPTWQXD0ZkAJ56fTDzbu6jeQ9lK7TA5MC4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732358AbfBYVdn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:33:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:39894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732244AbfBYVdk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:33:40 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3FEF5217F5;
        Mon, 25 Feb 2019 21:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551130419;
        bh=vudtx12oHcq2Bp0tQq5lxNFVflGs+C9/eCjyPrrrM/g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AoAvFro0mi1OhX7y0p3RmlE8pBYx00qfvw9TH9PyH4SODBiVX/RV9E4gkmTnYvtpD
         6h35S4AsAQSXemVSWn+sSgyS5yfIJIEVovhChV9dmVYiM+Epgg6KSHHqCeKL9oA7xK
         WCy5HjiL21kGKXRTxYGWutzOy4zaS29CP+mlYFKI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ido Schimmel <idosch@mellanox.com>,
        Alexander Petrovskiy <alexpe@mellanox.com>,
        Petr Machata <petrm@mellanox.com>,
        Roopa Prabhu <roopa@cumulusnetworks.com>,
        Nikolay Aleksandrov <nikolay@cumulusnetworks.com>,
        bridge@lists.linux-foundation.org,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 116/183] net: bridge: Mark FDB entries that were added by user as such
Date:   Mon, 25 Feb 2019 22:11:29 +0100
Message-Id: <20190225195114.133478058@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195054.748060397@linuxfoundation.org>
References: <20190225195054.748060397@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 710ae72877378e7cde611efd30fe90502a6e5b30 ]

Externally learned entries can be added by a user or by a switch driver
that is notifying the bridge driver about entries that were learned in
hardware.

In the first case, the entries are not marked with the 'added_by_user'
flag, which causes switch drivers to ignore them and not offload them.

The 'added_by_user' flag can be set on externally learned FDB entries
based on the 'swdev_notify' parameter in br_fdb_external_learn_add(),
which effectively means if the created / updated FDB entry was added by
a user or not.

Fixes: 816a3bed9549 ("switchdev: Add fdb.added_by_user to switchdev notifications")
Signed-off-by: Ido Schimmel <idosch@mellanox.com>
Reported-by: Alexander Petrovskiy <alexpe@mellanox.com>
Reviewed-by: Petr Machata <petrm@mellanox.com>
Cc: Roopa Prabhu <roopa@cumulusnetworks.com>
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Cc: bridge@lists.linux-foundation.org
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bridge/br_fdb.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
index e56ba3912a905..8b8abf88befbd 100644
--- a/net/bridge/br_fdb.c
+++ b/net/bridge/br_fdb.c
@@ -1102,6 +1102,8 @@ int br_fdb_external_learn_add(struct net_bridge *br, struct net_bridge_port *p,
 			err = -ENOMEM;
 			goto err_unlock;
 		}
+		if (swdev_notify)
+			fdb->added_by_user = 1;
 		fdb->added_by_external_learn = 1;
 		fdb_notify(br, fdb, RTM_NEWNEIGH, swdev_notify);
 	} else {
@@ -1121,6 +1123,9 @@ int br_fdb_external_learn_add(struct net_bridge *br, struct net_bridge_port *p,
 			modified = true;
 		}
 
+		if (swdev_notify)
+			fdb->added_by_user = 1;
+
 		if (modified)
 			fdb_notify(br, fdb, RTM_NEWNEIGH, swdev_notify);
 	}
-- 
2.19.1



