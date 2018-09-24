Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C5A9C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:51:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D8E2204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:51:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D8E2204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387543AbeIXSaX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:30:23 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:57452 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730974AbeIXSaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:30:22 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 3BFA11018;
        Mon, 24 Sep 2018 12:28:28 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mikko Perttunen <mperttunen@nvidia.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 032/235] clk: core: Potentially free connection id
Date:   Mon, 24 Sep 2018 13:50:18 +0200
Message-Id: <20180924113108.106343137@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113103.999624566@linuxfoundation.org>
References: <20180924113103.999624566@linuxfoundation.org>
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

From: Mikko Perttunen <mperttunen@nvidia.com>

[ Upstream commit 365f7a89c881e84f1ebc925f65f899d5d7ce547e ]

Patch "clk: core: Copy connection id" made it so that the connector id
'con_id' is kstrdup_const()ed to cater to drivers that pass non-constant
connection ids. The patch added the corresponding kfree_const to
__clk_free_clk(), but struct clk's can be freed also via __clk_put().
Add the kfree_const call to __clk_put() and add comments to both
functions to remind that the logic in them should be kept in sync.

Fixes: 253160a8ad06 ("clk: core: Copy connection id")
Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
Reviewed-by: Leonard Crestez <leonard.crestez@nxp.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/clk/clk.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -2933,6 +2933,7 @@ struct clk *__clk_create_clk(struct clk_
 	return clk;
 }
 
+/* keep in sync with __clk_put */
 void __clk_free_clk(struct clk *clk)
 {
 	clk_prepare_lock();
@@ -3312,6 +3313,7 @@ int __clk_get(struct clk *clk)
 	return 1;
 }
 
+/* keep in sync with __clk_free_clk */
 void __clk_put(struct clk *clk)
 {
 	struct module *owner;
@@ -3345,6 +3347,7 @@ void __clk_put(struct clk *clk)
 
 	module_put(owner);
 
+	kfree_const(clk->con_id);
 	kfree(clk);
 }
 


