Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 968B9C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 01:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 467B9263A8
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 01:00:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="X2Nc5gN0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 467B9263A8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935231AbeFZBAw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 21:00:52 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:39458 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755801AbeFZA7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 20:59:06 -0400
Received: by mail-it0-f68.google.com with SMTP id p185-v6so15059873itp.4
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 17:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xNjMY2VoPRCAGDy/phZ/JtqeH0mk6bVlwd6yiC6mUcw=;
        b=X2Nc5gN0Ie6Lz6LS2EKGw2QKVyjqLyVqFUvlAB4YdQnr+cFTwwMM/U6wN/LX4rjovU
         9RseU3tIKf2Y8J1zmA3oXW92xMKq9n0zof9KJuLlDcO3TXETdTc0uSzNaB1T4A8znDRT
         H6Goj/98dlxq5YH1piwJ9kEZ5smGfYww/1xe4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xNjMY2VoPRCAGDy/phZ/JtqeH0mk6bVlwd6yiC6mUcw=;
        b=BcIBsf0GjhhfTALxmpo9Okd0jBwlg7fff2H01BVQKMVjPaIEE4NRhy41Ma1xmcT6Co
         LYX0w+9/LNph7pFJ5qP7bSn4g87UJ81vI8w5PYffhku/CMWdUu1g7vOrE+ZowfnL+e8v
         8446Dv4v4lIqgtzyGw6JnnMIkSRQ9kDdqgdz/JLHHK2U6vFMOXEoLd1veLCPCTlxeDmZ
         oqs7xwTWoxAzHxr8BZ+xQs8h8VGLMf8rEGSt2wH7V0i1aqh3CAakeG4wvrbeqYS+DHCZ
         tFgNrHK7g3TCkth3e3ubzD/V/EJjAnFilK75i9twBpgOYM55MVRzc29usY7IkFs6ltoh
         P2zg==
X-Gm-Message-State: APt69E1RswXRN0pgpiWs/GxqlQg6l7Ttmi7uY1fRAI5Cdy+7NrPUt8qM
        gZWIjXE2JonvNdIqNqR2vtBrdg==
X-Google-Smtp-Source: ADUXVKKQwq8j9h1ttppa3fYuJrNH92pYA5u4auEzKLL/9Xi8nByigAeabPh/u472uSmEqQUtv1lZbw==
X-Received: by 2002:a24:c054:: with SMTP id u81-v6mr2664109itf.94.1529974745230;
        Mon, 25 Jun 2018 17:59:05 -0700 (PDT)
Received: from localhost.localdomain (c-71-195-29-92.hsd1.mn.comcast.net. [71.195.29.92])
        by smtp.gmail.com with ESMTPSA id f193-v6sm372556itf.9.2018.06.25.17.59.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 17:59:04 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     andy.gross@linaro.org
Cc:     clew@codeaurora.org, aneela@codeaurora.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH resend 04/12] soc: qcom: smem: small refactor in qcom_smem_enumerate_partitions()
Date:   Mon, 25 Jun 2018 19:58:48 -0500
Message-Id: <20180626005856.14174-5-elder@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180626005856.14174-1-elder@linaro.org>
References: <20180626005856.14174-1-elder@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Combine the code that checks whether a partition table entry is
associated with the local host with the assignment of the remote
host id value.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/soc/qcom/smem.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
index 83ba549cfea0..5d3ed510e54b 100644
--- a/drivers/soc/qcom/smem.c
+++ b/drivers/soc/qcom/smem.c
@@ -815,13 +815,12 @@ static int qcom_smem_enumerate_partitions(struct qcom_smem *smem,
 
 		host0 = le16_to_cpu(entry->host0);
 		host1 = le16_to_cpu(entry->host1);
-		if (host0 != local_host && host1 != local_host)
-			continue;
-
 		if (host0 == local_host)
 			remote_host = host1;
-		else
+		else if (host1 == local_host)
 			remote_host = host0;
+		else
+			continue;
 
 		if (remote_host >= SMEM_HOST_COUNT) {
 			dev_err(smem->dev,
-- 
2.17.1

