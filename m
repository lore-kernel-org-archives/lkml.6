Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC8AECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 064C1208FE
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:37:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 064C1208FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731358AbeGPIDO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 04:03:14 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46674 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728460AbeGPIDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 04:03:13 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C9F3BC03;
        Mon, 16 Jul 2018 07:37:12 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Christian Kellner <christian@kellner.me>,
        Yehezkel Bernat <yehezkelshb@gmail.com>
Subject: [PATCH 4.17 23/67] thunderbolt: Notify userspace when boot_acl is changed
Date:   Mon, 16 Jul 2018 09:34:52 +0200
Message-Id: <20180716073446.678897013@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180716073443.294323458@linuxfoundation.org>
References: <20180716073443.294323458@linuxfoundation.org>
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

From: Mika Westerberg <mika.westerberg@linux.intel.com>

commit 007a74907deeceefef9dc3ec4679fbd7921eaa51 upstream.

The commit 9aaa3b8b4c56 ("thunderbolt: Add support for preboot ACL")
introduced boot_acl attribute but missed the fact that now userspace
needs to poll the attribute constantly to find out whether it has
changed or not. Fix this by sending notification to the userspace
whenever the boot_acl attribute is changed.

Fixes: 9aaa3b8b4c56 ("thunderbolt: Add support for preboot ACL")
Reported-and-tested-by: Christian Kellner <christian@kellner.me>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Christian Kellner <christian@kellner.me>
Acked-by: Yehezkel Bernat <yehezkelshb@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/thunderbolt/domain.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/thunderbolt/domain.c
+++ b/drivers/thunderbolt/domain.c
@@ -213,6 +213,10 @@ static ssize_t boot_acl_store(struct dev
 		goto err_free_acl;
 	}
 	ret = tb->cm_ops->set_boot_acl(tb, acl, tb->nboot_acl);
+	if (!ret) {
+		/* Notify userspace about the change */
+		kobject_uevent(&tb->dev.kobj, KOBJ_CHANGE);
+	}
 	mutex_unlock(&tb->lock);
 
 err_free_acl:


