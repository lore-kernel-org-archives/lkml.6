Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3193DC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 10:18:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE19720868
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 10:18:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE19720868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387806AbeKOUZj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 15:25:39 -0500
Received: from relay.sw.ru ([185.231.240.75]:39648 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728859AbeKOUZj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 15:25:39 -0500
Received: from [172.16.24.21]
        by relay.sw.ru with esmtp (Exim 4.90_1)
        (envelope-from <vvs@virtuozzo.com>)
        id 1gNEjB-0006vW-3m; Thu, 15 Nov 2018 13:18:25 +0300
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH 2/3] dlm: lost put_lkb on error path in receive_convert() and
 receive_unlock()
To:     linux-kernel@vger.kernel.org,
        Christine Caulfield <ccaulfie@redhat.com>,
        David Teigland <teigland@redhat.com>, cluster-devel@redhat.com
Message-ID: <c04809a2-5806-2b63-f819-903b12b1aab5@virtuozzo.com>
Date:   Thu, 15 Nov 2018 13:18:24 +0300
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

Fixes 6d40c4a708e0 ("dlm: improve error and debug messages")
Cc: stable@kernel.org # 3.5

Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
---
 fs/dlm/lock.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
index 2cb125cc21c9..03d767b94f7b 100644
--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -4180,6 +4180,7 @@ static int receive_convert(struct dlm_ls *ls, struct dlm_message *ms)
 			  (unsigned long long)lkb->lkb_recover_seq,
 			  ms->m_header.h_nodeid, ms->m_lkid);
 		error = -ENOENT;
+		dlm_put_lkb(lkb);
 		goto fail;
 	}
 
@@ -4233,6 +4234,7 @@ static int receive_unlock(struct dlm_ls *ls, struct dlm_message *ms)
 			  lkb->lkb_id, lkb->lkb_remid,
 			  ms->m_header.h_nodeid, ms->m_lkid);
 		error = -ENOENT;
+		dlm_put_lkb(lkb);
 		goto fail;
 	}
 
-- 
2.17.1

