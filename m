Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 20840C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 11:08:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9E17208B0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 11:08:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="IecsdGvS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9E17208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933436AbeFLLH7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 07:07:59 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:37857 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932543AbeFLLH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 07:07:57 -0400
Received: by mail-lf0-f68.google.com with SMTP id g21-v6so33376460lfb.4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 04:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=CeMboJ8+PxGmQH0deFDvxeeEvIZBjafaepSG6nMV/80=;
        b=IecsdGvSX8AjmIQC8cuPaoN0YoUOG19XBoaNIczM3CHAgVOpieGtwWCIRd/T3Bv99F
         XqNsu5mZhKidkoH171mV7b0Faxa01CxGGW9S4eum7GgngGuemKFzNR21Loh3vZvY9Nl4
         yMFefDvzHIIZNxog5LG8Zkx4eyOk3gRTXaxHw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=CeMboJ8+PxGmQH0deFDvxeeEvIZBjafaepSG6nMV/80=;
        b=OZQKmIrkBKnuTb+bhVieedqyb2h5m22qCYILt262UvhBsuj+4JeKVYN1cpBIGx54gH
         DmS00XLQZ3WBrt7KTR6JCRXS3ur32eseFRYiC6UAnyVeSO0bog4qtj3yyr1ICfneBv4i
         i44reXl+ofvwcux5fYnF+x5RFPdAFBvTj+z/H+PeaRdGLy1/ocOF4bCDRmDzuYTmKEuw
         qzuQreuffc3bcvOnJIAGvcBgzRDoK9jkvQg91GEavhgXIG6eBuwFHBqGnXGJoLewzjTp
         PVzlgiK2nU3DZbQTTO69UliBfqxBOgW3DFQotL6rv4VgS6Z8sDbpwl4EadErpyzZWPb5
         feWw==
X-Gm-Message-State: APt69E1cuZdNl/yJ1dMTU6MVirBhuqfQ8IDwQqUdo5RFYiF49zKHNY6A
        70F7PdfiYjKZn3iumuugdrHvkw==
X-Google-Smtp-Source: ADUXVKK1qzDmQ74OxbOl74pBQ9nCJmuo26jOitIMrvQfjenQa8LH9TWhs9Y74ySfbr5RrGkY9l7qJg==
X-Received: by 2002:a2e:1414:: with SMTP id u20-v6mr2176718ljd.134.1528801675661;
        Tue, 12 Jun 2018 04:07:55 -0700 (PDT)
Received: from localhost (c-2c3d70d5.07-21-73746f28.bbcust.telenor.se. [213.112.61.44])
        by smtp.gmail.com with ESMTPSA id h77-v6sm147921lfk.47.2018.06.12.04.07.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Jun 2018 04:07:54 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     ast@kernel.org, daniel@iogearbox.net, shuah@kernel.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] selftests: bpf: config: add config fragments
Date:   Tue, 12 Jun 2018 13:05:10 +0200
Message-Id: <20180612110510.11731-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tests test_tunnel.sh fails due to config fragments ins't enabled.

Fixes: 933a741e3b82 ("selftests/bpf: bpf tunnel test.")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---

All tests passes except ip6gretap that still fails. I'm unsure why.
Ideas?

Cheers,
Anders

 tools/testing/selftests/bpf/config | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
index 1eefe211a4a8..7eb613ffef55 100644
--- a/tools/testing/selftests/bpf/config
+++ b/tools/testing/selftests/bpf/config
@@ -7,3 +7,13 @@ CONFIG_CGROUP_BPF=y
 CONFIG_NETDEVSIM=m
 CONFIG_NET_CLS_ACT=y
 CONFIG_NET_SCH_INGRESS=y
+CONFIG_NET_IPIP=y
+CONFIG_IPV6=y
+CONFIG_NET_IPGRE_DEMUX=y
+CONFIG_NET_IPGRE=y
+CONFIG_IPV6_GRE=y
+CONFIG_CRYPTO_USER_API_HASH=m
+CONFIG_CRYPTO_HMAC=m
+CONFIG_CRYPTO_SHA256=m
+CONFIG_VXLAN=y
+CONFIG_GENEVE=y
-- 
2.17.1

