Return-Path: <ben@decadent.org.uk>
X-Google-Smtp-Source: AG47ELs+2HAJiEMwWHwsLSkyHj8Pdz1gBbs6WtDr8jZiRkMGV0Y/aTjE6tBDsBL+krzwei1/bNnl
ARC-Seal: i=1; a=rsa-sha256; t=1520824072; cv=none;
        d=google.com; s=arc-20160816;
        b=t5pqRQHIxWcFw9jPSRp/bNLND2TgK8KzxCzMi110hkvpcdhG1sqtxEg6zZpifSQ6D/
         Z5xQFP7NA0mcHY+q+LSueLPV2xS1GwnAQzHiTwCh12p3HRBaEyZP/SfE3oFhWgP2DO5c
         OzJjBHV0GWMqG1KlEkX8EMYR2lTTqrohjndQU8oc7/pj5RZGyHFtYOoiShH8yMjisOQq
         RtPmiG23xO8qdRdtOnhl7KiLLHkfegPLgOifDmji2BbDtIx6/Quu2OkQjW/AdiH6WzE1
         DyFRfmuhubJKtv2h+Ld7mWp0hfAwN9j9a89vUqJbqB/VAvSCs/ZG5zLuM4yto40jOADK
         JOiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:subject:message-id:date:cc:to:from:mime-version
         :content-transfer-encoding:content-disposition
         :arc-authentication-results;
        bh=8s/AZKnrhiQzHe9eU7t17dTaFu/kD6eyhkOU15Hkhrs=;
        b=TyMJsH7E5X5BXCcHyNcIHSKsOmpuRHXYV5CP1yALhv4WYWtBOzcBL+aUJATkk/fceq
         vSVRHlKYKA0vdOpHka+kELni66HXaVHzwmF5qUiPKuaS9Y9/Li8yFItTjBU9dAoV9yOq
         CxrqOCDzw8XJQbR3AHmA7G2dzrbDwwvULTHFgS3NvocLOFa6frsgRsyWRFtZW3RHi3vj
         ZAGige8IfwXbuCH3AzkTmGiyDD/k/LHXOUys1KuyHBRRtwobL5WzSQz5+u08jHecSRhY
         ZJWciClGV4aTu7xyobBiGKn5YuKKWeWLgHLUCk5OxXrq/VIVQGazpNDMvLKzty/oQW/K
         rk/A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of ben@decadent.org.uk designates 88.96.1.126 as permitted sender) smtp.mailfrom=ben@decadent.org.uk
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of ben@decadent.org.uk designates 88.96.1.126 as permitted sender) smtp.mailfrom=ben@decadent.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, kernel-hardening@lists.openwall.com,
 torvalds@linux-foundation.org,
 "Elena Reshetova" <elena.reshetova@intel.com>,
 "Thomas Gleixner" <tglx@linutronix.de>,
 alan@linux.intel.com,
 "Dan Williams" <dan.j.williams@intel.com>,
 "David S. Miller" <davem@davemloft.net>,
 linux-arch@vger.kernel.org,
 "Christian Lamparter" <chunkeey@gmail.com>,
 linux-wireless@vger.kernel.org, gregkh@linuxfoundation.org,
 "Johannes Berg" <johannes@sipsolutions.net>
Date: Mon, 12 Mar 2018 03:06:12 +0000
Message-ID: <lsq.1520823972.857925406@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 58/76] nl80211: Sanitize array index in parse_txq_params
In-Reply-To: <lsq.1520823971.5976735@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594699622644454974?=
X-GMAIL-MSGID: =?utf-8?q?1594699622644454974?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.56-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Williams <dan.j.williams@intel.com>

commit 259d8c1e984318497c84eef547bbb6b1d9f4eb05 upstream.

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
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/wireless/nl80211.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -14,6 +14,7 @@
 #include <linux/nl80211.h>
 #include <linux/rtnetlink.h>
 #include <linux/netlink.h>
+#include <linux/nospec.h>
 #include <linux/etherdevice.h>
 #include <net/net_namespace.h>
 #include <net/genetlink.h>
@@ -1829,20 +1830,22 @@ static const struct nla_policy txq_param
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
 
