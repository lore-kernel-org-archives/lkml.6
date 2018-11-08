Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2100C43441
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:39:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87CB320844
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:39:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jJ32CGsB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87CB320844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729343AbeKIHec (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:34:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:51014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728546AbeKIHeb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:34:31 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF309208E3;
        Thu,  8 Nov 2018 21:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714223;
        bh=JS5QgyyG8CNobtv8kOWhBSATESKNUP3oNhHeYpnj61Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jJ32CGsB+4ysACRV8Ghampi+EwNqALBy95Fpcjfh9hsGcdYfo5eOBDGFXg1nZkASP
         lbTlyYI3NcKsq6CygeTVAS53UeGwHNd29BCnJQTDxsukGptiH09/2BbY/i9D0CGBHW
         S15zSUAgW63obR1YzjCH6u1aw01R1zahheCfO0N4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jamal Hadi Salim <jhs@mojatatu.com>,
        Lucas Bates <lucasb@mojatatu.com>,
        Chris Mi <chrism@mellanox.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 103/144] selftests: Introduce a new script to generate tc batch file
Date:   Thu,  8 Nov 2018 13:51:14 -0800
Message-Id: <20181108215105.279116642@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215054.826084593@linuxfoundation.org>
References: <20181108215054.826084593@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

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



