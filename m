Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 875CFECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 01:36:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42D872075C
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 01:36:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kepstin.ca header.i=@kepstin.ca header.b="OSz3283a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42D872075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kepstin.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731655AbeGRCMM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 22:12:12 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:53290 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730652AbeGRCMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 22:12:12 -0400
Received: by mail-it0-f66.google.com with SMTP id 72-v6so1878231itw.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 18:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kepstin.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=j0xFaJbwJ/MHER0BQC5OzaLd9qP1rA6+NEyBochapKU=;
        b=OSz3283aZjwGeD5C9Vkzu6LPVKHsMdiBhz/A4hZYhr4ID22b+BPG3w5aR5EGjbxMPc
         dpzR27Tbc4ayh+1eoG5SM8Nfh20KjKFfka7orHFfb1YeFgR9jRSaAgWwq8G6yEzCGdUU
         kjcSHIdwIdBk7W81i9jf0QW/fFTJG3q9PQve8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=j0xFaJbwJ/MHER0BQC5OzaLd9qP1rA6+NEyBochapKU=;
        b=P5OmTRNKcFFROD2jx+4E2TjflsAe9Xoadb7R3xBhFtuPp111DdVqG3RepOaij4sufo
         kdMAxihMGm6PkSbERkKyhIec6Y3pyjtlKVVTBm7lomcrvYIfeXnJRmr//GrhrHfxtZqT
         Ge6WW3o9/P0AxRmMXtIKsoSLPToJikbwW83xGR/Embe8tQwN3W4JX403uBAbrzSQRUR1
         YLqolaPg9hKNY6+KgFCKNL0GyT7SiAk70jHeTyxm3w46xzK2uiGtofOP/0x5FJPr7aiy
         F+lGrRN00WBlfIkoK65m2FOY/HRBN540GF5irPI8+aW2D3unYLao3TnVBb4D3D0G0vOF
         7l0g==
X-Gm-Message-State: AOUpUlE0SMIkKR0FvDw/ZEA9GUTJXdscRaVDOEEBqwloXPtdv/oRWyLE
        UC1CkSRNsdzasc54EcVf+ljdhH7T+6A=
X-Google-Smtp-Source: AAOMgpdBtpxfGS4qikB0QvnoZ4CtwWuFk8Uux2fK5N46k4lEC9wQtP7bpu+nUdbk5K3weXn1arG0DA==
X-Received: by 2002:a24:ddd3:: with SMTP id t202-v6mr365423itf.91.1531877811077;
        Tue, 17 Jul 2018 18:36:51 -0700 (PDT)
Received: from fuko.kepstin.ca ([2001:470:b3f4::561])
        by smtp.gmail.com with ESMTPSA id p21-v6sm1124251iog.70.2018.07.17.18.36.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jul 2018 18:36:50 -0700 (PDT)
From:   Calvin Walton <calvin.walton@kepstin.ca>
To:     linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <len.brown@intel.com>
Cc:     Calvin Walton <calvin.walton@kepstin.ca>
Subject: [PATCH 1/2] turbostat: Read extended processor family from CPUID
Date:   Tue, 17 Jul 2018 21:36:41 -0400
Message-Id: <20180718013642.10344-2-calvin.walton@kepstin.ca>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180718013642.10344-1-calvin.walton@kepstin.ca>
References: <20180718013642.10344-1-calvin.walton@kepstin.ca>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes the reported family on modern AMD processors (e.g. Ryzen,
which is family 0x17). Previously these processors all showed up as
family 0xf.

See the document
https://support.amd.com/TechDocs/56255_OSRR.pdf
section CPUID_Fn00000001_EAX for how to calculate the family
from the BaseFamily and ExtFamily values.
---
 tools/power/x86/turbostat/turbostat.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index bd9c6b31a504..f404d67fda92 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -4031,7 +4031,9 @@ void process_cpuid()
 	family = (fms >> 8) & 0xf;
 	model = (fms >> 4) & 0xf;
 	stepping = fms & 0xf;
-	if (family == 6 || family == 0xf)
+	if (family == 0xf)
+		family += ((fms >> 20) & 0xff);
+	if (family == 6 || family >= 0xf)
 		model += ((fms >> 16) & 0xf) << 4;
 
 	if (!quiet) {
-- 
2.18.0

