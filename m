Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40A70ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:54:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA26620821
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:54:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="J3ir5gD/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA26620821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728048AbeKAIys (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:54:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:52726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726532AbeKAIGE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:06:04 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D64A20866;
        Wed, 31 Oct 2018 23:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541027153;
        bh=rNjdU8QKxdta560gh0jiMdLoKJq5s/LlfVnklcD99xk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J3ir5gD/+sbxenb9joOnYlBxpHATNNLBWRlm0Ut1/UF6BZkU6Hn4j5gDBYacODGcp
         E/jiMT377cmDQ8XbLoxXurbzIgZbEiVf/oyPB+pTKBee6ruteQhwTg+kC7LITvlMyB
         SjyzqRe0Lpn04lbBY5wKcuhnQ4N7UUnQyWvZ34T4=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Serhey Popovych <serhe.popovych@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 011/146] tun: Consistently configure generic netdev params via rtnetlink
Date:   Wed, 31 Oct 2018 19:03:26 -0400
Message-Id: <20181031230541.28822-11-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181031230541.28822-1-sashal@kernel.org>
References: <20181031230541.28822-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Serhey Popovych <serhe.popovych@gmail.com>

[ Upstream commit df52eab23d703142c766ac00bdb8db19d71238d0 ]

Configuring generic network device parameters on tun will fail in
presence of IFLA_INFO_KIND attribute in IFLA_LINKINFO nested attribute
since tun_validate() always return failure.

This can be visualized with following ip-link(8) command sequences:

  # ip link set dev tun0 group 100
  # ip link set dev tun0 group 100 type tun
  RTNETLINK answers: Invalid argument

with contrast to dummy and veth drivers:

  # ip link set dev dummy0 group 100
  # ip link set dev dummy0 type dummy

  # ip link set dev veth0 group 100
  # ip link set dev veth0 group 100 type veth

Fix by returning zero in tun_validate() when @data is NULL that is
always in case since rtnl_link_ops->maxtype is zero in tun driver.

Fixes: f019a7a594d9 ("tun: Implement ip link del tunXXX")
Signed-off-by: Serhey Popovych <serhe.popovych@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/tun.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 50e9cc19023a..c52207beef88 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -2264,6 +2264,8 @@ static void tun_setup(struct net_device *dev)
 static int tun_validate(struct nlattr *tb[], struct nlattr *data[],
 			struct netlink_ext_ack *extack)
 {
+	if (!data)
+		return 0;
 	return -EINVAL;
 }
 
-- 
2.17.1

