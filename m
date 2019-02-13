Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C83F0C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:47:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FF8E222D4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550083644;
	bh=8QvocePH4OissGj6raugLFY6J3Fa6tVbLGYAalx7dLg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0zs1MRrB2yaRHkCZl4sR+F7dkK+hz32OMzkPuna4zJhuHttSY0VnXXIu6kIRTy77W
	 HMuSKcPgk+2pfblCvsm/xqg9XCr1gDc5hzp1Zbyc47QubISqxJ5JcgroTHDovpiLgm
	 vhKEU44k6sA7jo10mqJ2JzDQErRJBaI/lqSnDe5o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436546AbfBMSrX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 13:47:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:43998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406190AbfBMSpT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 13:45:19 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 04EB4222D2;
        Wed, 13 Feb 2019 18:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550083518;
        bh=8QvocePH4OissGj6raugLFY6J3Fa6tVbLGYAalx7dLg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Bm+oTHUypomYpcvDJZ05r90F9aHmjdyV5M+q0fwTvXn3r/Zj5ASN/cSnvnUhPSKQ6
         Ub532nKmqVtG52fH0PLrc0vK/3oaTlgt2ME36sqEvhySjZQMhkd2neeIRvG3crkfZO
         vwXkx41YQpiJbZ/u+qCKeKvhooRwJn3GYABvvzxs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Matt Ranostay <matt.ranostay@konsulko.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 4.20 08/50] iio: chemical: atlas-ph-sensor: correct IIO_TEMP values to millicelsius
Date:   Wed, 13 Feb 2019 19:38:13 +0100
Message-Id: <20190213183656.466853359@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190213183655.747168774@linuxfoundation.org>
References: <20190213183655.747168774@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

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


