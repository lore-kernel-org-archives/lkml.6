Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3026C282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:44:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8FAB222D2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550083474;
	bh=4Zhox896YP+gNjjW2TETc7yLdNzrNRHSHzdtPGXPCkk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sxonUv0/53QLhkGBUbHs+0YbDqtjuhNGsQLzDQpj03eAghbvN5bRQP0fXUTbUkyIE
	 tgmcvMEnH1KWdXqnWYvtyCnPZMJgqZd+ykMOyNMnOM+EZ71oHNnBWbSBfk/s8LIU0G
	 8L2j9xIKksYNUmEYkFqqC7myKiwQ5/hCbDMuI6ME=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406139AbfBMSoc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 13:44:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:42986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406126AbfBMSo1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 13:44:27 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F18BB20835;
        Wed, 13 Feb 2019 18:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550083466;
        bh=4Zhox896YP+gNjjW2TETc7yLdNzrNRHSHzdtPGXPCkk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wpThLmcGdjyshtXsJtFAieawmTTRlzviGvSR/0U8Q9Y4uT2UhPWXI8TKtLJHUWFI5
         w4kCY5/UuScOvhY5dBwBEHzGVUVMdT9w5q+Wc3g6GydInNPVzPfkPHWnzF8Y7g+XdK
         n7A468q4Rh3OTWEt1xdpxVBXu6GUdN+MxFAuESko=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Murphy <dmurphy@ti.com>,
        Stable@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 4.19 09/44] iio: ti-ads8688: Update buffer allocation for timestamps
Date:   Wed, 13 Feb 2019 19:38:10 +0100
Message-Id: <20190213183652.441142552@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190213183651.648060257@linuxfoundation.org>
References: <20190213183651.648060257@linuxfoundation.org>
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

From: Dan Murphy <dmurphy@ti.com>

commit f214ff521fb1f861c8d7f7d0af98b06bf61b3369 upstream.

Per Jonathan Cameron, the buffer needs to allocate room for a
64 bit timestamp as well as the channels.  Change the buffer
to allocate this additional space.

Fixes: 2a86487786b5c ("iio: adc: ti-ads8688: add trigger and buffer support")
Signed-off-by: Dan Murphy <dmurphy@ti.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/iio/adc/ti-ads8688.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/iio/adc/ti-ads8688.c
+++ b/drivers/iio/adc/ti-ads8688.c
@@ -41,6 +41,7 @@
 
 #define ADS8688_VREF_MV			4096
 #define ADS8688_REALBITS		16
+#define ADS8688_MAX_CHANNELS		8
 
 /*
  * enum ads8688_range - ADS8688 reference voltage range
@@ -385,7 +386,7 @@ static irqreturn_t ads8688_trigger_handl
 {
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
-	u16 buffer[8];
+	u16 buffer[ADS8688_MAX_CHANNELS + sizeof(s64)/sizeof(u16)];
 	int i, j = 0;
 
 	for (i = 0; i < indio_dev->masklength; i++) {


