Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EF55C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:37:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44B0B2176F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549276676;
	bh=p9ts7ugc69AyPCsCEyf2XXJieltkERD9Fgpyn7XjeW8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=psdqOmjbH80AS3c1yHBp/CqP4A96oU7M9PPBClO2zdLL2xRHfe9SSBRJT2xdR3vSm
	 1J2417XxlrwxS+rShV2YZEdDJIaG3M3A6oWX0HI1ttaGebeWrED0xURGtR277Jakvn
	 eR4pNpPfPaPsBqMmpadakFTn2T8mTUQwH0ysghhU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729032AbfBDKhy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 05:37:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:33260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728177AbfBDKhy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:37:54 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 041FB2070C;
        Mon,  4 Feb 2019 10:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549276673;
        bh=p9ts7ugc69AyPCsCEyf2XXJieltkERD9Fgpyn7XjeW8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dz924F/O5uoZykLo/nIF8YU6sifLftGm1r5iXHpjFFCBXfXG3gteTgZ/ZMv3xzJWb
         xjJAxI68cNyg2NOgIrvOwnAMpt33wIjZ7vSbAthMZFQm5r2aY9EzqyAaNRrySOhGBA
         p1hrC+DmXQatV5dWyxhgzmpSEmiH5tO/McxaMI+o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ross Lagerwall <ross.lagerwall@citrix.com>,
        Pravin B Shelar <pshelar@ovn.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 3.18 01/31] openvswitch: Avoid OOB read when parsing flow nlattrs
Date:   Mon,  4 Feb 2019 11:36:16 +0100
Message-Id: <20190204103558.323632266@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204103557.903263774@linuxfoundation.org>
References: <20190204103557.903263774@linuxfoundation.org>
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

From: Ross Lagerwall <ross.lagerwall@citrix.com>

[ Upstream commit 04a4af334b971814eedf4e4a413343ad3287d9a9 ]

For nested and variable attributes, the expected length of an attribute
is not known and marked by a negative number.  This results in an OOB
read when the expected length is later used to check if the attribute is
all zeros. Fix this by using the actual length of the attribute rather
than the expected length.

Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>
Acked-by: Pravin B Shelar <pshelar@ovn.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/openvswitch/flow_netlink.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/openvswitch/flow_netlink.c
+++ b/net/openvswitch/flow_netlink.c
@@ -314,7 +314,7 @@ static int __parse_flow_nlattrs(const st
 			return -EINVAL;
 		}
 
-		if (!nz || !is_all_zero(nla_data(nla), expected_len)) {
+		if (!nz || !is_all_zero(nla_data(nla), nla_len(nla))) {
 			attrs |= 1 << type;
 			a[type] = nla;
 		}


