Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76205C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 18:05:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2267121568
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 18:05:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e8ePzOsj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2267121568
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391131AbeIUXzB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 19:55:01 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53064 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389545AbeIUXzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 19:55:01 -0400
Received: by mail-wm1-f68.google.com with SMTP id y139-v6so3915986wmc.2;
        Fri, 21 Sep 2018 11:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ncB+MGwqY7VHZh1ATcJuf5QPS2cGQq1ixMcF/IGDplY=;
        b=e8ePzOsjkH54ywyv6nd8tY3615XPpSTGyHoIOXIWyw9fGgE36dteGLaUOKpSlH2zpZ
         KvhencsM5PSg4MSeSZ2q6ZEb+FXsVENlywLXUJCeEwETAKi16uzvd8KZlzBzoMo/M/Ge
         IKVUQMl7bZtdACIHAZ9exlaAiY2pS5E3Hk+zrCtF2j19ORu1Pcg3bglm7Z0qUpP3/217
         YL0D5i/ApOllEs8S8bq4Bpv0kr5YSqP/Gr1Rt7JaFIpQIL4ZCvikwTHkRTrunpsIDn8f
         CMQjbImDZp0a1u8ZP4LhTvdPGnsUC1BLPRVhBrlWlFWJSU0eBC+UEyIK9H0lSm6k6Jz+
         Ezqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ncB+MGwqY7VHZh1ATcJuf5QPS2cGQq1ixMcF/IGDplY=;
        b=ccBL2VASy1D0fBStyHgJzAee3rru/+ppAyLstiK9iFKIdcLeCZCCXX+ATgYpjP95uB
         03U5QhNyuLeIbIQmNZSU9W3S8XPx3PGOyJQqhRwthsuLg3QX5V8EeLFgr3Uw+DIzo2Q2
         yeQKOhcUVBONudr632YXvEDXUGyswAHvFEhwgvCTQqWv96mLvjAyOOMAxhCesJuTH5TN
         A+Vx23jG1LcLYjzBsc8p8arK5Y3isUVyUzMSmFGAx1DoZomfD4TJ0sAW/Eydi/ECPd87
         sQG2eINyW3tc8ORhEaBK7zwEfmb8k/JhoV/V9aDqFF/gaWgmBm03SFREgo1fQswVc76I
         h6KQ==
X-Gm-Message-State: APzg51CrH71a2wJ1U/hXBP8Q2INWmKiv4Emuy9XaaTTWPNN9Yh4B9tYk
        jdkDYR4U1wXRVw/ZeGyq3Gs=
X-Google-Smtp-Source: ANB0VdbyYUWSaTo1DdT8HRWt6xVUla9v0Drm/lXNDfgkWqXoiOaG5WiFa9QuUQUDEjNd1ZJ8HAGaiw==
X-Received: by 2002:a1c:66d5:: with SMTP id a204-v6mr1638770wmc.159.1537553098602;
        Fri, 21 Sep 2018 11:04:58 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id q200-v6sm8322606wmd.2.2018.09.21.11.04.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 11:04:57 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Santosh Shilimkar <santosh.shilimkar@oracle.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] RDS: IB: Use DEFINE_PER_CPU_SHARED_ALIGNED for rds_ib_stats
Date:   Fri, 21 Sep 2018 11:04:51 -0700
Message-Id: <20180921180451.18711-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns when two declarations' section attributes don't match.

net/rds/ib_stats.c:40:1: warning: section does not match previous
declaration [-Wsection]
DEFINE_PER_CPU_SHARED_ALIGNED(struct rds_ib_statistics, rds_ib_stats);
^
./include/linux/percpu-defs.h:142:2: note: expanded from macro
'DEFINE_PER_CPU_SHARED_ALIGNED'
        DEFINE_PER_CPU_SECTION(type, name,
PER_CPU_SHARED_ALIGNED_SECTION) \
        ^
./include/linux/percpu-defs.h:93:9: note: expanded from macro
'DEFINE_PER_CPU_SECTION'
        extern __PCPU_ATTRS(sec) __typeof__(type) name;
\
               ^
./include/linux/percpu-defs.h:49:26: note: expanded from macro
'__PCPU_ATTRS'
        __percpu __attribute__((section(PER_CPU_BASE_SECTION sec)))
\
                                ^
net/rds/ib.h:446:1: note: previous attribute is here
DECLARE_PER_CPU(struct rds_ib_statistics, rds_ib_stats);
^
./include/linux/percpu-defs.h:111:2: note: expanded from macro
'DECLARE_PER_CPU'
        DECLARE_PER_CPU_SECTION(type, name, "")
        ^
./include/linux/percpu-defs.h:87:9: note: expanded from macro
'DECLARE_PER_CPU_SECTION'
        extern __PCPU_ATTRS(sec) __typeof__(type) name
               ^
./include/linux/percpu-defs.h:49:26: note: expanded from macro
'__PCPU_ATTRS'
        __percpu __attribute__((section(PER_CPU_BASE_SECTION sec)))
\
                                ^
1 warning generated.

The initial definition was added in commit ec16227e1414 ("RDS/IB:
Infiniband transport") and the cache aligned definition was added in
commit e6babe4cc4ce ("RDS/IB: Stats and sysctls") right after. The
definition probably should have been updated in net/rds/ib.h, which is
what this patch does.

Link: https://github.com/ClangBuiltLinux/linux/issues/114
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 net/rds/ib.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/rds/ib.h b/net/rds/ib.h
index 73427ff439f9..fd483760c910 100644
--- a/net/rds/ib.h
+++ b/net/rds/ib.h
@@ -443,7 +443,7 @@ int rds_ib_send_grab_credits(struct rds_ib_connection *ic, u32 wanted,
 int rds_ib_xmit_atomic(struct rds_connection *conn, struct rm_atomic_op *op);
 
 /* ib_stats.c */
-DECLARE_PER_CPU(struct rds_ib_statistics, rds_ib_stats);
+DEFINE_PER_CPU_SHARED_ALIGNED(struct rds_ib_statistics, rds_ib_stats);
 #define rds_ib_stats_inc(member) rds_stats_inc_which(rds_ib_stats, member)
 #define rds_ib_stats_add(member, count) \
 		rds_stats_add_which(rds_ib_stats, member, count)
-- 
2.19.0

