Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D986C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:47:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12BEA222D1
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550083678;
	bh=hHXCe1RYkn0gikWuM1EYMOXYPvS1x2Ksr2FOiLeZw1Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Bw+QfZFFWMi756hJkHjunCJRbjw+bLBqzDioKOUc38DHgpBqWxaXCuhUn4jkF/1xd
	 x7AukKocxdGpLSoAJZ7JCoUd+TUGk+Ng4z85x7QC4zasu0PuVgmT6zQn/Ezyxk0+M6
	 JpIERYXACmWHlLsnV1X0vDOoiLUB6HspSL1/KZrU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392119AbfBMSr4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 13:47:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:45408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406543AbfBMSqw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 13:46:52 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 90D12222D1;
        Wed, 13 Feb 2019 18:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550083611;
        bh=hHXCe1RYkn0gikWuM1EYMOXYPvS1x2Ksr2FOiLeZw1Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wodVE+DeE8njh/xUccRNJ6YGUDs6p5wSBiABzP9xLLJzgC453Lo+GwBe2INmH0VOi
         Ui9wx02mouJ4pWXa25tevpfK4KS1wQwFc2Ml//d4LaCFEM9UEfELKqn1uPMwqTV4A5
         c7Z+NRM6GIrJ+JTCSZSJaJrPsx3fI3ZDh8DZj2Vo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+c764de0fcfadca9a8595@syzkaller.appspotmail.com,
        Dmitry Vyukov <dvyukov@google.com>,
        Sven Eckelmann <sven@narfation.org>,
        Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 4.20 49/50] batman-adv: Avoid WARN on net_device without parent in netns
Date:   Wed, 13 Feb 2019 19:38:54 +0100
Message-Id: <20190213183659.527325774@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190213183655.747168774@linuxfoundation.org>
References: <20190213183655.747168774@linuxfoundation.org>
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

From: Sven Eckelmann <sven@narfation.org>

commit 955d3411a17f590364238bd0d3329b61f20c1cd2 upstream.

It is not allowed to use WARN* helpers on potential incorrect input from
the user or transient problems because systems configured as panic_on_warn
will reboot due to such a problem.

A NULL return value of __dev_get_by_index can be caused by various problems
which can either be related to the system configuration or problems
(incorrectly returned network namespaces) in other (virtual) net_device
drivers. batman-adv should not cause a (harmful) WARN in this situation and
instead only report it via a simple message.

Fixes: b7eddd0b3950 ("batman-adv: prevent using any virtual device created on batman-adv as hard-interface")
Reported-by: syzbot+c764de0fcfadca9a8595@syzkaller.appspotmail.com
Reported-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/batman-adv/hard-interface.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -20,7 +20,6 @@
 #include "main.h"
 
 #include <linux/atomic.h>
-#include <linux/bug.h>
 #include <linux/byteorder/generic.h>
 #include <linux/errno.h>
 #include <linux/gfp.h>
@@ -179,8 +178,10 @@ static bool batadv_is_on_batman_iface(co
 	parent_dev = __dev_get_by_index((struct net *)parent_net,
 					dev_get_iflink(net_dev));
 	/* if we got a NULL parent_dev there is something broken.. */
-	if (WARN(!parent_dev, "Cannot find parent device"))
+	if (!parent_dev) {
+		pr_err("Cannot find parent device\n");
 		return false;
+	}
 
 	if (batadv_mutual_parents(net_dev, net, parent_dev, parent_net))
 		return false;


