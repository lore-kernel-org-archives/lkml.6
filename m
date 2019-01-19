Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5B6CC61CE4
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 21:50:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6D262084C
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 21:50:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aIDD9hqU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729640AbfASVub (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 16:50:31 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39824 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729056AbfASVub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 16:50:31 -0500
Received: by mail-wm1-f66.google.com with SMTP id y8so7525973wmi.4;
        Sat, 19 Jan 2019 13:50:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KJ11hf8h56plnV6JuCjf2i6n+ney8F5diLmrZi/39ds=;
        b=aIDD9hqUYmySD5akhAD9H4CnbF4PFK7A4BPHoVJMz5jNWAStUSzLUXY6mm3iqx296c
         giQ1HiIveID1HFtC+jERmEXmauilv/EpNJc3s9mz8TtpuuFGxiFGKih5avuACHhHNJyx
         mczIj7nCyzjtVubmkFQnhXUBxa8PnX4DQ5G8o0/Rpw/b51goNBpVxDP7ASsllbba3xIZ
         9/EsoiBilo9mCZ20VgjZ7ofFqfTkDKVWhn7dF9AaFUSlRMMt4UiUQhbY+utovQ35Xj/g
         sDQ+MzBTVjGWSNGuGacNtz+0R6AiK87EWPfNRQuSSFGLMU+FOcEeX5P+oZQCROuO+Lyt
         5cyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KJ11hf8h56plnV6JuCjf2i6n+ney8F5diLmrZi/39ds=;
        b=FhF7MmQvwdnHOPeOfVM70gyYJcYeOQQEMlagVaYjpNyV4vPm8MT1fDP0Ca4V65PUXx
         oOddiPOq+M1iDGghqzIpsHzR6w7aStT9cqnRyNbNi9kX5BJ4ZkOD6AEtKQc1CyuBGl7W
         IdltgAOvMs7fehaMQIkKz6PqbjvCiSXl/XpY0/HGMqjVW8CfwQLn9jlPdzgixCCgsAKL
         k+BsrashfW9R08/GxNDZF51CtUAxtWWaJrhq9octbySQZqCBDlJl5xYM64o6OWpGnPak
         xWkC+20n1E1ty9OrzhV+soYXD6UsE4ThVQ9l5THlPGcwoLPxdJWk0pmqwtr4hdZww9YJ
         v7JA==
X-Gm-Message-State: AJcUukdbZUfcaJLqsN7oulPUa8fYCUd486FMj+uURq6pDDTrTYotEX90
        HyFB3r7eQHCRS2LsPwoEjNY=
X-Google-Smtp-Source: ALg8bN4/q/uSHwZHHGqEpRbQrLP9F/sXCwKjx1HbyieaA4bYxtx1M0yTVtywLGre/QSzNUjM2m0+Iw==
X-Received: by 2002:a7b:c08f:: with SMTP id r15mr20168670wmh.118.1547934629447;
        Sat, 19 Jan 2019 13:50:29 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:40eb:400:dc79:225f:308a:97fa])
        by smtp.gmail.com with ESMTPSA id s16sm74290109wrt.77.2019.01.19.13.50.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 19 Jan 2019 13:50:28 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        Florian Westphal <fw@strlen.de>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        linux-kernel@vger.kernel.org,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] nft_counter: remove wrong __percpu of nft_counter_resest()'s arg
Date:   Sat, 19 Jan 2019 22:50:24 +0100
Message-Id: <20190119215024.90174-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

nft_counter_rest() has its first argument declared as
	struct nft_counter_percpu_priv __percpu *priv
but this structure is not percpu (it only countains
a member 'counter' which is, correctly, a pointer to a
percpu struct nft_counter).

So, remove the '__percpu' from the argument's declaration.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 net/netfilter/nft_counter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netfilter/nft_counter.c b/net/netfilter/nft_counter.c
index a61d7edfc..1a6b06ce6 100644
--- a/net/netfilter/nft_counter.c
+++ b/net/netfilter/nft_counter.c
@@ -104,7 +104,7 @@ static void nft_counter_obj_destroy(const struct nft_ctx *ctx,
 	nft_counter_do_destroy(priv);
 }
 
-static void nft_counter_reset(struct nft_counter_percpu_priv __percpu *priv,
+static void nft_counter_reset(struct nft_counter_percpu_priv *priv,
 			      struct nft_counter *total)
 {
 	struct nft_counter *this_cpu;
-- 
2.20.0

