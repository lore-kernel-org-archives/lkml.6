Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68718ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 21:10:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D2F1208A6
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 21:10:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="CF93WVpU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D2F1208A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732199AbeGMV0D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 17:26:03 -0400
Received: from www.zeus03.de ([194.117.254.33]:48412 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731871AbeGMV0D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 17:26:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id; s=k1; bh=3KrJknHHRCwzZZHj5bx
        wJqWCThzhfgW7Jmd4qND/CDU=; b=CF93WVpU8BD50baVBKzXVqYJDtidHYKjOxT
        eZKEVPIQxs/5k8omcWVhBj2QiOEpzFJA3WneL9pk3q9pxaahjaW9eiz85Bjrp4qM
        eygpKE7uwxbP8Bq2NFCdxVikklprR6bsv/RsvLzZCnS6UapWoU8c3i0oTaGsnvqP
        nZhiOSJ8=
Received: (qmail 3379 invoked from network); 13 Jul 2018 23:09:42 +0200
Received: by mail.zeus03.de with ESMTPSA (ECDHE-RSA-AES256-GCM-SHA384 encrypted, authenticated); 13 Jul 2018 23:09:42 +0200
X-UD-Smtp-Session: l3s3148p1@4ncB5udwdOUgAwDPW8bBAAId4P/+oMhl
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-i2c@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org, kernel@pengutronix.de,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH/RFT 0/6] i2c: recovery: fix GPIO usage for recovery
Date:   Fri, 13 Jul 2018 23:09:12 +0200
Message-Id: <20180713210920.3648-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have sent the last patch of this series before, but then I realized I need to
convert all users of GPIO recovery before. I needed to make sure they all set
the SDA GPIO to output, this is what patches 3-5 are doing. Which is also good
for them because then they can send STOP at apropriate places when doing
recovery.

Then, I noticed that two drivers were not using the open drain mode for SCL
which seems like a bug to me. So, patches 1+2 address that. I'd think those two
are stable material.

Due to no hardware, I could only build test these patches. I'd be really
looking forward to comments or tests of these patches.

A branch can be found here:

git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/i2c/recovery-sda-output

Thanks,

   Wolfram


Wolfram Sang (6):
  i2c: designware: use open drain for recovery GPIO
  i2c: imx: use open drain for recovery GPIO
  i2c: designware: set SDA as output for recovery
  i2c: davinci: set SDA as output for recovery
  i2c: imx: set SDA as output for recovery
  i2c: recovery: remove bogus check if SDA GPIO is set to output

 drivers/i2c/busses/i2c-davinci.c           | 3 ++-
 drivers/i2c/busses/i2c-designware-master.c | 4 ++--
 drivers/i2c/busses/i2c-imx.c               | 4 ++--
 drivers/i2c/i2c-core-base.c                | 4 +---
 4 files changed, 7 insertions(+), 8 deletions(-)

-- 
2.11.0

