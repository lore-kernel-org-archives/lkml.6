Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BA6CC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:23:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2351F20665
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:23:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Thtd5SWK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2351F20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731187AbeJYWxp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:53:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:36386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731173AbeJYWxp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:53:45 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 87EAE2086D;
        Thu, 25 Oct 2018 14:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540477246;
        bh=ZydLsMenvMivMoVWSLhnkc1EN6ohe7jwsHIUzuCRq4k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Thtd5SWKNhOk1yoRo1gRrGhCGSOnyhBHqYx6AV+UQ4OO3GEBkoqHDZZDvXI1TQTEe
         tdCEFuPjCHBSP7ZMbZzc6y81mAHK/K54dzwVNbhbxpUtPsZy1rwS79I3eFSKx4xF6V
         y+QAnMJp4RSXJq/gnJrHsRZ1D5kOLX97EMOPJtRE=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Chris Mi <chrism@mellanox.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 3.18 74/98] selftests: Introduce a new script to generate tc batch file
Date:   Thu, 25 Oct 2018 10:18:29 -0400
Message-Id: <20181025141853.214051-74-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141853.214051-1-sashal@kernel.org>
References: <20181025141853.214051-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chris Mi <chrism@mellanox.com>

[ Upstream commit 7f071998474a9e5f7b98103d3058a1b8ca5887e6 ]

  # ./tdc_batch.py -h
  usage: tdc_batch.py [-h] [-n NUMBER] [-o] [-s] [-p] device file

  TC batch file generator

  positional arguments:
    device                device name
    file                  batch file name

  optional arguments:
    -h, --help            show this help message and exit
    -n NUMBER, --number NUMBER
                          how many lines in batch file
    -o, --skip_sw         skip_sw (offload), by default skip_hw
    -s, --share_action    all filters share the same action
    -p, --prio            all filters have different prio

Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Acked-by: Lucas Bates <lucasb@mojatatu.com>
Signed-off-by: Chris Mi <chrism@mellanox.com>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../testing/selftests/tc-testing/tdc_batch.py | 62 +++++++++++++++++++
 1 file changed, 62 insertions(+)
 create mode 100755 tools/testing/selftests/tc-testing/tdc_batch.py

diff --git a/tools/testing/selftests/tc-testing/tdc_batch.py b/tools/testing/selftests/tc-testing/tdc_batch.py
new file mode 100755
index 000000000000..707c6bfef689
--- /dev/null
+++ b/tools/testing/selftests/tc-testing/tdc_batch.py
@@ -0,0 +1,62 @@
+#!/usr/bin/python3
+
+"""
+tdc_batch.py - a script to generate TC batch file
+
+Copyright (C) 2017 Chris Mi <chrism@mellanox.com>
+"""
+
+import argparse
+
+parser = argparse.ArgumentParser(description='TC batch file generator')
+parser.add_argument("device", help="device name")
+parser.add_argument("file", help="batch file name")
+parser.add_argument("-n", "--number", type=int,
+                    help="how many lines in batch file")
+parser.add_argument("-o", "--skip_sw",
+                    help="skip_sw (offload), by default skip_hw",
+                    action="store_true")
+parser.add_argument("-s", "--share_action",
+                    help="all filters share the same action",
+                    action="store_true")
+parser.add_argument("-p", "--prio",
+                    help="all filters have different prio",
+                    action="store_true")
+args = parser.parse_args()
+
+device = args.device
+file = open(args.file, 'w')
+
+number = 1
+if args.number:
+    number = args.number
+
+skip = "skip_hw"
+if args.skip_sw:
+    skip = "skip_sw"
+
+share_action = ""
+if args.share_action:
+    share_action = "index 1"
+
+prio = "prio 1"
+if args.prio:
+    prio = ""
+    if number > 0x4000:
+        number = 0x4000
+
+index = 0
+for i in range(0x100):
+    for j in range(0x100):
+        for k in range(0x100):
+            mac = ("%02x:%02x:%02x" % (i, j, k))
+            src_mac = "e4:11:00:" + mac
+            dst_mac = "e4:12:00:" + mac
+            cmd = ("filter add dev %s %s protocol ip parent ffff: flower %s "
+                   "src_mac %s dst_mac %s action drop %s" %
+                   (device, prio, skip, src_mac, dst_mac, share_action))
+            file.write("%s\n" % cmd)
+            index += 1
+            if index >= number:
+                file.close()
+                exit(0)
-- 
2.17.1

