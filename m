Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A21ACC282CB
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:52:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 632792070C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549277569;
	bh=19Buzb0HsjHv5fJwR/9XyH4/Ku6AMhDsdaX2y4cBo5U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PBa3FXdZ1NcCOgQSPf3LbOEwd2rkcfeumtfhjl7JFioplb9ehk1a+WZvLVuXUEevM
	 FJr3n5ZYffbi1Im00LoOwx4pFsNP0+Rhd0ab6xUO8oYDfG8x2buym+jxyGAV/zsAfx
	 4Te0C4woehl8cn5GKPjmoVhkGUCC3MAWFweQJUOM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732659AbfBDKwr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 05:52:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:50328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732641AbfBDKwl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:52:41 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CBCC221902;
        Mon,  4 Feb 2019 10:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549277561;
        bh=19Buzb0HsjHv5fJwR/9XyH4/Ku6AMhDsdaX2y4cBo5U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zf+1isxYAU8ixow0BcXPSxhS22UpLwWyYlsRDc9eCy2iF/LBUO9RVA0kD9uxichT2
         SOoex5kspEOsGFu//BVAbTwBW3ZiYmlBBKqUQErZYenCcu7wZ8FYlgvDJPYrrk1ScS
         Gtdii5gGkyBldmStIo87ytcJdjhUMW7rMZwNIBZM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Ahern <dsahern@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.20 34/80] ipv6: Consider sk_bound_dev_if when binding a socket to an address
Date:   Mon,  4 Feb 2019 11:36:54 +0100
Message-Id: <20190204103624.732100958@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204103620.287366543@linuxfoundation.org>
References: <20190204103620.287366543@linuxfoundation.org>
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
@@ -362,6 +362,9 @@ static int __inet6_bind(struct sock *sk,
 					err = -EINVAL;
 					goto out_unlock;
 				}
+			}
+
+			if (sk->sk_bound_dev_if) {
 				dev = dev_get_by_index_rcu(net, sk->sk_bound_dev_if);
 				if (!dev) {
 					err = -ENODEV;


