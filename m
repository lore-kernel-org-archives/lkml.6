Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A55D6C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 08:00:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E0FD20841
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 08:00:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Dv6Ao5gb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E0FD20841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387987AbeHAJog (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 05:44:36 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36736 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387647AbeHAJof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 05:44:35 -0400
Received: by mail-pf1-f195.google.com with SMTP id b11-v6so2254075pfo.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 01:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=H9V/pRhzf1RnH7rtjNBLRuYtR4l5xIhl8He5yhS2iQg=;
        b=Dv6Ao5gbCEtv75PDFcno/cC/X0jP0Kp+YSXjdpVy2ycLWc28q9h03Q+dW3/n3iDhi0
         WzYC/SbZjSVaYgsCyAp3rEq3HxWR1dl8CJD6iLTGOYG1WdBTT3Y1Sw3PQJGYMbFDj1va
         4y0hNmbkjjjgQt24IaFB+VzuDY/MYvhdnsC4o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=H9V/pRhzf1RnH7rtjNBLRuYtR4l5xIhl8He5yhS2iQg=;
        b=bjH1dnQLVAHtZyHNYpB/CX/rdaTGnosfcjDdw0I0y/ABoTyQYIhXZEANyXa0izMphe
         QRFUcOuPclX/RcM7Do/3k+0FSUDF85PeT90YLYWFAMl6iMow17dPLk/jfAg26RRMq0A1
         wHqAfW02/YOeACGsOVzN1zvkZ0ocvQlecyEvSZdPRFMHVr1KCSeaAwb6ZNlEGRnJZpln
         j+7UmyvDAl1TRlGqkfZQpjgIjT/1KzQm7emS9BKplBN5ElmXyMXP2GxfJZ4gqUmOhQkD
         NwWfnEaj58DHvsHxgHwBzCYQrU1fCo94NKvavdiwgcV2BJwQKUKI/Qig0KPqu9+Mz+Z5
         M07g==
X-Gm-Message-State: AOUpUlE4Oopg86iY9Hgr8lkYW3M0IVobox2vo/QQlKWjNbYVs3CUWS9L
        D3ftbEgoKxtnWfNo+pYBBaN68g==
X-Google-Smtp-Source: AAOMgpd77a85zHpHjYF49EVfk4NZft8mM871fKOIxngiuOlnjLs07tPx8w70cZs9VRa0wjVguKXQ8A==
X-Received: by 2002:a65:6398:: with SMTP id h24-v6mr23529895pgv.245.1533110409558;
        Wed, 01 Aug 2018 01:00:09 -0700 (PDT)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id h130-v6sm34714091pgc.88.2018.08.01.01.00.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Aug 2018 01:00:09 -0700 (PDT)
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
Subject: [PATCH v13 05/16] kexec_file: kexec_walk_memblock() only walks a dedicated region at kdump
Date:   Wed,  1 Aug 2018 16:58:09 +0900
Message-Id: <20180801075820.3753-6-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801075820.3753-1-takahiro.akashi@linaro.org>
References: <20180801075820.3753-1-takahiro.akashi@linaro.org>
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
index 1073ef56a95d..370d7d8ff27f 100644
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
2.18.0

