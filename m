Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BAC9C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 00:03:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6A2B20866
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 00:03:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ir5oEHU0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6A2B20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732097AbeKLIRt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:17:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:34452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732056AbeKLIRs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:17:48 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0504F208A3;
        Sun, 11 Nov 2018 22:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975273;
        bh=388qjFT6CyNdyTPXybAqNcnfUPRy4uQh4cqDOW2NonQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ir5oEHU0dJ2epCaBDHGwSGTRZgzX3iVuSJO//1Yu7EhiW0CPHR8jaTj2tlf/eM5Au
         IZxgpDHs+Hu9LvdDTr1KQsCta8aO7eROYNLn+KfVpDmujXxRngY45LxHPuXlsY6jmS
         QT49uE+kGOxSp9Qp7EJoDMAp+MU5jRBVz9ikypYQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Slava Shwartsman <slavash@mellanox.com>,
        Parav Pandit <parav@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 143/361] RDMA/cm: Respect returned status of cm_init_av_by_path
Date:   Sun, 11 Nov 2018 14:18:10 -0800
Message-Id: <20181111221640.612934902@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221619.915519183@linuxfoundation.org>
References: <20181111221619.915519183@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Leon Romanovsky <leonro@mellanox.com>

[ Upstream commit e54b6a3bcd1ec972b25a164bdf495d9e7120b107 ]

Add missing check for failure of cm_init_av_by_path

Fixes: e1444b5a163e ("IB/cm: Fix automatic path migration support")
Reported-by: Slava Shwartsman <slavash@mellanox.com>
Reviewed-by: Parav Pandit <parav@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/core/cm.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -3292,8 +3292,11 @@ static int cm_lap_handler(struct cm_work
 	if (ret)
 		goto unlock;
 
-	cm_init_av_by_path(param->alternate_path, NULL, &cm_id_priv->alt_av,
-			   cm_id_priv);
+	ret = cm_init_av_by_path(param->alternate_path, NULL,
+				 &cm_id_priv->alt_av, cm_id_priv);
+	if (ret)
+		goto unlock;
+
 	cm_id_priv->id.lap_state = IB_CM_LAP_RCVD;
 	cm_id_priv->tid = lap_msg->hdr.tid;
 	ret = atomic_inc_and_test(&cm_id_priv->work_count);


