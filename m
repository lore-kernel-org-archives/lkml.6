Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA82EC67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:34:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65ED620882
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544675650;
	bh=Ls2JXXw6vXO0CQ+FLFtHrd1j8F37283t2ENSVbBvfeM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aP8iOTBTrMUvnMd2vdpyZWeBoWERLO8Wh/gQ/mq1nReoe5gIcHtS5VGvjhv5/0Ls+
	 Ddhg4n6bUOThk/KvuCE5T+gIfR/mAMYv0gR3rRkLAW1c7elMEp+K+L7Cdjw38MFUe/
	 6AnA0vwjAH5SJcPYZe2iHCqmaUjzhH/tveaeTLdA=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65ED620882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729506AbeLMEeJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 23:34:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:47228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728989AbeLMEeB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 23:34:01 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9BC1D20873;
        Thu, 13 Dec 2018 04:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544675640;
        bh=Ls2JXXw6vXO0CQ+FLFtHrd1j8F37283t2ENSVbBvfeM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uXslMQHuWgVQstz/fcct/c8S6kHctyeEP46u6vPxZ8zQKc3fyysiCCWETSNVaxsa9
         AS6vwJUDNHk1ASlBtTpx1Srz+ZxlNmFGaq+F59o9SRJ4VRsSSWYjy/vvvsQqKTEOAN
         8a53ygKcvE9s7v/lUrV2gPs+LU82MXmG8tG2aIwQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yangtao Li <tiny.windzz@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, sparclinux@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: [PATCH AUTOSEL 3.18 09/16] drivers/tty: add missing of_node_put()
Date:   Wed, 12 Dec 2018 23:33:36 -0500
Message-Id: <20181213043343.76896-9-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181213043343.76896-1-sashal@kernel.org>
References: <20181213043343.76896-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yangtao Li <tiny.windzz@gmail.com>

[ Upstream commit dac097c4546e4c5b16dd303a1e97c1d319c8ab3e ]

of_find_node_by_path() acquires a reference to the node
returned by it and that reference needs to be dropped by its caller.
This place is not doing this, so fix it.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/suncore.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/suncore.c b/drivers/tty/serial/suncore.c
index 6e4ac8db2d79..2b06c1603f23 100644
--- a/drivers/tty/serial/suncore.c
+++ b/drivers/tty/serial/suncore.c
@@ -112,6 +112,7 @@ void sunserial_console_termios(struct console *con, struct device_node *uart_dp)
 		mode = of_get_property(dp, mode_prop, NULL);
 		if (!mode)
 			mode = "9600,8,n,1,-";
+		of_node_put(dp);
 	}
 
 	cflag = CREAD | HUPCL | CLOCAL;
-- 
2.19.1

