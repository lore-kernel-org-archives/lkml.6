Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C3A0C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:51:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F2ED2081B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549896684;
	bh=nfsqiN///uXWFHEd0LcaVlq80QMVk2fdVZ+2iJ3TE7Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BsGxKmaPiJfcf7fO9XEgDonuT9Esmya497RvngXssKNH55KKT82zT3PFvIHdKFveu
	 DMMEJZ7qiLW7qjhKgiB8Zito4Nz+xcsnq91mWAoFqYoYmdGE10+2SIoB/LuSQ2fVCG
	 obAA9kVGJB2YY6mEkNXPdNEAwnQxtniii+Aa+6qU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388253AbfBKOvW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:51:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:37254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388236AbfBKOvQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:51:16 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0DA4D20844;
        Mon, 11 Feb 2019 14:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549896675;
        bh=nfsqiN///uXWFHEd0LcaVlq80QMVk2fdVZ+2iJ3TE7Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=loCV99q8FeY/Ej3SnniAobPyhr0vG+1G+L8nE0PbKygwg/AfmFkTY7IOImaoFaxD9
         wk14ygBT/oKfF6++YScKGDETQ4Zy+LmYx7XchgQ+l+MlNTo26nxIEJhqnIAHQGHetx
         OoObfK3hdEr46IrA/gk2YY9ssYgMWIuSFE7StGYI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 264/313] net: dsa: Fix NULL checking in dsa_slave_set_eee()
Date:   Mon, 11 Feb 2019 15:19:04 +0100
Message-Id: <20190211141910.952022177@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141852.749630980@linuxfoundation.org>
References: <20190211141852.749630980@linuxfoundation.org>
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

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit 00670cb8a73b10b10d3c40f045c15411715e4465 ]

This function can't succeed if dp->pl is NULL.  It will Oops inside the
call to return phylink_ethtool_get_eee(dp->pl, e);

Fixes: 1be52e97ed3e ("dsa: slave: eee: Allow ports to use phylink")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Reviewed-by: Vivien Didelot <vivien.didelot@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/dsa/slave.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/net/dsa/slave.c
+++ b/net/dsa/slave.c
@@ -639,7 +639,7 @@ static int dsa_slave_set_eee(struct net_
 	int ret;
 
 	/* Port's PHY and MAC both need to be EEE capable */
-	if (!dev->phydev && !dp->pl)
+	if (!dev->phydev || !dp->pl)
 		return -ENODEV;
 
 	if (!ds->ops->set_mac_eee)
@@ -659,7 +659,7 @@ static int dsa_slave_get_eee(struct net_
 	int ret;
 
 	/* Port's PHY and MAC both need to be EEE capable */
-	if (!dev->phydev && !dp->pl)
+	if (!dev->phydev || !dp->pl)
 		return -ENODEV;
 
 	if (!ds->ops->get_mac_eee)


