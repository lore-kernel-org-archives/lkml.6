Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEDA7C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:56:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A751E21104
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:56:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gld2J1SX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A751E21104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404334AbeKTDUy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:20:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:60404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404073AbeKTDUx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:20:53 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8CE7E21104;
        Mon, 19 Nov 2018 16:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542646598;
        bh=xfk80TmjA8jFdIW+LRboMSxNOgz1gdpi3Jk3OL7ZpoY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Gld2J1SXRelzdsgTYiqUl5wixF/sQIv071uoGIJY93wUkHuNE5HT+a2me0ScoplGw
         G9pmehudPyjAGI4E2KLPD2SVLUY8tbNwVdF5Q8YqLafMEtrJtgAgIO8kFuZLMfjihC
         fbqJ07QYPo2AJkhD5YcKPU5VHmQK7V6vE/UP6I1I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Serhey Popovych <serhe.popovych@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 019/160] tun: Consistently configure generic netdev params via rtnetlink
Date:   Mon, 19 Nov 2018 17:27:38 +0100
Message-Id: <20181119162632.341723000@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162630.031306128@linuxfoundation.org>
References: <20181119162630.031306128@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/tun.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1475,6 +1475,8 @@ static void tun_setup(struct net_device
  */
 static int tun_validate(struct nlattr *tb[], struct nlattr *data[])
 {
+	if (!data)
+		return 0;
 	return -EINVAL;
 }
 


