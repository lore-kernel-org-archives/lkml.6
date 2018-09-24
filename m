Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D6C5ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:58:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB92720833
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:58:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB92720833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729986AbeIXR6A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 13:58:00 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51994 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729122AbeIXR57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 13:57:59 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 3AEF11072;
        Mon, 24 Sep 2018 11:56:14 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH 4.4 34/70] misc: hmc6352: fix potential Spectre v1
Date:   Mon, 24 Sep 2018 13:52:33 +0200
Message-Id: <20180924113102.735368447@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113058.420454070@linuxfoundation.org>
References: <20180924113058.420454070@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gustavo A. R. Silva <gustavo@embeddedor.com>

commit de916736aaaadddbd6061472969f667b14204aa9 upstream.

val is indirectly controlled by user-space, hence leading to a
potential exploitation of the Spectre variant 1 vulnerability.

This issue was detected with the help of Smatch:

drivers/misc/hmc6352.c:54 compass_store() warn: potential spectre issue
'map' [r]

Fix this by sanitizing val before using it to index map

Notice that given that speculation windows are large, the policy is
to kill the speculation on the first load and not worry if it can be
completed with a dependent load/store [1].

[1] https://marc.info/?l=linux-kernel&m=152449131114778&w=2

Cc: stable@vger.kernel.org
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/misc/hmc6352.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/misc/hmc6352.c
+++ b/drivers/misc/hmc6352.c
@@ -27,6 +27,7 @@
 #include <linux/err.h>
 #include <linux/delay.h>
 #include <linux/sysfs.h>
+#include <linux/nospec.h>
 
 static DEFINE_MUTEX(compass_mutex);
 
@@ -50,6 +51,7 @@ static int compass_store(struct device *
 		return ret;
 	if (val >= strlen(map))
 		return -EINVAL;
+	val = array_index_nospec(val, strlen(map));
 	mutex_lock(&compass_mutex);
 	ret = compass_command(c, map[val]);
 	mutex_unlock(&compass_mutex);


