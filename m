Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 893DDC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 18:31:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C9152080F
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 18:31:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hc5XmYBA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728794AbfA2SbQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 13:31:16 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:46303 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727198AbfA2SbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 13:31:15 -0500
Received: by mail-qk1-f196.google.com with SMTP id q1so12101753qkf.13;
        Tue, 29 Jan 2019 10:31:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=S9EDHsw96cyd0/3F78W3MTcTmErK7XmN4nklDQL57yg=;
        b=hc5XmYBA4bLnJOvvnDyVmhqXK77vAvxbXnSvAMaocWUubq5Ku4mQvXm+0/jnTrslQ+
         WAuvDyg0PF4yMpNHfE1sZl5j7qMq/v+Nmin/wJdkbnanc7yS4WARsJo8P1qOh+zIGYGb
         IlUXMED1RUIT3vrmeXgGLc61B2HG2fdWf49ontHd1SSJem6b5LyZVEqGgcB3res+udhQ
         2mxYrWTi09H6cKbadgiUAwofjwyDgTSTKiucE7B1hcanzO0hh3PMjSHsPd0SYfJcEieK
         0fvu2t/6oxUsqa0Hgl/QGuksAOBmfkquVITCqWM7xwV7u3dCqkMPRGwHJ4MmrbPrFJnr
         9Mqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=S9EDHsw96cyd0/3F78W3MTcTmErK7XmN4nklDQL57yg=;
        b=ukgmGhfhwbdcGOIyS/oz4eMCv2ASW5LKabV+lSvzlVgqi6pTfqPTldalcFmYdpw+11
         LZAXezQg/rPMSyxozazaRFK9v9Q8J6aHL7O7GVdnxjvn+Qby/vzgY98rJFxGPyC+1bvQ
         v5f8LtMKiqjIUZztm8U5psFRyy45SeFVz4XDZwh7Tqy6p6gzEc01QfIGwBmjEtKB5jea
         9YXwt21PujUElBxMYpiKb7wepBV0OhPbbWR2cKmpgrB8SdKfXMdGe/WuLumHXT6kA4bk
         8zXNYSN6egndY8KZ1/E5goNagSWOhMvKAdVQWnbXRCbtFQBUKSt6ZE46Vh72wTSfE6KM
         K/rA==
X-Gm-Message-State: AJcUukfN6wW/EOVNb/OrrP6pO+xXp6H+Y1oxHM/2gCfCzaIKkDJGJbFo
        TFzFvduijEH6yY0guVlzGq3Gac2PoOOWXg==
X-Google-Smtp-Source: ALg8bN7JUagEy384ubMe4QDPv6Hdw2AUwEPFy7fTx9Cg9/lMx1oa00esEj7Q06VMI1Mke5LjLhU0YA==
X-Received: by 2002:a37:6749:: with SMTP id b70mr24565322qkc.41.1548786674411;
        Tue, 29 Jan 2019 10:31:14 -0800 (PST)
Received: from voyager.ime.usp.br ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id a3sm49357708qkd.86.2019.01.29.10.31.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 29 Jan 2019 10:31:13 -0800 (PST)
From:   Camylla Cantanheide <c.cantanheide@gmail.com>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com,
        Feulo <guifeulo@gmail.com>,
        Camylla Cantanheide <c.cantanheide@gmail.com>
Subject: [PATCH] staging:iio:ad7152: align line to match open parenthesis
Date:   Tue, 29 Jan 2019 16:31:00 -0200
Message-Id: <1548786660-11935-1-git-send-email-c.cantanheide@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Feulo <guifeulo@gmail.com>

Align broken line to match upper line parenthesis. Solves the
checkpatch.pl's message

CHECK: Alignment should match open parenthesis.

Signed-off-by: Feulo <guifeulo@gmail.com>
Signed-off-by: Camylla Cantanheide <c.cantanheide@gmail.com>
---
 drivers/staging/iio/cdc/ad7152.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/cdc/ad7152.c b/drivers/staging/iio/cdc/ad7152.c
index 25f51db..e7f082f 100644
--- a/drivers/staging/iio/cdc/ad7152.c
+++ b/drivers/staging/iio/cdc/ad7152.c
@@ -362,7 +362,7 @@ static int ad7152_read_raw(struct iio_dev *indio_dev,
 		/* Trigger a single read */
 		regval |= AD7152_CONF_MODE_SINGLE_CONV;
 		ret = i2c_smbus_write_byte_data(chip->client, AD7152_REG_CFG,
-				regval);
+						regval);
 		if (ret < 0)
 			goto out;
 
-- 
2.7.4

