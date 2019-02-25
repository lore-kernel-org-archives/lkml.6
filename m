Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F3BDC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:34:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22D9B217F5
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551130497;
	bh=/KJdYk7z5dap/D3Fp04gH09BUyYpw8/v53Qr2TkLCX4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RtPDn/c1Trr6d7OIe8bfUJrFUuu13Y0vCTJAIyL8ca1pWgrpug62aEAWVq8LT7Xgp
	 iDZPx3O3B9P/efmXPkEle1p+GlBoG07jmL5/zKMnuGw4DK7ba8aIenOnlkFrPOo0J+
	 FKhLhVQGvx0YovOffVm5z/EyhFad05Gpzf50GYiQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732890AbfBYVez (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:34:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:41024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730958AbfBYVew (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:34:52 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7BA632186A;
        Mon, 25 Feb 2019 21:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551130492;
        bh=/KJdYk7z5dap/D3Fp04gH09BUyYpw8/v53Qr2TkLCX4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rCili3f8k2vXRm+kXDVWFXdAK4v3/fOlLajHIp7IMbhnSdtDjPy0RwT2VTHUd4NF7
         xVN5RMX+m76uC8bwgc5LeMYHDALPgD46+lIYNeFxqJMwhhBAgx6v9PlXBM/Z1pdrpb
         R/n7W6gDVhyV8Se9h6s2NBuskX/AEKcyjH94TpEo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johannes Berg <johannes.berg@intel.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.20 137/183] net: socket: make bond ioctls go through compat_ifreq_ioctl()
Date:   Mon, 25 Feb 2019 22:11:50 +0100
Message-Id: <20190225195118.017007207@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195054.748060397@linuxfoundation.org>
References: <20190225195054.748060397@linuxfoundation.org>
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

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit 98406133dd9cb9f195676eab540c270dceca879a ]

Same story as before, these use struct ifreq and thus need
to be read with the shorter version to not cause faults.

Cc: stable@vger.kernel.org
Fixes: f92d4fc95341 ("kill bond_ioctl()")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/socket.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/net/socket.c
+++ b/net/socket.c
@@ -3228,16 +3228,16 @@ static int compat_sock_ioctl_trans(struc
 	case SIOCGMIIPHY:
 	case SIOCGMIIREG:
 	case SIOCSMIIREG:
+	case SIOCBONDENSLAVE:
+	case SIOCBONDRELEASE:
+	case SIOCBONDSETHWADDR:
+	case SIOCBONDCHANGEACTIVE:
 		return compat_ifreq_ioctl(net, sock, cmd, argp);
 
 	case SIOCSARP:
 	case SIOCGARP:
 	case SIOCDARP:
 	case SIOCATMARK:
-	case SIOCBONDENSLAVE:
-	case SIOCBONDRELEASE:
-	case SIOCBONDSETHWADDR:
-	case SIOCBONDCHANGEACTIVE:
 		return sock_do_ioctl(net, sock, cmd, arg);
 	}
 


