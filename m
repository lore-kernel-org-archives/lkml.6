Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E049C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:03:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC48821508
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:03:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="2WuAwiuw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC48821508
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406231AbeKTD1j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:27:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:41698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404924AbeKTD1i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:27:38 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EDAF421508;
        Mon, 19 Nov 2018 17:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542647001;
        bh=a02NPdzmJ5zhBT3q6GU8RXjjUvDIUmhKsq27Mv7Q6ug=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2WuAwiuwW0UDoJO7002XT0Q3pXkdohOY2Wy6n+qUIjxO68TX0cBgKbkgs87BL8rRU
         DrJkZzrwFXHJ5Zr7r2mTyrfOkWsB2alVypr2tTHL++RIBzPPowO9tAanxlOFrOM/Xx
         2n9/j1/Jb6Y1KL46q4km3fvpg8nYZrQ360AlZ57s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Serhey Popovych <serhe.popovych@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 13/90] tun: Consistently configure generic netdev params via rtnetlink
Date:   Mon, 19 Nov 2018 17:28:55 +0100
Message-Id: <20181119162623.000717679@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162620.585061184@linuxfoundation.org>
References: <20181119162620.585061184@linuxfoundation.org>
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
@@ -1423,6 +1423,8 @@ static void tun_setup(struct net_device
  */
 static int tun_validate(struct nlattr *tb[], struct nlattr *data[])
 {
+	if (!data)
+		return 0;
 	return -EINVAL;
 }
 


