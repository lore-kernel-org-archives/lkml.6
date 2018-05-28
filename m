Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935799AbeE1KJt (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:09:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:57860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933283AbeE1KJn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:09:43 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 092/185] netfilter: ebtables: fix erroneous reject of last rule
Date: Mon, 28 May 2018 12:02:13 +0200
Message-Id: <20180528100058.592636911@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100050.700971285@linuxfoundation.org>
References: <20180528100050.700971285@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Florian Westphal <fw@strlen.de>

[ Upstream commit 932909d9b28d27e807ff8eecb68c7748f6701628 ]

The last rule in the blob has next_entry offset that is same as total size.
This made "ebtables32 -A OUTPUT -d de:ad:be:ef:01:02" fail on 64 bit kernel.

Fixes: b71812168571fa ("netfilter: ebtables: CONFIG_COMPAT: don't trust userland offsets")
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/bridge/netfilter/ebtables.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/net/bridge/netfilter/ebtables.c
+++ b/net/bridge/netfilter/ebtables.c
@@ -2086,8 +2086,12 @@ static int size_entry_mwt(struct ebt_ent
 	 * offsets are relative to beginning of struct ebt_entry (i.e., 0).
 	 */
 	for (i = 0; i < 4 ; ++i) {
-		if (offsets[i] >= *total)
+		if (offsets[i] > *total)
 			return -EINVAL;
+
+		if (i < 3 && offsets[i] == *total)
+			return -EINVAL;
+
 		if (i == 0)
 			continue;
 		if (offsets[i-1] > offsets[i])
