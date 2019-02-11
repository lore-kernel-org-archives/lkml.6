Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6D5AC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:31:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B59D921B26
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549899093;
	bh=Ik6nIoSd0YJD17c3CJwXtxh0eY3CDBSEWw7xAyI3Eu8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=c5YTjWx6RYAFF40/Kcoyl2twcSuWwEcFOuNOtonApx/upc7//9YaeIbMyX/N0FQnD
	 qDN12v6kVb2WVlv18ED4Q40E0vNG/ritSgclrMEyRPMwuXWpQSPAqcIwKoNGivK7zl
	 jY6VmOjj2b0zzTczabINn/1yhY942zsjTtVUEzFg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389376AbfBKPbb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:31:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:42940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389048AbfBKOzu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:55:50 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 81ABD20700;
        Mon, 11 Feb 2019 14:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549896950;
        bh=Ik6nIoSd0YJD17c3CJwXtxh0eY3CDBSEWw7xAyI3Eu8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FKPjstD60poexLoYsYXNC9eEvvw8ZL5exuqargkYb7hbC1xnhlaxJ21xnavFiIImr
         jvviqEDf5aJOM4xCn0tisyw+fel7TOukKkT1i+SNNQkUR4eaKLw4tk0nqDuW4UqKYK
         pwozwvk/XhJogve8c6XrHycShwafrfbNHtyK22QM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Straube <straube.linux@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 041/205] staging: pi433: fix potential null dereference
Date:   Mon, 11 Feb 2019 15:17:19 +0100
Message-Id: <20190211141830.771869543@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141827.214852402@linuxfoundation.org>
References: <20190211141827.214852402@linuxfoundation.org>
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

[ Upstream commit 64c4c4ca6c129a4191e8e1e91b2d5d9b8d08c518 ]

Add a test for successful call to cdev_alloc() to avoid
potential null dereference. Issue reported by smatch.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
Fixes: 874bcba65f9a ("staging: pi433: New driver")
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/pi433/pi433_if.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/staging/pi433/pi433_if.c b/drivers/staging/pi433/pi433_if.c
index 93c01680f016..5be40bdc191b 100644
--- a/drivers/staging/pi433/pi433_if.c
+++ b/drivers/staging/pi433/pi433_if.c
@@ -1210,6 +1210,10 @@ static int pi433_probe(struct spi_device *spi)
 
 	/* create cdev */
 	device->cdev = cdev_alloc();
+	if (!device->cdev) {
+		dev_dbg(device->dev, "allocation of cdev failed");
+		goto cdev_failed;
+	}
 	device->cdev->owner = THIS_MODULE;
 	cdev_init(device->cdev, &pi433_fops);
 	retval = cdev_add(device->cdev, device->devt, 1);
-- 
2.19.1



