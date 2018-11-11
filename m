Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5343C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:07:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A0EF20817
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:07:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="efyEh5zJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A0EF20817
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390366AbeKLI5s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:57:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:51248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390286AbeKLIWI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:22:08 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F178A223CB;
        Sun, 11 Nov 2018 22:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975532;
        bh=IK15JnU6i9Kx3RfC6shLuA2c/YVyz9q5ZENcgdaCz9w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=efyEh5zJiCho6iS/z9EIuZh3AzSJKhsxiksFzsanC+E4/H+OuTe3aN6vc2r0XyTI0
         ltFP6oG9lklAA7aHe546RIT2ISFVe93d7j3euRF65EYF5m/dLCiRxgCv/SW8DrWa0r
         4dpOvBH3fMlOOpJYgTx0PAECBaLrRr/eNszTLcg4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ryan C Goodfellow <rgoodfel@isi.edu>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Greg Weeks <greg.weeks@netronome.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 042/222] nfp: devlink port split support for 1x100G CXP NIC
Date:   Sun, 11 Nov 2018 14:22:19 -0800
Message-Id: <20181111221651.923012600@linuxfoundation.org>
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

From: Ryan C Goodfellow <rgoodfel@isi.edu>

[ Upstream commit 5948185b97fa1f83d7855e638a72982a1073ebf5 ]

This commit makes it possible to use devlink to split the 100G CXP
Netronome into two 40G interfaces. Currently when you ask for 2
interfaces, the math in src/nfp_devlink.c:nfp_devlink_port_split
calculates that you want 5 lanes per port because for some reason
eth_port.port_lanes=10 (shouldn't this be 12 for CXP?). What we really
want when asking for 2 breakout interfaces is 4 lanes per port. This
commit makes that happen by calculating based on 8 lanes if 10 are
present.

Signed-off-by: Ryan C Goodfellow <rgoodfel@isi.edu>
Reviewed-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Reviewed-by: Greg Weeks <greg.weeks@netronome.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/netronome/nfp/nfp_devlink.c |   17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

--- a/drivers/net/ethernet/netronome/nfp/nfp_devlink.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_devlink.c
@@ -96,6 +96,7 @@ nfp_devlink_port_split(struct devlink *d
 {
 	struct nfp_pf *pf = devlink_priv(devlink);
 	struct nfp_eth_table_port eth_port;
+	unsigned int lanes;
 	int ret;
 
 	if (count < 2)
@@ -114,8 +115,12 @@ nfp_devlink_port_split(struct devlink *d
 		goto out;
 	}
 
-	ret = nfp_devlink_set_lanes(pf, eth_port.index,
-				    eth_port.port_lanes / count);
+	/* Special case the 100G CXP -> 2x40G split */
+	lanes = eth_port.port_lanes / count;
+	if (eth_port.lanes == 10 && count == 2)
+		lanes = 8 / count;
+
+	ret = nfp_devlink_set_lanes(pf, eth_port.index, lanes);
 out:
 	mutex_unlock(&pf->lock);
 
@@ -127,6 +132,7 @@ nfp_devlink_port_unsplit(struct devlink
 {
 	struct nfp_pf *pf = devlink_priv(devlink);
 	struct nfp_eth_table_port eth_port;
+	unsigned int lanes;
 	int ret;
 
 	mutex_lock(&pf->lock);
@@ -142,7 +148,12 @@ nfp_devlink_port_unsplit(struct devlink
 		goto out;
 	}
 
-	ret = nfp_devlink_set_lanes(pf, eth_port.index, eth_port.port_lanes);
+	/* Special case the 100G CXP -> 2x40G unsplit */
+	lanes = eth_port.port_lanes;
+	if (eth_port.port_lanes == 8)
+		lanes = 10;
+
+	ret = nfp_devlink_set_lanes(pf, eth_port.index, lanes);
 out:
 	mutex_unlock(&pf->lock);
 


