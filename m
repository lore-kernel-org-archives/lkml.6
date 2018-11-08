Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B754ECDE4C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:07:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE00320844
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:07:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="f2VmYvyu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE00320844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731330AbeKIHoe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:44:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:37464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732148AbeKIHob (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:44:31 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F513208A3;
        Thu,  8 Nov 2018 22:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714820;
        bh=Xskz666Csv3hjhOfkD+EO6tbIsE/iWz/pC8k38JK0hU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f2VmYvyuOM/MI1GXBzlFgZoPDPl/lTZBETTX0lDloIm7278HPw7+iySrD+7FN31GO
         TUlfd6n+JIaybdcSj28b711vHHF6w9pmOUpdYTq21yqdd3hZNHsTZFZkd9N4VqKZJl
         zsjkwP6ez0x+eIlkMMl9BdFxwPpMZ5weLU2eXrSU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tobias Jungel <tobias.jungel@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 148/171] bonding: fix length of actor system
Date:   Thu,  8 Nov 2018 13:51:58 -0800
Message-Id: <20181108215137.603086575@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215127.257643509@linuxfoundation.org>
References: <20181108215127.257643509@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -628,8 +628,7 @@ static int bond_fill_info(struct sk_buff
 				goto nla_put_failure;
 
 			if (nla_put(skb, IFLA_BOND_AD_ACTOR_SYSTEM,
-				    sizeof(bond->params.ad_actor_system),
-				    &bond->params.ad_actor_system))
+				    ETH_ALEN, &bond->params.ad_actor_system))
 				goto nla_put_failure;
 		}
 		if (!bond_3ad_get_active_agg_info(bond, &info)) {


