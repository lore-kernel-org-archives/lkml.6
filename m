Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57E23C07520
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:53:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CCC920854
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:53:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CCC920854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730719AbeIMTDH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 15:03:07 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33676 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728810AbeIMTDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 15:03:06 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E0F9CCE7;
        Thu, 13 Sep 2018 13:53:30 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        John Johansen <john.johansen@canonical.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 052/197] apparmor: fix an error code in __aa_create_ns()
Date:   Thu, 13 Sep 2018 15:30:01 +0200
Message-Id: <20180913131843.615114388@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180913131841.568116777@linuxfoundation.org>
References: <20180913131841.568116777@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit 0a6b29230ec336189bab32498df3f06c8a6944d8 ]

We should return error pointers in this function.  Returning NULL
results in a NULL dereference in the caller.

Fixes: 73688d1ed0b8 ("apparmor: refactor prepare_ns() and make usable from different views")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: John Johansen <john.johansen@canonical.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 security/apparmor/policy_ns.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/security/apparmor/policy_ns.c
+++ b/security/apparmor/policy_ns.c
@@ -255,7 +255,7 @@ static struct aa_ns *__aa_create_ns(stru
 
 	ns = alloc_ns(parent->base.hname, name);
 	if (!ns)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 	ns->level = parent->level + 1;
 	mutex_lock_nested(&ns->lock, ns->level);
 	error = __aafs_ns_mkdir(ns, ns_subns_dir(parent), name, dir);


