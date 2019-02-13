Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF6C7C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:44:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CF4E222D2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550083469;
	bh=UcScgB/KufZY7N+HCt37p7qnEh/D5B3bZdFMX1QijNo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Kjfm6iZ3DtxuEaCPFqj5t4EhdH7rAIvarBqlDEad4380eSarOsj8rI9gsaWvY8i1l
	 kMkMjyrVBGSytnn7kohZI6HHUKP1rzyynSNROsB6qsaa2sHDEOYL1EQDtv9RT44Rh+
	 NFAxh6VK94A6C4QskzNDt36PPsugP0o/JRnf99fs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733053AbfBMSo1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 13:44:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:42940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406116AbfBMSoY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 13:44:24 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B7A9E20811;
        Wed, 13 Feb 2019 18:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550083463;
        bh=UcScgB/KufZY7N+HCt37p7qnEh/D5B3bZdFMX1QijNo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dOtgTVEtGvg18wzR7iZUQNnxvudL9Eb2sYq2yy/aO1BdXiCLwc9waZJYCtKZaE/VI
         tpnbwbezKFX3KCMCSRuUlJM52ydAlfHsH5KEG27U4642VKOQwIF99HRMC52APMr49G
         0Z++CT38msi9Ym8qRuEPUQYzu6XIeTzvgWtERP8A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Matt Ranostay <matt.ranostay@konsulko.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 4.19 08/44] iio: chemical: atlas-ph-sensor: correct IIO_TEMP values to millicelsius
Date:   Wed, 13 Feb 2019 19:38:09 +0100
Message-Id: <20190213183652.350397690@linuxfoundation.org>
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

From: Matt Ranostay <matt.ranostay@konsulko.com>

commit 0808831dc62e90023ad14ff8da4804c7846e904b upstream.

IIO_TEMP scale value for temperature was incorrect and not in millicelsius
as required by the ABI documentation.

Signed-off-by: Matt Ranostay <matt.ranostay@konsulko.com>
Fixes: 27dec00ecf2d (iio: chemical: add Atlas pH-SM sensor support)
Cc: <stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/iio/chemical/atlas-ph-sensor.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

--- a/drivers/iio/chemical/atlas-ph-sensor.c
+++ b/drivers/iio/chemical/atlas-ph-sensor.c
@@ -444,9 +444,8 @@ static int atlas_read_raw(struct iio_dev
 	case IIO_CHAN_INFO_SCALE:
 		switch (chan->type) {
 		case IIO_TEMP:
-			*val = 1; /* 0.01 */
-			*val2 = 100;
-			break;
+			*val = 10;
+			return IIO_VAL_INT;
 		case IIO_PH:
 			*val = 1; /* 0.001 */
 			*val2 = 1000;
@@ -477,7 +476,7 @@ static int atlas_write_raw(struct iio_de
 			   int val, int val2, long mask)
 {
 	struct atlas_data *data = iio_priv(indio_dev);
-	__be32 reg = cpu_to_be32(val);
+	__be32 reg = cpu_to_be32(val / 10);
 
 	if (val2 != 0 || val < 0 || val > 20000)
 		return -EINVAL;


