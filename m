Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE09FECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 18:27:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D8C32086E
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 18:27:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uS1/SbCK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D8C32086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727738AbeJTCeP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 22:34:15 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55022 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727547AbeJTCeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 22:34:15 -0400
Received: by mail-wm1-f66.google.com with SMTP id r63-v6so4521977wma.4;
        Fri, 19 Oct 2018 11:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZdxoQoo4AkSpovn00yKshE09tvQAz5dvOIoBV8/11ec=;
        b=uS1/SbCKnFBhH5ldRAPjvOydJGeMLotG9AAxj5N2Emf4zAQSsNT0v/zk3C31X9i3Pr
         0vTGEYJc5TjklobvP47r/u05qI4dWOhWaI4H/F06yfenFpelpZqpkCaglXud98vupjVJ
         TQspfPMXE7cs1pOricBcnrAkhoTmRKJtzbMMzTW+Qi11lil0TVbMr23tozOdswhQ9Met
         f6ADxVk3ZE1X81vj/GzPpad04zr/t4lAPf+vmepIyhTx5KUkVmjsScNX0WeLmj7ANrJ2
         dkAzgXEv0ndfy/nn+Zqs4YdgKWjZLHyXYDX0oA5q0JuPA9iNW1bhD4W7NtDQuPP7JV18
         wN1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZdxoQoo4AkSpovn00yKshE09tvQAz5dvOIoBV8/11ec=;
        b=Unmu/g5BJcB/oOZOgnkOVvFebokrVz7wnR12DW3Va0MC0z56aBYxwpYHXxet5gQFtp
         OQuu8TFn2NbeW/761vtsOtjuiGpv0F+dsr1TIFVYjPjqe6pkrf7rg72mcj8vYiKdmITG
         ogGpmfJzURCFeyBOEwW0RGPZWbkJ6WOrEGcY2e2etxYISpvcsw1sLpye81xiL7Gyoa3F
         11QNdOgqkqTTeAA2+3JheD/4fFonGzm1Hi4yX/lmMBSlDC8YIiJYbIBNJhWDdAjev1VU
         vjnhzQTjrxPYHsfA6i8ju3NfnUX7FdAuSDKMMtTtdLAZOQMkrxSPQL5+NUMtkBmlIzQv
         /opw==
X-Gm-Message-State: ABuFfojFxvx9j39GNUgubwT5I9C5aa3R2uho5oDVhvrTQFHAQfW0TVtE
        2x/MNDFN0jxFmNX8tnYobx8=
X-Google-Smtp-Source: ACcGV60V7K0RvwDQj8XkkosK28saFClhbIa830C+dEfD0FaGiutZYmwbdoB0NKdCaqlql5MvE9JNxw==
X-Received: by 2002:a1c:c683:: with SMTP id w125-v6mr5895086wmf.117.1539973620581;
        Fri, 19 Oct 2018 11:27:00 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id j46-v6sm34692376wre.91.2018.10.19.11.26.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Oct 2018 11:26:59 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] bpf/test_run: Add braces to initialization in bpf_prog_test_run_skb
Date:   Fri, 19 Oct 2018 11:26:50 -0700
Message-Id: <20181019182649.24301-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns:

net/bpf/test_run.c:120:20: error: suggest braces around initialization
of subobject [-Werror,-Wmissing-braces]
        struct sock sk = {0};
                          ^
                          {}

Add the braces to properly initialize all subobjects.

Fixes: 75079847e9d0 ("bpf: add tests for direct packet access from CGROUP_SKB")
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 net/bpf/test_run.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 8dccac305268..65e049c61a7a 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -117,7 +117,7 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
 	u32 retval, duration;
 	int hh_len = ETH_HLEN;
 	struct sk_buff *skb;
-	struct sock sk = {0};
+	struct sock sk = { { {0} } };
 	void *data;
 	int ret;
 
-- 
2.19.1

