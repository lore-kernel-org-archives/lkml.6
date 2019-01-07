Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8164AC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:48:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 540F720859
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546865294;
	bh=R3NgR2RsC1ur+LGyA5k5oxJJ1SGkqvGz50SHywsjt6Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lNqa5xCCCwQvrBCHa1DORocXmXsZW513UYtlXQDGTzxxXSxULcW24ErNhBwVGzCEK
	 NXKaLkYW8ZEX6k2ZPtHHBp1FHNm87ReLYV+hJ9eLhPv114rX906oYkJLm4+rLSC+/F
	 OknueQwe22IRBr6FbAM8DXU9z+maEzD/toi/vv4w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729119AbfAGMsN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:48:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:38702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729114AbfAGMsK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:48:10 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D06120651;
        Mon,  7 Jan 2019 12:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546865289;
        bh=R3NgR2RsC1ur+LGyA5k5oxJJ1SGkqvGz50SHywsjt6Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0L/ixj7/ra4VSHB40ncTOnA1Nac++tAn9jTBsSFlKwYBT17UkdkNoIZzTEEIShsGp
         Mww/NX8z7jCA1l7dUs47IaT0ucA7CJEEtRMRYdxqN77y4qrEtLedJq2uRXWSg4qYwl
         yd0LZoitZRNOdrG/dyphaq5X7cmK1CRGgFI+ke5s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 045/170] net/ipv6: Fix a test against ipv6_find_idev() return value
Date:   Mon,  7 Jan 2019 13:31:12 +0100
Message-Id: <20190107104458.559461061@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107104452.953560660@linuxfoundation.org>
References: <20190107104452.953560660@linuxfoundation.org>
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

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit 178fe94405bffbd1acd83b6ff3b40211185ae9c9 ]

'ipv6_find_idev()' returns NULL on error, not an error pointer.
Update the test accordingly and return -ENOBUFS, as already done in
'addrconf_add_dev()', if NULL is returned.

Fixes: ("ipv6: allow userspace to add IFA_F_OPTIMISTIC addresses")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/addrconf.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -4711,8 +4711,8 @@ inet6_rtm_newaddr(struct sk_buff *skb, s
 			 IFA_F_MCAUTOJOIN | IFA_F_OPTIMISTIC;
 
 	idev = ipv6_find_idev(dev);
-	if (IS_ERR(idev))
-		return PTR_ERR(idev);
+	if (!idev)
+		return -ENOBUFS;
 
 	if (!ipv6_allow_optimistic_dad(net, idev))
 		cfg.ifa_flags &= ~IFA_F_OPTIMISTIC;


