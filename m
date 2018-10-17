Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4127CECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 13:40:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F25F12150F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 13:40:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VRLLyrMS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F25F12150F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727401AbeJQVgl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 17:36:41 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35477 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726727AbeJQVgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 17:36:41 -0400
Received: by mail-pg1-f196.google.com with SMTP id 32-v6so1383060pgu.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 06:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=+HPXULssA1ETXhgVOaq0s/IubK54frOSNrsZ6GVnq2A=;
        b=VRLLyrMSQgGZvfej1UT9pzfFgcD68zGsohjfYRj6V1AdWrnoSq91PVyB40Ko6H7Xo6
         wKMczcpzSTymMoFtd9ffa8E/Y1C7OyKWFiSBLZ+zheIYhBe8Bkcg57mpEWfXp6D6Jpe7
         xWH02HUbbKp4EtusdOw2by4mFJMzUZDCFGFHp2EsbLKiB+kkaRO8eDwAj9z2Jfv61rV+
         /ADKnGVl/27f3IRxVkzxCGfH+fqVFV/0QCH8vzZtxtg//9nOlLqxhWJOQ7t2EWIZE//A
         fcsI3LytQT3QPO7oPcJR8yCk0KzPEMwqW2s7qzy8eRkCEdS5682hQeT+qsVfQ1sSDNtZ
         Xdkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+HPXULssA1ETXhgVOaq0s/IubK54frOSNrsZ6GVnq2A=;
        b=nYgp+y9nNmLZqiHyLIolb34KeRMM6Z2uWv3BL6X0opxPqf2Vu2uMCOG/6fe0YfZTYF
         t8lfSnMN6IKZCqg0g43xL5I0B+Pp3OdDM2wccle4RsjnPGV0fjYCRdor9rP+lN/g5k0+
         dkIyUb5Hm8JzBiqLcIvBNbbMtLzmnF2xzeCgchvl7ZJOjuExv0itZ4Zw9LQFlAyk4nMF
         rZWmuDpKfJTZbxrOQqlesM7Hl4+g0jyWt7g42ydV1ApYA5BQgF6vtju0KKvMil+nTrsY
         06VwR29JS6UAsyKFdVItkVn8tVOjf2aYVXDx75ZqylxQfDWXhPPoM4TRgtA06PsMMboL
         P2nA==
X-Gm-Message-State: ABuFfogTvMiKTjuiGsKKA5ktEP41RT8uOVa+1nsIrUZsfbZdHwp89Eji
        h8pmjz/e2ev09FI323SFlu0=
X-Google-Smtp-Source: ACcGV62iCtnOEnghBE5ZztdYslKNFIrQl3dNINno9Vn82U9tTaYCjci9e69JcWKp14jDc4nxqv81Lw==
X-Received: by 2002:a62:384c:: with SMTP id f73-v6mr26533406pfa.242.1539783655883;
        Wed, 17 Oct 2018 06:40:55 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:6001:4ff6:5400:1ff:feb7:a195])
        by smtp.gmail.com with ESMTPSA id 187-v6sm27236216pfu.129.2018.10.17.06.40.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Oct 2018 06:40:55 -0700 (PDT)
From:   Du Changbin <changbin.du@gmail.com>
To:     jan.kiszka@siemens.com, kbingham@kernel.org
Cc:     linux-kernel@vger.kernel.org, Du Changbin <changbin.du@gmail.com>
Subject: [PATCH v2] scripts/gdb: fix lx-version for gdb 7.3-
Date:   Wed, 17 Oct 2018 13:40:51 +0000
Message-Id: <20181017134051.3934-1-changbin.du@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For gdb version less than 7.3, lx-version only prints one character.
(gdb) lx-version
L(gdb)

This can be fixed by casting 'linux_banner' as (char *).
(gdb) lx-version
Linux version 4.19.0-rc1+ (changbin@acer) (gcc version 7.3.0 (Ubuntu 7.3.0-16ubuntu3)) #21 SMP Sat Sep 1 21:43:30 CST 2018

gdb 7.4 seems to be no such issue.

Signed-off-by: Du Changbin <changbin.du@gmail.com>
---
 scripts/gdb/linux/proc.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/gdb/linux/proc.py b/scripts/gdb/linux/proc.py
index 086d27223c0c..0aebd7565b03 100644
--- a/scripts/gdb/linux/proc.py
+++ b/scripts/gdb/linux/proc.py
@@ -41,7 +41,7 @@ class LxVersion(gdb.Command):
 
     def invoke(self, arg, from_tty):
         # linux_banner should contain a newline
-        gdb.write(gdb.parse_and_eval("linux_banner").string())
+        gdb.write(gdb.parse_and_eval("(char *)linux_banner").string())
 
 LxVersion()
 
-- 
2.17.1

