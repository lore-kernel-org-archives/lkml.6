Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBB3CC04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:56:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E49D20652
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:56:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E49D20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731421AbeIMTGU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 15:06:20 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34202 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730337AbeIMTGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 15:06:19 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A825CD10;
        Thu, 13 Sep 2018 13:56:42 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Georgi Nikolov <gnikolov@icdsoft.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Florian Westphal <fw@strlen.de>,
        Michal Hocko <mhocko@suse.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 073/197] netfilter: x_tables: do not fail xt_alloc_table_info too easilly
Date:   Thu, 13 Sep 2018 15:30:22 +0200
Message-Id: <20180913131844.446697748@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180913131841.568116777@linuxfoundation.org>
References: <20180913131841.568116777@linuxfoundation.org>
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

From: Michal Hocko <mhocko@suse.com>

[ Upstream commit a148ce15375fc664ad64762c751c0c2aecb2cafe ]

eacd86ca3b03 ("net/netfilter/x_tables.c: use kvmalloc()
in xt_alloc_table_info()") has unintentionally fortified
xt_alloc_table_info allocation when __GFP_RETRY has been dropped from
the vmalloc fallback. Later on there was a syzbot report that this
can lead to OOM killer invocations when tables are too large and
0537250fdc6c ("netfilter: x_tables: make allocation less aggressive")
has been merged to restore the original behavior. Georgi Nikolov however
noticed that he is not able to install his iptables anymore so this can
be seen as a regression.

The primary argument for 0537250fdc6c was that this allocation path
shouldn't really trigger the OOM killer and kill innocent tasks. On the
other hand the interface requires root and as such should allow what the
admin asks for. Root inside a namespaces makes this more complicated
because those might be not trusted in general. If they are not then such
namespaces should be restricted anyway. Therefore drop the __GFP_NORETRY
and replace it by __GFP_ACCOUNT to enfore memcg constrains on it.

Fixes: 0537250fdc6c ("netfilter: x_tables: make allocation less aggressive")
Reported-by: Georgi Nikolov <gnikolov@icdsoft.com>
Suggested-by: Vlastimil Babka <vbabka@suse.cz>
Acked-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Michal Hocko <mhocko@suse.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/netfilter/x_tables.c |    7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

--- a/net/netfilter/x_tables.c
+++ b/net/netfilter/x_tables.c
@@ -1178,12 +1178,7 @@ struct xt_table_info *xt_alloc_table_inf
 	if (sz < sizeof(*info) || sz >= XT_MAX_TABLE_SIZE)
 		return NULL;
 
-	/* __GFP_NORETRY is not fully supported by kvmalloc but it should
-	 * work reasonably well if sz is too large and bail out rather
-	 * than shoot all processes down before realizing there is nothing
-	 * more to reclaim.
-	 */
-	info = kvmalloc(sz, GFP_KERNEL | __GFP_NORETRY);
+	info = kvmalloc(sz, GFP_KERNEL_ACCOUNT);
 	if (!info)
 		return NULL;
 


