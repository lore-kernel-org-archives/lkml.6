Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49DD7C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 18:12:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02E822086A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 18:12:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="nKTp/aMm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02E822086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728073AbeIKXNE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 19:13:04 -0400
Received: from mx.aristanetworks.com ([162.210.129.12]:29904 "EHLO
        prod-mx.aristanetworks.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726622AbeIKXNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 19:13:04 -0400
X-Greylist: delayed 501 seconds by postgrey-1.27 at vger.kernel.org; Tue, 11 Sep 2018 19:13:03 EDT
Received: from prod-mx.aristanetworks.com (localhost [127.0.0.1])
        by prod-mx.aristanetworks.com (Postfix) with ESMTP id 2E33E194B;
        Tue, 11 Sep 2018 11:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arista.com;
        s=Arista-A; t=1536689055;
        bh=mtOIPUbI5AZNOxnziRVMV2p7Gv3ldKHNoDJmZMtHpZY=;
        h=From:To:Cc:Subject:Date;
        b=nKTp/aMmGLTXODcccIORWMIfa0TgnK+rsAVr7Vnsrnsjs/3OJ0a2En7qZm/D5xC4H
         yD/N11nTs98AiUnQD+NgGk12VjQS9LvxzgwLd72Y1YkXc2aGRC5wA950kNZBcO20Vq
         htKWbqDDf3vhRUqy8Grsylwj0IssSdfDgpHONqbV3ODexyVDt2kjMwXgpuEsy6xDRT
         YAuMWRv6rXGwB+hDNjMrlH8P0HQJcwXArlp8nqH5i5Dz9DGjG1oOAN3uxvWa0kN2dV
         ZcEDEwHq1offCi54uYS9VLORL+J1Q2WyC2ouWi3ARmxnQGE54VRdT4xKGkHyi8P4yb
         pveu/7tH0kKOQ==
Received: from vasilykh-thinkpad-x1.sjc.aristanetworks.com (unknown [10.80.8.45])
        by prod-mx.aristanetworks.com (Postfix) with ESMTP id B1B511940;
        Tue, 11 Sep 2018 11:04:14 -0700 (PDT)
From:   Vasily Khoruzhick <vasilykh@arista.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Roopa Prabhu <roopa@cumulusnetworks.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Jim Westfall <jwestfall@surrealistic.net>,
        Wolfgang Bumiller <w.bumiller@proxmox.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Ihar Hrachyshka <ihrachys@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Vasily Khoruzhick <vasilykh@arista.com>
Subject: [PATCH v2] neighbour: confirm neigh entries when ARP packet is received
Date:   Tue, 11 Sep 2018 11:04:06 -0700
Message-Id: <20180911180406.31283-1-vasilykh@arista.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update 'confirmed' timestamp when ARP packet is received. It shouldn't
affect locktime logic and anyway entry can be confirmed by any higher-layer
protocol. Thus it makes to sense not to confirm it when ARP packet is
received.

Fixes: 77d7123342 ("neighbour: update neigh timestamps iff update is
effective")

Signed-off-by: Vasily Khoruzhick <vasilykh@arista.com>
---
v2: - update comment to match new code.

 net/core/neighbour.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index aa19d86937af..56a554597db5 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -1180,6 +1180,12 @@ int neigh_update(struct neighbour *neigh, const u8 *lladdr, u8 new,
 		lladdr = neigh->ha;
 	}
 
+	/* Update confirmed timestamp for neighbour entry after we
+	 * received ARP packet even if it doesn't change IP to MAC binding.
+	 */
+	if (new & NUD_CONNECTED)
+		neigh->confirmed = jiffies;
+
 	/* If entry was valid and address is not changed,
 	   do not change entry state, if new one is STALE.
 	 */
@@ -1201,15 +1207,12 @@ int neigh_update(struct neighbour *neigh, const u8 *lladdr, u8 new,
 		}
 	}
 
-	/* Update timestamps only once we know we will make a change to the
+	/* Update timestamp only once we know we will make a change to the
 	 * neighbour entry. Otherwise we risk to move the locktime window with
 	 * noop updates and ignore relevant ARP updates.
 	 */
-	if (new != old || lladdr != neigh->ha) {
-		if (new & NUD_CONNECTED)
-			neigh->confirmed = jiffies;
+	if (new != old || lladdr != neigh->ha)
 		neigh->updated = jiffies;
-	}
 
 	if (new != old) {
 		neigh_del_timer(neigh);
-- 
2.18.0

