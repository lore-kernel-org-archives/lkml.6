Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71C5AC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:47:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37D8B206BB
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546865237;
	bh=Re7zD3iOEsFfUx82kK7I1+349goKLq329phxA3w74zc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CjvfcpMNTJv82cLMmky09h0lTSGNzp1bNABb4zq2jNb7pQNYqGykLTRTuCvJxLF5Z
	 MqTcx6bHr8nOTQAa1wYBLPw7VzQq2/E5eBBM2bOwQ9CCTHiq0spQ58dtqouxKwSiQx
	 NRzqHkNRYMzSXhyx1pjE/LsVCscCgAu2AmXXoOZ4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728670AbfAGMrQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:47:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:35672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728958AbfAGMp5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:45:57 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 020912183E;
        Mon,  7 Jan 2019 12:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546865157;
        bh=Re7zD3iOEsFfUx82kK7I1+349goKLq329phxA3w74zc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D0vD7Zg99+awBbN+mhdihvGSZddWUZVXt6+Ukkmvqs6hTfKo7WyhQwfe9IpafYZXB
         GEYhqYm9lsncAZpoFvHQao+3DHq3aQ/tU2OEPdLlvat+CNtHyARwuIISP9t2hC+7MC
         ZXcHlLzgGan5NzYjSVAss/wdkum0y6kpU1O2vXkc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Willem de Bruijn <willemb@google.com>,
        Alexander Aring <aring@mojatatu.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 004/170] ieee802154: lowpan_header_create check must check daddr
Date:   Mon,  7 Jan 2019 13:30:31 +0100
Message-Id: <20190107104453.480104481@linuxfoundation.org>
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

From: Willem de Bruijn <willemb@google.com>

[ Upstream commit 40c3ff6d5e0809505a067dd423c110c5658c478c ]

Packet sockets may call dev_header_parse with NULL daddr. Make
lowpan_header_ops.create fail.

Fixes: 87a93e4eceb4 ("ieee802154: change needed headroom/tailroom")
Signed-off-by: Willem de Bruijn <willemb@google.com>
Acked-by: Alexander Aring <aring@mojatatu.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ieee802154/6lowpan/tx.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/net/ieee802154/6lowpan/tx.c
+++ b/net/ieee802154/6lowpan/tx.c
@@ -48,6 +48,9 @@ int lowpan_header_create(struct sk_buff
 	const struct ipv6hdr *hdr = ipv6_hdr(skb);
 	struct neighbour *n;
 
+	if (!daddr)
+		return -EINVAL;
+
 	/* TODO:
 	 * if this package isn't ipv6 one, where should it be routed?
 	 */


