Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3EF9C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:25:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 907D920C01
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551129930;
	bh=5YaYQj8lw1XVeFF9IDBy7QMt9lAbZ+r6mMs1bgQtI3k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=k96LjIWP6AHx9/CB5I7kMjUH+YA+0BtkIN/Qj4bfa1mb7LCscU0eKYJw0AGOSqfhL
	 41sHNw/euz8RrWUN/QGmt/7lFl6qzb+k8/HO8HhKtEKNQbYG56AtJ3UZfF4MrtvJiv
	 CeZIFMXDQylfqbG9il9HyB5Dt7To4IgsSqW0zA+w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731420AbfBYVZ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:25:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:59892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731411AbfBYVZZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:25:25 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E4FFC20C01;
        Mon, 25 Feb 2019 21:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551129925;
        bh=5YaYQj8lw1XVeFF9IDBy7QMt9lAbZ+r6mMs1bgQtI3k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S0iJOJm4+NpEeE90dnAuq/24vlu9fefTeEVvqKaizFdpdyzsoNUpyz2rm/lX6ue5H
         hF4RgoyLz7mbJUWyNCepHaBSVWNP6OYCkLKD/c2p81JJv1kQkYS0wiJwY5N5VAGlH9
         v8dZmspNwMBThQ6Qqze2XeiLevJKlcG90ZUy06OE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johannes Berg <johannes.berg@intel.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 112/152] net: socket: make bond ioctls go through compat_ifreq_ioctl()
Date:   Mon, 25 Feb 2019 22:11:44 +0100
Message-Id: <20190225195050.755038868@linuxfoundation.org>
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
@@ -3230,16 +3230,16 @@ static int compat_sock_ioctl_trans(struc
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
 


