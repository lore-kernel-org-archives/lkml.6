Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3076C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 01:46:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BFDB20852
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 01:46:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BFDB20852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728789AbeGZDBP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 23:01:15 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:38301 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728716AbeGZDBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 23:01:14 -0400
Received: from mail-qk0-f200.google.com ([209.85.220.200])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <mfo@canonical.com>)
        id 1fiVMf-0005fH-6i
        for linux-kernel@vger.kernel.org; Thu, 26 Jul 2018 01:46:49 +0000
Received: by mail-qk0-f200.google.com with SMTP id w126-v6so104814qka.11
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 18:46:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=azGIAqjhubvPhiTxDMeOWSUNh8NUi3e8ryLgN8ahl9w=;
        b=ERy8XdnmglYL7uXC02scfmhtnO9LnVlS7wOErr+tpp9ajoXmseUYuMbGIBokJpifWI
         OVhrmPwA1k+JNMUExoZAFimKixxbB3Lrgtu+TqRTukdFoTb1gF//c1P0sw5bZSJA5L0v
         N/Em06PCuJ2aumSmGJyHoDHpDZJl5g3wfhNDq/r+r8HgAZFYmCD245DdTzNPgdYi4nzz
         wFX8gbr0qGo/d9AuS3WEtTaI7HvmCCQ2wu6IvuJmbI8In6bYibYq3WXm9bRRrD2rpO/T
         ehDG1h7NPRMKOQ6CrJcog9+7R6BJvXbi1ic9sASn8TEVqEFaBRa25fQ5jUoVH+YGmRgj
         czcQ==
X-Gm-Message-State: AOUpUlGeB0/NEdvuIJ4EJH734gkjx0KsWQmmsYIaXTm4ifi3q4SI3XP0
        N5jd2169LztZzGxSAvkWfRPupqKB1uwuEDKVpn4h5i9Sv9POvGvZZA4Y+ZT67AG6hsmIJZVkIvq
        qAY5BV1CvOp5VSrDXqCvBqlVjtNC+d6WZx+Ez7sxHHQ==
X-Received: by 2002:a37:6a82:: with SMTP id f124-v6mr21434410qkc.296.1532569608417;
        Wed, 25 Jul 2018 18:46:48 -0700 (PDT)
X-Google-Smtp-Source: AAOMgpcaaDNGU5Wh0qrW2GcuQ/dhhaPZP7JNKqlslNR/AB17iX1Y4f7BSTxTyw5qC+P3Hd+jKbH9nA==
X-Received: by 2002:a37:6a82:: with SMTP id f124-v6mr21434399qkc.296.1532569608260;
        Wed, 25 Jul 2018 18:46:48 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:482:77dd:8111:28ad:fd9c:9a4d])
        by smtp.gmail.com with ESMTPSA id r4-v6sm19619qtm.10.2018.07.25.18.46.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Jul 2018 18:46:47 -0700 (PDT)
From:   Mauricio Faria de Oliveira <mfo@canonical.com>
To:     axboe@kernel.dk
Cc:     phdm@macqel.be, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, daniel.axtens@canonical.com
Subject: [PATCH 2/2] partitions/aix: append null character to print data from disk
Date:   Wed, 25 Jul 2018 22:46:29 -0300
Message-Id: <20180726014629.30411-3-mfo@canonical.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180726014629.30411-1-mfo@canonical.com>
References: <20180726014629.30411-1-mfo@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Even if properly initialized, the lvname array (i.e., strings)
is read from disk, and might contain corrupt data (e.g., lack
the null terminating character for strings).

So, make sure the partition name string used in pr_warn() has
the null terminating character.

Fixes: 6ceea22bbbc8 ("partitions: add aix lvm partition support files")
Suggested-by: Daniel J. Axtens <daniel.axtens@canonical.com>
Signed-off-by: Mauricio Faria de Oliveira <mfo@canonical.com>
---
 block/partitions/aix.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/block/partitions/aix.c b/block/partitions/aix.c
index 850cbd1860d4..903f3ed175d0 100644
--- a/block/partitions/aix.c
+++ b/block/partitions/aix.c
@@ -283,10 +283,14 @@ int aix_partition(struct parsed_partitions *state)
 				next_lp_ix += 1;
 		}
 		for (i = 0; i < state->limit; i += 1)
-			if (lvip[i].pps_found && !lvip[i].lv_is_contiguous)
+			if (lvip[i].pps_found && !lvip[i].lv_is_contiguous) {
+				char tmp[sizeof(n[i].name) + 1]; // null char
+
+				snprintf(tmp, sizeof(tmp), "%s", n[i].name);
 				pr_warn("partition %s (%u pp's found) is "
 					"not contiguous\n",
-					n[i].name, lvip[i].pps_found);
+					tmp, lvip[i].pps_found);
+			}
 		kfree(pvd);
 	}
 	kfree(n);
-- 
2.17.1

