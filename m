Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF270C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4C962084F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550759839;
	bh=TSslYbhB7qXT8P+vvktdTYgCJIQWavn+MCUxZNUZSKM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WGrHLwmtZignWIy0ZToJkzjjPylqEGO/K4zDNXZMtyrrwqTCwoURV/MhRPNcSj9tC
	 M0OXfJ6PkYJCshUHsX22DzuAIr+iRVInYNY8X2pcrmiwDAKRGPop2ofSx94Gm19P+A
	 pSgTIvwZ8y6k4e2MpRQWaSQ0MHAjvDOz3TksySD4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728349AbfBUOhS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 09:37:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:58374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727594AbfBUOhQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 09:37:16 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E697F2075C;
        Thu, 21 Feb 2019 14:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550759835;
        bh=TSslYbhB7qXT8P+vvktdTYgCJIQWavn+MCUxZNUZSKM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NxogYABAtUXrz/E0IlPSWHOl3d11DXzmGAqI5x2zr9v8kqxQtn7zaWe0HxVvCSuYK
         FrgAN8CpbEPTDTltRz2+vAchTrHAzAXBoQ4hIC5eIhqsIV2FqLkAfU7b4pJ3XjFRsT
         0pquTo6tmMcXEEyjJYX+drIMl57vY7AdPRpHjdJg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wei Yongjun <weiyongjun1@huawei.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 3.18 09/13] hwmon: (lm80) Fix missing unlock on error in set_fan_div()
Date:   Thu, 21 Feb 2019 15:35:40 +0100
Message-Id: <20190221125241.076737759@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190221125240.091472334@linuxfoundation.org>
References: <20190221125240.091472334@linuxfoundation.org>
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

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wei Yongjun <weiyongjun1@huawei.com>

commit 07bd14ccc3049f9c0147a91a4227a571f981601a upstream.

Add the missing unlock before return from function set_fan_div()
in the error handling case.

Fixes: c9c63915519b ("hwmon: (lm80) fix a missing check of the status of SMBus read")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/hwmon/lm80.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/hwmon/lm80.c
+++ b/drivers/hwmon/lm80.c
@@ -393,8 +393,10 @@ static ssize_t set_fan_div(struct device
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


