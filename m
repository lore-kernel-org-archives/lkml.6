Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0A18C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 11:02:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B113C2073D
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 11:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549278157;
	bh=ubMXjxAZbvjDCR0NAFAHeWXnllVgV1N1a8Wuj6w77dE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0Wnz7BV0LHPuSIFkUns8+P0wrhq0tvTLLMEhx0Xu92q/bb/bEmNShxmFwDhmpDXjv
	 9tzykyBzMXh7tHzz8bA+KRl1axpUbCBOpGg3h+mLc6U3lLdjWXxQt1OHxrsoFIKp/w
	 8QWor/pbN2MWh1lICyi+i6NoAX85uiO/B1dyxPOg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731577AbfBDKrL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 05:47:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:45356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731545AbfBDKrH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:47:07 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 461AA2070C;
        Mon,  4 Feb 2019 10:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549277226;
        bh=ubMXjxAZbvjDCR0NAFAHeWXnllVgV1N1a8Wuj6w77dE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i7W0bDlTGEfkiinJPLisjKCa5H69POJlZCy+2Yi6urvjjDK5km2WeEWycuNTKzhzI
         C4oiaial399cXmUILHPq+DoxzomKv9s/as0cPHNRj2GaqPmOFrYhh8fkHpQn9CUl7b
         Rqco708PlsPlLHEtopFOI7Cy23CXRIag9TkDuHbg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mathias Thore <mathias.thore@infinera.com>,
        "David S. Miller" <davem@davemloft.net>,
        David Gounaris <david.gounaris@infinera.com>
Subject: [PATCH 4.19 17/74] ucc_geth: Reset BQL queue when stopping device
Date:   Mon,  4 Feb 2019 11:36:30 +0100
Message-Id: <20190204103621.828149961@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204103619.714714157@linuxfoundation.org>
References: <20190204103619.714714157@linuxfoundation.org>
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

From: Mathias Thore <mathias.thore@infinera.com>

[ Upstream commit e15aa3b2b1388c399c1a2ce08550d2cc4f7e3e14 ]

After a timeout event caused by for example a broadcast storm, when
the MAC and PHY are reset, the BQL TX queue needs to be reset as
well. Otherwise, the device will exhibit severe performance issues
even after the storm has ended.

Co-authored-by: David Gounaris <david.gounaris@infinera.com>
Signed-off-by: Mathias Thore <mathias.thore@infinera.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/freescale/ucc_geth.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/net/ethernet/freescale/ucc_geth.c
+++ b/drivers/net/ethernet/freescale/ucc_geth.c
@@ -1888,6 +1888,8 @@ static void ucc_geth_free_tx(struct ucc_
 	u16 i, j;
 	u8 __iomem *bd;
 
+	netdev_reset_queue(ugeth->ndev);
+
 	ug_info = ugeth->ug_info;
 	uf_info = &ug_info->uf_info;
 


