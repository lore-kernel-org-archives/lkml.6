Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 9PXHIu1AGVvmZgAAmS7hNA
	; Thu, 07 Jun 2018 14:28:32 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 2FCE66089E; Thu,  7 Jun 2018 14:28:32 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id A6197602FC;
	Thu,  7 Jun 2018 14:28:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A6197602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932981AbeFGOVv (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:21:51 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:39442 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933078AbeFGOJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:09:10 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbA-0005Zq-Jh; Thu, 07 Jun 2018 15:09:08 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvb7-000332-9B; Thu, 07 Jun 2018 15:09:05 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Florian Westphal" <fw@strlen.de>,
        "Mathias Krause" <minipli@googlemail.com>,
        "Steffen Klassert" <steffen.klassert@secunet.com>,
        syzbot+0ab777c27d2bb7588f73@syzkaller.appspotmail.com
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.345224122@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 230/410] xfrm_user: uncoditionally validate esn
 replay attribute struct
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Florian Westphal <fw@strlen.de>

commit d97ca5d714a5334aecadadf696875da40f1fbf3e upstream.

The sanity test added in ecd7918745234 can be bypassed, validation
only occurs if XFRM_STATE_ESN flag is set, but rest of code doesn't care
and just checks if the attribute itself is present.

So always validate.  Alternative is to reject if we have the attribute
without the flag but that would change abi.

Reported-by: syzbot+0ab777c27d2bb7588f73@syzkaller.appspotmail.com
Cc: Mathias Krause <minipli@googlemail.com>
Fixes: ecd7918745234 ("xfrm_user: ensure user supplied esn replay window is valid")
Fixes: d8647b79c3b7e ("xfrm: Add user interface for esn and big anti-replay windows")
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/xfrm/xfrm_user.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -120,22 +120,17 @@ static inline int verify_replay(struct x
 	struct nlattr *rt = attrs[XFRMA_REPLAY_ESN_VAL];
 	struct xfrm_replay_state_esn *rs;
 
-	if (p->flags & XFRM_STATE_ESN) {
-		if (!rt)
-			return -EINVAL;
-
-		rs = nla_data(rt);
+	if (!rt)
+		return (p->flags & XFRM_STATE_ESN) ? -EINVAL : 0;
 
-		if (rs->bmp_len > XFRMA_REPLAY_ESN_MAX / sizeof(rs->bmp[0]) / 8)
-			return -EINVAL;
+	rs = nla_data(rt);
 
-		if (nla_len(rt) < xfrm_replay_state_esn_len(rs) &&
-		    nla_len(rt) != sizeof(*rs))
-			return -EINVAL;
-	}
+	if (rs->bmp_len > XFRMA_REPLAY_ESN_MAX / sizeof(rs->bmp[0]) / 8)
+		return -EINVAL;
 
-	if (!rt)
-		return 0;
+	if (nla_len(rt) < xfrm_replay_state_esn_len(rs) &&
+	    nla_len(rt) != sizeof(*rs))
+		return -EINVAL;
 
 	/* As only ESP and AH support ESN feature. */
 	if ((p->id.proto != IPPROTO_ESP) && (p->id.proto != IPPROTO_AH))
