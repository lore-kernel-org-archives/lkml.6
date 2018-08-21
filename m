Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29472C04E83
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 21:23:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF5F321884
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 21:23:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vNwaRIts"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF5F321884
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbeHVApI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 20:45:08 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:35615 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbeHVApH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 20:45:07 -0400
Received: by mail-qt0-f194.google.com with SMTP id r21-v6so22038873qtm.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 14:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pAwyQEaHEwmDYTVF+IAr3GO6/Dh3nqid5fovpvm0XnY=;
        b=vNwaRItsvjroyNq3EKFmk8Ejg479/0EAHr0Zyn4wlN7PX+WFIuQzmEcr3crEJVTmlY
         BQLIenupERWEK0jA8lXUrK0RSDlpaCuxwX19BnwD4MRyxF+2Jiv8cj0/IV7kQmVrnTFJ
         1X6GUUdbmnQoiywkn0xxFVsKnO3vtCgcLLHDXlZH8FlE3PknSuwvzGfSvLgHxyVGxyzg
         7iO8mXHJK2ffbZaFbdAkxeYMeo6u0RIVtGzJr+G4mCGyAhaZn9xIHekj9HqMMPGdLeOl
         +iTsjMw6Mw295bOqtoCMDONKAo0rn3hJar8KmeKJGC/6O/6dqsf70wQtopvnIaKYCNIa
         9CTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pAwyQEaHEwmDYTVF+IAr3GO6/Dh3nqid5fovpvm0XnY=;
        b=SVM0a/Rkl1/f0N2M7zOPyffL4DQO6N2si60bLKzQl2aRpXhvAXmcs1W3QbAt8/HoXi
         OHOyN0Z5IO4FRVk0rAyKGp3mbtt71L6FytQnG2YWfTIxAYZvKIpe1065yefknBXROAAF
         fcfz7xgTj/VmluJ6eH5vScTmbXXEsoX0c1dayfL0izzNrAK5UmU9ZJvdGccd4OflHhXJ
         nectXE/VE9T+73OI2NAregMxCaAmhIqOE6H67dPm4Dsa+fRoFDVKVZiZ4YilgpxAyjsQ
         Swy1iL+Sb3PY64QHBcP+ETYWWfxFH3XoRZBGO0qtN1i7c8Eef8PghV21U0s674SsHaNn
         vhPQ==
X-Gm-Message-State: AOUpUlHGeyuuwKe4pxYn0Ide7SSGrY13G5S6dLiyu/uF6v+PWlRDEcWK
        7QVNOCWCoJa0np+9Akhzwg==
X-Google-Smtp-Source: ANB0VdYvg6/FBf+KUycVlREX1QYb7P2E5/IzXKT7qWGvbX3BK6h3j1OK9Q58Lzd9wxktsYlnY2u4gA==
X-Received: by 2002:ac8:2e2b:: with SMTP id r40-v6mr19109409qta.12.1534886597870;
        Tue, 21 Aug 2018 14:23:17 -0700 (PDT)
Received: from gabell.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id q6-v6sm2148525qtq.44.2018.08.21.14.23.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Aug 2018 14:23:17 -0700 (PDT)
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Baoquan He <bhe@redhat.com>
Cc:     Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] docs: kernel-parameters.txt: document rand_mem_physical_padding parameter
Date:   Tue, 21 Aug 2018 17:23:05 -0400
Message-Id: <20180821212305.20214-2-msys.mizuma@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180821212305.20214-1-msys.mizuma@gmail.com>
References: <20180821212305.20214-1-msys.mizuma@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>

This kernel parameter allows to change the padding used for the physical
memory mapping section when KASLR memory is enabled.

For some systems, the default value, CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING,
is not enough. The option is useful to adjust the padding size to work
around such issue.

Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 0c883029881a..97f54c910c9c 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3477,6 +3477,13 @@
 	ramdisk_size=	[RAM] Sizes of RAM disks in kilobytes
 			See Documentation/blockdev/ramdisk.txt.
 
+	rand_mem_physical_padding=
+			[KNL] Define the padding size in terabytes
+			used for the physical memory mapping section
+			when KASLR memory is enabled.
+			The default value is
+			CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING.
+
 	ras=option[,option,...]	[KNL] RAS-specific options
 
 		cec_disable	[X86]
-- 
2.18.0

