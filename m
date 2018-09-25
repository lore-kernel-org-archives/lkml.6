Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABE03C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 12:13:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60D0720842
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 12:13:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="l6Ukytcq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60D0720842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729099AbeIYSUU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 14:20:20 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:44392 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727531AbeIYSUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 14:20:19 -0400
Received: by mail-ed1-f67.google.com with SMTP id t11-v6so3532783edq.11
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 05:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2m92S3b88nnBwqQ1wfTMpyZvQhB+d+NfSNFR716x/D4=;
        b=l6UkytcqE3uswZr51nb5PDoAm503ScJYIHR4wM8YGMapY86ATjYVldX0otz8XPV0hx
         QHUVdBmUSvvGSom26vY7ncBO15CDFoMz5Tye7Fab3OpbhgKyoxZPYThxCfEJh/1XbUwu
         ZNjdwzHhk2/eLG8GffYaRREV6VD8L2eoUSlKU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2m92S3b88nnBwqQ1wfTMpyZvQhB+d+NfSNFR716x/D4=;
        b=ntM2RO6a9GgJfhgUGHSe6AKXIYgV1KmtQCSkzsvclXqYTPcAl2sQ2HnIbGW8iva2dW
         y6kD07Fpmn9i58QB7+DtKfg0LkMASQwF9Nx7FPfXlteF5Jopn9eWYb4OlU6GjpZKgQ4P
         ReSqg563s1AGbvqPNlxQJGXIXo9H+XXIK29dfXruuSEq6U1ydOvnpozZuTslbRuMTwjJ
         Z3WSSbLzqhEXkb1wUsM6MSmE43W+SKvT51WCoogPk53OZbS34XqMzBaAI4iB5B/DwXce
         Rxm+2HgF7VE2QJMmvY2cVM44a6YX5pViMMMHlUywZmoErsVJpnqmTeN1yx5j4p9FEqlC
         PqzQ==
X-Gm-Message-State: ABuFfohq0j2UsjRVFvcgJ9xHjsr6STlX7uENCkI7n+8P4jDfuFtIqDZi
        c3Rx/c926Lc6yYAaf7wG8S9y/ijPci9uSg==
X-Google-Smtp-Source: ACcGV6397GTlvO5hBc3au8aBB6sURP6UyjRCA+SIKmcNBTRIxZ6ZT2TvQpsvrerO0ONicnim3huNWA==
X-Received: by 2002:a50:b410:: with SMTP id b16-v6mr680402edh.190.1537877582572;
        Tue, 25 Sep 2018 05:13:02 -0700 (PDT)
Received: from andrea.amarulasolutions.com (85.100.broadband17.iol.cz. [109.80.100.85])
        by smtp.gmail.com with ESMTPSA id a11-v6sm6739522edn.95.2018.09.25.05.13.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 05:13:02 -0700 (PDT)
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andrea Parri <andrea.parri@amarulasolutions.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org
Subject: [PATCH 1/2] riscv/bitops: Remove smp_mb__{before,after}_clear_bit()
Date:   Tue, 25 Sep 2018 14:12:24 +0200
Message-Id: <20180925121225.9917-2-andrea.parri@amarulasolutions.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180925121225.9917-1-andrea.parri@amarulasolutions.com>
References: <20180925121225.9917-1-andrea.parri@amarulasolutions.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The barriers are unused; remove their definition.

Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: <linux-riscv@lists.infradead.org>
---
 arch/riscv/include/asm/bitops.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/riscv/include/asm/bitops.h b/arch/riscv/include/asm/bitops.h
index f30daf26f08f4..01db98dfd0435 100644
--- a/arch/riscv/include/asm/bitops.h
+++ b/arch/riscv/include/asm/bitops.h
@@ -23,11 +23,6 @@
 #include <asm/barrier.h>
 #include <asm/bitsperlong.h>
 
-#ifndef smp_mb__before_clear_bit
-#define smp_mb__before_clear_bit()  smp_mb()
-#define smp_mb__after_clear_bit()   smp_mb()
-#endif /* smp_mb__before_clear_bit */
-
 #include <asm-generic/bitops/__ffs.h>
 #include <asm-generic/bitops/ffz.h>
 #include <asm-generic/bitops/fls.h>
-- 
2.17.1

