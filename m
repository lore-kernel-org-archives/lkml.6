Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1860525-1518072231-2-14299309291679556405
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES roen,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518072230; b=TjfF5FGtqSpMMT1cd3AuiPDDR5SCofZRvuDk1OBjlp18OJ/
    z2Pv5P3zY99H160oNycQBTzoKX8DcaLF6WchFMsvoWNPYwmF3ydMERaLWhU9sEei
    bUbj49ZL3t07Nu0coVZwkaduhJJ9Hzvjhu29dsmbdxYFmk+1TtebKa9QoJgqJRXW
    DihBBnSSRyveVAgmi6bFrOc/FYbZcqHk8NKQm2VeR1bNoRoztuKrG1mohLvW0bSV
    FE+5EuIG3uGOHTUkQg//yCC6uD50qgDQiHd/Lit9MICS2vvXGokvTeYCDXRnT8aH
    7YQDBRiYrQx6DfIcq1HxLUUNFxWX4T0jWg3WToA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:from:to:cc:date:message-id
    :mime-version:content-type:content-transfer-encoding:sender
    :list-id; s=arctest; t=1518072230; bh=vZSEBMOh7l31gwWJVyOZaLvMGa
    x+sW2lOR9pd1+nEA8=; b=QRE/qWQnC8ypPhSJft2dlzHW0711Psjcu2P3eYphP/
    AlvTrMnPOOFy7ivRvmczkwwEkoyY7S5VWRni1kTyAYmeqzFh0JrRMDEHhk6mU04d
    kbPoZGerAQlRB2fakTLZysEAf6teKGSRjfBDs324VbLni50HrUPQDdRwejjwgLxu
    7K4Agk/XOVU290G5Z87XE+Tx41u/8NRTAQUtkXL/2I2MRLJijr3JoK8FLkaUkxHE
    5UeGtDZetTK1QqOJwFQObGc+jXbuKlONr1TZRALaTrWNOnOq2JFteqRbWkujwYEU
    cP0ibAFThi+7FSp5VM3r74bgSSS/Ji2UtXGWYoloYEfg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750839AbeBHGnb (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Feb 2018 01:43:31 -0500
Received: from mga09.intel.com ([134.134.136.24]:57668 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750810AbeBHGnb (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Feb 2018 01:43:31 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,477,1511856000";
   d="scan'208";a="199583961"
Subject: [PATCH] mpls, nospec: Sanitize array index in mpls_label_ok()
From: Dan Williams <dan.j.williams@intel.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        stable@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 07 Feb 2018 22:34:24 -0800
Message-ID: <151807166425.3807.8813780890075479680.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.17.1-9-g687f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

mpls_label_ok() validates that the 'platform_label' array index from a
userspace netlink message payload is valid. Under speculation the
mpls_label_ok() result may not resolve in the CPU pipeline until after
the index is used to access an array element. Sanitize the index to zero
to prevent userspace-controlled arbitrary out-of-bounds speculation, a
precursor for a speculative execution side channel vulnerability.

Cc: <stable@vger.kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric W. Biederman <ebiederm@xmission.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 net/mpls/af_mpls.c |   24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/net/mpls/af_mpls.c b/net/mpls/af_mpls.c
index 8ca9915befc8..aae3565c3a92 100644
--- a/net/mpls/af_mpls.c
+++ b/net/mpls/af_mpls.c
@@ -8,6 +8,7 @@
 #include <linux/ipv6.h>
 #include <linux/mpls.h>
 #include <linux/netconf.h>
+#include <linux/nospec.h>
 #include <linux/vmalloc.h>
 #include <linux/percpu.h>
 #include <net/ip.h>
@@ -935,24 +936,27 @@ static int mpls_nh_build_multi(struct mpls_route_config *cfg,
 	return err;
 }
 
-static bool mpls_label_ok(struct net *net, unsigned int index,
+static bool mpls_label_ok(struct net *net, unsigned int *index,
 			  struct netlink_ext_ack *extack)
 {
+	bool is_ok = true;
+
 	/* Reserved labels may not be set */
-	if (index < MPLS_LABEL_FIRST_UNRESERVED) {
+	if (*index < MPLS_LABEL_FIRST_UNRESERVED) {
 		NL_SET_ERR_MSG(extack,
 			       "Invalid label - must be MPLS_LABEL_FIRST_UNRESERVED or higher");
-		return false;
+		is_ok = false;
 	}
 
 	/* The full 20 bit range may not be supported. */
-	if (index >= net->mpls.platform_labels) {
+	if (is_ok && *index >= net->mpls.platform_labels) {
 		NL_SET_ERR_MSG(extack,
 			       "Label >= configured maximum in platform_labels");
-		return false;
+		is_ok = false;
 	}
 
-	return true;
+	*index = array_index_nospec(*index, net->mpls.platform_labels);
+	return is_ok;
 }
 
 static int mpls_route_add(struct mpls_route_config *cfg,
@@ -975,7 +979,7 @@ static int mpls_route_add(struct mpls_route_config *cfg,
 		index = find_free_label(net);
 	}
 
-	if (!mpls_label_ok(net, index, extack))
+	if (!mpls_label_ok(net, &index, extack))
 		goto errout;
 
 	/* Append makes no sense with mpls */
@@ -1052,7 +1056,7 @@ static int mpls_route_del(struct mpls_route_config *cfg,
 
 	index = cfg->rc_label;
 
-	if (!mpls_label_ok(net, index, extack))
+	if (!mpls_label_ok(net, &index, extack))
 		goto errout;
 
 	mpls_route_update(net, index, NULL, &cfg->rc_nlinfo);
@@ -1810,7 +1814,7 @@ static int rtm_to_route_config(struct sk_buff *skb,
 				goto errout;
 
 			if (!mpls_label_ok(cfg->rc_nlinfo.nl_net,
-					   cfg->rc_label, extack))
+					   &cfg->rc_label, extack))
 				goto errout;
 			break;
 		}
@@ -2137,7 +2141,7 @@ static int mpls_getroute(struct sk_buff *in_skb, struct nlmsghdr *in_nlh,
 			goto errout;
 		}
 
-		if (!mpls_label_ok(net, in_label, extack)) {
+		if (!mpls_label_ok(net, &in_label, extack)) {
 			err = -EINVAL;
 			goto errout;
 		}
