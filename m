Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34BACC67863
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 03:25:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED8B720671
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 03:25:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="n/KxNjXu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED8B720671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727129AbeJXLvh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 07:51:37 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44347 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbeJXLvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 07:51:36 -0400
Received: by mail-pl1-f196.google.com with SMTP id d23-v6so1565606pls.11
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 20:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i9K0nyViFXBj0Drso8AJlM+PUE5qlmvWph59qni6wn8=;
        b=n/KxNjXuw6UA4CkVkKthC4ej7XwtLwUUPxdcOhrUDuo4U5SEuR5iLEzLxjlxqDmeTm
         98m3WGuMdHZUisCg/h7GfGBmRbRyDr4E/DaPyRSp4QwjobDkHFVi484fxQzag2+7GgAu
         CdDsq1nS4v9iqKHF0ag5jYfl8YVnOhRu1N1oc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i9K0nyViFXBj0Drso8AJlM+PUE5qlmvWph59qni6wn8=;
        b=SiF0bdIXLPcTdP04jlU1ACOjOfpAdUs2CWpR2rzdwaUwxlrSy/AF+Sv+dz0E/D+D0J
         rP3X5kebOnzjVtP4RCLDEbQKRXnp4slfPe1a9RYG5T7OqErU8ZZmC5E6Zd9NS3phQHiE
         RO2T9T6syq1a+toSsnM+JplXeE0UwiA962mOrZrYme2+iqrXK+IDTjPrsb11/30sVmyo
         gRypiN+TFcfUR9E8Y3BldG4PGGfsG7O5pDh1N2kGxeet1m8mUx24QOWXrfl9uNSRHCc2
         aOnfNHz9/jkVXcSeAtk1dUG3vWjWC/mVB2TjL8b9dkfZF7kXijsdwQt70g83rk4wVaTG
         46EQ==
X-Gm-Message-State: AGRZ1gIzqVdBMvajeTHAGJzIB6CN81spIhycQ6uXAzreqVsr0X3BH2ZM
        aCn6USf4BtaQw7t9drLsaWzxv529z7U=
X-Google-Smtp-Source: AJdET5ciNObA0Ldg4HIecnAIeKWC8gKU0jnseVL1j8He0/pTawyqD5GeQW+arrhXQwVhOgZsRMrI6g==
X-Received: by 2002:a17:902:2907:: with SMTP id g7-v6mr586984plb.201.1540344707606;
        Tue, 23 Oct 2018 18:31:47 -0700 (PDT)
Received: from exogeni.mtv.corp.google.com ([2620:15c:202:1:5e2b:39df:72ed:4968])
        by smtp.gmail.com with ESMTPSA id p4-v6sm3882341pfg.188.2018.10.23.18.31.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Oct 2018 18:31:46 -0700 (PDT)
From:   Derek Basehore <dbasehore@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-doc@vger.kernel.org,
        sboyd@kernel.org, mturquette@baylibre.com, heiko@sntech.de,
        aisheng.dong@nxp.com, mchehab+samsung@kernel.org, corbet@lwn.net,
        Derek Basehore <dbasehore@chromium.org>
Subject: [PATCH 5/6] docs: driver-api: add pre_rate_req to clk documentation
Date:   Tue, 23 Oct 2018 18:31:31 -0700
Message-Id: <20181024013132.115907-6-dbasehore@chromium.org>
X-Mailer: git-send-email 2.19.1.568.g152ad8e336-goog
In-Reply-To: <20181024013132.115907-1-dbasehore@chromium.org>
References: <20181024013132.115907-1-dbasehore@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds documentation for the new clk op pre_rate_req.

Signed-off-by: Derek Basehore <dbasehore@chromium.org>
---
 Documentation/driver-api/clk.rst | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/driver-api/clk.rst b/Documentation/driver-api/clk.rst
index 593cca5058b1..917f6ac29645 100644
--- a/Documentation/driver-api/clk.rst
+++ b/Documentation/driver-api/clk.rst
@@ -82,6 +82,9 @@ the operations defined in clk-provider.h::
 						unsigned long *parent_rate);
 		int		(*determine_rate)(struct clk_hw *hw,
 						  struct clk_rate_request *req);
+		int		(*pre_rate_req)(struct clk_hw *hw,
+						const struct clk_rate_request *next,
+						struct clk_rate_request *pre);
 		int		(*set_parent)(struct clk_hw *hw, u8 index);
 		u8		(*get_parent)(struct clk_hw *hw);
 		int		(*set_rate)(struct clk_hw *hw,
@@ -224,6 +227,8 @@ optional or must be evaluated on a case-by-case basis.
    +----------------+------+-------------+---------------+-------------+------+
    |.determine_rate |      | y [1]_      |               |             |      |
    +----------------+------+-------------+---------------+-------------+------+
+   |.pre_rate_req   |      | y [1]_      |               |             |      |
+   +----------------+------+-------------+---------------+-------------+------+
    |.set_rate       |      | y           |               |             |      |
    +----------------+------+-------------+---------------+-------------+------+
    +----------------+------+-------------+---------------+-------------+------+
@@ -238,7 +243,7 @@ optional or must be evaluated on a case-by-case basis.
    |.init           |      |             |               |             |      |
    +----------------+------+-------------+---------------+-------------+------+
 
-.. [1] either one of round_rate or determine_rate is required.
+.. [1] one of round_rate, determine_rate, or pre_rate_req is required.
 
 Finally, register your clock at run-time with a hardware-specific
 registration function.  This function simply populates struct clk_foo's
-- 
2.19.1.568.g152ad8e336-goog

