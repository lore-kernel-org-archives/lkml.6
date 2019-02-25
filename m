Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD0C0C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:25:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FADC2084D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551129926;
	bh=mjCyoPR0JuqM3FPS5a7nKVBCiCDmHsgL0aw5yMDgNNc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BwI91i1eecWeogCedawpV/bVCmtnj+5RwC12nnARFBrQtydT33SQJs6rwG2aMQMl7
	 uYi1/NzQtJ9Hn+2SWSQ+c4rmPk/leFErxnBOZV9TFSayvy9ppe9GBIYFdfkGzDNByO
	 qMU8nVlCiKMognQBJASYj72LiVpuRG2YpBDnVqFo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731409AbfBYVZZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:25:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:59844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731374AbfBYVZX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:25:23 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1507F2084D;
        Mon, 25 Feb 2019 21:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551129922;
        bh=mjCyoPR0JuqM3FPS5a7nKVBCiCDmHsgL0aw5yMDgNNc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=baU1a/BitxmFal9yalVEcz1AKvfomapUHAvCPisS9R2CNjddP2JK7UWu9CvaV96GA
         p2ZgVpBIpuF1A6DI9N1rEExTCR/Gkt3EpRGmdEW/DVMWQBY0fyFo7UOyXCszo8vieS
         ruRityC31uhJ0pFvxCSa7JBW1QAdPi2MhPonQzCA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Robert OCallahan <robert@ocallahan.org>,
        Johannes Berg <johannes.berg@intel.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 111/152] net: socket: fix SIOCGIFNAME in compat
Date:   Mon, 25 Feb 2019 22:11:43 +0100
Message-Id: <20190225195050.671538075@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195043.645958524@linuxfoundation.org>
References: <20190225195043.645958524@linuxfoundation.org>
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

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit c6c9fee35dc27362b7bac34b2fc9f5b8ace2e22c ]

As reported by Robert O'Callahan in
https://bugzilla.kernel.org/show_bug.cgi?id=202273
reverting the previous changes in this area broke
the SIOCGIFNAME ioctl in compat again (I'd previously
fixed it after his previous report of breakage in
https://bugzilla.kernel.org/show_bug.cgi?id=199469).

This is obviously because I fixed SIOCGIFNAME more or
less by accident.

Fix it explicitly now by making it pass through the
restored compat translation code.

Cc: stable@vger.kernel.org
Fixes: 4cf808e7ac32 ("kill dev_ifname32()")
Reported-by: Robert O'Callahan <robert@ocallahan.org>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/socket.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/net/socket.c
+++ b/net/socket.c
@@ -3001,6 +3001,7 @@ static int compat_ifreq_ioctl(struct net
 		case SIOCGIFTXQLEN:
 		case SIOCGMIIPHY:
 		case SIOCGMIIREG:
+		case SIOCGIFNAME:
 			if (copy_in_user(uifr32, uifr, sizeof(*uifr32)))
 				err = -EFAULT;
 			break;
@@ -3224,6 +3225,7 @@ static int compat_sock_ioctl_trans(struc
 	case SIOCSIFTXQLEN:
 	case SIOCBRADDIF:
 	case SIOCBRDELIF:
+	case SIOCGIFNAME:
 	case SIOCSIFNAME:
 	case SIOCGMIIPHY:
 	case SIOCGMIIREG:
@@ -3238,7 +3240,6 @@ static int compat_sock_ioctl_trans(struc
 	case SIOCBONDRELEASE:
 	case SIOCBONDSETHWADDR:
 	case SIOCBONDCHANGEACTIVE:
-	case SIOCGIFNAME:
 		return sock_do_ioctl(net, sock, cmd, arg);
 	}
 


