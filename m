Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1164025AbeE1Kwo (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:52:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:41878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1163817AbeE1Kwh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:52:37 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Taehee Yoo <ap420073@gmail.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 253/496] xfrm: fix rcu_read_unlock usage in xfrm_local_error
Date: Mon, 28 May 2018 12:00:38 +0200
Message-Id: <20180528100330.553051491@linuxfoundation.org>
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

From: Taehee Yoo <ap420073@gmail.com>

[ Upstream commit 46c0ef6e1eb95f619d9f62da4332749153db92f7 ]

In the xfrm_local_error, rcu_read_unlock should be called when afinfo
is not NULL. because xfrm_state_get_afinfo calls rcu_read_unlock
if afinfo is NULL.

Fixes: af5d27c4e12b ("xfrm: remove xfrm_state_put_afinfo")
Signed-off-by: Taehee Yoo <ap420073@gmail.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/xfrm/xfrm_output.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/net/xfrm/xfrm_output.c
+++ b/net/xfrm/xfrm_output.c
@@ -285,8 +285,9 @@ void xfrm_local_error(struct sk_buff *sk
 		return;
 
 	afinfo = xfrm_state_get_afinfo(proto);
-	if (afinfo)
+	if (afinfo) {
 		afinfo->local_error(skb, mtu);
-	rcu_read_unlock();
+		rcu_read_unlock();
+	}
 }
 EXPORT_SYMBOL_GPL(xfrm_local_error);
