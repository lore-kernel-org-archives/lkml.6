Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1165467AbeE1NiR (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 09:38:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:35720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S937708AbeE1KpH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:45:07 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xin Long <lucien.xin@gmail.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 090/496] xfrm: do not call rcu_read_unlock when afinfo is NULL in xfrm_get_tos
Date: Mon, 28 May 2018 11:57:55 +0200
Message-Id: <20180528100323.596482294@linuxfoundation.org>
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

From: Xin Long <lucien.xin@gmail.com>

[ Upstream commit 143a4454daaf0e80a2b9f37159a0d6d2b61e64ed ]

When xfrm_policy_get_afinfo returns NULL, it will not hold rcu
read lock. In this case, rcu_read_unlock should not be called
in xfrm_get_tos, just like other places where it's calling
xfrm_policy_get_afinfo.

Fixes: f5e2bb4f5b22 ("xfrm: policy: xfrm_get_tos cannot fail")
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/xfrm/xfrm_policy.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -1459,10 +1459,13 @@ xfrm_tmpl_resolve(struct xfrm_policy **p
 static int xfrm_get_tos(const struct flowi *fl, int family)
 {
 	const struct xfrm_policy_afinfo *afinfo;
-	int tos = 0;
+	int tos;
 
 	afinfo = xfrm_policy_get_afinfo(family);
-	tos = afinfo ? afinfo->get_tos(fl) : 0;
+	if (!afinfo)
+		return 0;
+
+	tos = afinfo->get_tos(fl);
 
 	rcu_read_unlock();
 
