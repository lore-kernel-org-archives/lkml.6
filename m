Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F0FEC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:40:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 071F720989
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:40:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0nOGfQgy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 071F720989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733008AbeKTDEf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:04:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:37638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732128AbeKTDEe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:04:34 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B4176208E3;
        Mon, 19 Nov 2018 16:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542645625;
        bh=CbLzdErxh5ctnuFWQbgO0w0v8cxlx+hnpZGBsUvcHDU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0nOGfQgyFQKEp2HA/Kg5UNxQvUSZHYmilVSqGn+TuDiKra22bvjVAhUpeD0TVpnh2
         tXdCZ8EaehjSbxU+0eNbMi9eGFz0BzIW5eKllNUYk3mPYKKjKLgrZmbB15MfbgBWiI
         N+DJ4bXf9XPy7435uPYQjXgFYRahV4OKzlt0BAiQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.18 027/171] staging:iio:ad7606: fix voltage scales
Date:   Mon, 19 Nov 2018 17:27:03 +0100
Message-Id: <20181119162624.197570852@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162618.909354448@linuxfoundation.org>
References: <20181119162618.909354448@linuxfoundation.org>
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

From: Alexandru Ardelean <alexandru.ardelean@analog.com>

[ Upstream commit 4ee033301c898dd0835d035d0e0eb768a3d35da1 ]

Fixes commit 17be2a2905a6ec9aa27cd59521495e2f490d2af0 ("staging: iio:
ad7606: replace range/range_available with corresponding scale").

The AD7606 devices don't have a 2.5V voltage range, they have 5V & 10V
voltage range, which is selectable via the `gpio_range` descriptor.

The scales also seem to have been miscomputed, because when they were
applied to the raw values, the results differ from the expected values.
After checking the ADC transfer function in the datasheet, these were
re-computed.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/staging/iio/adc/ad7606.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/drivers/staging/iio/adc/ad7606.c
+++ b/drivers/staging/iio/adc/ad7606.c
@@ -26,9 +26,12 @@
 
 #include "ad7606.h"
 
-/* Scales are computed as 2.5/2**16 and 5/2**16 respectively */
+/*
+ * Scales are computed as 5000/32768 and 10000/32768 respectively,
+ * so that when applied to the raw values they provide mV values
+ */
 static const unsigned int scale_avail[2][2] = {
-	{0, 38147}, {0, 76294}
+	{0, 152588}, {0, 305176}
 };
 
 static int ad7606_reset(struct ad7606_state *st)


