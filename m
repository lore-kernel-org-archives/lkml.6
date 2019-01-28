Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62FE9C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:01:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAB822148E
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:01:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="T+p09RSz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726888AbfA1SBb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 13:01:31 -0500
Received: from mout01.posteo.de ([185.67.36.65]:55235 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726266AbfA1SBa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 13:01:30 -0500
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 49DBF160060
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 19:01:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1548698485; bh=n6QO8/kBOLSwDXVKRis8rB30gKt/R4phl4zvGqFALoA=;
        h=From:To:Cc:Subject:Date:From;
        b=T+p09RSzjJug4lGkgjDwxmryUH67+N2REZAW/mFdWvPgPYu0X8rUsFo+XMkL/pu76
         iUnU2CzVbc1al8tJWxKLBX/hSBrjm8EoH6hefipmtcDMlUIMv39NcSoxbMQuU6Kd+Y
         9RYno6V6PzX6u26o8ccTRNsygfSqd1WDvTuhw9q+9fUGhFHih1NSqxQbdZcdNEklWK
         QfO7u7a5bIMP+H4CGCLiVXP0RWzmMe+TsgFDH7t9j30+fSL0aW/dGHQDNHf/sYN/5f
         l24MgV2vqSVI2HJOwJpjMKyu3sC1LRShJmaO/pZr5rdn5/MMyUvUd/e+Wu27hYDfwx
         EwLEXsQJiB9hA==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 43pHW82LT2z6tmG;
        Mon, 28 Jan 2019 19:01:24 +0100 (CET)
From:   Martin Kepplinger <martink@posteo.de>
To:     gregkh@linuxfoundation.org, jslaby@suse.com
Cc:     linux-kernel@vger.kernel.org,
        Manfred Schlaegl <manfred.schlaegl@ginzinger.com>,
        Martin Kepplinger <martin.kepplinger@ginzinger.com>
Subject: [PATCH v2] tty: increase the default flip buffer limit to 2*640K
Date:   Mon, 28 Jan 2019 19:01:10 +0100
Message-Id: <20190128180110.14795-1-martink@posteo.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Manfred Schlaegl <manfred.schlaegl@ginzinger.com>

We increase the default limit for buffer memory allocation by a factor of
10 to 640K to prevent data loss when using fast serial interfaces.

For example when using RS485 without flow-control at speeds of 1Mbit/s
an upwards we've run into problems such as applications being too slow
to read out this buffer (on embedded devices based on imx53 or imx6).

If you want to write transmitted data to a slow SD card and thus have
realtime requirements, this limit can become a problem.

That shouldn't be the case and 640K buffers fix such problems for us.

This value is a maximum limit for allocation only. It has no effect
on systems that currently run fine. When transmission is slow enough
applications and hardware can keep up and increasing this limit
doesn't change anything.

It only _allows_ to allocate more than 2*64K in cases we currently fail to
allocate memory despite having some.

Signed-off-by: Manfred Schlaegl <manfred.schlaegl@ginzinger.com>
Signed-off-by: Martin Kepplinger <martin.kepplinger@ginzinger.com>
---

revision history
----------------
v2: more verbose commit message answering Greg's questions
v1: initial post


 drivers/tty/tty_buffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
index 77070c2d1240..ec145a59f199 100644
--- a/drivers/tty/tty_buffer.c
+++ b/drivers/tty/tty_buffer.c
@@ -26,7 +26,7 @@
  * Byte threshold to limit memory consumption for flip buffers.
  * The actual memory limit is > 2x this amount.
  */
-#define TTYB_DEFAULT_MEM_LIMIT	65536
+#define TTYB_DEFAULT_MEM_LIMIT	(640 * 1024UL)
 
 /*
  * We default to dicing tty buffer allocations to this many characters
-- 
2.20.1

