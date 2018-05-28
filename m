Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S939045AbeE1M5f (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 08:57:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:43266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1164267AbeE1KyU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:54:20 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 290/496] xfrm: Fix transport mode skb control buffer usage.
Date: Mon, 28 May 2018 12:01:15 +0200
Message-Id: <20180528100332.049943935@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100319.498712256@linuxfoundation.org>
References: <20180528100319.498712256@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Steffen Klassert <steffen.klassert@secunet.com>

[ Upstream commit 9a3fb9fb84cc30577c1b012a6a3efda944684291 ]

A recent commit introduced a new struct xfrm_trans_cb
that is used with the sk_buff control buffer. Unfortunately
it placed the structure in front of the control buffer and
overlooked that the IPv4/IPv6 control buffer is still needed
for some layer 4 protocols. As a result the IPv4/IPv6 control
buffer is overwritten with this structure. Fix this by setting
a apropriate header in front of the structure.

Fixes acf568ee859f ("xfrm: Reinject transport-mode packets ...")
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/xfrm/xfrm_input.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/net/xfrm/xfrm_input.c
+++ b/net/xfrm/xfrm_input.c
@@ -26,6 +26,12 @@ struct xfrm_trans_tasklet {
 };
 
 struct xfrm_trans_cb {
+	union {
+		struct inet_skb_parm	h4;
+#if IS_ENABLED(CONFIG_IPV6)
+		struct inet6_skb_parm	h6;
+#endif
+	} header;
 	int (*finish)(struct net *net, struct sock *sk, struct sk_buff *skb);
 };
 
