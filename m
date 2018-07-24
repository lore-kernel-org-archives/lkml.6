Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 717B3ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 13:33:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2663420880
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 13:33:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gliWVfAP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2663420880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388412AbeGXOkW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 10:40:22 -0400
Received: from mail-oi0-f45.google.com ([209.85.218.45]:37659 "EHLO
        mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388321AbeGXOkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 10:40:22 -0400
Received: by mail-oi0-f45.google.com with SMTP id k81-v6so7461987oib.4
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 06:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=DxwA46rfNWzVwaysnN1wqm4+glssjQdjUYUo9bSlWLQ=;
        b=gliWVfAPDD1qEJzU1dtPk9LI57iIeU1wXUEitTjlIoI98T/Aj4kZfRKkW2wqSRvxm3
         b1ZPR8R4tobSvIJ4vQAI9OpmzrlltQvSBd+ME3NVciiEu8g1dv5f4krnAG8+3bD4DYIA
         P68lIlqbuSxgrqYWgT6b9h1aKy0U1XdNrrChE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=DxwA46rfNWzVwaysnN1wqm4+glssjQdjUYUo9bSlWLQ=;
        b=VvgR+5tVMuEOHVHFKmWQkTTORMybRtU9+AisFm/JHySBONlCdrnAzob0Ja6E7w0K+F
         OwPIfieo8ISbpiFVAo40zNmRXKLunyIl/zOSa5wida0jg+6soPApCi1T7d1lfLrv/hzu
         JbICLlIn0J3uH3ReFGeiGt0lbiabRxs4TRj4c0AX+3TOA8ax2zZa6th/MeIGfV6yG9eX
         l+HAWTIqPbeRuZ3j+qQcxddoppyFv91S11qS3qIFh2xBRQ8iFkVm3AWEBuDT/FOqpx5s
         Z554+NxmnGpUmfzdyAWWnhfceobFvOw7a2uqC1fctX3Z1dJQaxtfwoP87rVGfnFFhQCN
         ivdw==
X-Gm-Message-State: AOUpUlHGMZGMTuLvHB6QdxKDwGExpOje0VfpucHGTo1Gg+btX+F1mhM6
        F9XIbF9r0zchVwiIfRbYJxh92w==
X-Google-Smtp-Source: AAOMgpdd/dxMAy+9r7lm7JxsfRo0B/gEo81QeV9ENutCpq+EW39xyhnV9jnomzO7BUsh6usFsjJhIg==
X-Received: by 2002:aca:de04:: with SMTP id v4-v6mr3408859oig.328.1532439230822;
        Tue, 24 Jul 2018 06:33:50 -0700 (PDT)
Received: from di3.localdomain (68-248-140-212.lightspeed.austtx.sbcglobal.net. [68.248.140.212])
        by smtp.gmail.com with ESMTPSA id r3-v6sm8502975oig.49.2018.07.24.06.33.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Jul 2018 06:33:50 -0700 (PDT)
From:   Brian Brooks <brian.brooks@linaro.org>
To:     ast@kernel.org, daniel@iogearbox.net, bjorn.topel@intel.com,
        magnus.karlsson@intel.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Brian Brooks <brian.brooks@linaro.org>
Subject: [PATCH bpf-next] samples/bpf: xdpsock: order memory on AArch64
Date:   Tue, 24 Jul 2018 08:33:37 -0500
Message-Id: <20180724133337.20175-1-brian.brooks@linaro.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Brian Brooks <brian.brooks@linaro.org>
---
 samples/bpf/xdpsock_user.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/samples/bpf/xdpsock_user.c b/samples/bpf/xdpsock_user.c
index 5904b1543831..1e82f7c617c3 100644
--- a/samples/bpf/xdpsock_user.c
+++ b/samples/bpf/xdpsock_user.c
@@ -145,8 +145,13 @@ static void dump_stats(void);
 	} while (0)
 
 #define barrier() __asm__ __volatile__("": : :"memory")
+#ifdef __aarch64__
+#define u_smp_rmb() __asm__ __volatile__("dmb ishld": : :"memory")
+#define u_smp_wmb() __asm__ __volatile__("dmb ishst": : :"memory")
+#else
 #define u_smp_rmb() barrier()
 #define u_smp_wmb() barrier()
+#endif
 #define likely(x) __builtin_expect(!!(x), 1)
 #define unlikely(x) __builtin_expect(!!(x), 0)
 
-- 
2.18.0

