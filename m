Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80750C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 14:21:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 340622145D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 14:21:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ClDugRdv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 340622145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728223AbeJRWWv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 18:22:51 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46943 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726924AbeJRWWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 18:22:51 -0400
Received: by mail-pl1-f193.google.com with SMTP id v5-v6so14388509plz.13
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 07:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=rrV0+StIJRy1F+te7mRBqkIHi8Zb86g4uzSBQ0Z1bWY=;
        b=ClDugRdvPtrr3UMH8VEYgs24Z9vHQh4sZtUAIva+8LTMZRGVpcXdtPsIxWINstUQ9R
         dCqI9Ni6y4OoKrBP/69Qw+h1aIqj0UwaA9O0was22bYZ5KyU8icAudXY+NyNlYW9YYjW
         3xsZhPDd9kXYTtVLdd6NmXvk0d/w58VaaoQi5vXIu2p3T19WPv20Bq0nnD2SoUPp7olV
         lIHu1RcPmpzQ+sAEi1UX2rnYkz1vQzZwmF7OCJfyVbXc6Sb+SHo1VRbBczHQ4u6prPT+
         W/RfWbKQKwvD3t1oD1XuCuPvRveWJwfHvzJ1YIMbTP1CVsK9YHXWsWNhiBrDSUAWv3aR
         K6RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=rrV0+StIJRy1F+te7mRBqkIHi8Zb86g4uzSBQ0Z1bWY=;
        b=atKxpH1G2ruwX9FStnfWzEVJTDdBugb1TUubdaO0xxsNfq8tRGywqKvPCIdEWC9AnL
         GwCQsoMav9GhF5oIWynVZvSh+gfDmeFN8HWE2DhsxkngW1+3YI2REGYTEkox5lL3OEpR
         QClw1ijw7odbLawGWy2oPvjsk9UyiMvCGDorT+rMPsSbH/dOax7opgnmWQgxbZdiAqnU
         qARAsC/lkwlyxe9NJseQ7FQ6jmNpO9tvt+Mf59zzEmDR4iTOnjYhxvFAFAz08ZHs617X
         RWXluc6Ci0xJVcxbk9B9ZHkh5Afeojw/JAj9lh0KB82M0dlSTwvAlxcrujw6bbwktpjU
         lGuQ==
X-Gm-Message-State: ABuFfoj4Ehp8KsG5KMIKXJIdy53D3uOOujolRzd0yxt9DLOUb7AVhU0H
        4m7pgLdC9h2Syyk/ZM7tzcE=
X-Google-Smtp-Source: ACcGV63SKt6dW9Hi0dI4kAzSmAYomFUMcH7e5xuzH/ZRKipVJHimcsnMVaW7DuFVmi8Bkkr5Kg/Eig==
X-Received: by 2002:a17:902:45a5:: with SMTP id n34-v6mr24235647pld.341.1539872496993;
        Thu, 18 Oct 2018 07:21:36 -0700 (PDT)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id h123-v6sm31171094pfg.138.2018.10.18.07.21.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Oct 2018 07:21:36 -0700 (PDT)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     joel@joelfernandes.org, tglx@linutronix.de
Cc:     mingo@kernel.org, rostedt@goodmis.org, frederic@kernel.org,
        paulmck@linux.vnet.ibm.com, alexander.levin@verizon.com,
        linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] softirq: modify comments about PF_MEMALLOC in __do_softirq
Date:   Thu, 18 Oct 2018 10:21:33 -0400
Message-Id: <20181018142133.12341-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

---
 kernel/softirq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/softirq.c b/kernel/softirq.c
index 6f584861d329..6193e1d1b30d 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -257,7 +257,7 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
 	int softirq_bit;
 
 	/*
-	 * Mask out PF_MEMALLOC s current task context is borrowed for the
+	 * Mask out PF_MEMALLOC as current task context is borrowed for the
 	 * softirq. A softirq handled such as network RX might set PF_MEMALLOC
 	 * again if the socket is related to swap
 	 */
-- 
2.17.0

