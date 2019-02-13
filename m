Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB861C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:40:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCBB4222D6
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550083203;
	bh=EMHBaVpU1ntNc7ITT/Z4dlzJ3I3M4Lzv9eh5ccJjqjE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xkZaMUCAo5h4e/PJqogR67LB3npmI77ZI9z3SerUSV5wlOi6ZdFeymjUpDIAJBHq4
	 udswl1G2nqsulEp7KMj9fruoWROTiSOsey5rLTZ9YjkiABybuYDkD10hr25jl5yiDI
	 rSwpWzZKz9MfKulPDAsWqHrto7IAoanwHNLs2QQQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405345AbfBMSkB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 13:40:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:38076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405302AbfBMSkA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 13:40:00 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D430222D8;
        Wed, 13 Feb 2019 18:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550083199;
        bh=EMHBaVpU1ntNc7ITT/Z4dlzJ3I3M4Lzv9eh5ccJjqjE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=v9efRJocLKfvLXBf2VQnXwLkE27XvV1OxP2aWTXmPpgkWxWsMIAr1B+ectunhhg4C
         9rX/HyykJHyE47dwuC0tQjeJ3WYSQzXQ8VKOEvUraEcKtYxm3zO39pfm+u3u5pFz4z
         wzF3/x+T7GE00n0gt6YC89wCzekaGezdmrC/Wt/Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Matt Ranostay <matt.ranostay@konsulko.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 4.9 02/24] iio: chemical: atlas-ph-sensor: correct IIO_TEMP values to millicelsius
Date:   Wed, 13 Feb 2019 19:37:59 +0100
Message-Id: <20190213183647.517234921@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190213183647.333441569@linuxfoundation.org>
References: <20190213183647.333441569@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -453,9 +453,8 @@ static int atlas_read_raw(struct iio_dev
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
@@ -486,7 +485,7 @@ static int atlas_write_raw(struct iio_de
 			   int val, int val2, long mask)
 {
 	struct atlas_data *data = iio_priv(indio_dev);
-	__be32 reg = cpu_to_be32(val);
+	__be32 reg = cpu_to_be32(val / 10);
 
 	if (val2 != 0 || val < 0 || val > 20000)
 		return -EINVAL;


