Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A6F0C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:39:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CC2420658
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:39:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CC2420658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731912AbeICWAQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 18:00:16 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49072 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727442AbeICWAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 18:00:15 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C4E5FBAE;
        Mon,  3 Sep 2018 17:39:04 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Johan Hovold <johan@kernel.org>,
        Andy Gross <andy.gross@linaro.org>
Subject: [PATCH 4.18 076/123] soc: qcom: rmtfs-mem: fix memleak in probe error paths
Date:   Mon,  3 Sep 2018 18:57:00 +0200
Message-Id: <20180903165722.757028020@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180903165719.499675257@linuxfoundation.org>
References: <20180903165719.499675257@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johan Hovold <johan@kernel.org>

commit 78ee559d7fc65e37670a46cfbeaaa62cb014af67 upstream.

Make sure to set the mem device release callback before calling
put_device() in a couple of probe error paths so that the containing
object also gets freed.

Fixes: d1de6d6c639b ("soc: qcom: Remote filesystem memory driver")
Cc: stable <stable@vger.kernel.org>     # 4.15
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Andy Gross <andy.gross@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/soc/qcom/rmtfs_mem.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/drivers/soc/qcom/rmtfs_mem.c
+++ b/drivers/soc/qcom/rmtfs_mem.c
@@ -184,6 +184,7 @@ static int qcom_rmtfs_mem_probe(struct p
 	device_initialize(&rmtfs_mem->dev);
 	rmtfs_mem->dev.parent = &pdev->dev;
 	rmtfs_mem->dev.groups = qcom_rmtfs_mem_groups;
+	rmtfs_mem->dev.release = qcom_rmtfs_mem_release_device;
 
 	rmtfs_mem->base = devm_memremap(&rmtfs_mem->dev, rmtfs_mem->addr,
 					rmtfs_mem->size, MEMREMAP_WC);
@@ -206,8 +207,6 @@ static int qcom_rmtfs_mem_probe(struct p
 		goto put_device;
 	}
 
-	rmtfs_mem->dev.release = qcom_rmtfs_mem_release_device;
-
 	ret = of_property_read_u32(node, "qcom,vmid", &vmid);
 	if (ret < 0 && ret != -EINVAL) {
 		dev_err(&pdev->dev, "failed to parse qcom,vmid\n");


