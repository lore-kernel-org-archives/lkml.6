Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C34F5C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:55:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95D6A2084C
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:55:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xvKAa1+V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95D6A2084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731429AbeKCEDp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 00:03:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:59786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726051AbeKCEDo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 00:03:44 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 28A4320848;
        Fri,  2 Nov 2018 18:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541184928;
        bh=hMdFCy+pKBszEGEC/JqET1D6kSBLQpo6mxZsHDvj7oA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xvKAa1+VYPKYosPGkvUztgF9Q+tK/a308lJgHvCBBPd9V70zldJDAHk5C3eSVWr3l
         OS8Kct3ZAEhNG2bOZXSqgLntSJYbKbBeUQZwKrQnO3ft4CPQFkqiCkNfGZjW7OqGLv
         D0gku778z9b5nSKDlPXmcSLHd5tBk/8sZ9WZ4NU4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tobias Jungel <tobias.jungel@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 132/143] bonding: fix length of actor system
Date:   Fri,  2 Nov 2018 19:35:17 +0100
Message-Id: <20181102182908.336077213@linuxfoundation.org>
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

From: Tobias Jungel <tobias.jungel@gmail.com>

[ Upstream commit 414dd6fb9a1a1b59983aea7bf0f79f0085ecc5b8 ]

The attribute IFLA_BOND_AD_ACTOR_SYSTEM is sent to user space having the
length of sizeof(bond->params.ad_actor_system) which is 8 byte. This
patch aligns the length to ETH_ALEN to have the same MAC address exposed
as using sysfs.

Fixes: f87fda00b6ed2 ("bonding: prevent out of bound accesses")
Signed-off-by: Tobias Jungel <tobias.jungel@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/bonding/bond_netlink.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/drivers/net/bonding/bond_netlink.c
+++ b/drivers/net/bonding/bond_netlink.c
@@ -638,8 +638,7 @@ static int bond_fill_info(struct sk_buff
 				goto nla_put_failure;
 
 			if (nla_put(skb, IFLA_BOND_AD_ACTOR_SYSTEM,
-				    sizeof(bond->params.ad_actor_system),
-				    &bond->params.ad_actor_system))
+				    ETH_ALEN, &bond->params.ad_actor_system))
 				goto nla_put_failure;
 		}
 		if (!bond_3ad_get_active_agg_info(bond, &info)) {


