Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751455AbeEDHFT (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 03:05:19 -0400
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:45284 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751412AbeEDHFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 03:05:17 -0400
X-Google-Smtp-Source: AB8JxZoT7HLLhfaLXm5tHsGJY8TwJoS3DpcLsa/T/ZAsXIiYbH9PF0basfn8vxpJQspNQ4jH8+Y+Sw==
From: Wenwen Wang <wang6495@umn.edu>
To: Wenwen Wang <wang6495@umn.edu>
Cc: Kangjie Lu <kjlu@umn.edu>, Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
        "David S. Miller" <davem@davemloft.net>,
        netdev@vger.kernel.org (open list:TC subsystem),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] net: sched: cls: fix a potential missing-check bug
Date: Fri,  4 May 2018 02:05:05 -0500
Message-Id: <1525417505-19056-1-git-send-email-wang6495@umn.edu>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In rsvp_change(), the value of f->res.classid is checked to be no more
than 255. Otherwise, the execution will goto errout. This is enforced by a
if-statement check. However, in the following execution, f->res.classid is
assigned with a new value returned from gen_tunnel(), and the new value
is only checked against 0. Given that gen_tunnel() may return a value
larger than 255 based on data, the new value of f->res.classid should
be re-checked.

This patch adds a re-check to ensure the new value of f->res.classid is not
great than 255; otherwise, an error code will be returned.

Signed-off-by: Wenwen Wang <wang6495@umn.edu>
---
 net/sched/cls_rsvp.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/sched/cls_rsvp.h b/net/sched/cls_rsvp.h
index 4f12976..7ced8fc 100644
--- a/net/sched/cls_rsvp.h
+++ b/net/sched/cls_rsvp.h
@@ -590,6 +590,9 @@ static int rsvp_change(struct net *net, struct sk_buff *in_skb,
 		if (f->res.classid == 0 &&
 		    (f->res.classid = gen_tunnel(data)) == 0)
 			goto errout;
+
+		if (f->res.classid > 255)
+			goto errout;
 	}
 
 	for (sp = &data->ht[h1];
-- 
2.7.4
