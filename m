Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-560692-1519835198-2-8475211198841820514
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519835197; b=pk/jXkwBJ5wAqP3NBsB3qx59iAeAx4HkUIvzZ445GxO1L4N
    NGE7pVQlCBrs8l5iHmVaNX0sbOL9E8MFF7vHzWFecmvneGC2WX27OFvOJF+GfFTS
    evweRnZzLP+w2WIfpGca5F8jBzKXOgk706XjjvjBivLnBOcRvxxkkWgtnyz54trW
    1KtiH/RcVxm0yGHwUp/alBuaa92WWGRmWby0z+Hs0RUfdxkg3OpD5wNIqOFBELoN
    PVk5E7g34f+hL/6xmPfCaRuJ9sy8+8EOTkepYeiU9uJSEsE3yN+UhOCI1YViLLSR
    4LioQ17sD9+Q7lMGH1Z5YQ16SBtqrilgRqQds2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519835197; bh=I59EIRmwpo2hPdSWhwZ
    dmxe9pwav4by40Y5KMInqj08=; b=XfXGyud6jFCWLSaQtGnp5U3DHO2/aXsypzY
    W++6YUgkdNGtAQXO6i/9E3mlDdo1NQGxuddZtSLmQJYlA9vwpHWnx2+qImcGqLR1
    tyRyMXkQhZfpWHvDZR0XbkcPGnMMOVDjma/SND28PfkilX12Wb8HUIAyNMycNuOM
    Eg3knStrU4I+Lnl82u6hxRT2ud7CzcwrK/eo6oYmfcZeCBMTChRwSrUR/XJ83FN5
    rNgMQVB96XPeDzIZhqLUxcaTXvawpCi3j98fJOJvF5XcJoqm46AY1G38qQv0r2Um
    Kr6ZXSlmn4OZEimH9XMUa5ZCEHFSwN/lu+o/w3Zyl8y9YN6GOFw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932732AbeB1QUJ (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 11:20:09 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35315 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932479AbeB1QUI (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 11:20:08 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Johannes Berg" <johannes.berg@intel.com>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.226716698@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 085/254] nl80211: fix nl80211_send_iface() error paths
In-Reply-To: <lsq.1519831217.271785318@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.55-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Johannes Berg <johannes.berg@intel.com>

commit 4564b187c16327045d87596e8980c65ba7b84c50 upstream.

Evidently I introduced a locking bug in my change here,
the nla_put_failure sometimes needs to unlock. Fix it.

Fixes: 44905265bc15 ("nl80211: don't expose wdev->ssid for most interfaces")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/wireless/nl80211.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -2346,7 +2346,7 @@ static int nl80211_send_iface(struct sk_
 	case NL80211_IFTYPE_AP:
 		if (wdev->ssid_len &&
 		    nla_put(msg, NL80211_ATTR_SSID, wdev->ssid_len, wdev->ssid))
-			goto nla_put_failure;
+			goto nla_put_failure_locked;
 		break;
 	case NL80211_IFTYPE_STATION:
 	case NL80211_IFTYPE_P2P_CLIENT:
@@ -2359,7 +2359,7 @@ static int nl80211_send_iface(struct sk_
 		if (!ssid_ie)
 			break;
 		if (nla_put(msg, NL80211_ATTR_SSID, ssid_ie[1], ssid_ie + 2))
-			goto nla_put_failure;
+			goto nla_put_failure_locked;
 		break;
 		}
 	default:
@@ -2370,6 +2370,8 @@ static int nl80211_send_iface(struct sk_
 
 	return genlmsg_end(msg, hdr);
 
+ nla_put_failure_locked:
+	wdev_unlock(wdev);
  nla_put_failure:
 	genlmsg_cancel(msg, hdr);
 	return -EMSGSIZE;
