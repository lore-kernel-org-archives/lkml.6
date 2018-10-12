Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F0EAC67872
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 15:28:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AE4F2098A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 15:28:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DCbpw9Sq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AE4F2098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729141AbeJLXBW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 19:01:22 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:38836 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729143AbeJLXBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 19:01:21 -0400
Received: by mail-lf1-f65.google.com with SMTP id g89-v6so9620782lfl.5
        for <linux-kernel@vger.kernel.org>; Fri, 12 Oct 2018 08:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GFM2oP3MJfc+130hzvOJu+Jv6lZMWZtKqWiyV/fnKNk=;
        b=DCbpw9SqEnBsxxnOjmDWA6tPBCsJEHbvE81wQAuuLOI6ABDrTHgGnE0uuaDF/wnUM5
         fQswoFyMc7CB5tHUBsuyAoVusKd98O8kE9iqdgvAZuR53eExLnGd/uoEXD0gG+wbNnmg
         in9GtPPJdrRVZcQHD+/JM72btWSzzSTyGToaE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GFM2oP3MJfc+130hzvOJu+Jv6lZMWZtKqWiyV/fnKNk=;
        b=aDGwyKbLzvKvz8mydm2ZrUREUZ70ehBGiXAGIotAMbhiNjjmvihjxzQJFHlyVfV01B
         kWYUyoYIpf+WNt58sUB9hvMoyzVfzCxuNEMkyPzJwUCnfVAVHl9xdmewn4clCb6EMsQ6
         UQvg1xmT+bdZ0zC8WqM/V8XZuzv2PoMUcDTZ8AP71e7xsBzczSUgxUHL63X2hjLZb2ud
         1Fmso9if/Zf5CRcNQdq+q8THTJpQbSY1hUx+VdsFzXFtjBzv1Nezdl+yaJcNhTBzj+g7
         m7xcvrc8d2yE5RqJX0VYlLAZjLr0cG4gpwi8P5g5H+r3uKqMx2tUAF+JBQy8MYCNWrXd
         iB7w==
X-Gm-Message-State: ABuFfogsekEMNLHGz0pscEyt0XXe6Vxrsn2SXoBc+uyWc+GZcgZyrCxh
        DfwQ5EdAJxtzfuM1BLshgSSZMUK8/ZU=
X-Google-Smtp-Source: ACcGV60mD7eH1dR5rI5/vDLKFyuI8MHGAuUezV4Irw1x/rcVHVQwtpMUEr2rw+B6jH7G7uhSdaWj1Q==
X-Received: by 2002:a19:1063:: with SMTP id f96-v6mr4115224lfi.88.1539358100626;
        Fri, 12 Oct 2018 08:28:20 -0700 (PDT)
Received: from localhost.localdomain (59-201-94-178.pool.ukrtel.net. [178.94.201.59])
        by smtp.gmail.com with ESMTPSA id a63-v6sm325923ljf.54.2018.10.12.08.28.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Oct 2018 08:28:19 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     grygorii.strashko@ti.com, davem@davemloft.net
Cc:     linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH 1/2] net: ethernet: ti: cpsw_ale: use const for API having pointer on mac address
Date:   Fri, 12 Oct 2018 18:28:14 +0300
Message-Id: <20181012152815.31320-2-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181012152815.31320-1-ivan.khoronzhuk@linaro.org>
References: <20181012152815.31320-1-ivan.khoronzhuk@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It allows to use function under callbacks with same const qualifier of
mac address for farther changes.

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
 drivers/net/ethernet/ti/cpsw_ale.c | 12 ++++++------
 drivers/net/ethernet/ti/cpsw_ale.h |  8 ++++----
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/ti/cpsw_ale.c b/drivers/net/ethernet/ti/cpsw_ale.c
index 5766225a4ce1..798c989d5d93 100644
--- a/drivers/net/ethernet/ti/cpsw_ale.c
+++ b/drivers/net/ethernet/ti/cpsw_ale.c
@@ -136,7 +136,7 @@ static inline void cpsw_ale_get_addr(u32 *ale_entry, u8 *addr)
 		addr[i] = cpsw_ale_get_field(ale_entry, 40 - 8*i, 8);
 }
 
-static inline void cpsw_ale_set_addr(u32 *ale_entry, u8 *addr)
+static inline void cpsw_ale_set_addr(u32 *ale_entry, const u8 *addr)
 {
 	int i;
 
@@ -175,7 +175,7 @@ static int cpsw_ale_write(struct cpsw_ale *ale, int idx, u32 *ale_entry)
 	return idx;
 }
 
-static int cpsw_ale_match_addr(struct cpsw_ale *ale, u8 *addr, u16 vid)
+static int cpsw_ale_match_addr(struct cpsw_ale *ale, const u8 *addr, u16 vid)
 {
 	u32 ale_entry[ALE_ENTRY_WORDS];
 	int type, idx;
@@ -309,7 +309,7 @@ static inline void cpsw_ale_set_vlan_entry_type(u32 *ale_entry,
 	}
 }
 
-int cpsw_ale_add_ucast(struct cpsw_ale *ale, u8 *addr, int port,
+int cpsw_ale_add_ucast(struct cpsw_ale *ale, const u8 *addr, int port,
 		       int flags, u16 vid)
 {
 	u32 ale_entry[ALE_ENTRY_WORDS] = {0, 0, 0};
@@ -336,7 +336,7 @@ int cpsw_ale_add_ucast(struct cpsw_ale *ale, u8 *addr, int port,
 }
 EXPORT_SYMBOL_GPL(cpsw_ale_add_ucast);
 
-int cpsw_ale_del_ucast(struct cpsw_ale *ale, u8 *addr, int port,
+int cpsw_ale_del_ucast(struct cpsw_ale *ale, const u8 *addr, int port,
 		       int flags, u16 vid)
 {
 	u32 ale_entry[ALE_ENTRY_WORDS] = {0, 0, 0};
@@ -352,7 +352,7 @@ int cpsw_ale_del_ucast(struct cpsw_ale *ale, u8 *addr, int port,
 }
 EXPORT_SYMBOL_GPL(cpsw_ale_del_ucast);
 
-int cpsw_ale_add_mcast(struct cpsw_ale *ale, u8 *addr, int port_mask,
+int cpsw_ale_add_mcast(struct cpsw_ale *ale, const u8 *addr, int port_mask,
 		       int flags, u16 vid, int mcast_state)
 {
 	u32 ale_entry[ALE_ENTRY_WORDS] = {0, 0, 0};
@@ -386,7 +386,7 @@ int cpsw_ale_add_mcast(struct cpsw_ale *ale, u8 *addr, int port_mask,
 }
 EXPORT_SYMBOL_GPL(cpsw_ale_add_mcast);
 
-int cpsw_ale_del_mcast(struct cpsw_ale *ale, u8 *addr, int port_mask,
+int cpsw_ale_del_mcast(struct cpsw_ale *ale, const u8 *addr, int port_mask,
 		       int flags, u16 vid)
 {
 	u32 ale_entry[ALE_ENTRY_WORDS] = {0, 0, 0};
diff --git a/drivers/net/ethernet/ti/cpsw_ale.h b/drivers/net/ethernet/ti/cpsw_ale.h
index d4fe9016429b..cd07a3e96d57 100644
--- a/drivers/net/ethernet/ti/cpsw_ale.h
+++ b/drivers/net/ethernet/ti/cpsw_ale.h
@@ -105,13 +105,13 @@ void cpsw_ale_start(struct cpsw_ale *ale);
 void cpsw_ale_stop(struct cpsw_ale *ale);
 
 int cpsw_ale_flush_multicast(struct cpsw_ale *ale, int port_mask, int vid);
-int cpsw_ale_add_ucast(struct cpsw_ale *ale, u8 *addr, int port,
+int cpsw_ale_add_ucast(struct cpsw_ale *ale, const u8 *addr, int port,
 		       int flags, u16 vid);
-int cpsw_ale_del_ucast(struct cpsw_ale *ale, u8 *addr, int port,
+int cpsw_ale_del_ucast(struct cpsw_ale *ale, const u8 *addr, int port,
 		       int flags, u16 vid);
-int cpsw_ale_add_mcast(struct cpsw_ale *ale, u8 *addr, int port_mask,
+int cpsw_ale_add_mcast(struct cpsw_ale *ale, const u8 *addr, int port_mask,
 		       int flags, u16 vid, int mcast_state);
-int cpsw_ale_del_mcast(struct cpsw_ale *ale, u8 *addr, int port_mask,
+int cpsw_ale_del_mcast(struct cpsw_ale *ale, const u8 *addr, int port_mask,
 		       int flags, u16 vid);
 int cpsw_ale_add_vlan(struct cpsw_ale *ale, u16 vid, int port, int untag,
 			int reg_mcast, int unreg_mcast);
-- 
2.17.1

