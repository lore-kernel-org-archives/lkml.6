Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 414DCC04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:42:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03CD720854
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:42:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03CD720854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729722AbeIMSvj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 14:51:39 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60108 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728864AbeIMSvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 14:51:39 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 87F15D1A;
        Thu, 13 Sep 2018 13:42:06 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH 4.14 005/115] net: sched: Fix memory exposure from short TCA_U32_SEL
Date:   Thu, 13 Sep 2018 15:30:25 +0200
Message-Id: <20180913131823.764057239@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180913131823.327472833@linuxfoundation.org>
References: <20180913131823.327472833@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kees Cook <keescook@chromium.org>

[ Upstream commit 98c8f125fd8a6240ea343c1aa50a1be9047791b8 ]

Via u32_change(), TCA_U32_SEL has an unspecified type in the netlink
policy, so max length isn't enforced, only minimum. This means nkeys
(from userspace) was being trusted without checking the actual size of
nla_len(), which could lead to a memory over-read, and ultimately an
exposure via a call to u32_dump(). Reachability is CAP_NET_ADMIN within
a namespace.

Reported-by: Al Viro <viro@zeniv.linux.org.uk>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Cong Wang <xiyou.wangcong@gmail.com>
Cc: Jiri Pirko <jiri@resnulli.us>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sched/cls_u32.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/net/sched/cls_u32.c
+++ b/net/sched/cls_u32.c
@@ -903,6 +903,7 @@ static int u32_change(struct net *net, s
 	struct nlattr *opt = tca[TCA_OPTIONS];
 	struct nlattr *tb[TCA_U32_MAX + 1];
 	u32 htid, flags = 0;
+	size_t sel_size;
 	int err;
 #ifdef CONFIG_CLS_U32_PERF
 	size_t size;
@@ -1024,8 +1025,11 @@ static int u32_change(struct net *net, s
 		return -EINVAL;
 
 	s = nla_data(tb[TCA_U32_SEL]);
+	sel_size = sizeof(*s) + sizeof(*s->keys) * s->nkeys;
+	if (nla_len(tb[TCA_U32_SEL]) < sel_size)
+		return -EINVAL;
 
-	n = kzalloc(sizeof(*n) + s->nkeys*sizeof(struct tc_u32_key), GFP_KERNEL);
+	n = kzalloc(offsetof(typeof(*n), sel) + sel_size, GFP_KERNEL);
 	if (n == NULL)
 		return -ENOBUFS;
 
@@ -1038,7 +1042,7 @@ static int u32_change(struct net *net, s
 	}
 #endif
 
-	memcpy(&n->sel, s, sizeof(*s) + s->nkeys*sizeof(struct tc_u32_key));
+	memcpy(&n->sel, s, sel_size);
 	RCU_INIT_POINTER(n->ht_up, ht);
 	n->handle = handle;
 	n->fshift = s->hmask ? ffs(ntohl(s->hmask)) - 1 : 0;


