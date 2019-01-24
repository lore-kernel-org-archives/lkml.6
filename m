Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31BD8C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:58:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E569521726
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548359895;
	bh=2Kw5Ddi1DMMqZHNBbKlSGstsm3wh+I4cOLOwTri0zzM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gvdMGTsvhz5u38JCZ76QoKRZ9EHKG6oFGII2GaHBSQ4gDl/jo6+ff9REodjd/W+lR
	 GbbugoIoPl0CQrDG9+Dn7XGFJYHHZ0odTds3TpVQ3CtmoSNR9yuFf4K1WRAl537fmX
	 j4fucLWEJjviT74ZOdepPMTC8MkUf8cIBycBSkW4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731617AbfAXT6N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:58:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:34484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728220AbfAXTej (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:34:39 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47E9F21903;
        Thu, 24 Jan 2019 19:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548358478;
        bh=2Kw5Ddi1DMMqZHNBbKlSGstsm3wh+I4cOLOwTri0zzM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RA82/Eq4YoFI682NKuzOBn28OwpnSZh5sFj4QDDDL4jSR5F4V4RfKQqT7QuOWbxAs
         wuhZ1UhjAVbTtDoWgzbUbMERA6cM0mEvo10Iln5T1moPdJsx0pYt6Qs/VIdFRFZg2b
         hDgnXKIMPOjg98A1/aFIHhM7W0HNZgrmB2a5kO5g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniele Palmas <dnlplm@gmail.com>,
        =?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 006/106] qmi_wwan: add MTU default to qmap network interface
Date:   Thu, 24 Jan 2019 20:19:23 +0100
Message-Id: <20190124190206.783297789@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124190206.342411005@linuxfoundation.org>
References: <20190124190206.342411005@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
 


