Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A661C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 17:39:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92B88223DD
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 17:39:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92B88223DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=openvz.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732035AbeKNDiH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 22:38:07 -0500
Received: from relay.sw.ru ([185.231.240.75]:45584 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730730AbeKNDiH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 22:38:07 -0500
Received: from [172.16.24.44] (helo=iris.sw.ru)
        by relay.sw.ru with esmtp (Exim 4.90_1)
        (envelope-from <den@openvz.org>)
        id 1gMceP-0005a0-48; Tue, 13 Nov 2018 20:38:57 +0300
From:   "Denis V. Lunev" <den@openvz.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Denis V. Lunev" <den@openvz.org>,
        Christine Caulfield <ccaulfie@redhat.com>,
        David Teigland <teigland@redhat.com>,
        Konstantin Khorenko <khorenko@virtuozzo.com>,
        cluster-devel@redhat.com
Subject: [PATCH 1/1] dlm: fix possible call to kfree() for non-initialized pointer
Date:   Tue, 13 Nov 2018 20:39:50 +0300
Message-Id: <20181113173950.7165-1-den@openvz.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Technically dlm_config_nodes() could return error and keep nodes
uninitialized. After that on the fail path of we'll call kfree()
for that uninitialized value.

The patch is simple - we should just initialize nodes with NULL.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Christine Caulfield <ccaulfie@redhat.com>
CC: David Teigland <teigland@redhat.com>
CC: Konstantin Khorenko <khorenko@virtuozzo.com>
CC: cluster-devel@redhat.com
---
 fs/dlm/member.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/dlm/member.c b/fs/dlm/member.c
index 3fda3832cf6a..2ce33088f8bb 100644
--- a/fs/dlm/member.c
+++ b/fs/dlm/member.c
@@ -671,7 +671,7 @@ int dlm_ls_stop(struct dlm_ls *ls)
 int dlm_ls_start(struct dlm_ls *ls)
 {
 	struct dlm_recover *rv, *rv_old;
-	struct dlm_config_node *nodes;
+	struct dlm_config_node *nodes = NULL;
 	int error, count;
 
 	rv = kzalloc(sizeof(*rv), GFP_NOFS);
-- 
2.17.1

