Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 416B0C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 14:28:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC8C72084D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 14:28:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="OASQL+R6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC8C72084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728951AbeJEV13 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 17:27:29 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46708 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728619AbeJEV13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 17:27:29 -0400
Received: by mail-lj1-f193.google.com with SMTP id 203-v6so11755424ljj.13
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 07:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ogYZIIg3jvNPutt7I+YgjQNutCFZg37nIjKrMGnlwaQ=;
        b=OASQL+R6qTXGud0yk+9T8bgIpcdEUlACQlk6HDU1bNqzc7pdRPCjN7Cr4fkP3uVLIT
         pXyCr8eI7sn5FHq5ohGT43QXi8I6mogySlU7oNlVvST9Dkq2Zl7pVceiIKgJDlGZOv7E
         OPp7hPbHvM8X8GGm8I/9Av4TxNnHSirFG1i38=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ogYZIIg3jvNPutt7I+YgjQNutCFZg37nIjKrMGnlwaQ=;
        b=Vd/im6lcXywPw8Z2+753afnCGR2lILqeEzEtFbDK8cwQdSLigO4XZIYD2sbwLo2j4s
         619bhYltVFAgNeNjIshorxNHw1YPPsaNcM2NmM1/kqDxA2UHcLtVLXMEwwKIDIYXLAp1
         MObgD8EqMUrtzMldIV3MmYjTZgm+rMoKtJ1SbFM/kyC5ADLm5nnELAAxlqEL/6b4KblV
         21GBBENdbKtmoneyClHb7sEUZQJ7r870PeRn4nFb8UZ4w4vtECJOIDjFxIXpFAWPLrnD
         D/9iWkL0KBJPhVcxgLjfGVL6PIFEk4Ujs2KI6JUhTWjPIf+iD/iF4c9Ts/fcrJaBGBWK
         feQw==
X-Gm-Message-State: ABuFfoicxy3oR4ZsSvpTO62ARK5MnnpQZ8NQcATmuJCretJHE2a7wryw
        PbekD5GrSoDDRA0qSxHOFNwYiA==
X-Google-Smtp-Source: ACcGV63L/2188+ymzWznoAmCYW2Q4BRXp75R8XiiUAxvCdUHa35Ez8WUXTysdaAVRSDDMzMoSeNYxg==
X-Received: by 2002:a2e:8146:: with SMTP id t6-v6mr7463322ljg.32.1538749710101;
        Fri, 05 Oct 2018 07:28:30 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id g68-v6sm1888287lje.44.2018.10.05.07.28.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 05 Oct 2018 07:28:29 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     "Bryan O'Donoghue" <pure.logic@nexus-software.ie>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] staging: greybus: loopback.c: remove unused gb_loopback::lbid
Date:   Fri,  5 Oct 2018 16:28:24 +0200
Message-Id: <20181005142826.26108-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's not obvious how the code prevents adding more than 31 elements to
the list and thus invoking undefined behaviour in the 1 << new_lbid
expression, and in practice causing ->lbid values to repeat every 32
elements.

But the definition of struct gb_loopback is local to loopback.c, and the
lbid field is entirely unused outside of this function, so it seems we
can just drop it entirely.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
Since lbid isn't mentioned anywhere else in greybus/, it's hard to
figure out how it was meant to be used. It does seem like entirely
dead (write-only) code.

 drivers/staging/greybus/loopback.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/staging/greybus/loopback.c b/drivers/staging/greybus/loopback.c
index 42f6f3de967c..7080294f705c 100644
--- a/drivers/staging/greybus/loopback.c
+++ b/drivers/staging/greybus/loopback.c
@@ -97,7 +97,6 @@ struct gb_loopback {
 	u32 timeout_min;
 	u32 timeout_max;
 	u32 outstanding_operations_max;
-	u32 lbid;
 	u64 elapsed_nsecs;
 	u32 apbridge_latency_ts;
 	u32 gbphy_latency_ts;
@@ -1014,16 +1013,9 @@ static int gb_loopback_bus_id_compare(void *priv, struct list_head *lha,
 
 static void gb_loopback_insert_id(struct gb_loopback *gb)
 {
-	struct gb_loopback *gb_list;
-	u32 new_lbid = 0;
-
 	/* perform an insertion sort */
 	list_add_tail(&gb->entry, &gb_dev.list);
 	list_sort(NULL, &gb_dev.list, gb_loopback_bus_id_compare);
-	list_for_each_entry(gb_list, &gb_dev.list, entry) {
-		gb_list->lbid = 1 << new_lbid;
-		new_lbid++;
-	}
 }
 
 #define DEBUGFS_NAMELEN 32
-- 
2.19.0

