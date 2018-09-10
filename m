Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF907C46469
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 23:20:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0C8B20658
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 23:20:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0C8B20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbeIKEQm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 00:16:42 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:34958 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbeIKEQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 00:16:42 -0400
Received: by mail-qt0-f194.google.com with SMTP id j7-v6so26322083qtp.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 16:20:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JMFMt7s2Fn5IXYGJbzlzQT9gKqCzA1W3C8hRQZcEHUU=;
        b=NYKFKcyxC6pwIUu49RXzrAlEg2LPuOwipjR06hQEDrOn3gPa0sOJPs9Hx8gOG2C5sZ
         CWbdHnewfWxdED/6Tu/F44liOxXLTHbenwPOExmEhL/VU4BEjD3hMTbKYPrPaxVYXBMV
         CKi7eJ9hiZuk9S91HoP99yZrAf7/PImHAYrLaX+ia+wmKIDsWoxt7YehmAnt77/8pEFk
         bjqM8tBly7lg5Yjlt6FojA1dCnN4QuAqssmEFXtpY2kdelINqdTYs7ssrHV2dF4GXy1s
         isYLBlSddQww6PBC1uJRPsw9z2kekMao53EJRGF0YGTT77ovZmwMHMPyx6Ya8knfwuZf
         WKtQ==
X-Gm-Message-State: APzg51CG5mGSmFTKbf3PegegfkPW3xDBEmoc1niuSwS/Nx0LQD1MVRGV
        G7aCezuc6gm4GV1hRuhZLbtRHw==
X-Google-Smtp-Source: ANB0VdaylUw3An2iDXXzdch/TjEPX315BDgUbgzxUxA3eKSbkyuTS05PKUbJrEUgq2YEaHR1jE1rNA==
X-Received: by 2002:a0c:8a4b:: with SMTP id 11-v6mr16410304qvu.57.1536621620485;
        Mon, 10 Sep 2018 16:20:20 -0700 (PDT)
Received: from labbott-redhat.redhat.com ([2601:602:9802:a8dc::42c3])
        by smtp.gmail.com with ESMTPSA id k5-v6sm10057941qkf.53.2018.09.10.16.20.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Sep 2018 16:20:19 -0700 (PDT)
From:   Laura Abbott <labbott@redhat.com>
To:     Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Laura Abbott <labbott@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kgdboc: Fix restrict error
Date:   Mon, 10 Sep 2018 16:20:14 -0700
Message-Id: <20180910232014.2642-1-labbott@redhat.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's an error when compiled with restrict:

drivers/tty/serial/kgdboc.c: In function ‘configure_kgdboc’:
drivers/tty/serial/kgdboc.c:137:2: error: ‘strcpy’ source argument is the same
as destination [-Werror=restrict]
  strcpy(config, opt);
  ^~~~~~~~~~~~~~~~~~~

As the error implies, this is from trying to use config as both source and
destination. Drop the call to the function where config is the argument
since nothing else happens in the function.

Signed-off-by: Laura Abbott <labbott@redhat.com>
---
 drivers/tty/serial/kgdboc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/kgdboc.c b/drivers/tty/serial/kgdboc.c
index b4ba2b1dab76..dd503743bbff 100644
--- a/drivers/tty/serial/kgdboc.c
+++ b/drivers/tty/serial/kgdboc.c
@@ -154,15 +154,13 @@ static int configure_kgdboc(void)
 {
 	struct tty_driver *p;
 	int tty_line = 0;
-	int err;
+	int err = -ENODEV;
 	char *cptr = config;
 	struct console *cons;
 
-	err = kgdboc_option_setup(config);
-	if (err || !strlen(config) || isspace(config[0]))
+	if (!strlen(config) || isspace(config[0]))
 		goto noconfig;
 
-	err = -ENODEV;
 	kgdboc_io_ops.is_console = 0;
 	kgdb_tty_driver = NULL;
 
-- 
2.17.1

