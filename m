Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6948C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:04:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BB2320855
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544544265;
	bh=F5EPLVNZC9KexBvbYdFq6ev/5C4i4KFofkKkaVDruFk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0eoifPTKV4qbub7ecq00iB2nel05hhkgMyFc0YC9nqnkMsyIGeV6Rab2fWQ5eMKRU
	 6irGXUfX9Y3UI4/leV4MzAQ4YcX4yiheju++G/FdOkbcUByGxEabCkuSIlBF+3bqVd
	 nOJG1zQEmigyb2GkV0m3QZOOrKXj4ciSy7xxisH8=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BB2320855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731297AbeLKQEY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 11:04:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:44922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730521AbeLKP4G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:56:06 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 15CCA21104;
        Tue, 11 Dec 2018 15:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543765;
        bh=F5EPLVNZC9KexBvbYdFq6ev/5C4i4KFofkKkaVDruFk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ldQTeKvTliF+d74pWqHLPxX9ZMdu9DxgMIC9xjK6nEI6ZDDOStOpED2eoEaDzilfU
         b0zIUoeQhY6PxaKv1K2V/4Hlk18MOtoc/b1jMxUC+ykGqD5SxJ9U4fCAttM/70Bqup
         Vx3F8sBqY3EGPMQPgi3oo93gTdFOWEkP5UjOYwHs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 055/118] net: amd: add missing of_node_put()
Date:   Tue, 11 Dec 2018 16:41:14 +0100
Message-Id: <20181211151646.468646947@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151644.216668863@linuxfoundation.org>
References: <20181211151644.216668863@linuxfoundation.org>
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

[ Upstream commit c44c749d3b6fdfca39002e7e48e03fe9f9fe37a3 ]

of_find_node_by_path() acquires a reference to the node
returned by it and that reference needs to be dropped by its caller.
This place doesn't do that, so fix it.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/amd/sunlance.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/amd/sunlance.c b/drivers/net/ethernet/amd/sunlance.c
index cdd7a611479b..19f89d9b1781 100644
--- a/drivers/net/ethernet/amd/sunlance.c
+++ b/drivers/net/ethernet/amd/sunlance.c
@@ -1419,7 +1419,7 @@ static int sparc_lance_probe_one(struct platform_device *op,
 
 			prop = of_get_property(nd, "tpe-link-test?", NULL);
 			if (!prop)
-				goto no_link_test;
+				goto node_put;
 
 			if (strcmp(prop, "true")) {
 				printk(KERN_NOTICE "SunLance: warning: overriding option "
@@ -1428,6 +1428,8 @@ static int sparc_lance_probe_one(struct platform_device *op,
 				       "to ecd@skynet.be\n");
 				auxio_set_lte(AUXIO_LTE_ON);
 			}
+node_put:
+			of_node_put(nd);
 no_link_test:
 			lp->auto_select = 1;
 			lp->tpe = 0;
-- 
2.19.1



