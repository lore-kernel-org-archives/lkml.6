Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752495AbeE3LHC (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 07:07:02 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:60629 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751591AbeE3LG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 07:06:56 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Pablo Neira Ayuso" <pablo@netfilter.org>,
        "Florian Westphal" <fw@strlen.de>
Date: Wed, 30 May 2018 11:52:41 +0100
Message-ID: <lsq.1527677561.711329105@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 005/153] netfilter: ebtables: fix erroneous reject of
 last rule
In-Reply-To: <lsq.1527677560.486731940@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.2.102-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Florian Westphal <fw@strlen.de>

commit 932909d9b28d27e807ff8eecb68c7748f6701628 upstream.

The last rule in the blob has next_entry offset that is same as total size.
This made "ebtables32 -A OUTPUT -d de:ad:be:ef:01:02" fail on 64 bit kernel.

Fixes: b71812168571fa ("netfilter: ebtables: CONFIG_COMPAT: don't trust userland offsets")
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/bridge/netfilter/ebtables.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/net/bridge/netfilter/ebtables.c
+++ b/net/bridge/netfilter/ebtables.c
@@ -2064,8 +2064,12 @@ static int size_entry_mwt(struct ebt_ent
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
