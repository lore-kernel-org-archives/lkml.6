Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59906C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 00:05:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20C53208A3
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 00:05:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="uREpnTk8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20C53208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732164AbeKLJzp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 04:55:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:34452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731934AbeKLIRo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:17:44 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9158221508;
        Sun, 11 Nov 2018 22:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975268;
        bh=qWjM+ajTMzFznb2L0ALdOhbCxFV+1suH5y6U04Da/rc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uREpnTk8fDxM21nDKSEHzKeCjDf6YYKG48doBwJE1iomSu0nUM5wMmW6NVpGfojNZ
         6yqFh7uvnmirxJVozi96sCJkzlrr/ZO1h94SZcjg9XFtQ0Q7/ZiqqX71/mbGMLxGpl
         KQr6DcGn87nPe+RqyyejeBmm6Y4K5JHPxq/aCLJg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 164/361] nvmem: check the return value of nvmem_add_cells()
Date:   Sun, 11 Nov 2018 14:18:31 -0800
Message-Id: <20181111221643.432526195@linuxfoundation.org>
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

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

[ Upstream commit fa72d847d68d7833b77a4bef944cf2c5baf56f49 ]

This function can fail so check its return value in nvmem_register()
and act accordingly.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/nvmem/core.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -516,11 +516,17 @@ struct nvmem_device *nvmem_register(cons
 			goto err_device_del;
 	}
 
-	if (config->cells)
-		nvmem_add_cells(nvmem, config->cells, config->ncells);
+	if (config->cells) {
+		rval = nvmem_add_cells(nvmem, config->cells, config->ncells);
+		if (rval)
+			goto err_teardown_compat;
+	}
 
 	return nvmem;
 
+err_teardown_compat:
+	if (config->compat)
+		device_remove_bin_file(nvmem->base_dev, &nvmem->eeprom);
 err_device_del:
 	device_del(&nvmem->dev);
 err_put_device:


