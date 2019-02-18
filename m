Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DE5CC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:15:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 645962177E
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550499319;
	bh=XMgQNZQyYI9mMZ3R4ZiAFFqG+y5+qUOe2U57+QtT4Rs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Fl/TUF+94sk5d10Et7pKqhlsqq83Lovw0Q5jGYcj4hnRakZ1b1nImCvU+O55TeRxd
	 RzInJobtEPgk64HanJ1uhczbTcdp1MAr4mL9Y/am+1GMb0yLhlh6N0gEpSDNBFQX8Y
	 /dUamTb5TN2N9je6oqKY6kUxCmIBMAEoqY1sjw0M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391566AbfBROPS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:15:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:56740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391974AbfBROMP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 09:12:15 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A0951218AD;
        Mon, 18 Feb 2019 14:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550499135;
        bh=XMgQNZQyYI9mMZ3R4ZiAFFqG+y5+qUOe2U57+QtT4Rs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CkQjjlx45dz/BlITIjftizZKgnMbBcISCKu115taZfVq7BSj7a5TcWI9q0e6cO80h
         YoGD1690/hd5iHhzqWbKHZT05S2BEhnhCMnNbpGEO8kWdKvsWV3WLaldekrCTW757o
         vEfBuTwPN2bHjqFdypX0uGTTqpEJyzUv4sjtfj6A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+c764de0fcfadca9a8595@syzkaller.appspotmail.com,
        Dmitry Vyukov <dvyukov@google.com>,
        Sven Eckelmann <sven@narfation.org>,
        Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 3.18 088/108] batman-adv: Avoid WARN on net_device without parent in netns
Date:   Mon, 18 Feb 2019 14:44:24 +0100
Message-Id: <20190218133523.649639296@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133519.525507231@linuxfoundation.org>
References: <20190218133519.525507231@linuxfoundation.org>
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

3.18-stable review patch.  If anyone has any objections, please let me know.

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
 net/batman-adv/hard-interface.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -89,8 +89,10 @@ static bool batadv_is_on_batman_iface(co
 	/* recurse over the parent device */
 	parent_dev = __dev_get_by_index(&init_net, net_dev->iflink);
 	/* if we got a NULL parent_dev there is something broken.. */
-	if (WARN(!parent_dev, "Cannot find parent device"))
+	if (!parent_dev) {
+		pr_err("Cannot find parent device\n");
 		return false;
+	}
 
 	ret = batadv_is_on_batman_iface(parent_dev);
 


