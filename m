Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0F6EC43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 18:55:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DA6A24788
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 18:55:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VAYdZSn1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DA6A24788
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934345AbeFVSzs (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 14:55:48 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:39567 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934096AbeFVSzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 14:55:46 -0400
Received: by mail-pg0-f66.google.com with SMTP id w12-v6so3344139pgc.6;
        Fri, 22 Jun 2018 11:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=mwS8CJyZeke6ueAm4WhBxu/Zk4s5vmR018Z8mY4mHOs=;
        b=VAYdZSn125zXZE3tkcqOFmfO1Pk7BTMGYRCatlqYSgr4eUs4vn68l1wB89xusC4lbx
         l6gEa5XW3CWT+c0RqYez7cErRaCI1JutgWptlvDO4zsyBRDGRW62GcNUt4Nu9NXrguZ7
         rYdclYvgcGDpaFGCHgskNJ5yQ7CXuLSi4dM/cBXBWhjiqS+Kqmk/mkW55RLc0QuYHHAJ
         h0st/CiYKUctWlSTt+UWf+awdRVGYb5mqNiEcAzk/cgH18baaCN2bJKEnlPbf59vKurZ
         eztleO3MmgtiQEU3rvIbuCBdAC0GbGtblEijhQd8BgvreHD/roNvVpN8AakvFjdH7zHN
         lJbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=mwS8CJyZeke6ueAm4WhBxu/Zk4s5vmR018Z8mY4mHOs=;
        b=RUjP2/0oBilv03EtXRf6J9DO/T5mnbwS7184uXpYC65JCi20yhi0UZzDYGaF6cOJ3U
         2LI7MaOv1Bje+515gPYpHwswWWFcIEeEIHyYOI0C/KWR4/qk/QxJNAVyjDWYyv70VZcT
         /b8l2PVsHJgxBt7/4dbPjGQxXL49WdA6289jvwwsQjfBfRIHFjgyP/wvfgbvgbx3b9Hz
         T7rRPbGaupHF0L0WnfEeAn1JhfbmtWqEpWbnhsd55P1NrHoELRJja0dANZ0CwvwL0nm6
         SzFtwFOC8HFH7kNkVZ7Pv6YoJKJCgtPc3tkQdJbATGQn+4V7IH0G78BrKOoPM9WQtPdv
         Y8Fg==
X-Gm-Message-State: APt69E175ge3AKdHZ6PgxzUSqdp6GCEn9Oe9cS8yA5kjZUdZdKW98IYy
        4W0yjtuKYbbpwcR3ZnHCLVTuNWdp
X-Google-Smtp-Source: ADUXVKIzMD5BMJdxyKkprY85KagW6G3fcxT9/LCj47rBLmmcb1Oa0oYvJ9UZIZWRkFVMaAyP2hHaFw==
X-Received: by 2002:a62:a30e:: with SMTP id s14-v6mr3027828pfe.168.1529693745531;
        Fri, 22 Jun 2018 11:55:45 -0700 (PDT)
Received: from localhost.localdomain ([122.174.152.149])
        by smtp.gmail.com with ESMTPSA id p73-v6sm22061389pfa.142.2018.06.22.11.55.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Jun 2018 11:55:45 -0700 (PDT)
From:   Jeffrin Jose T <ahiliation@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, shuah@kernel.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Jeffrin Jose T <ahiliation@gmail.com>
Subject: [PATCH] selftests: bpf: notification about privilege required to run test_lirc_mode2.sh testing script
Date:   Sat, 23 Jun 2018 00:24:17 +0530
Message-Id: <20180622185417.3452-1-ahiliation@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The test_lirc_mode2.sh script require root privilege for the successful
execution of the test.

This patch is to notify the user about the privilege the script
demands for the successful execution of the test.

Signed-off-by: Jeffrin Jose T (Rajagiri SET) <ahiliation@gmail.com>
---
 tools/testing/selftests/bpf/test_lirc_mode2.sh | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/testing/selftests/bpf/test_lirc_mode2.sh b/tools/testing/selftests/bpf/test_lirc_mode2.sh
index ce2e15e4f976..51184f8f9e64 100755
--- a/tools/testing/selftests/bpf/test_lirc_mode2.sh
+++ b/tools/testing/selftests/bpf/test_lirc_mode2.sh
@@ -1,6 +1,15 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
+# Kselftest framework requirement - SKIP code is 4.
+ksft_skip=4
+
+msg="skip all tests:"
+if [ $UID != 0 ]; then
+    echo $msg please run this as root >&2
+    exit $ksft_skip
+fi
+
 GREEN='\033[0;92m'
 RED='\033[0;31m'
 NC='\033[0m' # No Color
-- 
2.17.0

