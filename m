Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32A07C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:56:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEA6C21104
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:56:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="x1grzLwe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEA6C21104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732560AbeKLISN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:18:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:35336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732534AbeKLISM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:18:12 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B386F208A3;
        Sun, 11 Nov 2018 22:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975296;
        bh=f1w7zgAU7wDcqCuEAJA8FwQ6OW7/NZqyj4PHLC96Tvk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=x1grzLweM3y4PGfttl2/nRZACY8++FyGOasoff2Lm8QYVqoCeT8XzzYv8zIoHw/E0
         pniTVdU8TfRj4+m/DBeQl+gxCtQ8r5gGECz94yJUiUHzD2owEUbUWOsvlwut0E34FX
         adWPkPcKm3w833+3nj2JL6OfDFCBJ0DqsD+SW8dw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Christian Lamparter <chunkeey@gmail.com>,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 4.19 214/361] dmaengine: ppc4xx: fix off-by-one build failure
Date:   Sun, 11 Nov 2018 14:19:21 -0800
Message-Id: <20181111221649.939131366@linuxfoundation.org>
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

From: Christian Lamparter <chunkeey@gmail.com>

commit 27d8d2d7a9b7eb05c4484b74b749eaee7b50b845 upstream.

There are two poly_store, but one should have been poly_show.

|adma.c:4382:16: error: conflicting types for 'poly_store'
| static ssize_t poly_store(struct device_driver *dev, const char *buf,
|                ^~~~~~~~~~
|adma.c:4363:16: note: previous definition of 'poly_store' was here
| static ssize_t poly_store(struct device_driver *dev, char *buf)
|                ^~~~~~~~~~

CC: stable@vger.kernel.org
Fixes: 13efe1a05384 ("dmaengine: ppc4xx: remove DRIVER_ATTR() usage")
Signed-off-by: Christian Lamparter <chunkeey@gmail.com>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/dma/ppc4xx/adma.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/dma/ppc4xx/adma.c
+++ b/drivers/dma/ppc4xx/adma.c
@@ -4360,7 +4360,7 @@ static ssize_t enable_store(struct devic
 }
 static DRIVER_ATTR_RW(enable);
 
-static ssize_t poly_store(struct device_driver *dev, char *buf)
+static ssize_t poly_show(struct device_driver *dev, char *buf)
 {
 	ssize_t size = 0;
 	u32 reg;


