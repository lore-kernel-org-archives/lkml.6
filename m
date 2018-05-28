Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S939723AbeE1QLv (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 12:11:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:33518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936495AbeE1KNl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:13:41 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Richard Haines <richard_c_haines@btinternet.com>,
        Paul Moore <paul@paul-moore.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 180/185] netlabel: If PF_INET6, check sk_buff ip header version
Date: Mon, 28 May 2018 12:03:41 +0200
Message-Id: <20180528100116.144929819@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100050.700971285@linuxfoundation.org>
References: <20180528100050.700971285@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Richard Haines <richard_c_haines@btinternet.com>

[ Upstream commit 213d7f94775322ba44e0bbb55ec6946e9de88cea ]

When resolving a fallback label, check the sk_buff version as it
is possible (e.g. SCTP) to have family = PF_INET6 while
receiving ip_hdr(skb)->version = 4.

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
Acked-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/netlabel/netlabel_unlabeled.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

--- a/net/netlabel/netlabel_unlabeled.c
+++ b/net/netlabel/netlabel_unlabeled.c
@@ -1472,6 +1472,16 @@ int netlbl_unlabel_getattr(const struct
 		iface = rcu_dereference(netlbl_unlhsh_def);
 	if (iface == NULL || !iface->valid)
 		goto unlabel_getattr_nolabel;
+
+#if IS_ENABLED(CONFIG_IPV6)
+	/* When resolving a fallback label, check the sk_buff version as
+	 * it is possible (e.g. SCTP) to have family = PF_INET6 while
+	 * receiving ip_hdr(skb)->version = 4.
+	 */
+	if (family == PF_INET6 && ip_hdr(skb)->version == 4)
+		family = PF_INET;
+#endif /* IPv6 */
+
 	switch (family) {
 	case PF_INET: {
 		struct iphdr *hdr4;
