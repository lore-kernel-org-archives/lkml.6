Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6969BC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:14:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 312E22085A
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:14:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="LC6PbFN7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 312E22085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732220AbeKAIMY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:12:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:37282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731038AbeKAIMX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:12:23 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0132920843;
        Wed, 31 Oct 2018 23:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541027531;
        bh=xx0jE5Zm6B3+nvjtOfyvXln0fo96kZA1qqYqqcsOAls=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LC6PbFN7Qswv9KWwc2nHhMSo4sRAYRfg1gm3j+SCdPaZ5qYkzZ7gP6Edd1HU2S2me
         pAHnuLPYf3Ek0P4CXXmS1/QhAZlv7QAu8fPNiS2FdIFKCT+tExzCIcU8ZUQyj+lSsN
         yN7ruhOLN9EZYbDYc0mO5dG3uCthf0lge9x6Vsks=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Serhey Popovych <serhe.popovych@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 3.18 04/22] tun: Consistently configure generic netdev params via rtnetlink
Date:   Wed, 31 Oct 2018 19:11:48 -0400
Message-Id: <20181031231206.29509-4-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181031231206.29509-1-sashal@kernel.org>
References: <20181031231206.29509-1-sashal@kernel.org>
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
index 3067f840210e..7448ebe2c383 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1423,6 +1423,8 @@ static void tun_setup(struct net_device *dev)
  */
 static int tun_validate(struct nlattr *tb[], struct nlattr *data[])
 {
+	if (!data)
+		return 0;
 	return -EINVAL;
 }
 
-- 
2.17.1

