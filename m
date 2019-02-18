Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CE6FC10F01
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:21:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C79A21901
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550499701;
	bh=Hk79Y+waw1u7NJAzvLd0I3jEgjNBpSgnbe5uPdAiqgU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tmcH0ZM6Eay8b0hIMWOx2eTsO8VcvI+LschMmUXqvY6ovkxCWEaOIZGuZpnI+aUQi
	 z++jg7uQGzLtmQNyGOI8qXlqA/xnPr06+Ug5J4KPqNPfHHh1NqbO5YHA6RWfQSH9aN
	 KcG/F0x7hlP3Ikn/Eh33WfEwyHCYgzAYg1TF4djA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390372AbfBROGW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:06:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:49296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389506AbfBROGP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 09:06:15 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8CCF21908;
        Mon, 18 Feb 2019 14:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550498774;
        bh=Hk79Y+waw1u7NJAzvLd0I3jEgjNBpSgnbe5uPdAiqgU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aXbIaqWWc3PzTp548CqdDSbX3EOPV7kpjffOxzd84utr5p+AVC4uha4nLrm+WiEHJ
         wvQUmD/AYX2PlS8Fi+TfKlvFCbXz8m8GOu5MFp8mCl+7Ie2l9RFvj3cYLSgv1YjAIF
         d78d/OHmbDsu/7chsJvDEizjN+VWy6m0YsZf/Huk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+c764de0fcfadca9a8595@syzkaller.appspotmail.com,
        Dmitry Vyukov <dvyukov@google.com>,
        Sven Eckelmann <sven@narfation.org>,
        Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 4.4 116/143] batman-adv: Avoid WARN on net_device without parent in netns
Date:   Mon, 18 Feb 2019 14:44:04 +0100
Message-Id: <20190218133533.253315550@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133529.099444112@linuxfoundation.org>
References: <20190218133529.099444112@linuxfoundation.org>
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
@@ -18,7 +18,6 @@
 #include "hard-interface.h"
 #include "main.h"
 
-#include <linux/bug.h>
 #include <linux/byteorder/generic.h>
 #include <linux/errno.h>
 #include <linux/fs.h>
@@ -104,8 +103,10 @@ static bool batadv_is_on_batman_iface(co
 	/* recurse over the parent device */
 	parent_dev = __dev_get_by_index(&init_net, dev_get_iflink(net_dev));
 	/* if we got a NULL parent_dev there is something broken.. */
-	if (WARN(!parent_dev, "Cannot find parent device"))
+	if (!parent_dev) {
+		pr_err("Cannot find parent device\n");
 		return false;
+	}
 
 	ret = batadv_is_on_batman_iface(parent_dev);
 


