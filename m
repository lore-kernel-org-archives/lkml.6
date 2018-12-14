Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD2CCC67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:26:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82E0720892
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544790397;
	bh=aMFWSSLO1VOPky8BZ6yJXorr3YMr5lmajy4XbppBLX8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=h+UM7FE7kg/RBprnp7e7ESUS4UvGGNCy6RUxdY8qCtArJKfm6p6sc4PcF6jd3LK6H
	 Ew1sZpKmlg0i6/F1yGNzGU0ALM8XZG5KPvF5cKwS51yu62SCiF83ZizCLv8/Wd+R6N
	 GvarF/wb+Lz7mrt8pFA+fugEBw+bJzl5nF+LQj2A=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82E0720892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731763AbeLNM0g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:26:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:58760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731839AbeLNMLv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:11:51 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 158622133F;
        Fri, 14 Dec 2018 12:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789510;
        bh=aMFWSSLO1VOPky8BZ6yJXorr3YMr5lmajy4XbppBLX8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vnp89FmeIDKdsAEUXOri4C+C6UJJXskI3RRX5s87EKBEkR5yOQfEQ8se91TuTuVZK
         HisSAuU0Xgqrju5vILIF10YPzpneOY7HJeZiXUPvBzNfG2Raf7CervJ9xAWw9CoNzZ
         P2RsZf1u0puNrH7mCPRxcUVCh036t1QCPytm/+H8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 09/51] tun: forbid iface creation with rtnl ops
Date:   Fri, 14 Dec 2018 13:00:11 +0100
Message-Id: <20181214115714.132525314@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115713.244259772@linuxfoundation.org>
References: <20181214115713.244259772@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nicolas Dichtel <nicolas.dichtel@6wind.com>

[ Upstream commit 35b827b6d06199841a83839e8bb69c0cd13a28be ]

It's not supported right now (the goal of the initial patch was to support
'ip link del' only).

Before the patch:
$ ip link add foo type tun
[  239.632660] BUG: unable to handle kernel NULL pointer dereference at 0000000000000000
[snip]
[  239.636410] RIP: 0010:register_netdevice+0x8e/0x3a0

This panic occurs because dev->netdev_ops is not set by tun_setup(). But to
have something usable, it will require more than just setting
netdev_ops.

Fixes: f019a7a594d9 ("tun: Implement ip link del tunXXX")
CC: Eric W. Biederman <ebiederm@xmission.com>
Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/tun.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1570,9 +1570,9 @@ static void tun_setup(struct net_device
  */
 static int tun_validate(struct nlattr *tb[], struct nlattr *data[])
 {
-	if (!data)
-		return 0;
-	return -EINVAL;
+	/* NL_SET_ERR_MSG(extack,
+		       "tun/tap creation via rtnetlink is not supported."); */
+	return -EOPNOTSUPP;
 }
 
 static struct rtnl_link_ops tun_link_ops __read_mostly = {


