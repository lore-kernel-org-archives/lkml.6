Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05A48C282C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:34:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C00CF206B6
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550025277;
	bh=EMoSIh9FMivD+yni4s2yVWdfvGG39sgEAEWg7BeZPLA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=B1OI/XGz2jjqI9FxkgNH5wchAd1fKaJxceqpf5Br99pwZb5PyaKuEJOvvS8j5abS4
	 e+41lxokD5sdVdj1dol5ck/rYC4c7CeGsHhRFPtzsGva+egmDU9nFOWSlzex8weVh1
	 e2uAHooXQf6jfjS76Z01EAYh7XrIDfrD2HwWwcaY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387777AbfBMCeg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 21:34:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:38030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387738AbfBMCeb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 21:34:31 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 39717222C7;
        Wed, 13 Feb 2019 02:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550025271;
        bh=EMoSIh9FMivD+yni4s2yVWdfvGG39sgEAEWg7BeZPLA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gkwcDBGaw4eOHyvWWwnKmXXWhOds0rL6S3P6arnVnZkG9IUPATE2ohwF9H8WzMLUK
         8B9JzleEzYWUU/fqVHrXNaNjktbSIhlH/AwxrrWUJQCcDL3CopJw7SPUa8I+ARGR1S
         6m9xtTZ8NumQdaG6nSBgIv5s5tKSAFnckkr3tkAA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Taehee Yoo <ap420073@gmail.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 038/105] netfilter: nf_tables: fix leaking object reference count
Date:   Tue, 12 Feb 2019 21:32:29 -0500
Message-Id: <20190213023336.19019-38-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190213023336.19019-1-sashal@kernel.org>
References: <20190213023336.19019-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Taehee Yoo <ap420073@gmail.com>

[ Upstream commit b91d9036883793122cf6575ca4dfbfbdd201a83d ]

There is no code that decreases the reference count of stateful objects
in error path of the nft_add_set_elem(). this causes a leak of reference
count of stateful objects.

Test commands:
   $nft add table ip filter
   $nft add counter ip filter c1
   $nft add map ip filter m1 { type ipv4_addr : counter \;}
   $nft add element ip filter m1 { 1 : c1 }
   $nft add element ip filter m1 { 1 : c1 }
   $nft delete element ip filter m1 { 1 }
   $nft delete counter ip filter c1

Result:
   Error: Could not process rule: Device or resource busy
   delete counter ip filter c1
   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^

At the second 'nft add element ip filter m1 { 1 : c1 }', the reference
count of the 'c1' is increased then it tries to insert into the 'm1'. but
the 'm1' already has same element so it returns -EEXIST.
But it doesn't decrease the reference count of the 'c1' in the error path.
Due to a leak of the reference count of the 'c1', the 'c1' can't be
removed by 'nft delete counter ip filter c1'.

Fixes: 8aeff920dcc9 ("netfilter: nf_tables: add stateful object reference to set elements")
Signed-off-by: Taehee Yoo <ap420073@gmail.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nf_tables_api.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 6e548d7c9f67..aba6ec4a14ce 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -4474,6 +4474,8 @@ err6:
 err5:
 	kfree(trans);
 err4:
+	if (obj)
+		obj->use--;
 	kfree(elem.priv);
 err3:
 	if (nla[NFTA_SET_ELEM_DATA] != NULL)
-- 
2.19.1

