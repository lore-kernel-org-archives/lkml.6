Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2948269-1517591497-2-10259880464311870025
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
    t=1517591496; b=wWRkMKd7n0s5dsUx16NGk7JR4ocQ1TOCX6NR4HmPvkXbuTO
    6IojVdCFiSMNjvAgI/Gxj/2wOrmoB0KqdFhcHjX/B1wvj858nmLAbLYEVv3SArl8
    UWY1p4G/f1MCjgb7d7Kt+HUaal8UEqXwU044bz8PUzUjzFOgOB9m++9zpaSA7A0P
    1RLxbYqkJiaE4qBwWfft5pjupbiiKjqp91SZSyQ2ds65NawkPi6oEOmPvK+RZ0ne
    SAC7mkTH0/TOr+abUIy+gc8HAx7lSkxdU9pZXI4NcNlgGVH2URBaJnkji9R882Vk
    QnVI+vWMVHyatDk7J9O7w7Nm680L19yN9mbeeiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1517591496; bh=B+yACKYfP+6S0TdN+d7s0CsX8N
    1qPuos9sKbeKipXxw=; b=LxMXYmcJjKUkzjGQPLKVpIz++lJDh2oPoYJGFOcy9e
    2pxulZFQmcZEfpgoFgzJmPHUCRGt4+7EAT7mFNnVybAyabGuzTZPOHe3QAK6D1Cj
    h0keBwO21qN+rBd6vSLP6z2BrMYyBzPYbiDzLw05x+TaeLxx8ZMAzv/LYknHRquc
    D8gVGzXaf2xA5EqBsGSPct5e53e1ok6qc+NUMKAqll/rXt0v2DjV1yLle3EWCNUX
    VFLsVKZQ2Ku7aH+U82Y2ItSJoTCjavR8uOYGZefiYo1W+kIx0SLOTfKJA3x/TKQk
    luDhqWE5BfrCxzZyMTvtQe72pDWClaS0qb+8FlB4rnDg==
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
        id S1752807AbeBBRLe (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Feb 2018 12:11:34 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:38656 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753395AbeBBRLa (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Feb 2018 12:11:30 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chun-Yeow Yeoh <yeohchunyeow@gmail.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 070/156] mac80211: fix the update of path metric for RANN frame
Date: Fri,  2 Feb 2018 17:57:31 +0100
Message-Id: <20180202140843.456332414@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140840.242829545@linuxfoundation.org>
References: <20180202140840.242829545@linuxfoundation.org>
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

From: Chun-Yeow Yeoh <yeohchunyeow@gmail.com>


[ Upstream commit fbbdad5edf0bb59786a51b94a9d006bc8c2da9a2 ]

The previous path metric update from RANN frame has not considered
the own link metric toward the transmitting mesh STA. Fix this.

Reported-by: Michael65535
Signed-off-by: Chun-Yeow Yeoh <yeohchunyeow@gmail.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mac80211/mesh_hwmp.c |   15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

--- a/net/mac80211/mesh_hwmp.c
+++ b/net/mac80211/mesh_hwmp.c
@@ -797,7 +797,7 @@ static void hwmp_rann_frame_process(stru
 	struct mesh_path *mpath;
 	u8 ttl, flags, hopcount;
 	const u8 *orig_addr;
-	u32 orig_sn, metric, metric_txsta, interval;
+	u32 orig_sn, new_metric, orig_metric, last_hop_metric, interval;
 	bool root_is_gate;
 
 	ttl = rann->rann_ttl;
@@ -808,7 +808,7 @@ static void hwmp_rann_frame_process(stru
 	interval = le32_to_cpu(rann->rann_interval);
 	hopcount = rann->rann_hopcount;
 	hopcount++;
-	metric = le32_to_cpu(rann->rann_metric);
+	orig_metric = le32_to_cpu(rann->rann_metric);
 
 	/*  Ignore our own RANNs */
 	if (ether_addr_equal(orig_addr, sdata->vif.addr))
@@ -825,7 +825,10 @@ static void hwmp_rann_frame_process(stru
 		return;
 	}
 
-	metric_txsta = airtime_link_metric_get(local, sta);
+	last_hop_metric = airtime_link_metric_get(local, sta);
+	new_metric = orig_metric + last_hop_metric;
+	if (new_metric < orig_metric)
+		new_metric = MAX_METRIC;
 
 	mpath = mesh_path_lookup(sdata, orig_addr);
 	if (!mpath) {
@@ -838,7 +841,7 @@ static void hwmp_rann_frame_process(stru
 	}
 
 	if (!(SN_LT(mpath->sn, orig_sn)) &&
-	    !(mpath->sn == orig_sn && metric < mpath->rann_metric)) {
+	    !(mpath->sn == orig_sn && new_metric < mpath->rann_metric)) {
 		rcu_read_unlock();
 		return;
 	}
@@ -856,7 +859,7 @@ static void hwmp_rann_frame_process(stru
 	}
 
 	mpath->sn = orig_sn;
-	mpath->rann_metric = metric + metric_txsta;
+	mpath->rann_metric = new_metric;
 	mpath->is_root = true;
 	/* Recording RANNs sender address to send individually
 	 * addressed PREQs destined for root mesh STA */
@@ -876,7 +879,7 @@ static void hwmp_rann_frame_process(stru
 		mesh_path_sel_frame_tx(MPATH_RANN, flags, orig_addr,
 				       orig_sn, 0, NULL, 0, broadcast_addr,
 				       hopcount, ttl, interval,
-				       metric + metric_txsta, 0, sdata);
+				       new_metric, 0, sdata);
 	}
 
 	rcu_read_unlock();
