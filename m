Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3726165-1519676296-2-17832660773580645348
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519676295; b=YukGNaWkzxcUYoJJAaIfu/gQ3c5n6tKX30q5Uwn63UQn6Kj
    wXF95AunefJRNMRaImtNzYuRgAL5PfGdlF9czeuUTMWIo3wcmKn8bEyDOEIdlUrG
    lFIJOs0M4ANljvImozXTJfMlLt+a4Ep5joend3/C+WMbssgebzkl/n5Sc3Wq/ULp
    Sl5cB44d6swrYd634CG+LfibKFQcUY0aRkfda+Yk6VKS84E6/RNlosyS4PlVO3bz
    FVfn12i+SJ/1AUAvsNqGpolAzjd+ZpfF3+JwMlf2E4osQlIH71OT52bAWqfgF2oG
    uR109Ec2lWYMZctUzB58jedBtIB3XEoi1qpkSdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519676295; bh=MgTuFTrL6cLp+dualxDrvnHGKH
    7dgsijZbkuNtACgTY=; b=opzEZwAjG/M5v3HnNHa4nwaZ4wvdJ9iUFPZb+q4dhU
    KwiPCj/DHvUK8GRlObL4QriMFzaVM78ESEPDB6ybazZ6GUgv0xF5VzUQNc+ZVRtH
    oaLdsXi38ZcmOmBU0ht4Tu/68QeW7UEv0IJxA1oTSOxGesRz+/FhrSxoFQVDEdLq
    Ihzie1MoHMCc/4XT0pJWT2A3CP6hz2WRh8F/QmFSKeNHYu32DBo1sFUzlkvYyqPj
    8aYwe0JsH5hknGgDry03qtvIunm2obGN/pfvXsHEYdpEfhyZaSOd3UusmytgVTNb
    nAbbvbB+AKjH8RKoNFnjpUBk2eEpW3c5mqkr3N3hWUYw==
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
        id S1752241AbeBZURe (ORCPT <rfc822;greg@kroah.com>);
        Mon, 26 Feb 2018 15:17:34 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:59924 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752215AbeBZURd (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Feb 2018 15:17:33 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 4.4 08/22] cfg80211: fix cfg80211_beacon_dup
Date: Mon, 26 Feb 2018 21:16:08 +0100
Message-Id: <20180226201559.107810108@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180226201558.681421374@linuxfoundation.org>
References: <20180226201558.681421374@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit bee92d06157fc39d5d7836a061c7d41289a55797 upstream.

gcc-8 warns about some obviously incorrect code:

net/mac80211/cfg.c: In function 'cfg80211_beacon_dup':
net/mac80211/cfg.c:2896:3: error: 'memcpy' source argument is the same as destination [-Werror=restrict]

>From the context, I conclude that we want to copy from beacon into
new_beacon, as we do in the rest of the function.

Cc: stable@vger.kernel.org
Fixes: 73da7d5bab79 ("mac80211: add channel switch command and beacon callbacks")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/mac80211/cfg.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -2877,7 +2877,7 @@ cfg80211_beacon_dup(struct cfg80211_beac
 	}
 	if (beacon->probe_resp_len) {
 		new_beacon->probe_resp_len = beacon->probe_resp_len;
-		beacon->probe_resp = pos;
+		new_beacon->probe_resp = pos;
 		memcpy(pos, beacon->probe_resp, beacon->probe_resp_len);
 		pos += beacon->probe_resp_len;
 	}
