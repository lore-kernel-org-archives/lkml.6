Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B18FBC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 14:27:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CDA32085B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 14:27:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DllcVTVv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CDA32085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727532AbeJJVti (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 17:49:38 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:43513 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbeJJVti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 17:49:38 -0400
Received: by mail-lf1-f65.google.com with SMTP id p34-v6so4125215lfg.10
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 07:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hZvxuafgnN9LV74qclQCyNqJ1ARC5Hh1dFCIELTgzjw=;
        b=DllcVTVvA/uV5u5/YTMrIPmpubNP9T3++RZDFalQzo2v7diYOQhA7SPGdriWKZgJI/
         P544t9GuFFsqPDl96hDng1zT5Liz9ocoBvdfuXX1pNQIDnBpWgJyqsgyjPnq/wqT53vF
         P5n+4gyxIwG7o5MF3im7kCOv0l94V5sa2VRKU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hZvxuafgnN9LV74qclQCyNqJ1ARC5Hh1dFCIELTgzjw=;
        b=DXUwKiGlRxuOvsPtHYxD4gtFmXuVg/2Ox0pqyUAXB1lZpDrCUwsNQNjX/6NNHIEdqI
         zXRMpMsYeelRrz3Gmoy934Dx1uvWJiqugYPQhHD8rzjNqHxYpllBzX9wqGorXFP7Rdrw
         zBxp+ZT1u4OgzJzKNL+PIbkcbpuQWJ05Rq/XFB2PO8BPw5ThSYNnZUVFa6oTHOhCCYF1
         tHLFFuBy3R/mTWAl29bDNE+CNF8SPkj9pQP8LcDCmU+/5EVX+xyNlTsgXq7nrCTzgJkd
         GfJTNxR8E1ErHTqRcXTUpyUcwWtAux5cr1EMd5gH9oYse1VslDn/+mDIUnxWzcXEA4HU
         UIzg==
X-Gm-Message-State: ABuFfogNzhmQ/G2vUqquwV1h45PxJNtkz4vUB90TPAawvsFMtu5wahOF
        DAzyK4olqTXpQaoBIpakAOPAOQ==
X-Google-Smtp-Source: ACcGV62/ybPXFWk0Biy/aFjr7dCG/XG3ETci33LJ/CAv9i0vuGGiEYNBErkX908+ocW8aXkMbGRfpA==
X-Received: by 2002:ac2:5082:: with SMTP id f2-v6mr1924296lfm.47.1539181631122;
        Wed, 10 Oct 2018 07:27:11 -0700 (PDT)
Received: from localhost (c-732171d5.07-21-73746f28.bbcust.telenor.se. [213.113.33.115])
        by smtp.gmail.com with ESMTPSA id x64-v6sm4986784lfa.34.2018.10.10.07.27.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Oct 2018 07:27:10 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     ast@kernel.org, daniel@iogearbox.net, shuah@kernel.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] selftests: bpf: install script with_addr.sh
Date:   Wed, 10 Oct 2018 16:27:04 +0200
Message-Id: <20181010142704.26990-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When test_flow_dissector.sh runs it complains that it can't find script
with_addr.sh:

./test_flow_dissector.sh: line 81: ./with_addr.sh: No such file or
directory

Rework so that with_addr.sh gets installed, add it to
TEST_PROGS_EXTENDED variable.

Fixes: 50b3ed57dee9 ("selftests/bpf: test bpf flow dissection")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 tools/testing/selftests/bpf/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 1381ab81099c..efd108ff737d 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -51,6 +51,8 @@ TEST_PROGS := test_kmod.sh \
 	test_skb_cgroup_id.sh \
 	test_flow_dissector.sh
 
+TEST_PROGS_EXTENDED := with_addr.sh
+
 # Compile but not part of 'make run_tests'
 TEST_GEN_PROGS_EXTENDED = test_libbpf_open test_sock_addr test_skb_cgroup_id_user \
 	flow_dissector_load test_flow_dissector
-- 
2.19.1

