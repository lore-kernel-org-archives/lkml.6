Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2879036-1517590856-2-3333009369476609970
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
    t=1517590855; b=Ug3Ieax+vdSvF0ug9HmkaH4vHeq2rcSxvVCV35sw1L54LMy
    r08M7/HpsesD2+xnNzrtY9jwAKYlh+oalAOQ5x4oncN+M7S/ovchmo3nRoFJnwNk
    M7jgVA3rReStIMVOL4INvPzoCyqNbBmVpe6lKh1avoyzFz1bKaU98C8+oquCDP+1
    ozurpQXLZWL5ZbjhA5zjCSQ0G19S0sgeGD5S1lrwQisCPkSbAlrOcLoyaNOaWKLb
    I+ggJ68T6esJ4s7qWpefqNgSPh3bJ7EGuhw8zcmCc5F12K2V3Dt9gcZP6h8TbOhj
    1MbjflsMMD4mYlJOM6dv4mhRjYI+hyJROk9AwBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1517590855; bh=YqsiivzQT7AAiGlmUMxQnIYjNT
    PQMNFVGqSZpicueuA=; b=lQKSD8Dks54pvMtzfa5lXgXZgLgt5ELXftDBc/8cMH
    vc+1JtC4gCDc5SEGyXt3iKF2oKNINSx9qtr7iH6LU3YUXaCjr52EI73FmCYmmAa+
    J/bmL41OIh4xwkN3D/sExXAfThCe7kBTwrN8Hsbi/rzu0uc97g/GVmsjR3Rbg0q8
    hmBIkWfDjuiHGCiAyzzKV5lWqAmTSt3UF2P+AemwKlDb+E6DW6Bq53Oppig1NAZh
    MdMLjO8ZEiDTNOmTVHNhI6APTcURku4qkVHFtk+UqZOFNGPEzoCfNiWJLfPbqHHw
    OA9meyv4j7MKHK/6Gg6i6b1lToakBl4Dn2S0XAm0fOIw==
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
        id S1752645AbeBBRAx (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Feb 2018 12:00:53 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:34804 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752633AbeBBRAp (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Feb 2018 12:00:45 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chun-Yeow Yeoh <yeohchunyeow@gmail.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 34/67] mac80211: fix the update of path metric for RANN frame
Date: Fri,  2 Feb 2018 17:58:03 +0100
Message-Id: <20180202140819.420313005@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140815.091718203@linuxfoundation.org>
References: <20180202140815.091718203@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chun-Yeow Yeoh <yeohchunyeow@gmail.com>


[ Upstream commit fbbdad5edf0bb59786a51b94a9d006bc8c2da9a2 ]

The previous path metric update from RANN frame has not considered
the own link metric toward the transmitting mesh STA. Fix this.

Reported-by: Michael65535
Signed-off-by: Chun-Yeow Yeoh <yeohchunyeow@gmail.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mac80211/mesh_hwmp.c |   15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

--- a/net/mac80211/mesh_hwmp.c
+++ b/net/mac80211/mesh_hwmp.c
@@ -776,7 +776,7 @@ static void hwmp_rann_frame_process(stru
 	struct mesh_path *mpath;
 	u8 ttl, flags, hopcount;
 	const u8 *orig_addr;
-	u32 orig_sn, metric, metric_txsta, interval;
+	u32 orig_sn, new_metric, orig_metric, last_hop_metric, interval;
 	bool root_is_gate;
 
 	ttl = rann->rann_ttl;
@@ -787,7 +787,7 @@ static void hwmp_rann_frame_process(stru
 	interval = le32_to_cpu(rann->rann_interval);
 	hopcount = rann->rann_hopcount;
 	hopcount++;
-	metric = le32_to_cpu(rann->rann_metric);
+	orig_metric = le32_to_cpu(rann->rann_metric);
 
 	/*  Ignore our own RANNs */
 	if (ether_addr_equal(orig_addr, sdata->vif.addr))
@@ -804,7 +804,10 @@ static void hwmp_rann_frame_process(stru
 		return;
 	}
 
-	metric_txsta = airtime_link_metric_get(local, sta);
+	last_hop_metric = airtime_link_metric_get(local, sta);
+	new_metric = orig_metric + last_hop_metric;
+	if (new_metric < orig_metric)
+		new_metric = MAX_METRIC;
 
 	mpath = mesh_path_lookup(sdata, orig_addr);
 	if (!mpath) {
@@ -817,7 +820,7 @@ static void hwmp_rann_frame_process(stru
 	}
 
 	if (!(SN_LT(mpath->sn, orig_sn)) &&
-	    !(mpath->sn == orig_sn && metric < mpath->rann_metric)) {
+	    !(mpath->sn == orig_sn && new_metric < mpath->rann_metric)) {
 		rcu_read_unlock();
 		return;
 	}
@@ -835,7 +838,7 @@ static void hwmp_rann_frame_process(stru
 	}
 
 	mpath->sn = orig_sn;
-	mpath->rann_metric = metric + metric_txsta;
+	mpath->rann_metric = new_metric;
 	mpath->is_root = true;
 	/* Recording RANNs sender address to send individually
 	 * addressed PREQs destined for root mesh STA */
@@ -855,7 +858,7 @@ static void hwmp_rann_frame_process(stru
 		mesh_path_sel_frame_tx(MPATH_RANN, flags, orig_addr,
 				       orig_sn, 0, NULL, 0, broadcast_addr,
 				       hopcount, ttl, interval,
-				       metric + metric_txsta, 0, sdata);
+				       new_metric, 0, sdata);
 	}
 
 	rcu_read_unlock();
