Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 7A80CC5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 11:39:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31DBE208BA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 11:39:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="AXtBfkqJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31DBE208BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933367AbeFLLjz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 07:39:55 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:36361 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932556AbeFLLji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 07:39:38 -0400
Received: by mail-lf0-f66.google.com with SMTP id u4-v6so35509855lff.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 04:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vFTi7s4U/f45GltnkDWLYM3rEREPqox/mTtdjzNYOG0=;
        b=AXtBfkqJyfc4RQ8ZYIVdkmzXeHyAc4oJFIftEKwydl/7j77/JbdEwPXuSYswb3K7qV
         CIbfyqK74FqVVo3Ehzyp/0kJVxU3ZmX0FbtPSurKRwGK2PorSdoTuhAbD5e4D2kZ/35K
         HhYOXYsq17Qq+UB06ZzU1idJgleT7tMueG0EM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vFTi7s4U/f45GltnkDWLYM3rEREPqox/mTtdjzNYOG0=;
        b=doSUD5sgKgLwX7dxYWJQHFnh+LzdJnBOhfSVw30bG/ipwP/PtyEv9EuFUWEP6ZQulc
         UfRm7wB426omve8TNkBFb5BM2MuyvdijnQcozHpOxJctv8/1q2HDFBYiw3dRnB3WtMLK
         g+OAjegl+ExlEUQc5V/9Uk1ILwVCo84Dgid+Haq9Q1bZv5FnZ3Nx9SdmX+ak4rn1qg51
         +8sqGfeLtdEuA6lBCP0bEbF0/4ABB5cJKlg/kK8V1MVZm+DJXAaKeKahB6G+uWg6SrDB
         pwB7YxJC9bAljX2Xgxbsjzt78SlppY+oo8L4A3nZ1fxLf6Hcpxpk1IaQJFJ72GgkYKtH
         /9vQ==
X-Gm-Message-State: APt69E1W40obEdJBN3fb+HkkOg9aIzWV6lU+wg87DMjy7PjtuUTDFKuS
        Trvyhe/jTUuAJDnOQE2AVSRgYw==
X-Google-Smtp-Source: ADUXVKKS+cwpIi8AFbjjOzeY9uiHRpQUPYYak0jvNzmpbJz/9Pch7SEtjFAZ3khNmpAWv4oR/NpB6Q==
X-Received: by 2002:a2e:55cf:: with SMTP id g76-v6mr22764lje.4.1528803577482;
        Tue, 12 Jun 2018 04:39:37 -0700 (PDT)
Received: from centauri.lan (h-229-118.A785.priv.bahnhof.se. [5.150.229.118])
        by smtp.gmail.com with ESMTPSA id o11-v6sm186162lji.0.2018.06.12.04.39.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Jun 2018 04:39:37 -0700 (PDT)
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Niklas Cassel <niklas.cassel@linaro.org>,
        ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] ath10k: allow ATH10K_SNOC with COMPILE_TEST
Date:   Tue, 12 Jun 2018 13:39:06 +0200
Message-Id: <20180612113907.15043-2-niklas.cassel@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180612113907.15043-1-niklas.cassel@linaro.org>
References: <20180612113907.15043-1-niklas.cassel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ATH10K_SNOC builds just fine with COMPILE_TEST, so make that possible.

Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
---
 drivers/net/wireless/ath/ath10k/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath10k/Kconfig b/drivers/net/wireless/ath/ath10k/Kconfig
index 54ff5930126c..6572a43590a8 100644
--- a/drivers/net/wireless/ath/ath10k/Kconfig
+++ b/drivers/net/wireless/ath/ath10k/Kconfig
@@ -42,7 +42,8 @@ config ATH10K_USB
 
 config ATH10K_SNOC
 	tristate "Qualcomm ath10k SNOC support (EXPERIMENTAL)"
-	depends on ATH10K && ARCH_QCOM
+	depends on ATH10K
+	depends on ARCH_QCOM || COMPILE_TEST
 	---help---
 	  This module adds support for integrated WCN3990 chip connected
 	  to system NOC(SNOC). Currently work in progress and will not
-- 
2.17.1

