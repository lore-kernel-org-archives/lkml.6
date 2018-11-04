Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82C35C32789
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 12:45:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3070920685
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 12:45:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NVprx+qL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3070920685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729813AbeKDWAK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 17:00:10 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42773 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729232AbeKDWAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 17:00:10 -0500
Received: by mail-pf1-f195.google.com with SMTP id f26-v6so3087938pfn.9
        for <linux-kernel@vger.kernel.org>; Sun, 04 Nov 2018 04:45:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=bIm8zLb4s7u1F5PBDoMxVkZnvfUC6HnYnH6nJeMIfT8=;
        b=NVprx+qLLJlRaUTyXdzvHY6+plxXZ01KXfBOuPV+cXeTwiOTb/4js6gNPyOpAtO3Rd
         cPv2dolDGSwTKnu/i0L/SpH19cu0b5DMZ9aK0IDFFpOSzwjgzfLw2UZCpCX69bfRKNDr
         WrtEVM7siWvv7UmtgX/CRgeRNp+K9PL//FyuKLxQYKXkm5IJhx9P1K3s/CSwzSATUjT8
         TJyoChm7HB/npNdhLNrRFg3OGbZ+hrRYHurRIA87qrZvxf+bBEFDWxIhuN/Svu3Alg17
         6upt23lb7jh9fUgzmJH7+mhn1B7fhXM+SS4IxtvNsjo/O1gnWplEKHg9Ctf98SaZQcnT
         v1cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=bIm8zLb4s7u1F5PBDoMxVkZnvfUC6HnYnH6nJeMIfT8=;
        b=aAYl8z9HKkq2NKcef1G4l3SDKaOgbyUsmB/gjJN/7X1C2mcJ2CxpE4Tei/nXfkv+hz
         8Jsjxskz+jX7EtrZAa5uy5XVdaBLzo53oouV1UrjKzXDYqa/swjOq+o3+FyPRB38+NZX
         1HbV+n+HQDkGLWWEsRfgTVTHfkZRUi3Fp/hkXwb98GPRT/sFhwq6IvUkWsAbtUIMceJ3
         3NIAejNGswptuCkRNkqlgU3N538/mC+zmJ558IbKs0l5wlPxpb2cpabSbk1xvoQjO2Hs
         A5RYoO6k4pVKZr+f+Skuogcsux4231ry5RcUmBeIkiQ+QZy0nX2o9Ebb0ZJNNtRZw+pp
         +uxQ==
X-Gm-Message-State: AGRZ1gJyeHIHWw4T+Goq468Lt6bR1MP9P7tCfPkqNEt/z9avkKLhl8iH
        W58GWXS3/il/aJEjtKvTGgc=
X-Google-Smtp-Source: AJdET5cz3ORAB57b8YsBFFNY88eubj0WiRR5p3daV4nT/q+oOwns+eHuHzqi5vdhRt0uAgjGMMpcjA==
X-Received: by 2002:a62:2ec3:: with SMTP id u186-v6mr18396348pfu.189.1541335516786;
        Sun, 04 Nov 2018 04:45:16 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id i6-v6sm42047883pfb.135.2018.11.04.04.45.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 04 Nov 2018 04:45:15 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     akpm@linux-foundation.org, mhocko@suse.com,
        kirill.shutemov@linux.intel.com, vbabka@suse.cz,
        yang.shi@linux.alibaba.com, rientjes@google.com,
        linux@dominikbrodowski.net
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] mm: mmap: remove unnecessary unlikely()
Date:   Sun,  4 Nov 2018 07:44:56 -0500
Message-Id: <20181104124456.3424-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WARN_ON() already contains an unlikely(), so it's not necessary to use
unlikely.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 mm/mmap.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 6c04292e16a7..2077008ade0c 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2965,10 +2965,8 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long, start, unsigned long, size,
 static inline void verify_mm_writelocked(struct mm_struct *mm)
 {
 #ifdef CONFIG_DEBUG_VM
-	if (unlikely(down_read_trylock(&mm->mmap_sem))) {
-		WARN_ON(1);
+	if (WARN_ON(down_read_trylock(&mm->mmap_sem)))
 		up_read(&mm->mmap_sem);
-	}
 #endif
 }
 
-- 
2.17.0

