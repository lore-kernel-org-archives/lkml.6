Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F1D5C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:32:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D1F3218E2
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548358347;
	bh=jyoSicfYa3tVGX+tJDASHo9e/e/BlPIc3IP22/4QdG4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=R2KyyjL/I6NxAUe2JBL+ncwnFNFrrnAMFT29zn3xFxb5ybcX2xaAyOm8pFmXdBzXs
	 ztjxdCOYCYvZFy0Si/EimH84h+kzP0ywyFUngcDX5Ec0tJvj1bFpcZPAkiJoKx6xy7
	 Dbd+MOpf10zusO/UoUO7+7n+uHKwuoRw4YXE9PFo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731841AbfAXTcZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:32:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:60284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731822AbfAXTcV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:32:21 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 80C63218D4;
        Thu, 24 Jan 2019 19:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548358341;
        bh=jyoSicfYa3tVGX+tJDASHo9e/e/BlPIc3IP22/4QdG4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xLRWf04jfStDicYo41im24vwz7it6zzmO5UN/qMHAotmCTvs/ZvfuomYQj8k9NlTM
         2M5fbxbvmVjIphUtiYycE56jnIoKpzwPJFNh4EPL/neEl253ENFWPzwZq0HiFrtTdC
         pAUfykT9L+y2p8xyRU3Pxg806L4s9jTA3s3L5pE8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniele Palmas <dnlplm@gmail.com>,
        =?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 05/63] qmi_wwan: add MTU default to qmap network interface
Date:   Thu, 24 Jan 2019 20:19:54 +0100
Message-Id: <20190124190155.701324297@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124190155.176570028@linuxfoundation.org>
References: <20190124190155.176570028@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

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
 


