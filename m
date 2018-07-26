Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBF81C67790
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 01:46:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CC4020685
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 01:46:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CC4020685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728746AbeGZDBN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 23:01:13 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:38295 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728693AbeGZDBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 23:01:12 -0400
Received: from mail-qk0-f198.google.com ([209.85.220.198])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <mfo@canonical.com>)
        id 1fiVMd-0005ex-2Q
        for linux-kernel@vger.kernel.org; Thu, 26 Jul 2018 01:46:47 +0000
Received: by mail-qk0-f198.google.com with SMTP id q3-v6so114010qki.4
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 18:46:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IuEOiW/cv6Eng2xVlGMmOOASiU62pe70QuaMljcdVh8=;
        b=p8mvooYl9SgwTHNYkbpsm4lbLuGO+uRNI4eqPLHLl/h25O2PZ08NuhOla5X85PTgDc
         en4cBHHTKnNHiBcoA65OUNOUKc8zW7iwoNMp6eetEzxCIC/lnoiuJZdrBGsCoICpRG+X
         WOeRfTTdnyooy7sAextct2r8azFnG1Ii4P97s2sBr2xZ9ByUYV7aEyEEC9JQDf8yPdr3
         x7rw22XVO1T9sXJXasDP/sdaSr646SKLrjmTiwPi7joQN8MrXaahPMeZ9fSHC5SW43qR
         zQuGXcypzTd7NrsUTRgMigaq5+09gCxQEVTX+5mTDjb67qPu7bUNUaDCW2ngUS9XWvjC
         lxlw==
X-Gm-Message-State: AOUpUlE+NngGTXgweQ5J86OTUjNxP6IZkcA8sQspJv0ooXHtkvlD398A
        MAtu45xfW4B1qYnn+qubpTMsj6/Q2+zewCkKeReMxDDlF6RV94nwFhGVeca3H+klES3f+y6CykG
        0BcU1TEgKZY6UF9qp58QvnezR7zYwa/mpoZfYrNSBbg==
X-Received: by 2002:ac8:3318:: with SMTP id t24-v6mr23012285qta.224.1532569606244;
        Wed, 25 Jul 2018 18:46:46 -0700 (PDT)
X-Google-Smtp-Source: AAOMgpfx+Cr6OYC6xX4Hgu0K+vzQxFDyW2aVo3duP1S3HpbiDldZ9oKb8AiBNynxw6he3v2TxFhueQ==
X-Received: by 2002:ac8:3318:: with SMTP id t24-v6mr23012272qta.224.1532569606101;
        Wed, 25 Jul 2018 18:46:46 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:482:77dd:8111:28ad:fd9c:9a4d])
        by smtp.gmail.com with ESMTPSA id r4-v6sm19619qtm.10.2018.07.25.18.46.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Jul 2018 18:46:45 -0700 (PDT)
From:   Mauricio Faria de Oliveira <mfo@canonical.com>
To:     axboe@kernel.dk
Cc:     phdm@macqel.be, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, daniel.axtens@canonical.com
Subject: [PATCH 1/2] partitions/aix: fix usage of uninitialized lv_info and lvname structures
Date:   Wed, 25 Jul 2018 22:46:28 -0300
Message-Id: <20180726014629.30411-2-mfo@canonical.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180726014629.30411-1-mfo@canonical.com>
References: <20180726014629.30411-1-mfo@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The if-block that sets a successful return value in aix_partition()
uses 'lvip[].pps_per_lv' and 'n[].name' potentially uninitialized.

For example, if 'numlvs' is zero or alloc_lvn() fails, neither is
initialized, but are used anyway if alloc_pvd() succeeds after it.

So, make the alloc_pvd() call conditional on their initialization.

This has been hit when attaching an apparently corrupted/stressed
AIX LUN, misleading the kernel to pr_warn() invalid data and hang.

    [...] partition (null) (11 pp's found) is not contiguous
    [...] partition (null) (2 pp's found) is not contiguous
    [...] partition (null) (3 pp's found) is not contiguous
    [...] partition (null) (64 pp's found) is not contiguous

Fixes: 6ceea22bbbc8 ("partitions: add aix lvm partition support files")
Signed-off-by: Mauricio Faria de Oliveira <mfo@canonical.com>
---
 block/partitions/aix.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/block/partitions/aix.c b/block/partitions/aix.c
index 007f95eea0e1..850cbd1860d4 100644
--- a/block/partitions/aix.c
+++ b/block/partitions/aix.c
@@ -178,7 +178,7 @@ int aix_partition(struct parsed_partitions *state)
 	u32 vgda_sector = 0;
 	u32 vgda_len = 0;
 	int numlvs = 0;
-	struct pvd *pvd;
+	struct pvd *pvd = NULL;
 	struct lv_info {
 		unsigned short pps_per_lv;
 		unsigned short pps_found;
@@ -232,10 +232,11 @@ int aix_partition(struct parsed_partitions *state)
 				if (lvip[i].pps_per_lv)
 					foundlvs += 1;
 			}
+			/* pvd loops depend on n[].name and lvip[].pps_per_lv */
+			pvd = alloc_pvd(state, vgda_sector + 17);
 		}
 		put_dev_sector(sect);
 	}
-	pvd = alloc_pvd(state, vgda_sector + 17);
 	if (pvd) {
 		int numpps = be16_to_cpu(pvd->pp_count);
 		int psn_part1 = be32_to_cpu(pvd->psn_part1);
-- 
2.17.1

