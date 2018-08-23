Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60A3DC43615
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:42:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1ED5D2083A
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:42:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1ED5D2083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732629AbeHWMKv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:10:51 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49980 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732104AbeHWMKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:10:46 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 3B0537F6;
        Thu, 23 Aug 2018 08:42:10 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Zhouyang Jia <jiazhouyang09@gmail.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 059/324] xen: add error handling for xenbus_printf
Date:   Thu, 23 Aug 2018 09:52:05 +0200
Message-Id: <20180823074958.794786497@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823074955.885811006@linuxfoundation.org>
References: <20180823074955.885811006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zhouyang Jia <jiazhouyang09@gmail.com>

[ Upstream commit 84c029a73327cef571eaa61c7d6e67e8031b52ec ]

When xenbus_printf fails, the lack of error-handling code may
cause unexpected results.

This patch adds error-handling code after calling xenbus_printf.

Signed-off-by: Zhouyang Jia <jiazhouyang09@gmail.com>
Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/xen/manage.c |   18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

--- a/drivers/xen/manage.c
+++ b/drivers/xen/manage.c
@@ -289,8 +289,15 @@ static void sysrq_handler(struct xenbus_
 		return;
 	}
 
-	if (sysrq_key != '\0')
-		xenbus_printf(xbt, "control", "sysrq", "%c", '\0');
+	if (sysrq_key != '\0') {
+		err = xenbus_printf(xbt, "control", "sysrq", "%c", '\0');
+		if (err) {
+			pr_err("%s: Error %d writing sysrq in control/sysrq\n",
+			       __func__, err);
+			xenbus_transaction_end(xbt, 1);
+			return;
+		}
+	}
 
 	err = xenbus_transaction_end(xbt, 0);
 	if (err == -EAGAIN)
@@ -342,7 +349,12 @@ static int setup_shutdown_watcher(void)
 			continue;
 		snprintf(node, FEATURE_PATH_SIZE, "feature-%s",
 			 shutdown_handlers[idx].command);
-		xenbus_printf(XBT_NIL, "control", node, "%u", 1);
+		err = xenbus_printf(XBT_NIL, "control", node, "%u", 1);
+		if (err) {
+			pr_err("%s: Error %d writing %s\n", __func__,
+				err, node);
+			return err;
+		}
 	}
 
 	return 0;


