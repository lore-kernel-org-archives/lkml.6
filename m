Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10CE4C43143
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 18:21:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5BFF20880
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 18:21:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="ukcDJmv6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5BFF20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728184AbeIMXcU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 19:32:20 -0400
Received: from smtp.aristanetworks.com ([54.193.82.35]:35070 "EHLO
        uscaw2-clmxp01.aristanetworks.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726821AbeIMXcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 19:32:19 -0400
X-Greylist: delayed 475 seconds by postgrey-1.27 at vger.kernel.org; Thu, 13 Sep 2018 19:32:19 EDT
Received: from uscaw2-clmxp01.aristanetworks.com (localhost [127.0.0.1])
        by uscaw2-clmxp01.aristanetworks.com (Postfix) with ESMTP id 302C12100D19;
        Thu, 13 Sep 2018 11:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arista.com;
        s=Arista-A; t=1536862427;
        bh=xOs7cJzjGBrnvFCCH2zvU9p/c12nncn75wSd7aLpT8k=;
        h=From:To:Cc:Subject:Date;
        b=ukcDJmv6zRNwieOS3S66zg8ws344DnwOKC/2pdbleCfoWv4tdhKl+blnQXnaxp+Gr
         g07QtgqW0SOBrJASekre3+whjJbe/FkMqMZKOTPTrk9d0kWErezoMSrgoLlwfsCeql
         o95LyIhCjY4gABOU4/m1USuLFeYPwVs+fU8vOHi2mPufx8MxtLO8ml+qvTr80kE2mn
         3i+UXSBtQSO7DctVmPrcFhyZaJ8K18Eq7FCgnBmpxEwaV1LkfWvr31ToXG/5TuwNDn
         /HF9ex1zuy7ihRNrBASKb4uuzZOG/Dl5srKrQD6cslsQDSxWiKBDkrC8Lz6CEQJzHi
         hYxXFNI6dwEvA==
Received: from vasilykh-thinkpad-x1.sjc.aristanetworks.com (unknown [10.80.8.45])
        by uscaw2-clmxp01.aristanetworks.com (Postfix) with ESMTP id A2C3330EAA2C;
        Thu, 13 Sep 2018 11:13:46 -0700 (PDT)
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
        linux-kernel@vger.kernel.org,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc:     Vasily Khoruzhick <vasilykh@arista.com>
Subject: [PATCH v3] neighbour: confirm neigh entries when ARP packet is received
Date:   Thu, 13 Sep 2018 11:12:03 -0700
Message-Id: <20180913181203.4207-1-vasilykh@arista.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update 'confirmed' timestamp when ARP packet is received. It shouldn't
affect locktime logic and anyway entry can be confirmed by any higher-layer
protocol. Thus it makes sense to confirm it when ARP packet is received.

Fixes: 77d7123342 ("neighbour: update neigh timestamps iff update is effective")
Signed-off-by: Vasily Khoruzhick <vasilykh@arista.com>
---
v2: - update comment to match new code.
v3: - fix wording in commit message, make 'Fixes' tag one line, remove extra new line
      between 'Fixes' and 'Signed-off-by'.

 net/core/neighbour.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index aa19d86937af..91592fceeaad 100644
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

