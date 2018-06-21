Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D89CC43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 12:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5C7220883
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 12:37:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qZbAqtz+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5C7220883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932928AbeFUMhH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 08:37:07 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:39304 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751159AbeFUMhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 08:37:05 -0400
Received: by mail-wr0-f196.google.com with SMTP id w7-v6so3026896wrn.6;
        Thu, 21 Jun 2018 05:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=QRUU6Qiv2dCDbeL58I5aE7v6/Ffw6I9EoUzlxqzFRnc=;
        b=qZbAqtz+JUhv88AT9Su2xH1g+IXwUCTnqbXVpz5dQgdS+YU7vcZkRmNUFrakZ6+d1A
         d2UuXm+TeE72d4hFPCwmKlzIxzZtC5rjoZrL9cIeYbTYv2WFYo1WiDcxz+YUCkUalDLP
         yDOTPKMa18DPLYENVv9Y3qsYKzuAmKw+5y/Uu4toHGEG5W64pMUTrqFJfgR5VxCTHU37
         gjr2I5I/PeVEIIFy/8l7BHzvaqu3qdJYlxEglEBmexXAciIf1r+TAhdloFqqApV7Ovfx
         LRgBJUWsxZfdZ5ArLvMCXODJGJgCDb3uaqJcpbneOMy1IqPNlbWTvGOVye89PfbKZs5J
         f13Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=QRUU6Qiv2dCDbeL58I5aE7v6/Ffw6I9EoUzlxqzFRnc=;
        b=H7Ppe/eoSjoJ4yGvZQiRu4X6MQHMGR94x3br5gvTT3sTalXc3uih5UIsvfDLQG7c+/
         gODmzYe4SNqdks2agOaUtPkpRWoPBdDe2NkowFnNU6JM8mD1lnN7h3jgG19Q1Imdr/UO
         w3vRJDhbEODV9qHhlSi0YGuQoaUJlPBT5OT/+Y9fEItvuzxzhqPbkcE6hPOAcpcVchqp
         TwznOxVC7QuW9ogYJ1On3lPps9HpnOFRzmS+IenTMrWNOgFNGdYrgRteTxTJ26Mpfhcl
         d/6lFH8lhe7oVZmrYd2d2/4DTyektlN6gEbnPbHGFtY5k3XG0TfsQVE3K6EQNpx96cfj
         4HIw==
X-Gm-Message-State: APt69E27TxKPtW56y8W3ynYcWQ6sve0UnJ05AJXfJCRBzMZ9B6r8X+8P
        OmyzW4reBizpaxlotk5aaQ==
X-Google-Smtp-Source: ADUXVKIAHkd0bbrTFflQE4zZZo3VeyZdBX7VPrzJ9FdmVC86Ed85W94Imv3pAyVO0lXV3QsV2fEeEg==
X-Received: by 2002:adf:eb0c:: with SMTP id s12-v6mr22911767wrn.174.1529584623912;
        Thu, 21 Jun 2018 05:37:03 -0700 (PDT)
Received: from sesnaco ([196.43.135.103])
        by smtp.gmail.com with ESMTPSA id q14-v6sm7183247wmd.20.2018.06.21.05.37.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jun 2018 05:37:03 -0700 (PDT)
Date:   Thu, 21 Jun 2018 15:36:52 +0300
From:   Mawanda Henry <mawandahenrynaco@gmail.com>
To:     mawanda111@gmail.com
Cc:     wsa@the-dreams.de, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drivers/i2c: SPDX-License-header information
Message-ID: <20180621123652.GA8426@sesnaco>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SPDX License header included to easy developers and machine to know the
license governing a particular file

Signed-off-by: Mawanda Henry <mawandahenrynaco@gmail.com>
---
 drivers/i2c/i2c-core-slave.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/i2c/i2c-core-slave.c b/drivers/i2c/i2c-core-slave.c
index 4a78c65..d2cc8fc 100644
--- a/drivers/i2c/i2c-core-slave.c
+++ b/drivers/i2c/i2c-core-slave.c
@@ -1,12 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * Linux I2C core slave support code
- *
  * Copyright (C) 2014 by Wolfram Sang <wsa@sang-engineering.com>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License as published by the Free
- * Software Foundation; either version 2 of the License, or (at your option)
- * any later version.
  */
 
 #include <dt-bindings/i2c/i2c.h>
-- 
2.7.4

