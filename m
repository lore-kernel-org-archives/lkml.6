Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FA08C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:15:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14A5E20645
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:15:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14A5E20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728748AbeIHB6k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 21:58:40 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:42614 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727069AbeIHB6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 21:58:39 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 74C73F07;
        Fri,  7 Sep 2018 21:15:52 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xavier Deguillard <xdeguillard@vmware.com>,
        Nadav Amit <namit@vmware.com>
Subject: [PATCH 4.18 072/145] vmw_balloon: fix VMCI use when balloon built into kernel
Date:   Fri,  7 Sep 2018 23:08:58 +0200
Message-Id: <20180907210910.401453132@linuxfoundation.org>
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

commit c3cc1b0fc27508da53fe955a3b23d03964410682 upstream.

Currently, when all modules, including VMCI and VMware balloon are built
into the kernel, the initialization of the balloon happens before the
VMCI is probed. As a result, the balloon fails to initialize the VMCI
doorbell, which it uses to get asynchronous requests for balloon size
changes.

The problem can be seen in the logs, in the form of the following
message:
	"vmw_balloon: failed to initialize vmci doorbell"

The driver would work correctly but slightly less efficiently, probing
for requests periodically. This patch changes the balloon to be
initialized using late_initcall() instead of module_init() to address
this issue. It does not address a situation in which VMCI is built as a
module and the balloon is built into the kernel.

Fixes: 48e3d668b790 ("VMware balloon: Enable notification via VMCI")
Cc: stable@vger.kernel.org
Reviewed-by: Xavier Deguillard <xdeguillard@vmware.com>
Signed-off-by: Nadav Amit <namit@vmware.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/misc/vmw_balloon.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

--- a/drivers/misc/vmw_balloon.c
+++ b/drivers/misc/vmw_balloon.c
@@ -1297,7 +1297,14 @@ static int __init vmballoon_init(void)
 
 	return 0;
 }
-module_init(vmballoon_init);
+
+/*
+ * Using late_initcall() instead of module_init() allows the balloon to use the
+ * VMCI doorbell even when the balloon is built into the kernel. Otherwise the
+ * VMCI is probed only after the balloon is initialized. If the balloon is used
+ * as a module, late_initcall() is equivalent to module_init().
+ */
+late_initcall(vmballoon_init);
 
 static void __exit vmballoon_exit(void)
 {


