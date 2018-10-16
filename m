Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD542C5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:18:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7D472098A
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:18:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qnVzYbJE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7D472098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730178AbeJQBKJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:10:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:55006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727562AbeJQBKI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:10:08 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 035D42098A;
        Tue, 16 Oct 2018 17:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539710324;
        bh=fBWv3/51dqyAAWR/Cr1mDW0Tov6IigrcoRpYtEmgsJk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qnVzYbJEtuzlEq83r+LmR/22wJvHAlhUsUR4YdGYCMk4Xzu7M3VIQR39oUDy6cpEo
         ir5FmT9EAoZj0KE8UOBJgLfxwGBfmFmTptQNPqwZAVoTErpU/cSApOCLuHsEVpPa7V
         k1SLeFBV6GZOQzlWgFRc+nEwLV4HQpTKlD4UYhhU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        =?UTF-8?q?Maciej=20=C5=BBenczykowski?= <maze@google.com>
Subject: [PATCH 4.14 036/109] net-ethtool: ETHTOOL_GUFO did not and should not require CAP_NET_ADMIN
Date:   Tue, 16 Oct 2018 19:05:04 +0200
Message-Id: <20181016170526.977255132@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016170524.530541524@linuxfoundation.org>
References: <20181016170524.530541524@linuxfoundation.org>
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

From: "Maciej Żenczykowski" <maze@google.com>

[ Upstream commit 474ff2600889e16280dbc6ada8bfecb216169a70 ]

So it should not fail with EPERM even though it is no longer implemented...

This is a fix for:
  (userns)$ egrep ^Cap /proc/self/status
  CapInh: 0000003fffffffff
  CapPrm: 0000003fffffffff
  CapEff: 0000003fffffffff
  CapBnd: 0000003fffffffff
  CapAmb: 0000003fffffffff

  (userns)$ tcpdump -i usb_rndis0
  tcpdump: WARNING: usb_rndis0: SIOCETHTOOL(ETHTOOL_GUFO) ioctl failed: Operation not permitted
  Warning: Kernel filter failed: Bad file descriptor
  tcpdump: can't remove kernel filter: Bad file descriptor

With this change it returns EOPNOTSUPP instead of EPERM.

See also https://github.com/the-tcpdump-group/libpcap/issues/689

Fixes: 08a00fea6de2 "net: Remove references to NETIF_F_UFO from ethtool."
Cc: David S. Miller <davem@davemloft.net>
Signed-off-by: Maciej Żenczykowski <maze@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/core/ethtool.c |    1 +
 1 file changed, 1 insertion(+)

--- a/net/core/ethtool.c
+++ b/net/core/ethtool.c
@@ -2572,6 +2572,7 @@ int dev_ethtool(struct net *net, struct
 	case ETHTOOL_GPHYSTATS:
 	case ETHTOOL_GTSO:
 	case ETHTOOL_GPERMADDR:
+	case ETHTOOL_GUFO:
 	case ETHTOOL_GGSO:
 	case ETHTOOL_GGRO:
 	case ETHTOOL_GFLAGS:


