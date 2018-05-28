Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1165336AbeE1NVt (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 09:21:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:38828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1163454AbeE1KtD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:49:03 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 144/496] netfilter: ipt_CLUSTERIP: put config struct if we cant increment ct refcount
Date: Mon, 28 May 2018 11:58:49 +0200
Message-Id: <20180528100325.980698105@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100319.498712256@linuxfoundation.org>
References: <20180528100319.498712256@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Florian Westphal <fw@strlen.de>

[ Upstream commit 8ae56822812ddedc26a152ab1916eb30120b4748 ]

This needs to put() the entry to avoid a resource leak in error path.

Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/netfilter/ipt_CLUSTERIP.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/net/ipv4/netfilter/ipt_CLUSTERIP.c
+++ b/net/ipv4/netfilter/ipt_CLUSTERIP.c
@@ -492,12 +492,15 @@ static int clusterip_tg_check(const stru
 				return PTR_ERR(config);
 		}
 	}
-	cipinfo->config = config;
 
 	ret = nf_ct_netns_get(par->net, par->family);
-	if (ret < 0)
+	if (ret < 0) {
 		pr_info("cannot load conntrack support for proto=%u\n",
 			par->family);
+		clusterip_config_entry_put(par->net, config);
+		clusterip_config_put(config);
+		return ret;
+	}
 
 	if (!par->net->xt.clusterip_deprecated_warning) {
 		pr_info("ipt_CLUSTERIP is deprecated and it will removed soon, "
@@ -505,6 +508,7 @@ static int clusterip_tg_check(const stru
 		par->net->xt.clusterip_deprecated_warning = true;
 	}
 
+	cipinfo->config = config;
 	return ret;
 }
 
