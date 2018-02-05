Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224Y7DkafTVaMPaV6p9w94Zx6poW09wn68l2mePcYFt6S0ZzqvQHLtNaxARNv40Q2HfaIaz2
ARC-Seal: i=1; a=rsa-sha256; t=1517855145; cv=none;
        d=google.com; s=arc-20160816;
        b=PEGQRuANSY5yzPFr7Naom+/VDBDQ5Q9z2PhnMGyY4Ldkla4Kk6fozOarbtd4lGRnqY
         HXLs8nREO5m+vUwkNXVySTZrNxTAXWuJLONFnkMeASKrbP/B0oZA0rm9R7z+BmhniQmX
         sUYKnetiON9JwuSzqjr6mnbMKvk8m4BYxJ+/P4Tn8kuBvefKdP14Mv0Cm8YOZiouAyWy
         2eeQXrdK8H0K882ThZyhhCUzjO7tJPGjXtONq2EEE7xaRilVs2KdrExQIXym6Ixid5MP
         Ohlo9c1eZUfUUhyvjExJJESoMcOipH3Vqz2+UNGnxEn5xaXsCFYR912TW8cJNARGwmdL
         iXJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=9MBcfaPHsaTzzBWYwjwIcCnRTmWcs8vZzfj92Msdl4c=;
        b=Gt46WUPOquMR0EHqOTxYlx5YNanm8Crh0cpWjT8sQipQWuZWYhWarNWnNbYzhsIm30
         63Oy8k718FmVgRutEHdH5gyMHmXdlAY+Lqx8NsU3ZacTeTrMJHlEy2BzAKPitFG+2FQW
         XJHFcUFWbGmVSP4n1Obma/IxfX/6mGzJfP9n5aMIKTHZ9DwlSF1TJCTBKpYsgsE7GNsD
         UodkaPqTnKUcbedCMbxs8lz9lswDF3Z3NDP1zH9CToiYXvVHwBM9gniTlKq2EN8skIbV
         CnimIJM2/wkZLLCKfUrHIjHwQ/wACoFWTj6slKWoSyAaVBoZcMSqb3zy4HQHyQDxNy9d
         72pA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
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
	alan@linux.intel.com
Subject: [PATCH 4.15 42/60] nl80211: Sanitize array index in parse_txq_params
Date: Mon,  5 Feb 2018 10:23:15 -0800
Message-Id: <20180205182215.701214369@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180205182213.902626065@linuxfoundation.org>
References: <20180205182213.902626065@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591586388404593921?=
X-GMAIL-MSGID: =?utf-8?q?1591586476805299329?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Williams dan.j.williams@intel.com

commit 259d8c1e984318497c84eef547bbb6b1d9f4eb05

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
@@ -2056,20 +2057,22 @@ static const struct nla_policy txq_param
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
 
