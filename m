Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 903D2C0044C
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:16:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D98D20817
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:16:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="alp8Wm34"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D98D20817
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389944AbeKLJGw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 04:06:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:49358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389765AbeKLIVi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:21:38 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D9E421508;
        Sun, 11 Nov 2018 22:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975500;
        bh=1dPJcaejeqyW/yShYY1p3jzTyQewnFFV6XfGNb2KrlE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=alp8Wm348BBHn0Iaeaivu6fbgO4DZRHZ9PVOsnzo43kufGfynaSQQYdNEGg3HT8xh
         DZCH7XpTvSdkawRWj5wl2UdxLylyi7OOripcwvwa0Y5jmYkJ8gh5RZ1ZI/97iORK8S
         fvqyazUrOTYTtXV66PAQ9dahfiWbIT0DJqTPgi0E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Colin Ian King <colin.king@canonical.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [PATCH 4.18 308/350] rpmsg: smd: fix memory leak on channel create
Date:   Sun, 11 Nov 2018 14:22:52 -0800
Message-Id: <20181111221720.958420964@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221707.043394111@linuxfoundation.org>
References: <20181111221707.043394111@linuxfoundation.org>
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

From: Colin Ian King <colin.king@canonical.com>

commit 940c620d6af8fca7d115de40f19870fba415efac upstream.

Currently a failed allocation of channel->name leads to an
immediate return without freeing channel. Fix this by setting
ret to -ENOMEM and jumping to an exit path that kfree's channel.

Detected by CoverityScan, CID#1473692 ("Resource Leak")

Fixes: 53e2822e56c7 ("rpmsg: Introduce Qualcomm SMD backend")
Cc: stable@vger.kernel.org
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/rpmsg/qcom_smd.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/drivers/rpmsg/qcom_smd.c
+++ b/drivers/rpmsg/qcom_smd.c
@@ -1114,8 +1114,10 @@ static struct qcom_smd_channel *qcom_smd
 
 	channel->edge = edge;
 	channel->name = kstrdup(name, GFP_KERNEL);
-	if (!channel->name)
-		return ERR_PTR(-ENOMEM);
+	if (!channel->name) {
+		ret = -ENOMEM;
+		goto free_channel;
+	}
 
 	spin_lock_init(&channel->tx_lock);
 	spin_lock_init(&channel->recv_lock);
@@ -1165,6 +1167,7 @@ static struct qcom_smd_channel *qcom_smd
 
 free_name_and_channel:
 	kfree(channel->name);
+free_channel:
 	kfree(channel);
 
 	return ERR_PTR(ret);


