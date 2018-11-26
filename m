Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 564D0C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:58:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D64721473
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:58:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="kNdflg4L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D64721473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729138AbeKZVvu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 16:51:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:33128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727670AbeKZVvu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 16:51:50 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 371D321479;
        Mon, 26 Nov 2018 10:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543229885;
        bh=Erp3CIEJ/KEUio/Zo/nT5HEqNypLcCWsGURDa+jZkV4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kNdflg4LxmXIEVMvCy7cTn5JLjyj5kMV4EDCAk3HsnUT/jDb9jJYAPnoucdr4voyq
         WHsGF/ZRwUOCDz2hvWPg92aQ8KoGh4SMmOrBsX/AW7Bqn4OrQ6bWfOj1zFPF8OVtpH
         vvsq8kKc9N8zLJY8VZ1W6SYznQLPsSlQuv7ESlA4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alan Tull <atull@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 08/46] clk: fixed-rate: fix of_node_get-put imbalance
Date:   Mon, 26 Nov 2018 11:50:57 +0100
Message-Id: <20181126105046.776869163@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181126105045.447291262@linuxfoundation.org>
References: <20181126105045.447291262@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 52091c256bdcad0d01e2852a63f19cd2cce6af96 ]

When the fixed rate clock is created by devicetree,
of_clk_add_provider is called.  Add a call to
of_clk_del_provider in the remove function to balance
it out.

Signed-off-by: Alan Tull <atull@kernel.org>
Fixes: 435779fe1336 ("clk: fixed-rate: Convert into a module platform driver")
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/clk-fixed-rate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/clk-fixed-rate.c b/drivers/clk/clk-fixed-rate.c
index b5c46b3f8764..6d6475c32ee5 100644
--- a/drivers/clk/clk-fixed-rate.c
+++ b/drivers/clk/clk-fixed-rate.c
@@ -200,6 +200,7 @@ static int of_fixed_clk_remove(struct platform_device *pdev)
 {
 	struct clk *clk = platform_get_drvdata(pdev);
 
+	of_clk_del_provider(pdev->dev.of_node);
 	clk_unregister_fixed_rate(clk);
 
 	return 0;
-- 
2.17.1



