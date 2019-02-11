Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F8C3C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0906A21B1A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549898415;
	bh=UF2ahbSaLErvLTQIdoP3B3swzqSnXtAlig1diGyQ39I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RZ8gmw63QNOUTrnHHt5uPIsR/6z/lbtT2IlnfnZ/x8/pbVOzbmUFqlL5EK+2GkK77
	 hrgoiePiu6Cp6ryhjo1XZSgxrSIKZODhzgL+dg5sljA/sd9SRQTZJsfjP8KlTwJT4u
	 wlpepRg1Q1I5aFuuJcp323ur0FmRVevtz25kAWyo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391176AbfBKPUN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:20:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:54780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390998AbfBKPF3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 10:05:29 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A871222B0;
        Mon, 11 Feb 2019 15:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549897528;
        bh=UF2ahbSaLErvLTQIdoP3B3swzqSnXtAlig1diGyQ39I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FuUHm5hqaScx87Cvh1ZYXwBDPAGKQdVhzNMrovjogoqZA5ksTdCkbLZWvsLVUtPZA
         xflbT3u+1+8HXScH+3Oh5hA5bSDbeb+WkcKk8aW4GIBCNJzCBZ9e+e5UJpv9KkoRxM
         U9AkIfLAKoWTvMyQ7LSAc92T1CSgmpnsaMK6BZus=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 028/137] soc: bcm: brcmstb: Dont leak device tree node reference
Date:   Mon, 11 Feb 2019 15:18:29 +0100
Message-Id: <20190211141814.562090239@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141811.964925535@linuxfoundation.org>
References: <20190211141811.964925535@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 1861a7f07e02292830a1ca256328d370deefea30 ]

of_find_node_by_path() acquires a reference to the node returned by it
and that reference needs to be dropped by its caller. soc_is_brcmstb()
doesn't do that, so fix it.

[treding: slightly rewrite to avoid inline comparison]

Fixes: d52fad262041 ("soc: add stubs for brcmstb SoC's")
Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soc/bcm/brcmstb/common.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/bcm/brcmstb/common.c b/drivers/soc/bcm/brcmstb/common.c
index 94e7335553f4..3f6063b639ac 100644
--- a/drivers/soc/bcm/brcmstb/common.c
+++ b/drivers/soc/bcm/brcmstb/common.c
@@ -31,13 +31,17 @@ static const struct of_device_id brcmstb_machine_match[] = {
 
 bool soc_is_brcmstb(void)
 {
+	const struct of_device_id *match;
 	struct device_node *root;
 
 	root = of_find_node_by_path("/");
 	if (!root)
 		return false;
 
-	return of_match_node(brcmstb_machine_match, root) != NULL;
+	match = of_match_node(brcmstb_machine_match, root);
+	of_node_put(root);
+
+	return match != NULL;
 }
 
 static const struct of_device_id sun_top_ctrl_match[] = {
-- 
2.19.1



