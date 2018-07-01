Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BFA1C6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:19:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC0D624F81
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:19:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC0D624F81
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753502AbeGAQTO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 12:19:14 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33152 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753217AbeGAQTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:19:10 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 0636049B;
        Sun,  1 Jul 2018 16:19:09 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tobias Brunner <tobias@strongswan.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Zubin Mithra <zsm@chromium.org>
Subject: [PATCH 4.4 075/105] xfrm: Ignore socket policies when rebuilding hash tables
Date:   Sun,  1 Jul 2018 18:02:25 +0200
Message-Id: <20180701153154.850207079@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701153149.382300170@linuxfoundation.org>
References: <20180701153149.382300170@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tobias Brunner <tobias@strongswan.org>

commit 6916fb3b10b3cbe3b1f9f5b680675f53e4e299eb upstream.

Whenever thresholds are changed the hash tables are rebuilt.  This is
done by enumerating all policies and hashing and inserting them into
the right table according to the thresholds and direction.

Because socket policies are also contained in net->xfrm.policy_all but
no hash tables are defined for their direction (dir + XFRM_POLICY_MAX)
this causes a NULL or invalid pointer dereference after returning from
policy_hash_bysel() if the rebuild is done while any socket policies
are installed.

Since the rebuild after changing thresholds is scheduled this crash
could even occur if the userland sets thresholds seemingly before
installing any socket policies.

Fixes: 53c2e285f970 ("xfrm: Do not hash socket policies")
Signed-off-by: Tobias Brunner <tobias@strongswan.org>
Acked-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Zubin Mithra <zsm@chromium.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/xfrm/xfrm_policy.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -626,6 +626,10 @@ static void xfrm_hash_rebuild(struct wor
 
 	/* re-insert all policies by order of creation */
 	list_for_each_entry_reverse(policy, &net->xfrm.policy_all, walk.all) {
+		if (xfrm_policy_id2dir(policy->index) >= XFRM_POLICY_MAX) {
+			/* skip socket policies */
+			continue;
+		}
 		newpos = NULL;
 		chain = policy_hash_bysel(net, &policy->selector,
 					  policy->family,


