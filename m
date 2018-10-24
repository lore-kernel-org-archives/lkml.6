Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3061BC67863
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 15:21:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00586207DD
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 15:21:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00586207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbeJXXuL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 19:50:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:19234 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726407AbeJXXuK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 19:50:10 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4090F308ED5F
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 15:21:40 +0000 (UTC)
Received: from loberhel74.redhat.com (ovpn-121-56.rdu2.redhat.com [10.10.121.56])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AC04A60921;
        Wed, 24 Oct 2018 15:21:39 +0000 (UTC)
From:   Laurence Oberman <loberman@redhat.com>
To:     linux-kernel@vger.kernel.org, loberman@redhat.com
Subject: [PATCH] init/main.c Enable watchdog_thresh control from kernel line 
Date:   Wed, 24 Oct 2018 11:21:24 -0400
Message-Id: <1540394484-18252-1-git-send-email-loberman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Wed, 24 Oct 2018 15:21:40 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both graphics and serial consoels are exposed to hard lockups
when handling a large amount of messaging. The kernel watchdog_thresh
parameter up to now has not been available to be set on the kernel line for
early boot. 
This patch allows the setting of watchdog_thresh to be increased
when needed to avoid the hard lockups in the console code.

Signed-off-by: Laurence Oberman <loberman@redhat.com>
---
 init/main.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/init/main.c b/init/main.c
index e4a3160..5882750 100644
--- a/init/main.c
+++ b/init/main.c
@@ -977,6 +977,15 @@ static int __init set_debug_rodata(char *str)
 __setup("rodata=", set_debug_rodata);
 #endif
 
+static int __init
+is_watchdog_thresh_setup(char *str)
+{
+	get_option(&str, &watchdog_thresh);
+	return 1;
+}
+__setup("watchdog_thresh=", is_watchdog_thresh_setup);
+
+
 #ifdef CONFIG_STRICT_KERNEL_RWX
 static void mark_readonly(void)
 {
-- 
1.8.3.1

