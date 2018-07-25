Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E100C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 21:08:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D566920844
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 21:08:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="THG5Q+t/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D566920844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731337AbeGYWWK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 18:22:10 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:44734 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731150AbeGYWWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 18:22:10 -0400
Received: by mail-oi0-f68.google.com with SMTP id s198-v6so16421263oih.11
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 14:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=7PhOGjKwdw4TxOJ5GLTCvRnFYpd48EUQcmsr4BsgzzU=;
        b=THG5Q+t/bFFXG1X5aF3K5yaWb4wGci1j9WLT36yJxiz5PsgPaDeArVjDStp/6F7q3k
         c2VNSXsN1CxNgYiE/LtaTJKxxcYwK5OqviccyIGxJoymuJGDK2qBXkmJszDFhEOQ5qLp
         bYWBkEGTaL9DjGt1c6wNqyLjpzr8Qa1OiqOBw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7PhOGjKwdw4TxOJ5GLTCvRnFYpd48EUQcmsr4BsgzzU=;
        b=WbgQdcf8Mt2pd99f51GBXF1u26lL3ZsmLcgpSCOrYJLBCwJvYwfVAv5e4J/yq1LGyK
         erWFALKrRXQqJHZ6UhjilHzMGK6sR7D6esardXCCy8QjD2A8VS4B+nEkfmqBM87ch7a7
         adB1Oxu+i311OHPVkLSsgJoNKi+owr7S6Ga8svPKRP4aVuMrgctVYEuaajj9jhd2H99W
         lFgnmNG09k/MmsBMCmhnQnEylfGQCFzOFh+YIZc4S/dpdi7eO7IeJsoTbvBQbq75rl03
         EHzUxVSgN0ttJ4h9N3taHyd726101z9K091o8Os4oQR2/wkUFBLqWHBIOM5fL9glfecL
         +mZQ==
X-Gm-Message-State: AOUpUlE1MmoSH2IQMQ1uu/U56SoL6SEORcH+bGQkNYKJiewdm1hTIWg9
        Yz8/sW+4IvLY5uFrZ8d7a8ZZkw==
X-Google-Smtp-Source: AAOMgpcaEYjDpyDFjx9gx/RT58ukf/MKiiv3FfCW71plAPBpEmd71SVXk4W7DGspJjr2Gcn/DKj+aQ==
X-Received: by 2002:aca:4914:: with SMTP id w20-v6mr4942755oia.5.1532552921909;
        Wed, 25 Jul 2018 14:08:41 -0700 (PDT)
Received: from di3.localdomain (68-248-140-212.lightspeed.austtx.sbcglobal.net. [68.248.140.212])
        by smtp.gmail.com with ESMTPSA id p4-v6sm19265960oig.43.2018.07.25.14.08.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Jul 2018 14:08:41 -0700 (PDT)
From:   Brian Brooks <brian.brooks@linaro.org>
To:     ast@kernel.org, daniel@iogearbox.net, bjorn.topel@intel.com,
        magnus.karlsson@intel.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Brian Brooks <brian.brooks@linaro.org>
Subject: [PATCH v2 bpf-next] samples/bpf: xdpsock: order memory on AArch64
Date:   Wed, 25 Jul 2018 16:08:19 -0500
Message-Id: <20180725210819.1458-1-brian.brooks@linaro.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define u_smp_rmb() and u_smp_wmb() to respective barrier instructions.
This ensures the processor will order accesses to queue indices against
accesses to queue ring entries.

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

