Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D281C6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 11:55:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1DFD23FBA
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 11:55:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bVOrnvE1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1DFD23FBA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932642AbeGFLzT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 07:55:19 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36743 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932502AbeGFLzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 07:55:17 -0400
Received: by mail-lj1-f193.google.com with SMTP id u7-v6so6337131lji.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 04:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yFgmhAEN5T/kQI4KTP/dupJRtjZaMlk6K4+2n/Xul40=;
        b=bVOrnvE1A26wmxZRKEHpyGssi6W7NgTAR5cJbS0rIYqCig9ymhK9kkJ19wwuYPkGsR
         9aBnEoTg8B8EvRgy6u/RvEEsBeks5w7zlNx/GVebaRpl8ZODdFgl1wRSu9Q5KYaIdLlJ
         QkXoSBdNf6r/9ouIxSMYxepVcW6u53RjPG/6I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yFgmhAEN5T/kQI4KTP/dupJRtjZaMlk6K4+2n/Xul40=;
        b=tT7khL3f1XEj7US858pHILONmW9Dx9ATKh0W8cjR6qKu4qjCDIaYk/N/8hvx74ImAC
         DOGCQ/3380q1kghaSzmv+BLo51i1U9HUyC+gwn54Q3ijDimbaV36cy51+I/RsBPsgEdL
         QJQm6and2LTEEMDMSdPzoIzkFyxcZFHMkDKgBaE7dzr8JRdn/wKuAmy31uNMB338WK6t
         o83O+7VHoTP88HQ3j/nGpMiYBNQnuO/6/ACMf3Sr+i5uX3nvUpHQqohsDz9SfFOfwXjL
         S3xuUHrKw0zOKk/Ceks5NMt641ogMxpT7fmuWBRtj8C4oyvRXVbDBhyKGk7Ttf1/8rzt
         6SEA==
X-Gm-Message-State: APt69E1+d2YoQ4H+SKBXhq1YFu43+b2qOjlv+Ra9Ju/25uSokppTs2Fy
        83s0aIxtUzPpZAA94zFPYmD6gg==
X-Google-Smtp-Source: AAOMgpfDxwRepiLJEloAqs8t+a1uOOyvT5kAryhvRueIbPi+fLM99lfrc5wpe4cuLbXPGfAyB0XRkw==
X-Received: by 2002:a2e:80d3:: with SMTP id r19-v6mr4209593ljg.85.1530878115666;
        Fri, 06 Jul 2018 04:55:15 -0700 (PDT)
Received: from localhost (c-2c3d70d5.07-21-73746f28.bbcust.telenor.se. [213.112.61.44])
        by smtp.gmail.com with ESMTPSA id a5-v6sm2070973lfb.37.2018.07.06.04.55.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Jul 2018 04:55:15 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     viro@zeniv.linux.org.uk, willy@infradead.org,
        ross.zwisler@linux.intel.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] fs/dax: remove unused function
Date:   Fri,  6 Jul 2018 13:54:58 +0200
Message-Id: <20180706115458.7792-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180629173055.GA2973@linux.intel.com>
References: <20180629173055.GA2973@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_FS_DAX is enabled we get this warning:
fs/dax.c:106:14: warning: ‘dax_make_page_entry’ defined but not used
   [-Wunused-function]
 static void *dax_make_page_entry(struct page *page, void *entry)
              ^~~~~~~~~~~~~~~~~~~
Remove the unused function.

Fixes: 9bfcbe5ef12f ("dax: Convert dax_lock_page to XArray")
Reported-by: Ross Zwisler <ross.zwisler@linux.intel.com>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 fs/dax.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index fcf1332dcb0a..6e6cae1db520 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -103,12 +103,6 @@ static void *dax_make_entry(pfn_t pfn, unsigned long flags)
 	return xa_mk_value(flags | (pfn_t_to_pfn(pfn) << DAX_SHIFT));
 }
 
-static void *dax_make_page_entry(struct page *page, void *entry)
-{
-	pfn_t pfn = page_to_pfn_t(page);
-	return dax_make_entry(pfn, dax_is_pmd_entry(entry));
-}
-
 static bool dax_is_locked(void *entry)
 {
 	return xa_to_value(entry) & DAX_LOCKED;
-- 
2.18.0

