Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 291EFC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:50:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1FBF21726
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548359440;
	bh=gg3lyrrCpCuScEL5travU2z4fEzbnHaE77PTkjD2zN8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WVWQx+fIWQqvFciwcKT3+3ZCMp3t3nE8xgQf3nYszGwAbhtk7p1DrO0YQ87W6tvQ+
	 ka0uWGWxxSLfls3n8ExJkzxRSuPJydE0lZhYLVXWuAN+w+z+sxHBjT/8dmB/xZ0pGx
	 kK97TQiGv0DydPiYM1PsNr58L1PjxHk2PUCit7tI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733253AbfAXTkW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:40:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:40478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733237AbfAXTkT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:40:19 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4BC08218D9;
        Thu, 24 Jan 2019 19:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548358818;
        bh=gg3lyrrCpCuScEL5travU2z4fEzbnHaE77PTkjD2zN8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mY6Nbpkkn8pZ802wO6EFg8ppOOwGAWWEGoNy+tZE6Itjk33WyjNKGJfi5D8c913Gi
         ckLjPE96zu3rTlVhKtIAZIR8DBENKVVGMcI/bnXvaL8PRlAhstF94ydoSVhSlP1bY8
         kIRaXUObTJQL/0gmdIXnGJWpZdDLfj8rPrkdmj4A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniele Palmas <dnlplm@gmail.com>,
        =?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.20 006/127] qmi_wwan: add MTU default to qmap network interface
Date:   Thu, 24 Jan 2019 20:19:12 +0100
Message-Id: <20190124190212.337141736@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124190211.984305387@linuxfoundation.org>
References: <20190124190211.984305387@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniele Palmas <dnlplm@gmail.com>

[ Upstream commit f87118d5760f00af7228033fbe783c7f380d2866 ]

This patch adds MTU default value to qmap network interface in
order to avoid "RTNETLINK answers: No buffer space available"
error when setting an ipv6 address.

Signed-off-by: Daniele Palmas <dnlplm@gmail.com>
Acked-by: Bjørn Mork <bjorn@mork.no>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/usb/qmi_wwan.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/net/usb/qmi_wwan.c
+++ b/drivers/net/usb/qmi_wwan.c
@@ -123,6 +123,7 @@ static void qmimux_setup(struct net_devi
 	dev->addr_len        = 0;
 	dev->flags           = IFF_POINTOPOINT | IFF_NOARP | IFF_MULTICAST;
 	dev->netdev_ops      = &qmimux_netdev_ops;
+	dev->mtu             = 1500;
 	dev->needs_free_netdev = true;
 }
 


