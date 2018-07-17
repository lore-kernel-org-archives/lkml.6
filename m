Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FB4FECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 03:21:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B835B20877
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 03:21:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="RM3erbjG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B835B20877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lechnology.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730301AbeGQDvj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 23:51:39 -0400
Received: from vern.gendns.com ([206.190.152.46]:35635 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729952AbeGQDvj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 23:51:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=References:In-Reply-To:Message-Id:Date:Subject
        :Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ETlNqQYXbQxJqETHsGE2g1O1rdX9QJplc7dX4SJSXIg=; b=RM3erbjGSo7AwMbIFHZ92blvQ
        9AZD5g1QGzC5pD6NV7chisSX+KPKwW2nrfxRKapaXFCVWyDNBFvRwWO0rzKYf3CNetllfPT7WJr/o
        ZVXqoX5t/OVw9OTc87RY3W4zpcT/Lhvc6nMv7YBDMcjAkWwoMCoO+BdZ6mUIr2YcmJqsA5EpEW5Mn
        KfQhGpCo7kyzTSLJnuzVq1VYbfzJRNsZd7jQ03mgj8vd97cBncRCRCco8R4rq2CMOPF1O0lxamxsE
        bxocoltP6uKCRzh6uo10rCq0pA3OjKmpJ2rhtGi7ZhUE0QnSgJ0wpFu3lBceP2OfduaS6BbwsXJgj
        SQy1pUW5w==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:53228 helo=freyr.lechnology.com)
        by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <david@lechnology.com>)
        id 1ffGY5-00CnnZ-LQ; Mon, 16 Jul 2018 23:21:13 -0400
From:   David Lechner <david@lechnology.com>
To:     linux-spi@vger.kernel.org, linux-iio@vger.kernel.org
Cc:     David Lechner <david@lechnology.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] spi: spi-bitbang: change flags from u8 to u16
Date:   Mon, 16 Jul 2018 22:20:49 -0500
Message-Id: <20180717032052.12273-2-david@lechnology.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180717032052.12273-1-david@lechnology.com>
References: <20180717032052.12273-1-david@lechnology.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This changes the data type of the flags field in struct spi_bitbang from
u8 to u16. This matches the size of the mode field of struct spi_device
where these flags are also used.

This is done in preparation of adding a new SPI mode flag that will be
used with this field that would otherwise not fit in 8 bits.

Signed-off-by: David Lechner <david@lechnology.com>
---
 include/linux/spi/spi_bitbang.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/spi/spi_bitbang.h b/include/linux/spi/spi_bitbang.h
index 51d8c060e513..c1e61641a7f1 100644
--- a/include/linux/spi/spi_bitbang.h
+++ b/include/linux/spi/spi_bitbang.h
@@ -8,7 +8,7 @@ struct spi_bitbang {
 	struct mutex		lock;
 	u8			busy;
 	u8			use_dma;
-	u8			flags;		/* extra spi->mode support */
+	u16			flags;		/* extra spi->mode support */
 
 	struct spi_master	*master;
 
-- 
2.17.1

