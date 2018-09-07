Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADCA7C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:15:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F89A20645
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:15:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F89A20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728698AbeIHB60 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 21:58:26 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:42584 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727598AbeIHB60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 21:58:26 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 96214F07;
        Fri,  7 Sep 2018 21:15:39 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.18 038/145] cxl: Fix wrong comparison in cxl_adapter_context_get()
Date:   Fri,  7 Sep 2018 23:08:24 +0200
Message-Id: <20180907210907.683169753@linuxfoundation.org>
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

From: Vaibhav Jain <vaibhav@linux.ibm.com>

commit ef6cb5f1a048fdf91ccee6d63d2bfa293338502d upstream.

Function atomic_inc_unless_negative() returns a bool to indicate
success/failure. However cxl_adapter_context_get() wrongly compares
the return value against '>=0' which will always be true. The patch
fixes this comparison to '==0' there by also fixing this compile time
warning:

	drivers/misc/cxl/main.c:290 cxl_adapter_context_get()
	warn: 'atomic_inc_unless_negative(&adapter->contexts_num)' is unsigned

Fixes: 70b565bbdb91 ("cxl: Prevent adapter reset if an active context exists")
Cc: stable@vger.kernel.org # v4.9+
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
Acked-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Acked-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/misc/cxl/main.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/misc/cxl/main.c
+++ b/drivers/misc/cxl/main.c
@@ -287,7 +287,7 @@ int cxl_adapter_context_get(struct cxl *
 	int rc;
 
 	rc = atomic_inc_unless_negative(&adapter->contexts_num);
-	return rc >= 0 ? 0 : -EBUSY;
+	return rc ? 0 : -EBUSY;
 }
 
 void cxl_adapter_context_put(struct cxl *adapter)


