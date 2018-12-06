Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C9FFC04EBF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:51:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2075520892
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544107863;
	bh=Qd8AwWCBmS/zdSslecm1cmuwZtHyHLMENuFAAkB0tjo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bho8WFGN/BIGhq+3V9c2TCU5aa0SCa/mBTEfMcmiKJi6sWGxadESmX5X2AuasGHqZ
	 Dh4vfeMigctFTU/yAdQ89/sK9LQRMwCZcqdZxL6CU+sgJtcAgQch09sFsxEio4oAdd
	 gyzZQTLhHQHFcm80pXDjIO09OqXh6jEZC96DXWBY=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2075520892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731149AbeLFOvB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 09:51:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:51768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731356AbeLFOq7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 09:46:59 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE41F2082B;
        Thu,  6 Dec 2018 14:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544107619;
        bh=Qd8AwWCBmS/zdSslecm1cmuwZtHyHLMENuFAAkB0tjo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FwkS/c8WGZvT9vuqjets2l7VkNarS49rKW87Xtc5Ok78jLz/pxxEYRzb2CroPrOFH
         JZA1FWfXN2r5fe8Ah7fQi77VrgylaO19xcQ36+KgOjnLkkr7uIgcTKJquyiRucU58G
         7UFlZLoNeeksfJlcOLexrj14Y7lsmWrPCqj/No68=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Dinh Nguyen <dinguyen@kernel.org>
Subject: [PATCH 4.9 039/101] reset: core: fix reset_control_put
Date:   Thu,  6 Dec 2018 15:38:38 +0100
Message-Id: <20181206143013.777623814@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206143011.174892052@linuxfoundation.org>
References: <20181206143011.174892052@linuxfoundation.org>
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

From: Heiner Kallweit <hkallweit1@gmail.com>

commit 4891486fb2c80eaf3bb0f9eb065d15ecd357702f upstream.

Commit "reset: make optional functions really optional" missed to
adjust one check in reset_control_put, causing a NULL pointer
access for optional resets.

Fixes: bb475230b8e5 "reset: make optional functions really optional"
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Dinh Nguyen <dinguyen@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/reset/core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/reset/core.c
+++ b/drivers/reset/core.c
@@ -358,7 +358,7 @@ EXPORT_SYMBOL_GPL(__of_reset_control_get
 
 void reset_control_put(struct reset_control *rstc)
 {
-	if (IS_ERR(rstc))
+	if (IS_ERR_OR_NULL(rstc))
 		return;
 
 	mutex_lock(&reset_list_mutex);


