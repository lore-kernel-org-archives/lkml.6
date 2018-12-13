Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 385A1C67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:29:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E32F020873
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544675373;
	bh=DBN5kwkL/AY1jaA8doZZN+E0JR4Vt2HIaEBuJZ7Wmls=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=F0YuA60e7Vfbxf8eKNy9wny7T1MgXAczUdjvPf2HxM9+tg97x+F90BD8lTrYzaIFV
	 +UtGBu4FmXff8vFTv+CLPgP29/QG0tKngknHyTKcjiCP2LAnXgraVi/gXOaBFUQk2n
	 a4Jw4aT+T+QhF5gCNolk+ES0HdCoTNoEzdgR8cFk=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E32F020873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727730AbeLME3b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 23:29:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:42490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727692AbeLME32 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 23:29:28 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 31C2F20879;
        Thu, 13 Dec 2018 04:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544675367;
        bh=DBN5kwkL/AY1jaA8doZZN+E0JR4Vt2HIaEBuJZ7Wmls=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aofh86u3mCQs3Jsv98WAaYBkwP6W0gAE8aR/rAvzvBJbxUsHbdV87LPUnatEm6Szo
         PHp/n1IpzLJ67+gkgQ1KrrCrVRUm8XeSqlqYweaNcsCWXCKXLE0zOZ4ISOrcnzQ2SZ
         EsWggXDj+GdtI0dDgyIkfPm6a0ZVE4uUPh78UiyY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yangtao Li <tiny.windzz@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, sparclinux@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 30/73] drivers/tty: add missing of_node_put()
Date:   Wed, 12 Dec 2018 23:27:55 -0500
Message-Id: <20181213042838.75160-30-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181213042838.75160-1-sashal@kernel.org>
References: <20181213042838.75160-1-sashal@kernel.org>
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
index 70a4ea4eaa6e..990376576970 100644
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

