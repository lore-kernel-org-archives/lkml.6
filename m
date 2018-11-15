Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E574C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 10:18:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C47A20868
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 10:18:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C47A20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387614AbeKOUZe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 15:25:34 -0500
Received: from relay.sw.ru ([185.231.240.75]:39646 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728859AbeKOUZd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 15:25:33 -0500
Received: from [172.16.24.21]
        by relay.sw.ru with esmtp (Exim 4.90_1)
        (envelope-from <vvs@virtuozzo.com>)
        id 1gNEj6-0006vR-3L; Thu, 15 Nov 2018 13:18:20 +0300
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH 1/3] dlm: possible memory leak on error path in create_lkb()
To:     linux-kernel@vger.kernel.org,
        Christine Caulfield <ccaulfie@redhat.com>,
        David Teigland <teigland@redhat.com>, cluster-devel@redhat.com
Message-ID: <a4b90c7b-7cd3-aa58-5170-33148dd9b5cb@virtuozzo.com>
Date:   Thu, 15 Nov 2018 13:18:18 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes 3d6aa675fff9 ("dlm: keep lkbs in idr")
Cc: stable@kernel.org # 3.1

Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
---
 fs/dlm/lock.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
index cc91963683de..2cb125cc21c9 100644
--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -1209,6 +1209,7 @@ static int create_lkb(struct dlm_ls *ls, struct dlm_lkb **lkb_ret)
 
 	if (rv < 0) {
 		log_error(ls, "create_lkb idr error %d", rv);
+		dlm_free_lkb(lkb);
 		return rv;
 	}
 
-- 
2.17.1

