Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9617CC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:49:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DC2120872
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:49:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="U3UlU2up"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DC2120872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732994AbeKLISh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:18:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:38154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732963AbeKLISh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:18:37 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DFE1A21780;
        Sun, 11 Nov 2018 22:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975320;
        bh=AGkhQk2r6oZOUbLqcJLZ7vPaBtSm6OHbs5Z0yl37v2s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U3UlU2upjUB71psnbJkXYzpW4wbIh4MaQX+KD2A5bugPdPQ+1/yRl37OeGzJ0fQaz
         FjLLTUS/SnPkVpUV33e3SwszkfS8Uj74ZcZ2cnzldmzfsZqP9tn5rkJZNidyfurHZS
         4G+NRqPyH5hL+EBEGH5UZTouqOj0TbYGywE0w0YE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Colin Ian King <colin.king@canonical.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [PATCH 4.19 317/361] rpmsg: smd: fix memory leak on channel create
Date:   Sun, 11 Nov 2018 14:21:04 -0800
Message-Id: <20181111221658.805217784@linuxfoundation.org>
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
@@ -1122,8 +1122,10 @@ static struct qcom_smd_channel *qcom_smd
 
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
@@ -1173,6 +1175,7 @@ static struct qcom_smd_channel *qcom_smd
 
 free_name_and_channel:
 	kfree(channel->name);
+free_channel:
 	kfree(channel);
 
 	return ERR_PTR(ret);


