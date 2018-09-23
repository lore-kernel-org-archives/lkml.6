Return-Path: <SRS0=ZOiK=MF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3064C433F4
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 03:31:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69BBC214DC
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 03:31:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y9UxRaiw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69BBC214DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726071AbeIWJ1c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Sep 2018 05:27:32 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37640 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbeIWJ1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Sep 2018 05:27:32 -0400
Received: by mail-wm1-f66.google.com with SMTP id n11-v6so6810540wmc.2;
        Sat, 22 Sep 2018 20:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RYWG0dNjBbOy+OExJsHEjUAntuCTfTW56OkKfm6NKTA=;
        b=Y9UxRaiw/fWsi8RZQRXC9dqjtFXiWV1MW9VnbWZyKb76B4Lh7L4EfRxW9X7XLSWq38
         L5ERcYU7NcuOFo7Mn9iAfWlkKoB6B8zEWosnYOCjI1klHy9p2dys+rAsau0BkgN0pkkT
         NBzfZ3MbvH2BlMezwMtKiI0PccrkZ1zoQsOewGn4/TZeADYg01pqUx97iUiBNlY/lyFe
         NwB2AC9PsPoFuO+n3t2OgjOoPCly/cmlf9AYT0m9HRK/fD1xJLYaN0z6kR5oiGskGQj2
         RBnjqM2lW+r+I9Jb3CucOf5vbfntjS8RqwM+QDfV8fpNIcWDIwBvBRhjnyrsyC2fNk1E
         8Ysg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RYWG0dNjBbOy+OExJsHEjUAntuCTfTW56OkKfm6NKTA=;
        b=Y7qxC2pWqp8kzs20e6oOVu8ncRju2yL1dvKzf2eae/JDmoIezMWB1umspBoGjvi9M0
         Xx4flQ6Nhhjslkf+rya1kpaDO+MKHhR9KyCDUiYpHYTGITBZ2BBV24iDTG9Dj4xYbRKb
         JcGB/mwdzO90x5JRUx22k/oqV15W0I5KRSY6H1OSeInj6SlnF/sVxG2Fkt9ahBRT3tso
         08PtxU8WKgz7viPC9HInDhpwH6EvAJEvqr/4y+RxeQ1en8BuWkXNwoUcldJPTgLDoEuC
         lgSEfwfjVNC27Xlg2L40slYLTaDHPA9Rwfymy87LZpYveuavvZUekrSPtrpcby7Y1F0R
         4LOA==
X-Gm-Message-State: APzg51CqligrqWMfh3I16JGWmDCfq4bQgXxftNiKhaEyYEjq3IRFt9r/
        V/zOUIPGVUD1EjABhdl18kM=
X-Google-Smtp-Source: ANB0VdajSqW8eXxCFb4xLse9IarO9sFj63U4HNI0hyY7wKV9B9qBGKWn53AW7Wh24fn84p3qUUNyqQ==
X-Received: by 2002:a1c:ce0b:: with SMTP id e11-v6mr3207305wmg.47.1537673496170;
        Sat, 22 Sep 2018 20:31:36 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id p64-v6sm11528116wrc.97.2018.09.22.20.31.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 Sep 2018 20:31:35 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Santosh Shilimkar <santosh.shilimkar@oracle.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH v2] RDS: IB: Use DECLARE_PER_CPU_SHARED_ALIGNED for rds_ib_stats
Date:   Sat, 22 Sep 2018 20:29:39 -0700
Message-Id: <20180923032938.27093-1-natechancellor@gmail.com>
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

v1 -> v2:

Fix reported build error by using DECLARE instead of DEFINE

 net/rds/ib.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/rds/ib.h b/net/rds/ib.h
index 73427ff439f9..71ff356ee702 100644
--- a/net/rds/ib.h
+++ b/net/rds/ib.h
@@ -443,7 +443,7 @@ int rds_ib_send_grab_credits(struct rds_ib_connection *ic, u32 wanted,
 int rds_ib_xmit_atomic(struct rds_connection *conn, struct rm_atomic_op *op);
 
 /* ib_stats.c */
-DECLARE_PER_CPU(struct rds_ib_statistics, rds_ib_stats);
+DECLARE_PER_CPU_SHARED_ALIGNED(struct rds_ib_statistics, rds_ib_stats);
 #define rds_ib_stats_inc(member) rds_stats_inc_which(rds_ib_stats, member)
 #define rds_ib_stats_add(member, count) \
 		rds_stats_add_which(rds_ib_stats, member, count)
-- 
2.19.0

