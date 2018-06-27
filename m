Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08768C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 20:05:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8334A25858
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 20:05:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YT7XYTE7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8334A25858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966499AbeF0UFj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 16:05:39 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:39120 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932944AbeF0UFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 16:05:38 -0400
Received: by mail-wm0-f48.google.com with SMTP id p11-v6so6683297wmc.4
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 13:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=AHJbwW6O56CPCPysh+hwoGF0uRPk/XgLuyxMWmMIj+w=;
        b=YT7XYTE7wsDDbUmiK1ghi6+2phr8yzGZmv3dm9oQXipOIixqfY93L7hvWYfYgDWB6M
         0sC+gJJ5LL+MjtfFWNk2CZSA8y4wsG6uv5XV2NCXKaYeosBDZ/VuHk3iHgP7E+kVNwvu
         kHdwstBwV7p5Jw0q/TC3K8a4tpsK2QEjZML+pAl0zN5RrQM8J1BN0+ZQeVomu/v5qcNt
         x0i3CI60wbkveZ1TvFyona7ptW1h2ufcc5fZ5GB1jwqpEvzEwXKZTBbl/k4Z0WOve3Rf
         53OC153gcfR/+cSVNkqyM2lA3UuuxrDj/+MiYyCIAGoDciWuFlStz/KLdezHgXAQ21XS
         GM6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=AHJbwW6O56CPCPysh+hwoGF0uRPk/XgLuyxMWmMIj+w=;
        b=hWURumWYAPwUIT0fAuWHunHsqm5JacIw2oTOEhokTj4UikTgIkTfarUY0rK2M0VqOk
         /ZR7BXMX4Z7QYH+06Te2YpETko8ihWp0lvIo9FLYGcbsg7Wd634O4wHwdVfJOuniw1Qt
         N45hPgQZLO9CTohQgzg20N0WukqqdtSoCxzLQT54ozoo7rMdB34oDZh1f6z+KHeer8P4
         eSrsogHbWyAUULdB3SZU9XbStjjI7dtz0EFHiLAd1CNqp5CMLca+7oatwO8ZN9Sv+dbg
         ry4qtT5AdIpbJj0j766Zg+RblqLDcL7qGatowssvehfraJo3eWW1BvQTvy/oSnfldohA
         8Gaw==
X-Gm-Message-State: APt69E1mT0xDmtjtjZASVNdKwasFIXQHx/Lc6CyRwBXssyVbASiwUs5k
        cZa8lPUbzF9nCuOGlwlKIQ==
X-Google-Smtp-Source: AAOMgpeRlQXVbhsMn9E5i9J3WqNW5heqfVDVWsv6ctx4X0MCJwqFcUsUaYeVSCTiammXBx0l+N8muw==
X-Received: by 2002:a1c:ed07:: with SMTP id l7-v6mr6287241wmh.139.1530129937060;
        Wed, 27 Jun 2018 13:05:37 -0700 (PDT)
Received: from avx2 (nat4-minsk-pool-46-53-177-92.telecom.by. [46.53.177.92])
        by smtp.gmail.com with ESMTPSA id s16-v6sm1355481wrq.20.2018.06.27.13.05.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 13:05:36 -0700 (PDT)
Date:   Wed, 27 Jun 2018 23:05:34 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, arjan@linux.intel.com
Subject: [PATCH] proc: use macro in /proc/latency hook
Message-ID: <20180627200534.GA18434@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

->latency_record is defined as

	struct latency_record[LT_SAVECOUNT];

so use the same macro whie iterating.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/proc/base.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -463,7 +463,7 @@ static int lstats_show_proc(struct seq_file *m, void *v)
 	if (!task)
 		return -ESRCH;
 	seq_puts(m, "Latency Top version : v0.1\n");
-	for (i = 0; i < 32; i++) {
+	for (i = 0; i < LT_SAVECOUNT; i++) {
 		struct latency_record *lr = &task->latency_record[i];
 		if (lr->backtrace[0]) {
 			int q;
