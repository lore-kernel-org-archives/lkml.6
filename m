Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47835C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 09:21:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D0EF214FF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 09:21:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VzLv5ZK9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D0EF214FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbeJJQmy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 12:42:54 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35831 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726830AbeJJQmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 12:42:54 -0400
Received: by mail-lj1-f194.google.com with SMTP id o14-v6so4230535ljj.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 02:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7iZmHxq2lk1gkDrvUA6mrD+hyYQepxmLa3cJbSGBdZg=;
        b=VzLv5ZK9GDC69kGRbtMPoJghWO9lni2CmNdB3basYnHAi2qMe8i/EgujvrHxMSzHGR
         UHLCYUNq38FRK2wTMNEyaGzbOpxco6RYu4nFBM+GtioyJf58L3IeHWEXqQIyT497LvJE
         KNS4MmghVo3AUsxmX5pjXPdYHDnKlOYXIdN34=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7iZmHxq2lk1gkDrvUA6mrD+hyYQepxmLa3cJbSGBdZg=;
        b=kwGa1Om/lqjmyXuadeaLz44rNLob0FMo5hY/VmFDfBg6CcSmDE7Z29ZqnCtFhoBO5Q
         IYH1TBmexKFVqOx6hqG6ZbTqe38vgCdLbDfuSnhNDMhMyKNsdYXGQxmL2yisw7rgA05M
         1tIWxWqCku37Ws2697WYwoN6bm+BZRsSvCU3bN/FFCaWIQzsgNO5TXqVCTJZXzIM5Rmn
         +htGeSePlFSaiJWsMbw7egxmHI6OpN7S9OJwokCPjYJvtyYV3/G9Kp7zLxQa7cx6QGrd
         +ariaNRMYmvl+saZSTqaGJFYifmU6iUN/Buh9L7dfAEd9LWT4A+c7K29da54p3cqkrbn
         QEmQ==
X-Gm-Message-State: ABuFfoi4Sik2FmZLX9/GNePsT3JH7xMM5zpuh4Rw9ntDnuFscaQ80S+T
        +gLltkbdebK4iOHhxP7EnWr6+w==
X-Google-Smtp-Source: ACcGV61dwfmI4qP4E4Zi4VqJFe7W9GzR30Z6AvcQngIZXGvp2FmvatCF70RkkxbNSY/z8ixATfNFlg==
X-Received: by 2002:a2e:8146:: with SMTP id t6-v6mr20084527ljg.32.1539163295351;
        Wed, 10 Oct 2018 02:21:35 -0700 (PDT)
Received: from localhost (c-732171d5.07-21-73746f28.bbcust.telenor.se. [213.113.33.115])
        by smtp.gmail.com with ESMTPSA id o19-v6sm4836716lff.36.2018.10.10.02.21.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Oct 2018 02:21:34 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     ast@kernel.org, daniel@iogearbox.net, shuah@kernel.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] selftests: bpf: add config fragment LWTUNNEL
Date:   Wed, 10 Oct 2018 11:21:23 +0200
Message-Id: <20181010092123.26218-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When test_lwt_seg6local.sh was added commit c99a84eac026
("selftests/bpf: test for seg6local End.BPF action") config fragment
wasn't added, and without CONFIG_LWTUNNEL enabled we see this:
Error: CONFIG_LWTUNNEL is not enabled in this kernel.
selftests: test_lwt_seg6local [FAILED]

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 tools/testing/selftests/bpf/config | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
index 3655508f95fd..dd49df5e2df4 100644
--- a/tools/testing/selftests/bpf/config
+++ b/tools/testing/selftests/bpf/config
@@ -19,3 +19,4 @@ CONFIG_CRYPTO_SHA256=m
 CONFIG_VXLAN=y
 CONFIG_GENEVE=y
 CONFIG_NET_CLS_FLOWER=m
+CONFIG_LWTUNNEL=y
-- 
2.19.1

