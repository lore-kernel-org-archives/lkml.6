Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E12B5C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:50:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0CC82082C
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548841819;
	bh=sj0tNwJ0EzD0y9QvMKm6YFJlgw8lkwRLa0YbWW9X408=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=p/6fSO7IYm2EASMOuukHSbXDFEZS5Tqexr7maPtVuu/HYB/paLM8qQv9kBpgDPfIs
	 pxRnnIe58NA9Udz64OotQUQrfTUSruce+CWr9ceCgtPt1zquaWiZaCfDA063XqFv0Q
	 X6czjRrJx56zN8ikzAPIHTrGzf1ztff5eOR5nUaY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730033AbfA3JuR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 04:50:17 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:46531 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726972AbfA3JuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 04:50:15 -0500
Received: by mail-lf1-f65.google.com with SMTP id f5so16860183lfc.13;
        Wed, 30 Jan 2019 01:50:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NanYgte5LFdggF1rtBl08xezcfm+tdZaDruR5cWG55Y=;
        b=YV3q/GSkZbYzq/BToC2dyD0Klg3M6VQiBKiohDw+U/nJ7lKMf6D++n06NUys9xI9MF
         PiScQNObINpjA+02ANz83fJ0gga5XywcI2FHBGbhVjkcRR/axDDdgAA+18UMcOP0sUOs
         Wh+ZGz6PiBUBcV+OZaJNYkXBXt9+bzaxCxa0g6Z4mMsnCOxfXgmRNkSnpM8tuYmho9Fd
         pc1ZfmgC+xi0Qc1G4nHgT+elfCO6hyTo5kY7I6hzHS+9MG2cRh2fiDmqfeHgvHr3sVxh
         xz82z9+O3YtKAjKkNCrQ8CtsrNIeAw/dhYpYGWdynNkOlvlwK9EZQR/Vvvg9xNnsci/7
         tvFA==
X-Gm-Message-State: AJcUukd/ikwnm35o/tgHv/vKddKAwL4iXGooHfY5UmYd1QHUo0oPRAjx
        /BIyCS4CjZ+MMc3OACOZizw=
X-Google-Smtp-Source: ALg8bN7payxL1JrHkNoI1WZtp+OzSEGYEFsrKdAqIgOZFElInKcrwxGxp7b4cw6dBTGnPwnecS/P0w==
X-Received: by 2002:a19:4345:: with SMTP id m5mr22821843lfj.142.1548841813454;
        Wed, 30 Jan 2019 01:50:13 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id b25-v6sm188574lji.94.2019.01.30.01.50.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 01:50:12 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@xi.terra>)
        id 1gomVU-00017G-MP; Wed, 30 Jan 2019 10:50:08 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     speakup@linux-speakup.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        stable <stable@vger.kernel.org>,
        Okash Khawaja <okash.khawaja@gmail.com>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>
Subject: [PATCH] staging: speakup: fix tty-operation NULL derefs
Date:   Wed, 30 Jan 2019 10:49:34 +0100
Message-Id: <20190130094934.4231-1-johan@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The send_xchar() and tiocmset() tty operations are optional. Add the
missing sanity checks to prevent user-space triggerable NULL-pointer
dereferences.

Fixes: 6b9ad1c742bf ("staging: speakup: add send_xchar, tiocmset and input functionality for tty")
Cc: stable <stable@vger.kernel.org>     # 4.13
Cc: Okash Khawaja <okash.khawaja@gmail.com>
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/staging/speakup/spk_ttyio.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/speakup/spk_ttyio.c b/drivers/staging/speakup/spk_ttyio.c
index c92bbd05516e..005de0024dd4 100644
--- a/drivers/staging/speakup/spk_ttyio.c
+++ b/drivers/staging/speakup/spk_ttyio.c
@@ -265,7 +265,8 @@ static void spk_ttyio_send_xchar(char ch)
 		return;
 	}
 
-	speakup_tty->ops->send_xchar(speakup_tty, ch);
+	if (speakup_tty->ops->send_xchar)
+		speakup_tty->ops->send_xchar(speakup_tty, ch);
 	mutex_unlock(&speakup_tty_mutex);
 }
 
@@ -277,7 +278,8 @@ static void spk_ttyio_tiocmset(unsigned int set, unsigned int clear)
 		return;
 	}
 
-	speakup_tty->ops->tiocmset(speakup_tty, set, clear);
+	if (speakup_tty->ops->tiocmset)
+		speakup_tty->ops->tiocmset(speakup_tty, set, clear);
 	mutex_unlock(&speakup_tty_mutex);
 }
 
-- 
2.20.1

