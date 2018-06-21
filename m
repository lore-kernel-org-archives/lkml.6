Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 988FCC43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 09:40:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46ECA20883
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 09:40:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SzlT5Lz/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46ECA20883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932883AbeFUJkh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 05:40:37 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:44573 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932620AbeFUJkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 05:40:35 -0400
Received: by mail-wr0-f193.google.com with SMTP id p12-v6so825471wrn.11;
        Thu, 21 Jun 2018 02:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=2sByfOT2bN+73FAkfIoqTkf3DwGyCvZ8B2ldjgyT0Tc=;
        b=SzlT5Lz/8oWE7qiR4Q+4t7/g5C8n2ivdIe8/A5MsUh504vNqStvm3cicWZgMSxwLZR
         +OYuqnMkg9RQL/MeI9Lk+WmSO7goytGRwVLXHN/btvXAMHuiTPJS7TvJ+aYwxBOOxQXR
         Zop3Gr00jbJbw4s355AHpcD6RRs0b5eRy0DCEFGoT3Pody1FIkDjLZrgXmhWuNapnaKc
         b+E6fApyvE7OOqv4iUyJRE54Lr7SC7rWl6IgGYbX5OtQbG3T7ldJIDuUhWq8fkVHKsGy
         bBPjmsleSbUWSiYL4DR1kC2w0LP7ApGtW+i4Ts/qtoSquctdzop/NLYC5Je05ht2H31m
         Jagw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=2sByfOT2bN+73FAkfIoqTkf3DwGyCvZ8B2ldjgyT0Tc=;
        b=qK0emHZ0/nOvZNJ29Qxm0sOatMmfnm0AFH72VCCyFZqKFHIlZW+7mVohiN0RLtERMU
         CL6jdWW504dkmV3ocGmjjK5SnWNbWTDsasQHg0syB/9uDnwt1cznkKPwIu6gX9zYSEiM
         f7OuyWkUeRi3p2g/9l7r46RnGxFtJD3lEBAgVHSLZwY1SkJ2iDn37ml9D8ItE8pBkczY
         vsFoXq9MmyBCuMJ22L9JfHhqaEVoRH7OmwuROUEKEeGFRteVyoXXQgGVomi9UUhtyQkd
         L7FBKA5oFYLNdcdtuye4xSlkcI44hcYv4yGZPw/686+F9KIwI8cep1cjNRA1pmxqlavj
         NaqQ==
X-Gm-Message-State: APt69E2NB/BigTtTBRMkJ/h4KBjLpvjxdYrh8SKbo6Fyi1N/PPYcbXj9
        MbqsdGNmFnHFGT/6MlqqE+valh2R/Q==
X-Google-Smtp-Source: ADUXVKILrs13h5folIqIgJvNGG2j2WXODGyPihwJbFRWSxM89Sjxzdi3717AUYjGJTCNHl0IZIBlUg==
X-Received: by 2002:adf:c844:: with SMTP id e4-v6mr20704265wrh.236.1529574034428;
        Thu, 21 Jun 2018 02:40:34 -0700 (PDT)
Received: from sesnaco ([196.43.135.103])
        by smtp.gmail.com with ESMTPSA id k17-v6sm6879984wmc.23.2018.06.21.02.40.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jun 2018 02:40:33 -0700 (PDT)
Date:   Thu, 21 Jun 2018 12:40:19 +0300
From:   Mawanda Henry <mawandahenrynaco@gmail.com>
To:     mawanda111@gmail.com
Cc:     wsa@the-dreams.de, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drivers/i2c:  Include SPDX-license-identifier
Message-ID: <20180621094019.GA5348@sesnaco>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

including the SPDX license identifier header  makes it easy for
developers and machines to know the lecense that is governing the file

Signed-off-by: Mawanda Henry <mawandahenrynaco@gmail.com>
---
 drivers/i2c/i2c-core-slave.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/i2c-core-slave.c b/drivers/i2c/i2c-core-slave.c
index 4a78c65..883ca836 100644
--- a/drivers/i2c/i2c-core-slave.c
+++ b/drivers/i2c/i2c-core-slave.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Linux I2C core slave support code
  *
-- 
2.7.4

