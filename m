Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82F51ECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:54:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D46921104
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:54:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lvSFAm/i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D46921104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728376AbeKIHcS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:32:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:47362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727360AbeKIHcR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:32:17 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CCC682086C;
        Thu,  8 Nov 2018 21:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714090;
        bh=a/zgkPBVbUtykwZbRWCa0efPEq2znYl8Ks8OOcUFGYI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lvSFAm/i1JK6nvb5vqzOV1q73w1uBTqOVGI6wAEIv3MdezmhC16oDTnS4dEqNMXy3
         2aL8z4E2az7uVCrmeUxwkV+ugN+0UGt0DHTk1iUzJQxDFY6XXAichd6UHTsznYxeqz
         y/e9+rlPo8rPWgC+3xv1N//0XcnVynEbkkeYNkC0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Fabien Proriol <fabien.proriol@jdsu.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 051/144] iio: iio: Fix iio_channel_read return if channel havnt info
Date:   Thu,  8 Nov 2018 13:50:22 -0800
Message-Id: <20181108215058.534135979@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215054.826084593@linuxfoundation.org>
References: <20181108215054.826084593@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

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



