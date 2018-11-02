Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5DC8C65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:42:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85DE12084A
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:42:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="k9tM6zTF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85DE12084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729866AbeKCDu7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 23:50:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:46146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728033AbeKCDu6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 23:50:58 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A4AA62084A;
        Fri,  2 Nov 2018 18:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541184166;
        bh=y+1fAwNFv5Q1L9VUFJTgjM2I9rHapylzYuJbSBI+IGY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k9tM6zTFh/bCQHuan1v8ACAQOkRQNkH0z12a2IGLjBGzCNwZuWD+skcLwzl5OF744
         o7mWmM+eRYv7Tz0vYZKDn/oVQ2g1+LQT/Hat411Erpo6Be291SBLDiEHazPLaKqR72
         oSPzEMqYoNPqZq6sU49x2GORmRVDTYwoyefm4XAo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.18 100/150] Revert "mm: slowly shrink slabs with a relatively small number of objects"
Date:   Fri,  2 Nov 2018 19:34:22 +0100
Message-Id: <20181102182910.340083654@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181102182902.250560510@linuxfoundation.org>
References: <20181102182902.250560510@linuxfoundation.org>
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

This reverts commit 62aad93f09c1952ede86405894df1b22012fd5ab.

Which was upstream commit 172b06c32b94 ("mm: slowly shrink slabs with a
relatively small number of objects").

The upstream commit was found to cause regressions. While there is a
proposed fix upstream, revent this patch from stable trees for now as
testing the fix will take some time.

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/vmscan.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index fc0436407471..03822f86f288 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -386,17 +386,6 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
 	delta = freeable >> priority;
 	delta *= 4;
 	do_div(delta, shrinker->seeks);
-
-	/*
-	 * Make sure we apply some minimal pressure on default priority
-	 * even on small cgroups. Stale objects are not only consuming memory
-	 * by themselves, but can also hold a reference to a dying cgroup,
-	 * preventing it from being reclaimed. A dying cgroup with all
-	 * corresponding structures like per-cpu stats and kmem caches
-	 * can be really big, so it may lead to a significant waste of memory.
-	 */
-	delta = max_t(unsigned long long, delta, min(freeable, batch_size));
-
 	total_scan += delta;
 	if (total_scan < 0) {
 		pr_err("shrink_slab: %pF negative objects to delete nr=%ld\n",
-- 
2.17.1



