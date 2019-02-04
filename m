Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41D4CC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:40:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12AE52087C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549276848;
	bh=4KgBf8j6E9GWlU+20QNfPNDWGNCNULfmYbn0A4Q4y2U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0lnYyvsv9hCnEx8jhw+jrutGTYPzovtM+ZquELyU12ckIO6sLf6X9kV7Xs8Gbffmp
	 FLElOI8ecX5M4aVML/Sj4y/wi6Ej37DwSzLv9BFHu4xtMIVq7EJbrMMemee5sEZ+vb
	 vMkDt/MFLb8bfc1ZPjGXTR3vNqBD/Hupd55fBzHI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730101AbfBDKkq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 05:40:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:38768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729006AbfBDKko (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:40:44 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 039DB2070C;
        Mon,  4 Feb 2019 10:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549276844;
        bh=4KgBf8j6E9GWlU+20QNfPNDWGNCNULfmYbn0A4Q4y2U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dmZ9vFM45srVmj7c9QNgXSmbRu0SowIV8p+zKway45bl/kQU72XsSCj7e6xhaXx7d
         qXvpXWrFD+3d4kfv6vb0XSke+IyRNXRQo0EwT/zJgJJ5sojPL+uy13zWpFBnU5YUjt
         4Kxs4ZCUV7NQPfIxxs9VfmFXrXow24jyNRAtIDlk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Ahern <dsahern@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 34/65] ipv6: Consider sk_bound_dev_if when binding a socket to an address
Date:   Mon,  4 Feb 2019 11:36:27 +0100
Message-Id: <20190204103616.667400566@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204103610.583715954@linuxfoundation.org>
References: <20190204103610.583715954@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -345,6 +345,9 @@ int inet6_bind(struct socket *sock, stru
 					err = -EINVAL;
 					goto out_unlock;
 				}
+			}
+
+			if (sk->sk_bound_dev_if) {
 				dev = dev_get_by_index_rcu(net, sk->sk_bound_dev_if);
 				if (!dev) {
 					err = -ENODEV;


