Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48BA1C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:42:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17E3A20838
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550760134;
	bh=Izgsj4otg4HpIwXcLut662g2yH/9iA3IfoZq9BOInz0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=z6UZY5XEtJnwkj3qjvqB1Z6h+nHPiFlU3CEMcCV546glfYNxjmUX3MPKI2dozrUay
	 PH+YZGAFJKcP9zRnq5f7FgLaxNYOksOkHSv7jr0WQiXaEbWayuLzTXJ7Hp+niDAnrX
	 LJrt8yCBUT8KZq0BQQCdF8abAU9a3ltD/vKLKkjk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728758AbfBUOmM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 09:42:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:37604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729035AbfBUOmK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 09:42:10 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3ADBC2075A;
        Thu, 21 Feb 2019 14:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550760129;
        bh=Izgsj4otg4HpIwXcLut662g2yH/9iA3IfoZq9BOInz0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BWbooGToGsTb81/3NwgRNUQJ8yBh5Jh/Ig3wD2Cy4wK9guMOt8/g9PUJR2Ul0QiMz
         cg9hTrGAKO+FqGC8cdaWBKGGNvpHia4djy8Bmyqo86I1SK9C7k0Exa8X9/vLAj149q
         VEbMWRp+St9x4xwsofrEBJ9htMFEqunoT8exkFJ0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Greg Rose <gvrose8192@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 07/30] net: ip6_gre: initialize erspan_ver just for erspan tunnels
Date:   Thu, 21 Feb 2019 15:35:49 +0100
Message-Id: <20190221125250.934685008@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190221125250.543158526@linuxfoundation.org>
References: <20190221125250.543158526@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 4974d5f678abb34401558559d47e2ea3d1c15cba ]

After commit c706863bc890 ("net: ip6_gre: always reports o_key to
userspace"), ip6gre and ip6gretap tunnels started reporting TUNNEL_KEY
output flag even if it is not configured.
ip6gre_fill_info checks erspan_ver value to add TUNNEL_KEY for
erspan tunnels, however in commit 84581bdae9587 ("erspan: set
erspan_ver to 1 by default when adding an erspan dev")
erspan_ver is initialized to 1 even for ip6gre or ip6gretap
Fix the issue moving erspan_ver initialization in a dedicated routine

Fixes: c706863bc890 ("net: ip6_gre: always reports o_key to userspace")
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Reviewed-by: Greg Rose <gvrose8192@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv6/ip6_gre.c | 34 ++++++++++++++++++++--------------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
index be04877b3827b..faed98dab9137 100644
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -1735,6 +1735,24 @@ static int ip6erspan_tap_validate(struct nlattr *tb[], struct nlattr *data[],
 	return 0;
 }
 
+static void ip6erspan_set_version(struct nlattr *data[],
+				  struct __ip6_tnl_parm *parms)
+{
+	parms->erspan_ver = 1;
+	if (data[IFLA_GRE_ERSPAN_VER])
+		parms->erspan_ver = nla_get_u8(data[IFLA_GRE_ERSPAN_VER]);
+
+	if (parms->erspan_ver == 1) {
+		if (data[IFLA_GRE_ERSPAN_INDEX])
+			parms->index = nla_get_u32(data[IFLA_GRE_ERSPAN_INDEX]);
+	} else if (parms->erspan_ver == 2) {
+		if (data[IFLA_GRE_ERSPAN_DIR])
+			parms->dir = nla_get_u8(data[IFLA_GRE_ERSPAN_DIR]);
+		if (data[IFLA_GRE_ERSPAN_HWID])
+			parms->hwid = nla_get_u16(data[IFLA_GRE_ERSPAN_HWID]);
+	}
+}
+
 static void ip6gre_netlink_parms(struct nlattr *data[],
 				struct __ip6_tnl_parm *parms)
 {
@@ -1783,20 +1801,6 @@ static void ip6gre_netlink_parms(struct nlattr *data[],
 
 	if (data[IFLA_GRE_COLLECT_METADATA])
 		parms->collect_md = true;
-
-	parms->erspan_ver = 1;
-	if (data[IFLA_GRE_ERSPAN_VER])
-		parms->erspan_ver = nla_get_u8(data[IFLA_GRE_ERSPAN_VER]);
-
-	if (parms->erspan_ver == 1) {
-		if (data[IFLA_GRE_ERSPAN_INDEX])
-			parms->index = nla_get_u32(data[IFLA_GRE_ERSPAN_INDEX]);
-	} else if (parms->erspan_ver == 2) {
-		if (data[IFLA_GRE_ERSPAN_DIR])
-			parms->dir = nla_get_u8(data[IFLA_GRE_ERSPAN_DIR]);
-		if (data[IFLA_GRE_ERSPAN_HWID])
-			parms->hwid = nla_get_u16(data[IFLA_GRE_ERSPAN_HWID]);
-	}
 }
 
 static int ip6gre_tap_init(struct net_device *dev)
@@ -2225,6 +2229,7 @@ static int ip6erspan_newlink(struct net *src_net, struct net_device *dev,
 	int err;
 
 	ip6gre_netlink_parms(data, &nt->parms);
+	ip6erspan_set_version(data, &nt->parms);
 	ign = net_generic(net, ip6gre_net_id);
 
 	if (nt->parms.collect_md) {
@@ -2270,6 +2275,7 @@ static int ip6erspan_changelink(struct net_device *dev, struct nlattr *tb[],
 	if (IS_ERR(t))
 		return PTR_ERR(t);
 
+	ip6erspan_set_version(data, &p);
 	ip6gre_tunnel_unlink_md(ign, t);
 	ip6gre_tunnel_unlink(ign, t);
 	ip6erspan_tnl_change(t, &p, !tb[IFLA_MTU]);
-- 
2.19.1



