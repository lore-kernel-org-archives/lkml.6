Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1330670-1519988855-2-12933945065139577380
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519988855; b=T+k3aUF0EawYo5PA6q+JvxmqIsT6HhwLPXKFw7y65kkLxhM
    Qd4KDgy/7RcxyJVfXu3QHxrHjrTtKtImWgXazcXsGYXDN3CAgQA+L74LQkfqYj6M
    XJ5X704Mx7V6hNCmnaNXqtwv3EBQEIfPu2fPN5QdALthkcOtNoT7A91WPoh6iUe0
    ueGGlLpbWozphZuOYsb0cRDhDAH0pVQtJ1tCNzTyxMtSJuqjaov/7orkLfFrnCf5
    V8RX+WKkzWe0SmuDlCLhu5BzMe+lzlz6cGCt9FjxSqsWwoHD5CdR2oxyPNN4Uiy4
    /nXLnydxIZs307Cg8XuWbSXrq2MXUNbVoFR9wew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519988855; bh=ILXQkfiYkra+6YeKwLrTaM+5m7
    la+P63LPOS2gLP+u0=; b=LZor0gPlbXLOHlzdXGRR7Rd5FMRCX3F/oss3crQCG3
    rQ33pEVl95sva1BKeJ/lUJ89+yAaeUM/ES0De2wp4f0urnEmYmWZxrGzfN4yOYBk
    D6n369V1vQ1fsq/SFoZZv8kq6H1iHvSNpso+FQ2zVgjitVMzjHc9A/X9McDwgZjb
    AOk4ahJTqPUMAvQeXWqibyKSMHZ+C/TrzaefQWTv41sIi/Uqf/VIShZX+6ia5JeA
    1vdabMe74WCHQ6tAlCy3LBCdjscg/YKUGyLJumOkxRGkBs3usLiWFRT+EcgvxROl
    edykcqn1ZkuCH9WIAM/byzG4RsvLDafylPpGHzNtNLqg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1423609AbeCBLHM (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Mar 2018 06:07:12 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:50594 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1423570AbeCBIyz (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Mar 2018 03:54:55 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Gui Iribarren <gui@altermundi.net>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 24/34] mac80211: mesh: drop frames appearing to be from us
Date: Fri,  2 Mar 2018 09:51:20 +0100
Message-Id: <20180302084437.595058321@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084435.842679610@linuxfoundation.org>
References: <20180302084435.842679610@linuxfoundation.org>
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

From: Johannes Berg <johannes.berg@intel.com>


[ Upstream commit 736a80bbfda709fb3631f5f62056f250a38e5804 ]

If there are multiple mesh stations with the same MAC address,
they will both get confused and start throwing warnings.

Obviously in this case nothing can actually work anyway, so just
drop frames that look like they're from ourselves early on.

Reported-by: Gui Iribarren <gui@altermundi.net>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mac80211/rx.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -3367,6 +3367,8 @@ static bool ieee80211_accept_frame(struc
 		}
 		return true;
 	case NL80211_IFTYPE_MESH_POINT:
+		if (ether_addr_equal(sdata->vif.addr, hdr->addr2))
+			return false;
 		if (multicast)
 			return true;
 		return ether_addr_equal(sdata->vif.addr, hdr->addr1);
