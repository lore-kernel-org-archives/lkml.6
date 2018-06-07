Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id ho4MJBtaGVvoDQAAmS7hNA
	; Thu, 07 Jun 2018 16:15:39 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 6C2B7607E7; Thu,  7 Jun 2018 16:15:39 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id D9F7460115;
	Thu,  7 Jun 2018 16:15:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D9F7460115
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936106AbeFGQPg (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 12:15:36 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:39115 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932899AbeFGOI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:08:58 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvay-0005Zx-Hl; Thu, 07 Jun 2018 15:08:56 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvax-0002hD-HI; Thu, 07 Jun 2018 15:08:55 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Florian Westphal" <fw@strlen.de>,
        "Pablo Neira Ayuso" <pablo@netfilter.org>,
        "" <syzbot+845a53d13171abf8bf29@syzkaller.appspotmail.com>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.894752538@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 015/410] netfilter: ebtables: CONFIG_COMPAT: don't
 trust userland offsets
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

commit b71812168571fa55e44cdd0254471331b9c4c4c6 upstream.

We need to make sure the offsets are not out of range of the
total size.
Also check that they are in ascending order.

The WARN_ON triggered by syzkaller (it sets panic_on_warn) is
changed to also bail out, no point in continuing parsing.

Briefly tested with simple ruleset of
-A INPUT --limit 1/s' --log
plus jump to custom chains using 32bit ebtables binary.

Reported-by: <syzbot+845a53d13171abf8bf29@syzkaller.appspotmail.com>
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/bridge/netfilter/ebtables.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

--- a/net/bridge/netfilter/ebtables.c
+++ b/net/bridge/netfilter/ebtables.c
@@ -2010,7 +2010,9 @@ static int ebt_size_mwt(struct compat_eb
 		if (match_kern)
 			match_kern->match_size = ret;
 
-		WARN_ON(type == EBT_COMPAT_TARGET && size_left);
+		if (WARN_ON(type == EBT_COMPAT_TARGET && size_left))
+			return -EINVAL;
+
 		match32 = (struct compat_ebt_entry_mwt *) buf;
 	}
 
@@ -2067,6 +2069,15 @@ static int size_entry_mwt(struct ebt_ent
 	 *
 	 * offsets are relative to beginning of struct ebt_entry (i.e., 0).
 	 */
+	for (i = 0; i < 4 ; ++i) {
+		if (offsets[i] >= *total)
+			return -EINVAL;
+		if (i == 0)
+			continue;
+		if (offsets[i-1] > offsets[i])
+			return -EINVAL;
+	}
+
 	for (i = 0, j = 1 ; j < 4 ; j++, i++) {
 		struct compat_ebt_entry_mwt *match32;
 		unsigned int size;
