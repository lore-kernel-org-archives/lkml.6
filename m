Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8F92C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 12:13:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71C2520842
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 12:13:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="awy8TMgQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71C2520842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729130AbeIYSUZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 14:20:25 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:34957 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727531AbeIYSUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 14:20:25 -0400
Received: by mail-ed1-f67.google.com with SMTP id y21-v6so6865954edr.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 05:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BmpJkDN07E+AS9yjKsUuKkRKgiK5CZIb2pORABiNKMc=;
        b=awy8TMgQC4gp8pAmlvDps2Pc7etAhMwF33txOl3Pk3sUgWlY/t3BYP/w6Bw3xytfG2
         hZgn4dMkeXdgIcLtUfqIUPC1VC4sdBetbwyKmrRHMcaOFxv4DV1Lsi45UaZzNGP8fD/q
         9Xj5A32FgKeUTh3vlWV7MP6sFgTrsn2fyQKps=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BmpJkDN07E+AS9yjKsUuKkRKgiK5CZIb2pORABiNKMc=;
        b=Lbp+lzIeVdnHc0+3O5C5N7OOHdfSbnUcvI817lTb3G51Jtu2efQ6qYpfSkkFgxjpkY
         h2mLN20YhsnrqdTaxB/PnXGuNpJP0npDAhbX5mC3HOJf9e++iPgUcH8pFuBCKgZLwCZP
         u6SRpHXxebct1B07Z9djoZALCdwSMZs262HOIsbE8D26pfP54ncmaeNBt2EYI4A5+AVH
         T5e+QaHiCtDjeOjIXXlMZ2q6wk3RSbtCMUy/cuR7aHtRQ2JJR1COqOY7kUreiFbvgdC+
         WQRjss1LGH6tL3BYE5uuk4hxtbXw1OY+aA23yCj2OQdeCyU9XHxrr8qKDAOkJUZZ5i7b
         wyfg==
X-Gm-Message-State: ABuFfog9NQMpN+hNYMQxPDbBqKyhVCYEGwPWqNj2wY4doC3i5Fnqo2M2
        W6DPe+WDxeHLDcV08AqP4mzq6lNd+4f0KQ==
X-Google-Smtp-Source: ACcGV63+yTmvZ0tiu0lHrn7jpJc3B8qwUAwJKWVxCjqIKzzZgGER2kA1psag5qHS+KL071becISNOA==
X-Received: by 2002:a50:a705:: with SMTP id h5-v6mr689686edc.162.1537877587473;
        Tue, 25 Sep 2018 05:13:07 -0700 (PDT)
Received: from andrea.amarulasolutions.com (85.100.broadband17.iol.cz. [109.80.100.85])
        by smtp.gmail.com with ESMTPSA id a11-v6sm6739522edn.95.2018.09.25.05.13.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 05:13:06 -0700 (PDT)
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andrea Parri <andrea.parri@amarulasolutions.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        uclinux-h8-devel@lists.sourceforge.jp
Subject: [PATCH 2/2] h8300/bitops: Remove smp_mb__{before,after}_clear_bit()
Date:   Tue, 25 Sep 2018 14:12:25 +0200
Message-Id: <20180925121225.9917-3-andrea.parri@amarulasolutions.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180925121225.9917-1-andrea.parri@amarulasolutions.com>
References: <20180925121225.9917-1-andrea.parri@amarulasolutions.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The barriers are unused; remove their definition.

Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: <uclinux-h8-devel@lists.sourceforge.jp>
---
 arch/h8300/include/asm/bitops.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/h8300/include/asm/bitops.h b/arch/h8300/include/asm/bitops.h
index 647a83bd40b70..7aa16c732aa9f 100644
--- a/arch/h8300/include/asm/bitops.h
+++ b/arch/h8300/include/asm/bitops.h
@@ -51,12 +51,6 @@ static inline void FNAME(int nr, volatile unsigned long *addr)	\
 	}							\
 }
 
-/*
- * clear_bit() doesn't provide any barrier for the compiler.
- */
-#define smp_mb__before_clear_bit()	barrier()
-#define smp_mb__after_clear_bit()	barrier()
-
 H8300_GEN_BITOP(set_bit,    "bset")
 H8300_GEN_BITOP(clear_bit,  "bclr")
 H8300_GEN_BITOP(change_bit, "bnot")
-- 
2.17.1

