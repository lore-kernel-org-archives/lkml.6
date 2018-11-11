Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 440C2C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:07:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03B5321508
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:07:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YrfrhnyM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03B5321508
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390473AbeKLI5e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:57:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:51200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390295AbeKLIWJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:22:09 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 512442241B;
        Sun, 11 Nov 2018 22:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975532;
        bh=p1N51I+b2pwvSgs9l6nTdRzlDSbt7KKc5BxWcejCO6M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YrfrhnyMod8MW5pP9NPrv6CK+fkTbJ6pTDw17aDFe1ZEp33YJocdydf7g0h2YxpZx
         1Xnz4+yMVu8owE9hZr15oDmkbRS0w1x/jw91Qg8YP2dmMleEfE1xcv2+UAoBkNJ0q/
         39EYXgkjdGdP3dJDujySuLd+AA/OVRT5jHwGCIHQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Serhey Popovych <serhe.popovych@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 043/222] tun: Consistently configure generic netdev params via rtnetlink
Date:   Sun, 11 Nov 2018 14:22:20 -0800
Message-Id: <20181111221652.021910790@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221647.665769131@linuxfoundation.org>
References: <20181111221647.665769131@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1814,6 +1814,8 @@ static void tun_setup(struct net_device
 static int tun_validate(struct nlattr *tb[], struct nlattr *data[],
 			struct netlink_ext_ack *extack)
 {
+	if (!data)
+		return 0;
 	return -EINVAL;
 }
 


