Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9741DC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:17:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E5EA2184C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547216221;
	bh=saKEvZEKF3KL8z9IlyNDy3vdJwlv80m06CPIezkhRVE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xkk4pSye4MzCmRvMBV4gixEZXyt5wCxp+KY1C0yqbw0//OGLjb4n8bY+df2n+9MFX
	 VIJqcIL+22LfG1TccWzHnR8YlMKjwrF9xp4aLeCYhtQf2Jng0NA6gBAotmCSs9k8k+
	 auz/S9ak6P2iyzF8Kd0Tzbe1TAVa3KWr9sJynnIs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387781AbfAKORA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:17:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:33260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387740AbfAKOQ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:16:56 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 62E1721783;
        Fri, 11 Jan 2019 14:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547216215;
        bh=saKEvZEKF3KL8z9IlyNDy3vdJwlv80m06CPIezkhRVE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AwwH9OgBIMwEUyakMbVppLMNy025H8Dl/9bTUo9Dl5wtknyY5pJibu7AZQMyXXLfX
         54QgYjlqNySuNPOcMMH0IZXTS2GjRgVBG8rkyjw4uakZjlVEhwQH+Qvxr2JYrIjH3d
         54ko1jW138/sMeF7XsC4IRqYjqXQSmTVEQwtvb1g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Willem de Bruijn <willemb@google.com>,
        Alexander Aring <aring@mojatatu.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 18/88] ieee802154: lowpan_header_create check must check daddr
Date:   Fri, 11 Jan 2019 15:07:47 +0100
Message-Id: <20190111131048.835006301@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131045.137499039@linuxfoundation.org>
References: <20190111131045.137499039@linuxfoundation.org>
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
@@ -55,6 +55,9 @@ int lowpan_header_create(struct sk_buff
 	const u8 *daddr = _daddr;
 	struct lowpan_addr_info *info;
 
+	if (!daddr)
+		return -EINVAL;
+
 	/* TODO:
 	 * if this package isn't ipv6 one, where should it be routed?
 	 */


