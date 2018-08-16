Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03E63C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 11:42:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EBDD20C03
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 11:42:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="ATqcspov"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EBDD20C03
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391299AbeHPOkP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 10:40:15 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:33310 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391286AbeHPOkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 10:40:15 -0400
Received: by mail-ed1-f65.google.com with SMTP id x5-v6so2504416edr.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Aug 2018 04:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=V66+xGepQFjZmPSUVX1IzO9ogdAfUKulrbjGYOoVRoI=;
        b=ATqcspovY8d3zE5cwSKJoOpgZvJFRFFj0Rdl+1S1L2NARXrwg97WkkXDouI/RoMOKg
         M5PLDNgzjIkMvMslvdidjvlBNPQnDJ/dP4xbeWNVavKt3704aeCVd5My7KsPPxlYICZc
         nRbliEKJTQd/jke3cnEiixvR3GTGeYnWDQ88o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=V66+xGepQFjZmPSUVX1IzO9ogdAfUKulrbjGYOoVRoI=;
        b=PQK4wIJkr0Db+DVXKWXQTw+0idBjewdzZkmuZGS+H0IafVXY4tE/iFppyp+jiHgQtD
         V8aJrNKwxm8yZtW528F9rZ2UJEMZuTtR1h4mKoPRfAW/SU4LorKwKFjozZY4I5WL3YnJ
         AWNimhoR6Qu/X5vqEKGQPtJtwNzhNpp2mLAk6sffvxIMUj80pe4Q3WMw4Z/OazHa/8+s
         8zDLeV3R6rlrpLbY/XRVqoeHRYnVZ4BioJ0drCExubjVvulckAnNo1qrN+gq0/BprFsz
         LlAX1gylCpo89TvnrFnHIbADgswufEHgd0kDX4qBBoKVQIKMnjjs3sJjwTvLgScMvNSY
         tMVQ==
X-Gm-Message-State: AOUpUlFs+MeXj+1DAeXOPqi+xf1JADU1v5+ICLkH8AUw959bITHvkf87
        abFE4mNPCSCtZzGZa/r/9m6L6g==
X-Google-Smtp-Source: AA+uWPypl2XShIpIcFDxA7XpQnRM3ctN3WHDKt02H2ehjKjq8TTo3eHUPO5JBwCYjdIVD+9C8p9cRA==
X-Received: by 2002:a50:9154:: with SMTP id f20-v6mr36104301eda.29.1534419732570;
        Thu, 16 Aug 2018 04:42:12 -0700 (PDT)
Received: from prevas-ravi.waoo.dk (dhcp-5-186-120-115.cgn.ip.fibianet.dk. [5.186.120.115])
        by smtp.gmail.com with ESMTPSA id k16-v6sm356450edq.89.2018.08.16.04.42.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 16 Aug 2018 04:42:11 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ia64/sn/hwperf: check seq_open return value to avoid NULL deref
Date:   Thu, 16 Aug 2018 13:42:02 +0200
Message-Id: <20180816114202.7094-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This code should check the return value of seq_open(); if it failed,
file->private_data is NULL. But in that case we then need to dispose of
objbuf to prevent a resource leak.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 arch/ia64/sn/kernel/sn2/sn_hwperf.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/ia64/sn/kernel/sn2/sn_hwperf.c b/arch/ia64/sn/kernel/sn2/sn_hwperf.c
index 55febd65911a..9e36f0b7d9ae 100644
--- a/arch/ia64/sn/kernel/sn2/sn_hwperf.c
+++ b/arch/ia64/sn/kernel/sn2/sn_hwperf.c
@@ -947,8 +947,12 @@ int sn_topology_open(struct inode *inode, struct file *file)
 
 	if ((e = sn_hwperf_enum_objects(&nobj, &objbuf)) == 0) {
 		e = seq_open(file, &sn_topology_seq_ops);
-		seq = file->private_data;
-		seq->private = objbuf;
+		if (e) {
+			vfree(objbuf);
+		} else {
+			seq = file->private_data;
+			seq->private = objbuf;
+		}
 	}
 
 	return e;
-- 
2.16.4

