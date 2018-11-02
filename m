Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1E5BC65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:41:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BCC72084A
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:41:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Byc1mc2u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BCC72084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729516AbeKCDtU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 23:49:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:43884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728441AbeKCDtT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 23:49:19 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 99B8E2082E;
        Fri,  2 Nov 2018 18:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541184067;
        bh=NHsJWOeWxfK8K9+maimBZ+1LWZomPaco6LtWQp5TaHw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Byc1mc2ub6e6q532cHi5PaE1vcyO2BPxhz4Png7tx0gRKAgxX51riLwhD2Lbb0GEp
         HrNbE1BgSGITgV0cE1Ai1VoUjw7VhcfKDsKrNEcQIqBIxpryMtWnIPopN/x9yuv1bW
         tgjtu9P7Qnv+P5tGvd47y+kBGfpRdeGZFQvjm1oI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wenwen Wang <wang6495@umn.edu>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.18 069/150] yam: fix a missing-check bug
Date:   Fri,  2 Nov 2018 19:33:51 +0100
Message-Id: <20181102182908.415893703@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181102182902.250560510@linuxfoundation.org>
References: <20181102182902.250560510@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

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
index 16ec7af6ab7b..ba9df430fca6 100644
--- a/drivers/net/hamradio/yam.c
+++ b/drivers/net/hamradio/yam.c
@@ -966,6 +966,8 @@ static int yam_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
 				 sizeof(struct yamdrv_ioctl_mcs));
 		if (IS_ERR(ym))
 			return PTR_ERR(ym);
+		if (ym->cmd != SIOCYAMSMCS)
+			return -EINVAL;
 		if (ym->bitrate > YAM_MAXBITRATE) {
 			kfree(ym);
 			return -EINVAL;
@@ -981,6 +983,8 @@ static int yam_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
 		if (copy_from_user(&yi, ifr->ifr_data, sizeof(struct yamdrv_ioctl_cfg)))
 			 return -EFAULT;
 
+		if (yi.cmd != SIOCYAMSCFG)
+			return -EINVAL;
 		if ((yi.cfg.mask & YAM_IOBASE) && netif_running(dev))
 			return -EINVAL;		/* Cannot change this parameter when up */
 		if ((yi.cfg.mask & YAM_IRQ) && netif_running(dev))
-- 
2.17.1



