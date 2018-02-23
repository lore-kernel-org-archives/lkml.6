Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225nBM96bRQ1Z/AG00vtAq4VeXMcC1SkXNsnM66fIDt5JkbLrPK1N4fFX2aAlVPP+AQAe3VH
ARC-Seal: i=1; a=rsa-sha256; t=1519411274; cv=none;
        d=google.com; s=arc-20160816;
        b=gBj3JFn870talljc3sHQv0v1iqVyt2SmcT5hDdGc8xPEr5qGfTZMOC8Vgif9j0911t
         vUQs8BUgDD9jchTaj6fGyROzUKnOLHzwka4pCHFZSy9J4fj+AT2dHs7rrSpQHKDszSXW
         4N5SkIoBrOH+ghicExnZMHEHnFu1bk9Dwkcs2n75QYG6ey1ijAcnhRWhW2SwIEwOHhtr
         ooFhYCVLW3F/ScY0ecf4nYOIPWK2/2rbSCtHt6fg8lzjVsBbTEHdgCBCwGVFiIFV9jp0
         Ti4votRoErqfOmaEgBC1C5DIA8e/FWyDcra0EqRlh09JvO56aafle+zo40u6WzhwVhIb
         MFcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=R9dKKsVygUpm0t1EGJOqgLjVlbyOq1bfVrFfv5I0h28=;
        b=Al6tBumJApg//oOarlf89gDgjbZMfsU92sh2fJWRXrjM8yHH7SGMN4lAwf9KVE0ZjG
         e/+tfix67ItcyD8d9PsSv5EKLuT8bZo4TpTVZ3gZ6fsZ94ESxr8Je2trbvIvSGyTlk3W
         b5l+J+u4P9viip63MKY35HC5yBEiK+ZyDeaANfLvx/DdXSzZPWR2EZQn+5bOLF4UgLz+
         BD1SoV+Zj8tsnAF2eD4GF/uybKxQmInC3TiEWCOZdAhvTQcGoAFJFkWC3L1G0maA7l7Y
         4cibSYWwEL4jdsjUufx6kAwEVku9QK5VB+ag4lcIA2LrcQoiH29mVpGMy3oxbkSVvdVv
         s0aQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Christian Lamparter <chunkeey@gmail.com>,
	Elena Reshetova <elena.reshetova@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-arch@vger.kernel.org,
	kernel-hardening@lists.openwall.com,
	linux-wireless@vger.kernel.org,
	torvalds@linux-foundation.org,
	"David S. Miller" <davem@davemloft.net>,
	alan@linux.intel.com,
	David Woodhouse <dwmw@amazon.co.uk>,
	Jack Wang <jinpu.wang@profitbricks.com>
Subject: [PATCH 4.4 180/193] nl80211: Sanitize array index in parse_txq_params
Date: Fri, 23 Feb 2018 19:26:53 +0100
Message-Id: <20180223170354.369164387@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593218196541583573?=
X-GMAIL-MSGID: =?utf-8?q?1593218196541583573?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Williams <dan.j.williams@intel.com>

(cherry picked from commit 259d8c1e984318497c84eef547bbb6b1d9f4eb05)

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
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
[jwang: cherry pick to 4.4]
Signed-off-by: Jack Wang <jinpu.wang@profitbricks.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/wireless/nl80211.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

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
@@ -1879,20 +1880,22 @@ static const struct nla_policy txq_param
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
 
