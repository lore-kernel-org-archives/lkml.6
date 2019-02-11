Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84016C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:37:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 517D920700
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549895845;
	bh=tD7xVjHiAbceYoaqAulRpyXeSOTx8m1bXDAjDNIah9k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kxUEJY8sxuY2VZF+7hlOSgHCcPSGZdUDrbGWyfI5NUgV3T/nzb9ckBBu2MHLDzEtk
	 nAS2G4LT9gj/9SbJO+LI9v1883h/pTcjz7NI++U3yhF4FRdU8OJ5Aa2g4RelGPVnNF
	 u9bzNvE/2q6j2lfYcnQv0KZsP24zZpTQbdwmhi8E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731444AbfBKOhX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:37:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:46684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727856AbfBKOhU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:37:20 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E7AE20700;
        Mon, 11 Feb 2019 14:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549895839;
        bh=tD7xVjHiAbceYoaqAulRpyXeSOTx8m1bXDAjDNIah9k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1HMSgQhyeDz6t64hzT/zgLYG1kRKhF45CfNvCwtZjbETDwUrAZ99ytr+R3hKCRzes
         qEHvuzEIQvKL4oxEPJFMJI6ywQyDV3Fr7A+W32w1YEsDvYbLTPyHafTdACSCx/hYHE
         ma/o4YXS8FowYLqIkD9hu8QdEJPNRievppLkzaWg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Petr Machata <petrm@mellanox.com>,
        Jiri Pirko <jiri@mellanox.com>,
        Ido Schimmel <idosch@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.20 309/352] net: cls_flower: Remove filter from mask before freeing it
Date:   Mon, 11 Feb 2019 15:18:56 +0100
Message-Id: <20190211141906.508563277@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141846.543045703@linuxfoundation.org>
References: <20190211141846.543045703@linuxfoundation.org>
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

From: Petr Machata <petrm@mellanox.com>

[ Upstream commit c1f7e02979edd7a3a3e69fe04be60b1d650dc8a7 ]

In fl_change(), when adding a new rule (i.e. fold == NULL), a driver may
reject the new rule, for example due to resource exhaustion. By that
point, the new rule was already assigned a mask, and it was added to
that mask's hash table. The clean-up path that's invoked as a result of
the rejection however neglects to undo the hash table addition, and
proceeds to free the new rule, thus leaving a dangling pointer in the
hash table.

Fix by removing fnew from the mask's hash table before it is freed.

Fixes: 35cc3cefc4de ("net/sched: cls_flower: Reject duplicated rules also under skip_sw")
Signed-off-by: Petr Machata <petrm@mellanox.com>
Acked-by: Jiri Pirko <jiri@mellanox.com>
Reviewed-by: Ido Schimmel <idosch@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sched/cls_flower.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/net/sched/cls_flower.c
+++ b/net/sched/cls_flower.c
@@ -1257,7 +1257,7 @@ static int fl_change(struct net *net, st
 	if (!tc_skip_hw(fnew->flags)) {
 		err = fl_hw_replace_filter(tp, fnew, extack);
 		if (err)
-			goto errout_mask;
+			goto errout_mask_ht;
 	}
 
 	if (!tc_in_hw(fnew->flags))
@@ -1287,6 +1287,10 @@ static int fl_change(struct net *net, st
 	kfree(mask);
 	return 0;
 
+errout_mask_ht:
+	rhashtable_remove_fast(&fnew->mask->ht, &fnew->ht_node,
+			       fnew->mask->filter_ht_params);
+
 errout_mask:
 	fl_mask_put(head, fnew->mask, false);
 


