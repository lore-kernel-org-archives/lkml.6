Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB13EC65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:50:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7DE120837
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:50:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="HorLzLCe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7DE120837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730769AbeKCD6T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 23:58:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:54080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728280AbeKCD6S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 23:58:18 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 443552082D;
        Fri,  2 Nov 2018 18:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541184603;
        bh=Que25jxbaDSrZ9jNXlVNKusTgd97Doq+/1rkgDuvnTU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HorLzLCeeTSj03VHkuNTdujtcOYzwY3ASxaDc3eeAqvERlt2fVYHYHxtYihAY2b4S
         MR93bOD06eHwXLEobOrdHdguGZxtuiStArK7lpQ04BkhWCMmBOf+g34+aoZ6p3Mbhg
         fONMCcyyoS8bhIKX/lCujfbIrnYbs/cavDsQuHI0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wenwen Wang <wang6495@umn.edu>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 048/143] yam: fix a missing-check bug
Date:   Fri,  2 Nov 2018 19:33:53 +0100
Message-Id: <20181102182900.897198861@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181102182857.064326086@linuxfoundation.org>
References: <20181102182857.064326086@linuxfoundation.org>
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

[ Upstream commit 0781168e23a2fc8dceb989f11fc5b39b3ccacc35 ]

In yam_ioctl(), the concrete ioctl command is firstly copied from the
user-space buffer 'ifr->ifr_data' to 'ioctl_cmd' and checked through the
following switch statement. If the command is not as expected, an error
code EINVAL is returned. In the following execution the buffer
'ifr->ifr_data' is copied again in the cases of the switch statement to
specific data structures according to what kind of ioctl command is
requested. However, after the second copy, no re-check is enforced on the
newly-copied command. Given that the buffer 'ifr->ifr_data' is in the user
space, a malicious user can race to change the command between the two
copies. This way, the attacker can inject inconsistent data and cause
undefined behavior.

This patch adds a re-check in each case of the switch statement if there is
a second copy in that case, to re-check whether the command obtained in the
second copy is the same as the one in the first copy. If not, an error code
EINVAL will be returned.

Signed-off-by: Wenwen Wang <wang6495@umn.edu>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/hamradio/yam.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/hamradio/yam.c b/drivers/net/hamradio/yam.c
index 7a7c5224a336..16a6e1193912 100644
--- a/drivers/net/hamradio/yam.c
+++ b/drivers/net/hamradio/yam.c
@@ -980,6 +980,8 @@ static int yam_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
 				 sizeof(struct yamdrv_ioctl_mcs));
 		if (IS_ERR(ym))
 			return PTR_ERR(ym);
+		if (ym->cmd != SIOCYAMSMCS)
+			return -EINVAL;
 		if (ym->bitrate > YAM_MAXBITRATE) {
 			kfree(ym);
 			return -EINVAL;
@@ -995,6 +997,8 @@ static int yam_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
 		if (copy_from_user(&yi, ifr->ifr_data, sizeof(struct yamdrv_ioctl_cfg)))
 			 return -EFAULT;
 
+		if (yi.cmd != SIOCYAMSCFG)
+			return -EINVAL;
 		if ((yi.cfg.mask & YAM_IOBASE) && netif_running(dev))
 			return -EINVAL;		/* Cannot change this parameter when up */
 		if ((yi.cfg.mask & YAM_IRQ) && netif_running(dev))
-- 
2.17.1



