Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BE20C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:40:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D7082082F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549896036;
	bh=R3lqzptGrBnYHZHyg1Z5gS4alLwgDytUqHgL7dMw6+I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LBIp7ghZ68sKFtdLheJtZLbDb6SPy9suo+Ui/eFvrCCbzj5SGZeEgx7iXyEXnx3aG
	 0K6gP9G4jKzUa7Ra5Py20NmroxJGl1vyc/z7lHW4gdY1EV0ikQJ3UH5EITNF3732Un
	 XeTx0vfbwEOJwxx8pcNXCZaG4xAO+qJDEpJJqJOo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731681AbfBKOke (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:40:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:51368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731392AbfBKOka (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:40:30 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E6CC6214DA;
        Mon, 11 Feb 2019 14:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549896029;
        bh=R3lqzptGrBnYHZHyg1Z5gS4alLwgDytUqHgL7dMw6+I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vLMaWf5w3e6CrAKVdPTOVs27ypf9NUSSiQ9DcUM2bNcmsA7wEM17LJ6J+Xj1jiVKq
         KCPln4Z4WZoI51YJ3n3RGKjkkT+G0GXO0pgkwWBrvAM77aZAjVPVkiTKeoZs2ejm6T
         Bd/ibb1qr1WiN0pte/WtB2/ZV/MPXGzw5+bFTjtc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Thierry Reding <treding@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 049/313] soc/tegra: Dont leak device tree node reference
Date:   Mon, 11 Feb 2019 15:15:29 +0100
Message-Id: <20190211141856.978448820@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141852.749630980@linuxfoundation.org>
References: <20190211141852.749630980@linuxfoundation.org>
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

[ Upstream commit 9eb40fa2cd2d1f6829e7b49bb22692f754b9cfe0 ]

of_find_node_by_path() acquires a reference to the node returned by it
and that reference needs to be dropped by its caller. soc_is_tegra()
doesn't do that, so fix it.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
Acked-by: Jon Hunter <jonathanh@nvidia.com>
[treding: slightly rewrite to avoid inline comparison]
Signed-off-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soc/tegra/common.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/tegra/common.c b/drivers/soc/tegra/common.c
index cd8f41351add..7bfb154d6fa5 100644
--- a/drivers/soc/tegra/common.c
+++ b/drivers/soc/tegra/common.c
@@ -22,11 +22,15 @@ static const struct of_device_id tegra_machine_match[] = {
 
 bool soc_is_tegra(void)
 {
+	const struct of_device_id *match;
 	struct device_node *root;
 
 	root = of_find_node_by_path("/");
 	if (!root)
 		return false;
 
-	return of_match_node(tegra_machine_match, root) != NULL;
+	match = of_match_node(tegra_machine_match, root);
+	of_node_put(root);
+
+	return match != NULL;
 }
-- 
2.19.1



