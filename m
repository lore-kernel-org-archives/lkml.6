Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6242C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 14:56:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A85925BDC
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 14:56:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="h2S2TY4X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A85925BDC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934671AbeFYO4e (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 10:56:34 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:36870 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934543AbeFYO43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 10:56:29 -0400
Received: by mail-lf0-f66.google.com with SMTP id g21-v6so14730361lfb.4
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 07:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=nQryVprnxJSnUORgcvnRLVbukJviqO2reZecUlzewE8=;
        b=h2S2TY4XnuYmaRQ4jFrnO5iGDHp3/JpJf9deJzU/HJjECcetoVpwqoHInGOAuU0SSr
         TNoqTO8MuKuTdOBmVpuLcFNJaxJi85jfE3T/kYBONJvNHp8l2Ee/fx2nDuzPZ5AGnTus
         LGT9EVC1tIGLAj03llfO2+pUZSw6gDAKvOnig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=nQryVprnxJSnUORgcvnRLVbukJviqO2reZecUlzewE8=;
        b=GlkV1kngGa37S4fWbNZuStXpzYe6/hQHBgk+C5VsxmJRBtk+LPpIqjDMri7lrX+JyW
         3kdyEF/324Ujk+oBvUeKvsd6ZZNy8FV5G/nH4XkVrw07QFgmgBT0B6+6cyHkp/1yAVgm
         74zXiozQtczbQCU51UuV8zxgN+nD14Yq0kT134O+ByVgiQ6H59AMYAuhLdHqNQx+fxqw
         jP31ywTBVXzDscb7jH714Y1tuOQx7o6y2rHnXSzOm/UXfSkSiHS93ut1GW5B7rjB5RD9
         0UQMRF8iJGAI62t0p4kXXy/rFMmc+2GCO+BwsNFTM7ArlT5/slsBRmAtli4CglfAAqhv
         8IMQ==
X-Gm-Message-State: APt69E35SnuAGUpBcyQlHa7N9JVyKq5flpvINkf4pOhmidA0a05tCfN/
        H4yF5pgi0Y5RdY2o7SBBDQfrEQ==
X-Google-Smtp-Source: ADUXVKJUNHX3pPu660CKtDyoV/maKAq11DAKxwStBcFt92oLMYwXsuxDZUVJtHf2PFDnSNf1dRyJ5A==
X-Received: by 2002:a19:29c7:: with SMTP id p190-v6mr6557704lfp.146.1529938587957;
        Mon, 25 Jun 2018 07:56:27 -0700 (PDT)
Received: from localhost (c-2c3d70d5.07-21-73746f28.bbcust.telenor.se. [213.112.61.44])
        by smtp.gmail.com with ESMTPSA id q2-v6sm2408113ljg.90.2018.06.25.07.56.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Jun 2018 07:56:27 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     ast@kernel.org, daniel@iogearbox.net, shuah@kernel.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] selftests: bpf: enable NET_SCHED
Date:   Mon, 25 Jun 2018 16:56:05 +0200
Message-Id: <20180625145605.13726-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_NET_SCHED wasn't enabled in arm64's defconfig only for x86.
So bpf/test_tunnel.sh tests fails with:
RTNETLINK answers: Operation not supported
RTNETLINK answers: Operation not supported
We have an error talking to the kernel, -1
Enable NET_SCHED and more tests passes.

Fixes: 3bce593ac06b ("selftests: bpf: config: add config fragments")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 tools/testing/selftests/bpf/config | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
index 1e0c547caf3c..7a6d92562dc6 100644
--- a/tools/testing/selftests/bpf/config
+++ b/tools/testing/selftests/bpf/config
@@ -6,6 +6,7 @@ CONFIG_TEST_BPF=m
 CONFIG_CGROUP_BPF=y
 CONFIG_NETDEVSIM=m
 CONFIG_NET_CLS_ACT=y
+CONFIG_NET_SCHED=y
 CONFIG_NET_SCH_INGRESS=y
 CONFIG_NET_IPIP=y
 CONFIG_IPV6=y
-- 
2.18.0

