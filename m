Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45D0EC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:58:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 032E820818
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:58:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tu0th+b/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 032E820818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403878AbeKLIse (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:48:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:53878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403763AbeKLIWk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:22:40 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6ED9C21707;
        Sun, 11 Nov 2018 22:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975563;
        bh=DX5DKsdNyfyQ1jseEn469DT4m89aRJOmuY4NBtMJyPQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Tu0th+b/eFrH20uXbIOkusaDGKnw4L/bZ4PyzNkkwIUAUQb40mP8zQnKS/KiZct3g
         qmsCAn3xY4TBQrPwhNrj1NKPLXStSGijbEr2N6GANQQZWzIYjllV9l4m0STVtFCMXn
         5kiAVAA5uXyFUa7eyHh7OX3HesycGmfwQROzZKPk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Christian Lamparter <chunkeey@gmail.com>,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 4.14 129/222] dmaengine: ppc4xx: fix off-by-one build failure
Date:   Sun, 11 Nov 2018 14:23:46 -0800
Message-Id: <20181111221659.153303559@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221647.665769131@linuxfoundation.org>
References: <20181111221647.665769131@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

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


