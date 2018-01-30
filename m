Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753686AbeA3WlR (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 17:41:17 -0500
Received: from terminus.zytor.com ([65.50.211.136]:49751 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753637AbeA3WlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 17:41:13 -0500
Date: Tue, 30 Jan 2018 14:38:03 -0800
From: tip-bot for Dan Williams <tipbot@zytor.com>
Message-ID: <tip-259d8c1e984318497c84eef547bbb6b1d9f4eb05@git.kernel.org>
Cc: chunkeey@gmail.com, johannes@sipsolutions.net, tglx@linutronix.de,
        davem@davemloft.net, mingo@kernel.org, elena.reshetova@intel.com,
        hpa@zytor.com, dan.j.williams@intel.com, linux-kernel@vger.kernel.org
Reply-To: davem@davemloft.net, tglx@linutronix.de, chunkeey@gmail.com,
        johannes@sipsolutions.net, linux-kernel@vger.kernel.org,
        dan.j.williams@intel.com, mingo@kernel.org, hpa@zytor.com,
        elena.reshetova@intel.com
In-Reply-To: <151727419584.33451.7700736761686184303.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <151727419584.33451.7700736761686184303.stgit@dwillia2-desk3.amr.corp.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] nl80211: Sanitize array index in parse_txq_params
Git-Commit-ID: 259d8c1e984318497c84eef547bbb6b1d9f4eb05
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  259d8c1e984318497c84eef547bbb6b1d9f4eb05
Gitweb:     https://git.kernel.org/tip/259d8c1e984318497c84eef547bbb6b1d9f4eb05
Author:     Dan Williams <dan.j.williams@intel.com>
AuthorDate: Mon, 29 Jan 2018 17:03:15 -0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 30 Jan 2018 21:54:32 +0100

nl80211: Sanitize array index in parse_txq_params

Wireless drivers rely on parse_txq_params to validate that txq_params->ac
is less than NL80211_NUM_ACS by the time the low-level driver's ->conf_tx()
handler is called. Use a new helper, array_index_nospec(), to sanitize
txq_params->ac with respect to speculation. I.e. ensure that any
speculation into ->conf_tx() handlers is done with a value of
txq_params->ac that is within the bounds of [0, NL80211_NUM_ACS).

Reported-by: Christian Lamparter <chunkeey@gmail.com>
Reported-by: Elena Reshetova <elena.reshetova@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-arch@vger.kernel.org
Cc: kernel-hardening@lists.openwall.com
Cc: gregkh@linuxfoundation.org
Cc: linux-wireless@vger.kernel.org
Cc: torvalds@linux-foundation.org
Cc: "David S. Miller" <davem@davemloft.net>
Cc: alan@linux.intel.com
Link: https://lkml.kernel.org/r/151727419584.33451.7700736761686184303.stgit@dwillia2-desk3.amr.corp.intel.com

---
 net/wireless/nl80211.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 542a4fc..4bbcfc1 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -16,6 +16,7 @@
 #include <linux/nl80211.h>
 #include <linux/rtnetlink.h>
 #include <linux/netlink.h>
+#include <linux/nospec.h>
 #include <linux/etherdevice.h>
 #include <net/net_namespace.h>
 #include <net/genetlink.h>
@@ -2056,20 +2057,22 @@ static const struct nla_policy txq_params_policy[NL80211_TXQ_ATTR_MAX + 1] = {
 static int parse_txq_params(struct nlattr *tb[],
 			    struct ieee80211_txq_params *txq_params)
 {
+	u8 ac;
+
 	if (!tb[NL80211_TXQ_ATTR_AC] || !tb[NL80211_TXQ_ATTR_TXOP] ||
 	    !tb[NL80211_TXQ_ATTR_CWMIN] || !tb[NL80211_TXQ_ATTR_CWMAX] ||
 	    !tb[NL80211_TXQ_ATTR_AIFS])
 		return -EINVAL;
 
-	txq_params->ac = nla_get_u8(tb[NL80211_TXQ_ATTR_AC]);
+	ac = nla_get_u8(tb[NL80211_TXQ_ATTR_AC]);
 	txq_params->txop = nla_get_u16(tb[NL80211_TXQ_ATTR_TXOP]);
 	txq_params->cwmin = nla_get_u16(tb[NL80211_TXQ_ATTR_CWMIN]);
 	txq_params->cwmax = nla_get_u16(tb[NL80211_TXQ_ATTR_CWMAX]);
 	txq_params->aifs = nla_get_u8(tb[NL80211_TXQ_ATTR_AIFS]);
 
-	if (txq_params->ac >= NL80211_NUM_ACS)
+	if (ac >= NL80211_NUM_ACS)
 		return -EINVAL;
-
+	txq_params->ac = array_index_nospec(ac, NL80211_NUM_ACS);
 	return 0;
 }
 
