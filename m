Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B574C6783B
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 00:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D315820811
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 00:55:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kC4WdKD2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D315820811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbeLLAzq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 19:55:46 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:38527 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbeLLAzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 19:55:45 -0500
Received: by mail-io1-f68.google.com with SMTP id l14so13449195ioj.5;
        Tue, 11 Dec 2018 16:55:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ry4gCuZwxl4eTtZDuPmKDxqeBqB1zeEesHvItHlLEa8=;
        b=kC4WdKD2r4PK0fbt9txKCC70r/0VAPoug/fgGzehJXaG/ALY478m74qCbDxsAj1KPl
         IDGQFjptY3jSUs2FfR+v4bEx2ELuZ8wS+7lmO0nx8wF1gGiN5M+zgIF16hURNxLdZlTU
         qnrv72e42CXgWZ6xpfVf+HSST0Z4gJNPwKrupeAySvzi1tDnhnfUgHCHtPSCu/t1JVxV
         ToeP6es9391XvIJveMWt0ezWZUBRVh89mQZJIabr0Rs1n5wQQVUJfAo8tcVS7KnRlbSO
         rRQqbUHtst8WvsahzPYiye9H0M9Y2ky4eNFig9prLjobe8jfWK4vyOLBu9PNGXf3tJFg
         /mdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ry4gCuZwxl4eTtZDuPmKDxqeBqB1zeEesHvItHlLEa8=;
        b=eyqYOW3Hg1MRvCwIopZlmAtElyCDlSFqy0VAA8AId+y4vBH+A0YWZyxlANZnWdy1ME
         wxQF5UK+ei515kWSD3kwxILbXvchwcM+LqRk4dkxRPQxvp8gS54USyQp1bFQacr0AJ2V
         n1+r8Q016z8h4jrPiDJ2ZCRrEeApv3eXRgyEK7QIGU69t6r2/gs5NScu2eS9tnMTacde
         e+FSMKL5UHe0F5IbIdTZlsGvqYnQjDL680/xHrHNNghPuWhB9SPScMMOTDK05IDHSemd
         zn6kFNKDnpjLMKA/iMAz78aj2LYQcGBPpsNvAFqkUgKBloIsg12QofBlHZldeBl9q4va
         vAog==
X-Gm-Message-State: AA+aEWbl4iQUsSOKYza2H2RVEX6LZ9n5rjX7g66L9qM1sv5RKEcbzBq6
        cE5HN14zvO2pRhjjYmzC5dCQINT2o0U87g==
X-Google-Smtp-Source: AFSGD/V7KmA8s/g3ILTXk/GLlykDvOAr2VRl/J308rm2jFuHubMr1hNkdsnQAlQ/d2sfrW+VmAAKZw==
X-Received: by 2002:a6b:d005:: with SMTP id x5mr15420936ioa.46.1544576144438;
        Tue, 11 Dec 2018 16:55:44 -0800 (PST)
Received: from r2700x.localdomain (c-75-70-96-103.hsd1.co.comcast.net. [75.70.96.103])
        by smtp.gmail.com with ESMTPSA id l186sm1952445itl.22.2018.12.11.16.55.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 16:55:44 -0800 (PST)
From:   Jeremy Fertic <jeremyfertic@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Jeremy Fertic <jeremyfertic@gmail.com>
Subject: [PATCH 01/11] staging: iio: adt7316: fix register and bit definitions
Date:   Tue, 11 Dec 2018 17:54:53 -0700
Message-Id: <20181212005503.28054-2-jeremyfertic@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181212005503.28054-1-jeremyfertic@gmail.com>
References: <20181212005503.28054-1-jeremyfertic@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change two register addresses and one bit definition to match the
datasheet.

Signed-off-by: Jeremy Fertic <jeremyfertic@gmail.com>
---
 drivers/staging/iio/addac/adt7316.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
index dc93e85808e0..1fa4a4c2b4f3 100644
--- a/drivers/staging/iio/addac/adt7316.c
+++ b/drivers/staging/iio/addac/adt7316.c
@@ -59,8 +59,8 @@
 #define ADT7316_CONFIG1			0x18
 #define ADT7316_CONFIG2			0x19
 #define ADT7316_CONFIG3			0x1A
-#define ADT7316_LDAC_CONFIG		0x1B
-#define ADT7316_DAC_CONFIG		0x1C
+#define ADT7316_DAC_CONFIG		0x1B
+#define ADT7316_LDAC_CONFIG		0x1C
 #define ADT7316_INT_MASK1		0x1D
 #define ADT7316_INT_MASK2		0x1E
 #define ADT7316_IN_TEMP_OFFSET		0x1F
@@ -117,7 +117,7 @@
  */
 #define ADT7316_ADCLK_22_5		0x1
 #define ADT7316_DA_HIGH_RESOLUTION	0x2
-#define ADT7316_DA_EN_VIA_DAC_LDCA	0x4
+#define ADT7316_DA_EN_VIA_DAC_LDCA	0x8
 #define ADT7516_AIN_IN_VREF		0x10
 #define ADT7316_EN_IN_TEMP_PROP_DACA	0x20
 #define ADT7316_EN_EX_TEMP_PROP_DACB	0x40
-- 
2.19.1

