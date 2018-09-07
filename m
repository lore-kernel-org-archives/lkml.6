Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6A5DC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:18:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7649720645
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:18:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7649720645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728804AbeIHCBD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 22:01:03 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45008 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbeIHCBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 22:01:03 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 9814EE2F;
        Fri,  7 Sep 2018 21:18:15 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xavier Deguillard <xdeguillard@vmware.com>,
        Nadav Amit <nadav.amit@gmail.com>
Subject: [PATCH 4.18 070/145] vmw_balloon: do not use 2MB without batching
Date:   Fri,  7 Sep 2018 23:08:56 +0200
Message-Id: <20180907210910.274713352@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180907210903.617721278@linuxfoundation.org>
References: <20180907210903.617721278@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nadav Amit <namit@vmware.com>

commit 5081efd112560d3febb328e627176235b250d59d upstream.

If the hypervisor sets 2MB batching is on, while batching is cleared,
the balloon code breaks. In this case the legacy mechanism is used with
2MB page. The VM would report a 2MB page is ballooned, and the
hypervisor would only take the first 4KB.

While the hypervisor should not report such settings, make the code more
robust by not enabling 2MB support without batching.

Fixes: 365bd7ef7ec8e ("VMware balloon: Support 2m page ballooning.")
Cc: stable@vger.kernel.org
Reviewed-by: Xavier Deguillard <xdeguillard@vmware.com>
Signed-off-by: Nadav Amit <nadav.amit@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/misc/vmw_balloon.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--- a/drivers/misc/vmw_balloon.c
+++ b/drivers/misc/vmw_balloon.c
@@ -341,7 +341,13 @@ static bool vmballoon_send_start(struct
 		success = false;
 	}
 
-	if (b->capabilities & VMW_BALLOON_BATCHED_2M_CMDS)
+	/*
+	 * 2MB pages are only supported with batching. If batching is for some
+	 * reason disabled, do not use 2MB pages, since otherwise the legacy
+	 * mechanism is used with 2MB pages, causing a failure.
+	 */
+	if ((b->capabilities & VMW_BALLOON_BATCHED_2M_CMDS) &&
+	    (b->capabilities & VMW_BALLOON_BATCHED_CMDS))
 		b->supported_page_sizes = 2;
 	else
 		b->supported_page_sizes = 1;


