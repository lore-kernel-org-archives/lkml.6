Return-Path: <SRS0=KDb5=I5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 66F41C004E4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 21:10:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15CB92086D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 21:10:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KzkYGh54"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15CB92086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754164AbeFKVKB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 17:10:01 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:41457 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752801AbeFKVKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 17:10:00 -0400
Received: by mail-pl0-f66.google.com with SMTP id az12-v6so13019771plb.8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 14:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=27owysnX14HEcDVIWfr1qFoh0CBLmYb3+9NO+C2BgoU=;
        b=KzkYGh54E9JoTqD3jvrOfCcgRI3yP3UaJ2jlYsNgblqq/IC167fGalTUaLqI0rS/Np
         QVhMuiSYn0xfzuTz+iFVyCWQs1jlEFfqoiupHW46ESYSIxchB4HTTaBks0/+l6dLrxpw
         OUmNGsZJp3feyujF+cjG4GhpRb+Iit4oiGgnA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=27owysnX14HEcDVIWfr1qFoh0CBLmYb3+9NO+C2BgoU=;
        b=bF7AZGKJT+wTe8N+2R4YfELc3BBSm1/xWI7/TlUYV8gfSK2CgAPZnPFQUoeBI+AB1a
         cH3Ob/B2Q0Q6dkOlSYKfkcbCQH7hP1xP1GTPVljLhDgs/bic7S+IAKMET0TpYnmGYvpC
         rWXJxONQZl23eJUn+dTxnn1XKG1hdm8VkjgBZmo0yKcoVhSnNW+xyKEU68NfPmK5jXkk
         PNoq/yIYdxOOgWrvNW52x9VqXBvw8yqdRWBd1iA3HR7x5DE+Y7qe+zorMrDxPo90Sp2Y
         SJrUKfErFLVjd+472fii2HC2rboopduwb4dzSAbi2nTjEDCanmq8x7OFYiY31gY4c6Qb
         QWwg==
X-Gm-Message-State: APt69E0ET23jFL0XbCF6DwlKwAlaXYi+wKfb4RNZtuJWAidQlDLyj2qj
        ESTjofWFg5bUt5TKOC06AzgSyQ==
X-Google-Smtp-Source: ADUXVKIJHWB4qXfITSZ6UB8yuF79x0rbO2pXHIzKzhe+KRrvApOJY5C8hkHcxMXH+oqnOrp7bUhVRw==
X-Received: by 2002:a17:902:76c4:: with SMTP id j4-v6mr792401plt.19.1528751399771;
        Mon, 11 Jun 2018 14:09:59 -0700 (PDT)
Received: from ban.mtv.corp.google.com ([2620:0:1000:1501:bc2f:3082:9938:5d41])
        by smtp.gmail.com with ESMTPSA id c4-v6sm49116184pfe.53.2018.06.11.14.09.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 14:09:58 -0700 (PDT)
From:   Brian Norris <briannorris@chromium.org>
To:     Kalle Valo <kvalo@qca.qualcomm.com>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Govind Singh <govinds@codeaurora.org>,
        <linux-kernel@vger.kernel.org>,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH 1/4] ath10k: snoc: use correct bus-specific pointer in RX retry
Date:   Mon, 11 Jun 2018 14:09:43 -0700
Message-Id: <20180611210946.241341-1-briannorris@chromium.org>
X-Mailer: git-send-email 2.18.0.rc1.242.g61856ae69a-goog
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We're 'ath10k_snoc', not 'ath10k_pci'. This probably means we're
accessing junk data in ath10k_snoc_rx_replenish_retry(), unless
'ath10k_snoc' and 'ath10k_pci' happen to have very similar struct
layouts.

Noticed by inspection.

Fixes: d915105231ca ("ath10k: add hif rx methods for wcn3990")
Signed-off-by: Brian Norris <briannorris@chromium.org>
---
It's possible this would be a for-4.18 target, since the buggy patch is
in the -rc1 merge. But this driver is not fully operational yet. Also,
I'm sending some companion refactorings to help avoid this bug. They
probably aren't 4.18 material.

Let me know if I should do anything differently.

 drivers/net/wireless/ath/ath10k/snoc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath10k/snoc.c b/drivers/net/wireless/ath/ath10k/snoc.c
index ee74e0060504..c7cfc9c9b3d7 100644
--- a/drivers/net/wireless/ath/ath10k/snoc.c
+++ b/drivers/net/wireless/ath/ath10k/snoc.c
@@ -449,7 +449,7 @@ static void ath10k_snoc_htt_rx_cb(struct ath10k_ce_pipe *ce_state)
 
 static void ath10k_snoc_rx_replenish_retry(struct timer_list *t)
 {
-	struct ath10k_pci *ar_snoc = from_timer(ar_snoc, t, rx_post_retry);
+	struct ath10k_snoc *ar_snoc = from_timer(ar_snoc, t, rx_post_retry);
 	struct ath10k *ar = ar_snoc->ar;
 
 	ath10k_snoc_rx_post(ar);
-- 
2.18.0.rc1.242.g61856ae69a-goog

