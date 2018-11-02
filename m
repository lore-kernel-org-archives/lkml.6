Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D72BC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 19:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E2D420831
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 19:10:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="Jw14A603"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E2D420831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=android.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728703AbeKCETR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 00:19:17 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36427 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728332AbeKCETQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 00:19:16 -0400
Received: by mail-pg1-f193.google.com with SMTP id z17-v6so1382605pgv.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 12:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=k4pvQxbFZYb3iNXjmM+O1DlOw4HWMl6dcpFYLa32pvM=;
        b=Jw14A603Ee/r0QV5vxDQWv+bRhxoQFzuM7WrTDq+4uYPwk8VXFjMOeqvD+olvokseS
         c919bZugJxDVClSfLXPoR9WcZWdLBUV29gU9L87PuKmz51DWVvbvJpRRAvOujONraPr4
         9BGvwFtVq1df5UlDE70lXgS7avhng2fEMIoCbs9JjpdaPjdrDeZdyDgXDx2HvPGjZzrC
         +NsAQ0n6gCqvxQtTD8S8Jemwm6x06HQ72QdPWoa/KrTw+uj1wKfmkeJgQQ/3e9ne0gdw
         EwyKrwBGpcusStpXniPHqm1JOSGy1MmqF9sTJ0pp2s7SbKEjrynJ1cQK8yxl0Qc5qxLg
         id8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=k4pvQxbFZYb3iNXjmM+O1DlOw4HWMl6dcpFYLa32pvM=;
        b=t82Kbg2uA2aTlwNJYtpvBArVYruxgDGJbs6yHU2HJaj0pdtc1PsQOnYdNA2OuqFYC3
         cI6siHTgQBTyK3bt918HNKDH80bhGIJhsPFvYfyGuS22DEDDKOvn36868ze4sS/LyaOH
         mwALh/hERXRPjkUWQaiE51FY6RZaP1fL5B4KUSUmiGv9r4zuDZOIpyhgpGmx7SAWR7cc
         sqQCeRrC5sasNmW/Oy7Go/HJhNSABCUoWI9uTggg5/cU+0qgG62Taz6yU2cGhn7nJMHk
         n9MHy0hyQSGbBeAc2/jgRi/dtLBN9pAy1wvo8s4Lx632FCRnrpi61ncssxYB80iyTDko
         gRJQ==
X-Gm-Message-State: AGRZ1gJkJpFFg0DYv8M6gP5fVwiTHkxYqQ1IecsbIjf0N+zYL0QhF7qD
        Y6x2+p4YlvfJSLPHrGPntRD0l10Qog0=
X-Google-Smtp-Source: AJdET5cc1qtwzTF/0+BB0Gul57NIs0rmZI7qYKufZt26W5tKko/yOEL+TgthH5tKEvpEM9AeHS/KVg==
X-Received: by 2002:a63:d70e:: with SMTP id d14mr9287383pgg.159.1541185855500;
        Fri, 02 Nov 2018 12:10:55 -0700 (PDT)
Received: from nebulus.mtv.corp.google.com ([2620:0:1000:1612:b4fb:6752:f21f:3502])
        by smtp.gmail.com with ESMTPSA id q123-v6sm98718810pfq.169.2018.11.02.12.10.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Nov 2018 12:10:54 -0700 (PDT)
From:   Mark Salyzyn <salyzyn@android.com>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Salyzyn <salyzyn@android.com>, stable@vger.kernel.org
Subject: /proc/iomem: only expose physical resource addresses to privileged users
Date:   Fri,  2 Nov 2018 12:08:59 -0700
Message-Id: <20181102191028.226989-1-salyzyn@android.com>
X-Mailer: git-send-email 2.19.1.930.g4563a0d9d0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linus Torvalds <torvalds@linux-foundation.org>

commit 51d7b120418e99d6b3bf8df9eb3cc31e8171dee4 upstream ported to
3.18.y

In commit c4004b02f8e5b ("x86: remove the kernel code/data/bss resources
from /proc/iomem") I was hoping to remove the phyiscal kernel address
data from /proc/iomem entirely, but that had to be reverted because some
system programs actually use it.

This limits all the detailed resource information to properly
credentialed users instead.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Mark Salyzyn <salyzyn@android.com>
Cc: linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org # 3.18
---
 kernel/resource.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/kernel/resource.c b/kernel/resource.c
index d9c7d5d77c8a..83658ca0e69c 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -104,16 +104,25 @@ static int r_show(struct seq_file *m, void *v)
 {
 	struct resource *root = m->private;
 	struct resource *r = v, *p;
+	unsigned long long start, end;
 	int width = root->end < 0x10000 ? 4 : 8;
 	int depth;
 
 	for (depth = 0, p = r; depth < MAX_IORES_LEVEL; depth++, p = p->parent)
 		if (p->parent == root)
 			break;
+
+	if (file_ns_capable(m->file, &init_user_ns, CAP_SYS_ADMIN)) {
+		start = r->start;
+		end = r->end;
+	} else {
+		start = end = 0;
+	}
+
 	seq_printf(m, "%*s%0*llx-%0*llx : %s\n",
 			depth * 2, "",
-			width, (unsigned long long) r->start,
-			width, (unsigned long long) r->end,
+			width, start,
+			width, end,
 			r->name ? r->name : "<BAD>");
 	return 0;
 }
-- 
2.19.1.930.g4563a0d9d0-goog

