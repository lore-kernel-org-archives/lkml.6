Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCBADC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 06:48:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97CA12172C
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 06:48:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Kk2MuAr2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97CA12172C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729062AbeI1NKd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 09:10:33 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40587 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbeI1NKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 09:10:33 -0400
Received: by mail-pf1-f193.google.com with SMTP id s5-v6so3624633pfj.7
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 23:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7lEK32bpyfZBbvzr+AgaMH3E2lcp0Tdtbfmv5MlM7pE=;
        b=Kk2MuAr2ZxQGAFTckoI4a3OJjqCm/d1ykOA9ozVI2d5mQlhjrcGdC9cRGkw13D3b5+
         luxQvhuNtGsEi3sx4uVzGEz+tkO982AHPYPk2EFmfsZAQmC6Xwqt/4DxGwu7a7IsX9bz
         fTR41f4878GBeepJZeruzkxW8PtyUjdFaHlW8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7lEK32bpyfZBbvzr+AgaMH3E2lcp0Tdtbfmv5MlM7pE=;
        b=NXNRtCdhb01Qoq3ARJ+SdiLA82plJNefxGSqM/OaMronory5oteHmG0NDhd7h8CMbV
         gMhd67vg0UcpdrlkSbU7R1pMTj66E1f2HyZsU2RyR9er3FQHo1pwAjIjPZ1Yx6P0WbJo
         pL+sflvCx+62Z39CjKggfYfostFmFyEmJbzLrODiCRfsgamJSPsDJe6yHgrQL8THrIdR
         22AZGgNrIrH0TbYdplKMWVAotR5QN2BE11okO0RmX3EL84XyU8EvKh4zsI9Lpkxtmq07
         dy8N3SbQ9b2v9XLtSJa4YR9uzHuylfyDi/8rydND57XCKgMmpV8DjgjKbEWJTanv9ouf
         eirQ==
X-Gm-Message-State: ABuFfogL7iQ5O35FADO77IvdsF+w0qcuQoOK4mKTbNSDMtzfSoFg1efn
        KmvRWU9SR/pzsVgGnXjJSuUhng==
X-Google-Smtp-Source: ACcGV60sTkh7k8gMS6cAMiFFQ89lfpIQtHaRo1p9d7THHcKbHldE5LM41g64aklBZ3NQ4VGGQtkkpQ==
X-Received: by 2002:a17:902:9045:: with SMTP id w5-v6mr14943273plz.10.1538117298309;
        Thu, 27 Sep 2018 23:48:18 -0700 (PDT)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id h12-v6sm5847448pfo.135.2018.09.27.23.48.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 23:48:17 -0700 (PDT)
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     catalin.marinas@arm.com, will.deacon@arm.com, dhowells@redhat.com,
        vgoyal@redhat.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, dyoung@redhat.com, bhe@redhat.com,
        arnd@arndb.de, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
Cc:     prudo@linux.ibm.com, ard.biesheuvel@linaro.org,
        james.morse@arm.com, bhsharma@redhat.com,
        kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v15 05/16] kexec_file: kexec_walk_memblock() only walks a dedicated region at kdump
Date:   Fri, 28 Sep 2018 15:48:30 +0900
Message-Id: <20180928064841.14117-6-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180928064841.14117-1-takahiro.akashi@linaro.org>
References: <20180928064841.14117-1-takahiro.akashi@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In kdump case, there exists only one dedicated memblock region as usable
memory (crashk_res). With this patch, kexec_walk_memblock() runs a given
callback function on this region.

Cosmetic change: 0 to MEMBLOCK_NONE at for_each_free_mem_range*()

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: Dave Young <dyoung@redhat.com>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: Baoquan He <bhe@redhat.com>
---
 kernel/kexec_file.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 370d7eab49fe..2f615a7968dd 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -511,8 +511,11 @@ static int kexec_walk_memblock(struct kexec_buf *kbuf,
 	phys_addr_t mstart, mend;
 	struct resource res = { };
 
+	if (kbuf->image->type == KEXEC_TYPE_CRASH)
+		return func(&crashk_res, kbuf);
+
 	if (kbuf->top_down) {
-		for_each_free_mem_range_reverse(i, NUMA_NO_NODE, 0,
+		for_each_free_mem_range_reverse(i, NUMA_NO_NODE, MEMBLOCK_NONE,
 						&mstart, &mend, NULL) {
 			/*
 			 * In memblock, end points to the first byte after the
@@ -526,8 +529,8 @@ static int kexec_walk_memblock(struct kexec_buf *kbuf,
 				break;
 		}
 	} else {
-		for_each_free_mem_range(i, NUMA_NO_NODE, 0, &mstart, &mend,
-					NULL) {
+		for_each_free_mem_range(i, NUMA_NO_NODE, MEMBLOCK_NONE,
+					&mstart, &mend, NULL) {
 			/*
 			 * In memblock, end points to the first byte after the
 			 * range while in kexec, end points to the last byte
-- 
2.19.0

