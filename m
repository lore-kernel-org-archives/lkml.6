Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51468C282CB
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:38:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23224214DA
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549276702;
	bh=3y63w//THIFl97v2xdUX7EDR6XWGcAkSYzcIvZ61no8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZR7Cbf4de2O808Z2mWkHU4zMt2LoVtYvu3Yy5s4mLjeLoyGYU8ukpcGIvCyN3l/if
	 qLRdghSlMrQtdWyNuudq5IjrcoYOKn+nJgkqQoZAKKZ0to4iEEJ3dICsEHOeI+D/Fd
	 IVdOcdmq9jRIIbqTqVgvBZ6kBLnSgR/PEQJIa50I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729279AbfBDKiU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 05:38:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:34702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729220AbfBDKiS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:38:18 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1FE3D2176F;
        Mon,  4 Feb 2019 10:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549276697;
        bh=3y63w//THIFl97v2xdUX7EDR6XWGcAkSYzcIvZ61no8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VaSUYXzg2N8OqQGI1Gm4tDVHa+pK31NsUMgD7N/LBHE/c/ej6VGX9MOeurMeC7xbf
         OgIg5B7tc+U89Xbx4mr5V0aNskrJqqDT+zyPFXisc/ebrbp0+HWus2OQQDzYaKTRPD
         BpM9eZNyAg1dyq7rWmIaDkwlxevFhWdcKhLdX1Gk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Ahern <dsahern@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 3.18 17/31] ipv6: Consider sk_bound_dev_if when binding a socket to an address
Date:   Mon,  4 Feb 2019 11:36:32 +0100
Message-Id: <20190204103601.385995802@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204103557.903263774@linuxfoundation.org>
References: <20190204103557.903263774@linuxfoundation.org>
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

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Ahern <dsahern@gmail.com>

[ Upstream commit c5ee066333ebc322a24a00a743ed941a0c68617e ]

IPv6 does not consider if the socket is bound to a device when binding
to an address. The result is that a socket can be bound to eth0 and then
bound to the address of eth1. If the device is a VRF, the result is that
a socket can only be bound to an address in the default VRF.

Resolve by considering the device if sk_bound_dev_if is set.

This problem exists from the beginning of git history.

Signed-off-by: David Ahern <dsahern@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/af_inet6.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/net/ipv6/af_inet6.c
+++ b/net/ipv6/af_inet6.c
@@ -333,6 +333,9 @@ int inet6_bind(struct socket *sock, stru
 					err = -EINVAL;
 					goto out_unlock;
 				}
+			}
+
+			if (sk->sk_bound_dev_if) {
 				dev = dev_get_by_index_rcu(net, sk->sk_bound_dev_if);
 				if (!dev) {
 					err = -ENODEV;


