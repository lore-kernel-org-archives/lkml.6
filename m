Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id c6XYFf1GGVuiOgAAmS7hNA
	; Thu, 07 Jun 2018 14:55:09 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 2033D608B8; Thu,  7 Jun 2018 14:55:09 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 1BD6D606DD;
	Thu,  7 Jun 2018 14:55:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1BD6D606DD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935452AbeFGOzE (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:55:04 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41037 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S935431AbeFGOzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:55:02 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbO-0005Zs-O2; Thu, 07 Jun 2018 15:09:23 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbD-0003Gi-FR; Thu, 07 Jun 2018 15:09:11 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Daniel Borkmann" <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.949680204@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 372/410] skb: Add skb_postpush_rcsum()
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

From: Ben Hutchings <ben@decadent.org.uk>

This is based on commit f8ffad69c9f8b8dfb0b633425d4ef4d2493ba61a upstream,
"bpf: add skb_postpush_rcsum and fix dev_forward_skb occasions".  We don't
need the bpf fixes here, just the new function.

Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: David S. Miller <davem@davemloft.net>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -2477,6 +2477,23 @@ static inline void skb_postpull_rcsum(st
 
 unsigned char *skb_pull_rcsum(struct sk_buff *skb, unsigned int len);
 
+static inline void skb_postpush_rcsum(struct sk_buff *skb,
+				      const void *start, unsigned int len)
+{
+	/* For performing the reverse operation to skb_postpull_rcsum(),
+	 * we can instead of ...
+	 *
+	 *   skb->csum = csum_add(skb->csum, csum_partial(start, len, 0));
+	 *
+	 * ... just use this equivalent version here to save a few
+	 * instructions. Feeding csum of 0 in csum_partial() and later
+	 * on adding skb->csum is equivalent to feed skb->csum in the
+	 * first place.
+	 */
+	if (skb->ip_summed == CHECKSUM_COMPLETE)
+		skb->csum = csum_partial(start, len, skb->csum);
+}
+
 /**
  *	pskb_trim_rcsum - trim received skb and update checksum
  *	@skb: buffer to trim
