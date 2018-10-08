Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94C95C677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:49:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A0B7204FD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:49:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="AxDvhTbb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A0B7204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731852AbeJICC2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 22:02:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:51688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726991AbeJICC1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 22:02:27 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA473204FD;
        Mon,  8 Oct 2018 18:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539024560;
        bh=YfVWx+vmrq44s9Ggnw4FoI652JkxujFgO5ICBruZ2gk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AxDvhTbbFv0NGIKgXVzsz9RAtqP87rOxZM9AhHozEHzJKTusJL6+vDsjVA9iLkgWq
         JnqQKKnz2KLVRi3Z0kRizRplfK2IKfEEmS0UTss4O1tEHP7hoGAp5nK/1lG2N4vxjZ
         OHqoYRcH2+4ju0YehR5rQHgn0P1FXc3X6VADaxrQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Martin Willi <martin@strongswan.org>,
        Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 079/168] netfilter: xt_cluster: add dependency on conntrack module
Date:   Mon,  8 Oct 2018 20:30:59 +0200
Message-Id: <20181008175623.065215093@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181008175620.043587728@linuxfoundation.org>
References: <20181008175620.043587728@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Martin Willi <martin@strongswan.org>

[ Upstream commit c1dc2912059901f97345d9e10c96b841215fdc0f ]

The cluster match requires conntrack for matching packets. If the
netns does not have conntrack hooks registered, the match does not
work at all.

Implicitly load the conntrack hook for the family, exactly as many
other extensions do. This ensures that the match works even if the
hooks have not been registered by other means.

Signed-off-by: Martin Willi <martin@strongswan.org>
Acked-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/netfilter/xt_cluster.c |   14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

--- a/net/netfilter/xt_cluster.c
+++ b/net/netfilter/xt_cluster.c
@@ -125,6 +125,7 @@ xt_cluster_mt(const struct sk_buff *skb,
 static int xt_cluster_mt_checkentry(const struct xt_mtchk_param *par)
 {
 	struct xt_cluster_match_info *info = par->matchinfo;
+	int ret;
 
 	if (info->total_nodes > XT_CLUSTER_NODES_MAX) {
 		pr_info_ratelimited("you have exceeded the maximum number of cluster nodes (%u > %u)\n",
@@ -135,7 +136,17 @@ static int xt_cluster_mt_checkentry(cons
 		pr_info_ratelimited("node mask cannot exceed total number of nodes\n");
 		return -EDOM;
 	}
-	return 0;
+
+	ret = nf_ct_netns_get(par->net, par->family);
+	if (ret < 0)
+		pr_info_ratelimited("cannot load conntrack support for proto=%u\n",
+				    par->family);
+	return ret;
+}
+
+static void xt_cluster_mt_destroy(const struct xt_mtdtor_param *par)
+{
+	nf_ct_netns_put(par->net, par->family);
 }
 
 static struct xt_match xt_cluster_match __read_mostly = {
@@ -144,6 +155,7 @@ static struct xt_match xt_cluster_match
 	.match		= xt_cluster_mt,
 	.checkentry	= xt_cluster_mt_checkentry,
 	.matchsize	= sizeof(struct xt_cluster_match_info),
+	.destroy	= xt_cluster_mt_destroy,
 	.me		= THIS_MODULE,
 };
 


