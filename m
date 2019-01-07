Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAFA5C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:49:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BEF120859
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546865370;
	bh=gF+Fy+j0ynQVWUd5Z1PpDhDaSk2SewhNJzHWsXdaMGM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Z4yAEuGEQMrBbciWdB4Q0AoDqpzvyWav3DxaQr8oAntTcDS9Rg+UAlEBWsaRWrOXw
	 4awb+lSdMJAzx+P7HGygffJLz5eUMOALCwO9R7ZbNyki9LtM3fhYLbTkC0w+jkC2IQ
	 BbU42ryyh77429NclguL+T8eC80Evb8U6ya87Mkw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729504AbfAGMt3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:49:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:40272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728654AbfAGMtY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:49:24 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1AB120651;
        Mon,  7 Jan 2019 12:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546865364;
        bh=gF+Fy+j0ynQVWUd5Z1PpDhDaSk2SewhNJzHWsXdaMGM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BKRUrD2G3xVy1MGQrJLsD+E3UtsuykXKhRUMT+mYEsff2DojKWubyldaL1a+JYDY7
         NynhnCNucOHTqVDRLbVYHqutHBhdGozF0q84LSU026Ma/E8konKEhzl9kG/QdEjy25
         ix1RDahcvEN9z2QFzEBToby8att5juiF1HuHDBvE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 020/170] net: stmmac: Fix an error code in probe()
Date:   Mon,  7 Jan 2019 13:30:47 +0100
Message-Id: <20190107104455.429287665@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107104452.953560660@linuxfoundation.org>
References: <20190107104452.953560660@linuxfoundation.org>
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

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit b26322d2ac6c1c1087af73856531bb836f6963ca ]

The function should return an error if create_singlethread_workqueue()
fails.

Fixes: 34877a15f787 ("net: stmmac: Rework and fix TX Timeout code")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -4247,6 +4247,7 @@ int stmmac_dvr_probe(struct device *devi
 	priv->wq = create_singlethread_workqueue("stmmac_wq");
 	if (!priv->wq) {
 		dev_err(priv->device, "failed to create workqueue\n");
+		ret = -ENOMEM;
 		goto error_wq;
 	}
 


