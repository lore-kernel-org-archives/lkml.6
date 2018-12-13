Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 419EAC65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A5BF20849
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544676021;
	bh=Tdxf+gi/OLduCJFhzmv/kpLIbv39O8UmfQR1UR0qTA8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Jq+OiJ6+sjwvugqGzx454LbjFICvXkqu7EOiCNDnY0ZJw/LhnEFAaQWA1fbaowdF4
	 iB31d99iMflO5Dqdziq2Cw5fpEUwJE12KJ+zLrT5DVGoXmk6rEde67g2n8E8glw/AV
	 X2DQG5Mxm+COWrZsr/OeEhW5dGJdkMukBgZ3TTPA=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A5BF20849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729074AbeLMEkT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 23:40:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:45318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729059AbeLMEcY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 23:32:24 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C493F20879;
        Thu, 13 Dec 2018 04:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544675543;
        bh=Tdxf+gi/OLduCJFhzmv/kpLIbv39O8UmfQR1UR0qTA8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TOHyYsPF8VFW+JvqLmywAsepSTuPQ2B86f+2N4Ta14nrLXLzLy8a8B1NzMo/YG2uh
         MhDoLnLg48PIDJAfl/tI8otoz0TBKfwn+3sKyeZZLTQ7t7HI6LTa40mPIK4lXu5saX
         rDB+b+90nE9WX/Z0u7V1tPnpPfnbFTyxfC1VG+zs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yangtao Li <tiny.windzz@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, sparclinux@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 13/34] drivers/tty: add missing of_node_put()
Date:   Wed, 12 Dec 2018 23:31:39 -0500
Message-Id: <20181213043200.76295-13-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181213043200.76295-1-sashal@kernel.org>
References: <20181213043200.76295-1-sashal@kernel.org>
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
index 127472bd6a7c..209f314745ab 100644
--- a/drivers/tty/serial/suncore.c
+++ b/drivers/tty/serial/suncore.c
@@ -111,6 +111,7 @@ void sunserial_console_termios(struct console *con, struct device_node *uart_dp)
 		mode = of_get_property(dp, mode_prop, NULL);
 		if (!mode)
 			mode = "9600,8,n,1,-";
+		of_node_put(dp);
 	}
 
 	cflag = CREAD | HUPCL | CLOCAL;
-- 
2.19.1

