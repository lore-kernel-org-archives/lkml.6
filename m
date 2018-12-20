Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 839A1C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:27:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DA5420989
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545298056;
	bh=dKxnd5ORcIsF3Jisc10a92ngDmzzK/JzLJk1tPQmBGs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nVgxPxeUzKeWJkcLHtRrKK8q3zs8QrZGc59ev2y8uPWXEuTTS9As+irylZE8fti43
	 jBhKLgubBj3YoBF/PxfUsQMB+1cXbpvjj4Xbtk57kbXhxQnCuy9WG4AIeX9cJaZje4
	 l32G/mfN8bBFdIhLfvf0iPpJbyOellcOn4O6gy2E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732346AbeLTJ1f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:27:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:37488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732332AbeLTJ1b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:27:31 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B0D5020656;
        Thu, 20 Dec 2018 09:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545298051;
        bh=dKxnd5ORcIsF3Jisc10a92ngDmzzK/JzLJk1tPQmBGs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t8bph8rQuonFqUEny1GcnIcDHRb3CbT0PJFL1kYtdcATtlLlYzmOOllJoBk2v2r3/
         W/T3Y6L8xd7bBdNHB362xHl7mjzrMwJOBLJN7I7MXc51vqe8/rftTTi3/So2F9GgPH
         AYOjQQMawnYuDGnUoCg8WWchZT2BXUYSV7GdVDbU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 53/72] clk: mmp: Off by one in mmp_clk_add()
Date:   Thu, 20 Dec 2018 10:18:52 +0100
Message-Id: <20181220085924.431161336@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181220085922.332225035@linuxfoundation.org>
References: <20181220085922.332225035@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 2e85c57493e391b93445c1e0d530b36b95becc64 ]

The > comparison should be >= or we write one element beyond the end of
the unit->clk_table[] array.

(The unit->clk_table[] array is allocated in the mmp_clk_init() function
and it has unit->nr_clks elements).

Fixes: 4661fda10f8b ("clk: mmp: add basic support functions for DT support")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/mmp/clk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/mmp/clk.c b/drivers/clk/mmp/clk.c
index ad8d483a35cd..ca7d37e2c7be 100644
--- a/drivers/clk/mmp/clk.c
+++ b/drivers/clk/mmp/clk.c
@@ -183,7 +183,7 @@ void mmp_clk_add(struct mmp_clk_unit *unit, unsigned int id,
 		pr_err("CLK %d has invalid pointer %p\n", id, clk);
 		return;
 	}
-	if (id > unit->nr_clks) {
+	if (id >= unit->nr_clks) {
 		pr_err("CLK %d is invalid\n", id);
 		return;
 	}
-- 
2.19.1



