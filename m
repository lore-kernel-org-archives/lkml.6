Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D49B6C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:20:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8144020844
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:20:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8144020844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404609AbeHATGk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:06:40 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:48940 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404595AbeHATGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:06:40 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id ED6C6D38;
        Wed,  1 Aug 2018 17:19:57 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Alexander Boyko <alexander.boyko@seagate.com>,
        Alexey Lyashkov <c17817@cray.com>,
        Doug Oucharek <dougso@me.com>,
        "John L. Hammond" <john.hammond@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 165/246] staging: lustre: o2iblnd: fix race at kiblnd_connect_peer
Date:   Wed,  1 Aug 2018 18:51:15 +0200
Message-Id: <20180801165019.647438013@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801165011.700991984@linuxfoundation.org>
References: <20180801165011.700991984@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Doug Oucahrek <dougso@me.com>

[ Upstream commit cf04968efe341b9b1c30a527e5dd61b2af9c43d2 ]

cmid will be destroyed at OFED if kiblnd_cm_callback return error.
if error happen before the end of kiblnd_connect_peer, it will touch
destroyed cmid and fail as
(o2iblnd_cb.c:1315:kiblnd_connect_peer())
            ASSERTION( cmid->device != ((void *)0) ) failed:

Signed-off-by: Alexander Boyko <alexander.boyko@seagate.com>
Intel-bug-id: https://jira.hpdd.intel.com/browse/LU-10015
Reviewed-by: Alexey Lyashkov <c17817@cray.com>
Reviewed-by: Doug Oucharek <dougso@me.com>
Reviewed-by: John L. Hammond <john.hammond@intel.com>
Signed-off-by: Doug Oucharek <dougso@me.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd_cb.c |   18 +++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

--- a/drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd_cb.c
+++ b/drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd_cb.c
@@ -1289,11 +1289,6 @@ kiblnd_connect_peer(struct kib_peer *pee
 		goto failed2;
 	}
 
-	LASSERT(cmid->device);
-	CDEBUG(D_NET, "%s: connection bound to %s:%pI4h:%s\n",
-	       libcfs_nid2str(peer->ibp_nid), dev->ibd_ifname,
-	       &dev->ibd_ifip, cmid->device->name);
-
 	return;
 
  failed2:
@@ -2995,8 +2990,19 @@ kiblnd_cm_callback(struct rdma_cm_id *cm
 		} else {
 			rc = rdma_resolve_route(
 				cmid, *kiblnd_tunables.kib_timeout * 1000);
-			if (!rc)
+			if (!rc) {
+				struct kib_net *net = peer->ibp_ni->ni_data;
+				struct kib_dev *dev = net->ibn_dev;
+
+				CDEBUG(D_NET, "%s: connection bound to "\
+				       "%s:%pI4h:%s\n",
+				       libcfs_nid2str(peer->ibp_nid),
+				       dev->ibd_ifname,
+				       &dev->ibd_ifip, cmid->device->name);
+
 				return 0;
+			}
+
 			/* Can't initiate route resolution */
 			CERROR("Can't resolve route for %s: %d\n",
 			       libcfs_nid2str(peer->ibp_nid), rc);


