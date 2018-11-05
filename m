Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB2FCC46475
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 15:34:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FF9B2085B
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 15:34:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SW7eV0i+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FF9B2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729810AbeKFAyx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 19:54:53 -0500
Received: from mail-pf1-f181.google.com ([209.85.210.181]:38279 "EHLO
        mail-pf1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727623AbeKFAyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 19:54:52 -0500
Received: by mail-pf1-f181.google.com with SMTP id b11-v6so4602036pfi.5
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 07:34:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=r5uZv0RCgn9wzjZbqwM46nUUC+0snod25QSmzs7r9yw=;
        b=SW7eV0i+Awy3YE4+q1Bdd6yG0v7k+GCOKSg31YYRAf+EnWivYloziVoUbBAU+GGP9G
         XX8/wQ3qLXqhWhCWMnzZefltDWMa9g6IEDvqRFxpfIkqsjNByPTEXs48H66IelwnICzs
         loXktGjTwEbEyuPgeV6iPcxkPLbOYjULKsUNnGgeCz6Q3+7ELJulzeQHvXt3xt7HLNk+
         TCsH3OGA82//CM16HgkHJDh6a0FN/mugxi1EY+nW8ZMupj8NET12DlQSO3H6UH8KgODQ
         MtA8Fayr4bSP6FmJ9GoH8uTHjkXaLjCKMMudaOfawJA5h+usyjoIVnRw/BbIhhv2aD7T
         AfwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=r5uZv0RCgn9wzjZbqwM46nUUC+0snod25QSmzs7r9yw=;
        b=eD/8qHlPxfABGRPF+2sQESTUCPjzzOCzryCk5lYXghbUy0jga8oUd4lpadUrkBAOvV
         pQFKLXg1fdrpqbNRvPMLsXHBy6rQDkFjPd0StB1F+mw+xKGRVUhwFQxzRJPSRXHgYEGP
         k6uCVDJTUG2BXl5cocCyy+sxGAO+IKLBF2vf4fjkCpQ3AOIo3Us/6n+m6i2b4hLRxOzc
         TvljOSHKSsT5rkspzkg0CrxsNk4jm4LjzNq9exL1A5YWHPHJGcJVDJYNkmXzlJ5ZfYw9
         6tSNF7GRaNRF476cPfAbyLXEEA6g4w5OV1nPXQ0BB7ffvzy1HotxZuV0bTm8/dGJjMiB
         JV+g==
X-Gm-Message-State: AGRZ1gLxkhr4l1gwQEeFRaXJMGyU+xXtTivVnPfevXViPjqojl5NMWux
        IuI+3FzhqCuveweTYb3iJcw=
X-Google-Smtp-Source: AJdET5ev8K44VjHTLv3SRYNtwGbeb2rRazdZ5ZZ7RGzGwfHGXjXg63h8rdbxc6VOsP1pvTP07rAi0g==
X-Received: by 2002:a63:f652:: with SMTP id u18-v6mr20725940pgj.267.1541432076843;
        Mon, 05 Nov 2018 07:34:36 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id u7-v6sm53536595pfl.34.2018.11.05.07.34.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Nov 2018 07:34:35 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     gregkh@linuxfoundation.org, natechancellor@gmail.com
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [RESEND] staging: rtl8723bs: fix small typo
Date:   Mon,  5 Nov 2018 10:34:33 -0500
Message-Id: <20181105153433.6923-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ture->true

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/staging/rtl8723bs/include/rtw_cmd.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/include/rtw_cmd.h b/drivers/staging/rtl8723bs/include/rtw_cmd.h
index 1530d0ea1d51..7dc5bf050839 100644
--- a/drivers/staging/rtl8723bs/include/rtw_cmd.h
+++ b/drivers/staging/rtl8723bs/include/rtw_cmd.h
@@ -543,7 +543,7 @@ struct Tx_Beacon_param
 
 	mac[0] == 0
 	==> CMD mode, return H2C_SUCCESS.
-	The following condition must be ture under CMD mode
+	The following condition must be true under CMD mode
 		mac[1] == mac[4], mac[2] == mac[3], mac[0]=mac[5]= 0;
 		s0 == 0x1234, s1 == 0xabcd, w0 == 0x78563412, w1 == 0x5aa5def7;
 		s2 == (b1 << 8 | b0);
-- 
2.17.0

