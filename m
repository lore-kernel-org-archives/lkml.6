Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCAADC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 09:36:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A02AA218F0
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 09:36:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="sHrbCxIl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387575AbeLUJgL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 04:36:11 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36979 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731114AbeLUJgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 04:36:11 -0500
Received: by mail-pf1-f193.google.com with SMTP id y126so2350812pfb.4
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 01:36:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=jOg5unArcqZ+VdWb7aU7utg4uQN/o7oo7CVo+2rNe/E=;
        b=sHrbCxIlwmo1PszNoDeqH9j4bcGdmpDq6jl9FX67h9iJRDEqgO8e3u6MZaQRwe+LmO
         SIYM9RCGKHDo0PzLiam08+UcC158NjBbyzYq/qDZkd70IcRnEUa0Cd4DMeWb3rUNwuMT
         2ns2s0YTxVREampBsNoZP7fOc/hov/bEed+hsXX1a7YSjQjFsuXHAs7T7RssAJbABzvo
         pGn6S8vZI0g1JMUIwONvts4kC9HBpo9BsHjqy33UuVL/uLhCfuoFX5h3+b6QUprLqLI3
         i6MmJCk03dp894RbNoy8+NcTJIba/oYK+qalLNyU2yvtjmww9X7NHJUB3O8waA98hPVZ
         5Xqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=jOg5unArcqZ+VdWb7aU7utg4uQN/o7oo7CVo+2rNe/E=;
        b=eBlaY8ejWxGmswwAMoMzDiYyyatX1F294AadbDLLQfS3NDftIXD6nI/Yj69w7PhMBh
         JwyeEmCAYRXhnGvxSd5vv1uPIoWzbSzV95ZQ3sdrF+k/zpQzTrNFwWymJo8Vi4Vs+A2L
         Ru9qqmyix3FMYivnQeYLSrsKgKRA1TmF2tTX/JbBBaQAK6jM5AfIKgfITq0YnUjVnx9U
         3ozbE9gVrNhsdJ9ukHkVd/17hNFDbRBEqdySorC/KP9BT1x+/yXC9bHOSAjZ95XDsr8y
         HBTOiQNAxVzJOdFGfyz+9w0P9I1KfRHeFQWnUvJ8GiyF55Dijsy2fgJ1cy1ZpPPMt2AQ
         KlCA==
X-Gm-Message-State: AA+aEWaqJYyeC/2Du6fBiIAdNOOsEbafPxR2VGohg0iGasiCW0StmNa0
        PkcCMaU+pxRdmUJMovFFCUcX5g==
X-Google-Smtp-Source: AFSGD/WOCiRyxTe9pWFuLL7JQRMZYoSb65x37DvfsVQXCq0e2e97AxrqafQ4ZDb/S+EdRMb8LQznDg==
X-Received: by 2002:a62:1289:: with SMTP id 9mr1799825pfs.102.1545384969977;
        Fri, 21 Dec 2018 01:36:09 -0800 (PST)
Received: from n3-021-216.byted.org ([122.14.241.161])
        by smtp.gmail.com with ESMTPSA id g3sm51601804pfe.37.2018.12.21.01.36.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Dec 2018 01:36:08 -0800 (PST)
From:   Xiaozhou Liu <liuxiaozhou@bytedance.com>
To:     netdev@vger.kernel.org
Cc:     Xiaozhou Liu <liuxiaozhou@bytedance.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next] selftests/bpf: fix error printing in test_devmap()
Date:   Fri, 21 Dec 2018 17:35:11 +0800
Message-Id: <20181221093512.117777-1-liuxiaozhou@bytedance.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As a simple fix, just print the correct map type.

Signed-off-by: Xiaozhou Liu <liuxiaozhou@bytedance.com>
---
 tools/testing/selftests/bpf/test_maps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/test_maps.c b/tools/testing/selftests/bpf/test_maps.c
index 9c79ee017df3..e2b9eee37187 100644
--- a/tools/testing/selftests/bpf/test_maps.c
+++ b/tools/testing/selftests/bpf/test_maps.c
@@ -510,7 +510,7 @@ static void test_devmap(int task, void *data)
 	fd = bpf_create_map(BPF_MAP_TYPE_DEVMAP, sizeof(key), sizeof(value),
 			    2, 0);
 	if (fd < 0) {
-		printf("Failed to create arraymap '%s'!\n", strerror(errno));
+		printf("Failed to create devmap '%s'!\n", strerror(errno));
 		exit(1);
 	}
 
-- 
2.11.0

