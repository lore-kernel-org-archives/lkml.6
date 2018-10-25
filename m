Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A617AC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:29:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5206D2084A
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:29:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="S0QrYRMp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5206D2084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730534AbeJYWw0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:52:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:34450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728037AbeJYWwZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:52:25 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D8C32085B;
        Thu, 25 Oct 2018 14:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540477168;
        bh=nuhSsZfIuTepcz0eG4zUbvSsstNDmmN44CO1jOjt24U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S0QrYRMpyPkRMEsL7Cj3+sIhOoZ5kKe2nKbpev4YWl3dqUrl2kydsGjqbo6hIDMWv
         devb4eam0riYjB4fMsZls6Jktx4JAvOeJhgTJbZT+0/MzVyqpunK/K4Wf/eTD7bh9Q
         D1nRMuUzgFmi11fS0yacFRI0Bg7Gv1j8x5hbUKog=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Fabien Proriol <fabien.proriol@jdsu.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 3.18 21/98] iio: iio: Fix iio_channel_read return if channel havn't info
Date:   Thu, 25 Oct 2018 10:17:36 -0400
Message-Id: <20181025141853.214051-21-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141853.214051-1-sashal@kernel.org>
References: <20181025141853.214051-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fabien Proriol <fabien.proriol@jdsu.com>

[ Upstream commit 65de7654d39c70c2b942f801cea01590cf7e3458 ]

When xilinx-xadc is used with hwmon driver to read voltage, offset used
for temperature is always applied whatever the channel.

iio_channel_read must return an error to avoid offset for channel
without IIO_CHAN_INFO_OFFSET property.

Signed-off-by: Fabien Proriol <fabien.proriol@jdsu.com>
Signed-off-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/inkern.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index f0846108d006..d33590e89337 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -426,6 +426,9 @@ static int iio_channel_read(struct iio_channel *chan, int *val, int *val2,
 	if (val2 == NULL)
 		val2 = &unused;
 
+	if(!iio_channel_has_info(chan->channel, info))
+		return -EINVAL;
+
 	if (chan->indio_dev->info->read_raw_multi) {
 		ret = chan->indio_dev->info->read_raw_multi(chan->indio_dev,
 					chan->channel, INDIO_MAX_RAW_ELEMENTS,
-- 
2.17.1

