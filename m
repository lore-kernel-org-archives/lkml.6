Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05320C282D0
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:10:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEB4A2147A
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548763840;
	bh=62oZfSNWXUYboU9YAexESmBSsLLLsbYlMwS6AVTqW5Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rhNmzPgIS4YqmriVJH++u7QRX+rDnPuk818uqXFB0yzdIstlViBzqGx+YCrkojMIh
	 E4gS83TvFjgNEyQU719zEa9Ok69nF56VvqM/vuOS8KerVJ5zEe6gbk2o9d5cvjjtn4
	 qWH1AWzqepohUR5W2GK1r3Zzio7y7jrum4wIEmwQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728785AbfA2LhR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:37:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:53890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728764AbfA2LhO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:37:14 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5298020844;
        Tue, 29 Jan 2019 11:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548761833;
        bh=62oZfSNWXUYboU9YAexESmBSsLLLsbYlMwS6AVTqW5Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=COGDMds0GPhUgXbanfiCCftWQAzugGwaibeTW1uIAfGzJ6rZAyvVKEgdCA36EXGO+
         g7D4ERDlffHRhp55d5PWCx/YWfUsDwmudM+ynGrLkhbFsHB6fvA2GcNeXrEtLVFKup
         X99Ej7bD2vex6IZr6a38EkAvozgyiqHaB6tDUcKU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Petr Machata <petrm@mellanox.com>,
        Olivier Matz <olivier.matz@6wind.com>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.20 017/117] ip6_gre: fix tunnel list corruption for x-netns
Date:   Tue, 29 Jan 2019 12:34:28 +0100
Message-Id: <20190129113208.493884725@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129113207.477505932@linuxfoundation.org>
References: <20190129113207.477505932@linuxfoundation.org>
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

From: Olivier Matz <olivier.matz@6wind.com>

[ Upstream commit ab5098fa25b91cb6fe0a0676f17abb64f2bbf024 ]

In changelink ops, the ip6gre_net pointer is retrieved from
dev_net(dev), which is wrong in case of x-netns. Thus, the tunnel is not
unlinked from its current list and is relinked into another net
namespace. This corrupts the tunnel lists and can later trigger a kernel
oops.

Fix this by retrieving the netns from device private area.

Fixes: c8632fc30bb0 ("net: ip6_gre: Split up ip6gre_changelink()")
Cc: Petr Machata <petrm@mellanox.com>
Signed-off-by: Olivier Matz <olivier.matz@6wind.com>
Acked-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/ip6_gre.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -2029,9 +2029,9 @@ static int ip6gre_changelink(struct net_
 			     struct nlattr *data[],
 			     struct netlink_ext_ack *extack)
 {
-	struct ip6gre_net *ign = net_generic(dev_net(dev), ip6gre_net_id);
+	struct ip6_tnl *t = netdev_priv(dev);
+	struct ip6gre_net *ign = net_generic(t->net, ip6gre_net_id);
 	struct __ip6_tnl_parm p;
-	struct ip6_tnl *t;
 
 	t = ip6gre_changelink_common(dev, tb, data, &p, extack);
 	if (IS_ERR(t))


