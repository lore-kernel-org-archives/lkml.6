Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 925BDECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 21:57:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A11E20673
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 21:57:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A11E20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731170AbeGTWrs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 18:47:48 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:37626 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728214AbeGTWrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 18:47:47 -0400
Received: from 2.general.tyhicks.us.vpn ([10.172.64.53] helo=sec.l.tihix.com)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <tyhicks@canonical.com>)
        id 1fgdP3-0004ZT-Rn; Fri, 20 Jul 2018 21:57:34 +0000
From:   Tyler Hicks <tyhicks@canonical.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Stephen Hemminger <stephen@networkplumber.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bridge@lists.linux-foundation.org,
        Linux Containers <containers@lists.linux-foundation.org>
Subject: [PATCH net-next v3 3/8] kobject: kset_create_and_add() - fetch ownership info from parent
Date:   Fri, 20 Jul 2018 21:56:49 +0000
Message-Id: <1532123814-1109-4-git-send-email-tyhicks@canonical.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1532123814-1109-1-git-send-email-tyhicks@canonical.com>
References: <1532123814-1109-1-git-send-email-tyhicks@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

This change implements get_ownership() for ksets created with
kset_create_and_add() call by fetching ownership data from parent kobject.
This is done mostly for benefit of "queues" attribute of net devices so
that corresponding directory belongs to container's root instead of global
root for network devices in a container.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reviewed-by: Tyler Hicks <tyhicks@canonical.com>
---
 lib/kobject.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/lib/kobject.c b/lib/kobject.c
index f2dc1f756007..389829d3a1d1 100644
--- a/lib/kobject.c
+++ b/lib/kobject.c
@@ -887,9 +887,16 @@ static void kset_release(struct kobject *kobj)
 	kfree(kset);
 }
 
+void kset_get_ownership(struct kobject *kobj, kuid_t *uid, kgid_t *gid)
+{
+	if (kobj->parent)
+		kobject_get_ownership(kobj->parent, uid, gid);
+}
+
 static struct kobj_type kset_ktype = {
 	.sysfs_ops	= &kobj_sysfs_ops,
-	.release = kset_release,
+	.release	= kset_release,
+	.get_ownership	= kset_get_ownership,
 };
 
 /**
-- 
2.7.4

