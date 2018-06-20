Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46220C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:44:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02DA3208B3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:44:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="OQJZdZFT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02DA3208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932855AbeFTIo0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 04:44:26 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:45032 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932505AbeFTImu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 04:42:50 -0400
Received: by mail-lf0-f66.google.com with SMTP id p23-v6so3664455lfh.11
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 01:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+R4eGX5eAJCC9sbXyeuYvo0XKQNvBJaTjc88N6RgIzo=;
        b=OQJZdZFTa3D64IzYYsSW4wLNuSHE+ja5yxDvahiFzZx+tt4QNzHhK5sVt2WALyrZNz
         Kq1zc6IJyJAyReZU4ek3iM9iWq60++VFr9sJeki0KmdFmdZaFlRB7Z3HYqlHRSp1d6RR
         Gt2tUjxFI2xfPX/O/VihEFZHNDskTxMk1DfXc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+R4eGX5eAJCC9sbXyeuYvo0XKQNvBJaTjc88N6RgIzo=;
        b=t9ac9YhFj7uKEelzE52BxgHmIy+YYeHSm1Qmd7pwKlhndMLdaeu68CacHbf/+WYbju
         GEZnunUeBqKwtnYCuMJxlD6Lr5fZ+8VqOVi9lRI7Zg0d0nG1Y5Jy8xTeqRRq688q4prv
         AWhytL3FcAZQMHgtruz+0PAGiXTF/gRTeNI16EiQjH7bYGSVgR4MMq2AP6qVof8/IwFk
         WPkROBkcfllLLsfWU6Mu5f8EwaYv6oQehMzIoCdWs2blpeEG3IIW+kcktdznZZGBzCe9
         zaZPQGxbdXqQmg+UQWzxpJnkCnKGMM0gJhMt+8dSjv7OVm3ixmfT9/EYsjUU5bLG4pIU
         qe2Q==
X-Gm-Message-State: APt69E2lSKFVzf3wunuJwt0y2/tTxXwIQs89mwovbcR+47poD4ceylhg
        5U/2yp8hUnxKEujIr/cvdj8KMg==
X-Google-Smtp-Source: ADUXVKLk5vN+pCKA0ypIs1GzzEFc6MxtzGYIX07/bZ6PwakcI8o9lADjeoSnUQbSzBMuMgqdXqvIMQ==
X-Received: by 2002:a2e:5111:: with SMTP id f17-v6mr11538634ljb.16.1529484169027;
        Wed, 20 Jun 2018 01:42:49 -0700 (PDT)
Received: from centauri.lan (h-229-118.A785.priv.bahnhof.se. [5.150.229.118])
        by smtp.gmail.com with ESMTPSA id h90-v6sm296656ljf.65.2018.06.20.01.42.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Jun 2018 01:42:48 -0700 (PDT)
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>
Cc:     alagusankar@silex-india.com,
        Niklas Cassel <niklas.cassel@linaro.org>,
        ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] ath10k: sdio: set skb len for all rx packets
Date:   Wed, 20 Jun 2018 10:42:22 +0200
Message-Id: <20180620084222.3521-4-niklas.cassel@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180620084222.3521-1-niklas.cassel@linaro.org>
References: <20180620084222.3521-1-niklas.cassel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Without this, packets larger than 1500 will silently be dropped.
Easily reproduced by sending a ping packet with a size larger
than 1500.

Signed-off-by: Alagu Sankar <alagusankar@silex-india.com>
Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
---
 drivers/net/wireless/ath/ath10k/sdio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/ath/ath10k/sdio.c b/drivers/net/wireless/ath/ath10k/sdio.c
index 0c57d6aaa437..8ac47b04a17e 100644
--- a/drivers/net/wireless/ath/ath10k/sdio.c
+++ b/drivers/net/wireless/ath/ath10k/sdio.c
@@ -396,6 +396,7 @@ static int ath10k_sdio_mbox_rx_process_packet(struct ath10k *ar,
 	int ret;
 
 	payload_len = le16_to_cpu(htc_hdr->len);
+	skb->len = payload_len + sizeof(struct ath10k_htc_hdr);
 
 	if (trailer_present) {
 		trailer = skb->data + sizeof(*htc_hdr) +
-- 
2.17.1

