Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CAD8C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:50:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00F7E20700
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550760656;
	bh=+4I2RzSS2SEcodEF9Kmu8b7yvbJvX2mpTmrq3LBipDI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VWrPaxfKlg6sGshNk6riYF90dpLwSR3hWzKKcwslkCLzWMi2673hSAD/hMMLT4Fzj
	 ur3uX5Rdzufjp/35WsDlAjZjkYhyQFk5XwZvB/4ZO2SEHC+cFyl9R7xI5+RECv/4eh
	 WjWnEsRZlpDMmpKAmtM2gyo2eb3jMclkWymu2lj8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728564AbfBUOuy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 09:50:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:59496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728554AbfBUOiA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 09:38:00 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E025E2075C;
        Thu, 21 Feb 2019 14:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550759879;
        bh=+4I2RzSS2SEcodEF9Kmu8b7yvbJvX2mpTmrq3LBipDI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rMvdnE1y01ubfhmvupERiQwkUYwwtb6d7kBn8BWRsGRagwOLltl9zdIwD5JiNk2iY
         d+KxQx0IIt0NwVnOa2UsvGv1VA8F5ODFsFApZ4KYQLA1nAb+JTRfQCblPD4x71MaCg
         dFrmWFnByY0uP/mFCRFTvDGSGpnimqwuJcLxTjDQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wei Yongjun <weiyongjun1@huawei.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 03/20] hwmon: (lm80) Fix missing unlock on error in set_fan_div()
Date:   Thu, 21 Feb 2019 15:35:33 +0100
Message-Id: <20190221141946.875229899@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190221141946.772985220@linuxfoundation.org>
References: <20190221141946.772985220@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 07bd14ccc3049f9c0147a91a4227a571f981601a ]

Add the missing unlock before return from function set_fan_div()
in the error handling case.

Fixes: c9c63915519b ("hwmon: (lm80) fix a missing check of the status of SMBus read")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/lm80.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/lm80.c b/drivers/hwmon/lm80.c
index cb6606a0470d1..be60bd5bab783 100644
--- a/drivers/hwmon/lm80.c
+++ b/drivers/hwmon/lm80.c
@@ -393,8 +393,10 @@ static ssize_t set_fan_div(struct device *dev, struct device_attribute *attr,
 	}
 
 	rv = lm80_read_value(client, LM80_REG_FANDIV);
-	if (rv < 0)
+	if (rv < 0) {
+		mutex_unlock(&data->update_lock);
 		return rv;
+	}
 	reg = (rv & ~(3 << (2 * (nr + 1))))
 	    | (data->fan_div[nr] << (2 * (nr + 1)));
 	lm80_write_value(client, LM80_REG_FANDIV, reg);
-- 
2.19.1



