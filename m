Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6F87C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:58:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9646A20842
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550498287;
	bh=9/cza0IcYtET5jxOZC8D8N/yDJBpil8S+IaYRe+ptQo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aGZwIyeV7xrMTpfBhnI8bEL3rEAeBqQLU7GlFbL8WIxegNgdqY0sXhK2rz3BD+I1f
	 KIaKvWJJF3eNM3hJ8b8PN6o1Alnh0GMOcvuSV9Od+9lOmS0EWmy8TzIJ+GgbeJ39tT
	 5Ms+cJi0Arsu+vu2UnXQjpEHzbyVKGqTEAwB7lEw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388253AbfBRN6F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 08:58:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:38532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388207AbfBRN6A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:58:00 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A476E20842;
        Mon, 18 Feb 2019 13:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550498279;
        bh=9/cza0IcYtET5jxOZC8D8N/yDJBpil8S+IaYRe+ptQo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k5fb0FpI8WJeigaOdf6pQ+vAHFHNsQ7l4eZihdNcagr2rag3bCA/vand5jqAc1+ID
         DbanY5042JPYjBf4XtMU3zZXOSorihDWr7MVJ7ecHhuz2lJVpmmv9QXnT0TinpR7JX
         lU2IssWyyb9T/jQgEDZtO53fFniAyOj73BcKoAyk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Adrian Bunk <bunk@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 02/58] eeprom: at24: add support for 24c2048
Date:   Mon, 18 Feb 2019 14:43:23 +0100
Message-Id: <20190218133508.757497289@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133508.567416115@linuxfoundation.org>
References: <20190218133508.567416115@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

commit 37cf28d3b5bca1b532a0b6aac722e7f2788a9294 upstream.

Works with ST M24M02.

Signed-off-by: Adrian Bunk <bunk@kernel.org>
Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/misc/eeprom/Kconfig | 2 +-
 drivers/misc/eeprom/at24.c  | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/eeprom/Kconfig b/drivers/misc/eeprom/Kconfig
index c4e41c26649e..fac10c0e852c 100644
--- a/drivers/misc/eeprom/Kconfig
+++ b/drivers/misc/eeprom/Kconfig
@@ -12,7 +12,7 @@ config EEPROM_AT24
 	  ones like at24c64, 24lc02 or fm24c04:
 
 	     24c00, 24c01, 24c02, spd (readonly 24c02), 24c04, 24c08,
-	     24c16, 24c32, 24c64, 24c128, 24c256, 24c512, 24c1024
+	     24c16, 24c32, 24c64, 24c128, 24c256, 24c512, 24c1024, 24c2048
 
 	  Unless you like data loss puzzles, always be sure that any chip
 	  you configure as a 24c32 (32 kbit) or larger is NOT really a
diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index d8a485f1798b..a37b9b6a315a 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -170,6 +170,7 @@ static const struct i2c_device_id at24_ids[] = {
 	{ "24c256",	AT24_DEVICE_MAGIC(262144 / 8,	AT24_FLAG_ADDR16) },
 	{ "24c512",	AT24_DEVICE_MAGIC(524288 / 8,	AT24_FLAG_ADDR16) },
 	{ "24c1024",	AT24_DEVICE_MAGIC(1048576 / 8,	AT24_FLAG_ADDR16) },
+	{ "24c2048",	AT24_DEVICE_MAGIC(2097152 / 8,	AT24_FLAG_ADDR16) },
 	{ "at24", 0 },
 	{ /* END OF LIST */ }
 };
-- 
2.19.1



