Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3105817-1517855080-2-16983944585253551088
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517855079; b=IAGpp29xmBzmODsvLs/EiWtGhBTGi5Xv+gWpxN+ifQL2uPM
    pxX95YdStrwE/0IJ0g4XF6tjwtX6lBDBvySE0bBWcs5GSbmDMyPgI9teNgW5PuIM
    miM6Y3TcDOn+ulybNLJeRQQzTCsQWnPa4/Fky0b96MZpZgOXZSyEo7qdS3l+tP7x
    legXoLQAd7pPa9zoM6iY+17npNoYNBmL0O5OhwNCG8Kyn3UrM/nzB4mhp3D5U15r
    EaovG30Bg7KIhCC/0k6YnHA6nTFDppp9hqCdCC9m7IaPTs6OFC79kEyfTVKwl7Ca
    ic7CPY29IqK03Wq/Jo5roffuZL+vgVXAv9kSioQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1517855079; bh=U5YFcwxunj7Mqq3c0d7uVCp3sl
    /Pjiph9wl/k3njJQE=; b=Cl9hIWObljyuGtfeuqIo8Vl92iZVcql7DVzTHhxCX5
    KIMnJYyyLg5ncl7rVLXbQm8j9DJ3Ecq/v8HuoW94jPnkGb1F80zR368C6H327up3
    AxCn9tZCmOxsDKx3n6xu3RwLepBIqsfJjom37vIk7Razdr9EAmu9YZuySYduxj0G
    GLCMd/sjH0PeW+a1T/Jo+qFZARnwdgaMw76wKtORK6yfFrZkW7O87AfKnsPxzoC6
    EF2vljeSdF6BLCeSAXff7uhAj54EX1kxdJSFYPdJDITWw8jQybe5ByRMYWIpCol0
    Adjd3/EPBrgSlVCskgjDUHLkAT1buA94AMbywxeDNsAg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753581AbeBESYf (ORCPT <rfc822;greg@kroah.com>);
        Mon, 5 Feb 2018 13:24:35 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:51494 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753525AbeBESYU (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 5 Feb 2018 13:24:20 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Christian Lamparter <chunkeey@gmail.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-arch@vger.kernel.org, kernel-hardening@lists.openwall.com,
        linux-wireless@vger.kernel.org, torvalds@linux-foundation.org,
        "David S. Miller" <davem@davemloft.net>, alan@linux.intel.com
Subject: [PATCH 4.14 46/64] nl80211: Sanitize array index in parse_txq_params
Date: Mon,  5 Feb 2018 10:23:05 -0800
Message-Id: <20180205182140.464675558@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180205182138.571333346@linuxfoundation.org>
References: <20180205182138.571333346@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
 
